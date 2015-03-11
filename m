From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git commit --amend safety check?
Date: Tue, 10 Mar 2015 23:00:42 -0700
Message-ID: <CAJo=hJtxeZGyP=VxLSdDzoMOtVZTFNsNTqPpNUTXUOBDZKzY9Q@mail.gmail.com>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
 <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 07:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVZhi-0006PB-75
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbbCKGBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:01:05 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:42283 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbCKGBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:01:03 -0400
Received: by yhoa41 with SMTP id a41so3353014yho.9
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cS8Nf2R54XvE7xAXCF+K+erWVZInVR3yZ6KhWWGbNgo=;
        b=HVh50ytqz8t2yMaf4kIeSOXM7uuE6bbA8SDE366/zOLr4aOVkxBq2o7L7nhlDoqVed
         IRWwnMOKyQcz18K6DYlqQUfPrqIPxA7Pjbm0fvMZjR/PcdhTKi34euY3ngCY23/ZDmXf
         6V45a1FFPBM3zwUE9QQeVy+jAss9nI4ODZrPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=cS8Nf2R54XvE7xAXCF+K+erWVZInVR3yZ6KhWWGbNgo=;
        b=gfeWhCw0Ag9pQOR/Zc3wR84cnKlPHkPw5mWtigul17qBz2RVJYwBwcjw9QX5fCyDEn
         FzBRsssssoUUWdanHNF1DOyQssInwuEPqMY4rncICmsCkfvRI0iCY9FZrWbposXWGxVQ
         zPH8ppGY0SMWBmYT7jGl7aVw8XiPaUv+na61mpSbMOVr2uCzjSPDeH1vMEEMO4+TG8MW
         /av6bSUzkSuV8Vw02U8YpjEibHY6KU8+Y1lEYSX897ZnPqBpgfskNZYi0dYYoEQXiy6J
         /fuW2gPoy8hFnxARcdrw+OuHVc/KbFOJCcCIFr0ssZENPCqOfvjPRZhinTExAhZwiR0T
         SJJQ==
X-Gm-Message-State: ALoCoQnAXg9U4I2pTFWrtZ7op9W9ZCRm5+1JF62TaCS0lXJQTrWtljRAubyw7cohGZBaUwebc8DE
X-Received: by 10.170.190.69 with SMTP id h66mr38416167yke.51.1426053662439;
 Tue, 10 Mar 2015 23:01:02 -0700 (PDT)
Received: by 10.170.122.149 with HTTP; Tue, 10 Mar 2015 23:00:42 -0700 (PDT)
In-Reply-To: <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265303>

On Tue, Mar 10, 2015 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> We keep seeing reports of Gerrit Code Review users who incorrectly do
>> something like:
>>
>>   git clone URL foo
>>   cd foo
>>   git commit --amend -m "My first change!" -a
>>   git push URL HEAD:refs/for/master
>>
>> Step #3 is where they get into trouble. They just amended the
>> published tip commit and pushed it back to the server. That is... lets
>> just say not good.
>>
>> Hg is known to be more user friendly. One way its user friendly is it
>> by default refuses to let you amend a change set that the client has
>> reasonable assertion to believe was already published through a remote
>> repository.
>
> Well, it is not Git that is less user friendly, but Gerrit is the
> problem.  More specifically, the last line:
>
>>   git push URL HEAD:refs/for/master
>
> is what catches this non-fast-forward in usual workflow with Git.

OK, replace that Gerrit-specific push syntax with:

 git send-email

:)

Even in mailing list based workflows we ask Git users to use "git
commit" to make their new commit and "git commit --amend" to polish it
up. New users are often confused and cargo-culting their Git usage
because they cannot be bothered to actually learn the tools they are
using; they are too busy learning all of the other tools they need,
like their programming language or the latest jQuery plugin.

> Wouldn't the real problem that the refs/for/master magic accepts
> anything, even a non-fast-forward?

I see your argument. But this was a conscious design choice.

It is already untenable to ask users sending you patches on git ML to
first fetch and rebase *their* working tree against your latest master
before they run git send-email. The async nature of when you publish
your tree vs. when they prepared their commit makes it likely that at
least some of the patches you receive were based on a different tip
than what you most recently published.

On very fast moving development repositories that have hundreds of
developers working against them during the bulk of the working day the
tip can be advancing more rapidly than users have the patience to run:

  while ! ( git pull --rebase && git push origin HEAD:refs/for/master ); do
    echo Retrying ...
  done

> Having said that, disabling --amend and forcing to use --force or
> something when it is clear that the user is attempting something
> unusual is a good idea.  But I am not sure what the definition of
> unusual should be.  In a non-Gerrit central repository workflow, the
> rule might be "HEAD must not be reachable from @{upstream}"
> (otherwise you are rewriting what you got from elsewhere), or it may
> be "HEAD must not be reachable from @{publish}'s remote tracking
> branch", or perhaps both, as these two could be different in
> triangular workflow.
>
> But I am not sure what the sensible rules are when the user prepares
> the commit, planning to push it to a ref like refs/for/master that
> does not have a counterpart on our side.

True.

Another way users get into a bind is they pull someone else's branch
(so they can build on top of her work), then `git commit --amend -a`
by mistake instead of making a new commit. Now they mixed their work
with her last commit. Then they push this.

Currently Gerrit Code Review accepts that as an intentional squash to
further polish her proposed change. And why not? I can take a patch
proposed by Peff from the mailing list, `commit --amend` additional
polishing, and resend with attribution^Wblame to Peff.


Perhaps Gerrit Code Review should reject this by default unless the
user has some sort of "Yes I know what I am doing" bit toggled on her
user account.

That only mildly helps the poor newbie who has no idea how to
"unstick" their Git repository. Most users just rm -rf the directory,
reclone, and start over from scratch, meanwhile complaining that "Git
lost hours of their work".

Nevermind that one could probably get out of such a jam with something like:

  git diff HEAD@{1}..HEAD >P
  git reset --hard HEAD@{1}
  git apply --index P ; rm P

If only they knew how to use their tools. :(
