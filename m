From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Proposal for pruning tags
Date: Fri, 6 Jun 2014 08:54:30 -0500
Message-ID: <CAHd499A2c09am7iFU9st-9MiNqBh_2SSyMqm+54cKL+Yq27fWA@mail.gmail.com>
References: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
	<xmqqoay7rsgd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:54:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsubL-0007mt-6P
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 15:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbaFFNyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 09:54:31 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:34451 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaFFNya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 09:54:30 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so3137967veb.8
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sndTL1DF20Rzasxj2AKYyWJ4QW/UgucvElwEsmts+p8=;
        b=ekEL8az1VOnfFNAkY6TeaOeCz9OAPJN1NxfMiUlQ2iyUq5nOScQ5Tz9Ibl075ANEr4
         miYVgjbiuBYTcefMpMxbNjCjpJnpgbJCs587Z0DHTSbUvMNt7xu83qH5CuJF/YehzuIw
         T/1y/A1yftBr5eJGburgklsronEjSWM+X8Yu2MKAj40kqHj7/GMq6oiKG7X053T4viJ1
         DoNG3nHHJUCo83WovUXLYoqWU6xQdoaRAG1VRcmugJWwwXPOGWyTW86JkEYL6m6zSHGx
         LZ3gL4XWUje2t2qC6DBzNS7C6cp547FjpOQaQNW7tZJtzA2nn13z9GHg7VI15tWpxU9D
         lhUw==
X-Received: by 10.58.109.71 with SMTP id hq7mr5644821veb.26.1402062870043;
 Fri, 06 Jun 2014 06:54:30 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Fri, 6 Jun 2014 06:54:30 -0700 (PDT)
In-Reply-To: <xmqqoay7rsgd.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: kzb9Njb9zRksM4DVgSnoR_3rKCI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250914>

On Thu, Jun 5, 2014 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think you need to explain what you mean by "prune" a lot better
> than what you are doing in your message to be understood by others.
>
> After seeing the above two commands, my *guess* of what you want to
> do is to remove any of your local tag that is *not* present in the
> repository you usually fetch from (aka "origin"), but that directly
> contradicts with what you said you wish, i.e.
>
>> This is not only wasteful, but dangerous. I might accidentally delete
>> a local tag I haven't pushed yet...
>
> which only shows that your definition of "prune" is different from
> "remove what I do not have at 'origin'".
>
> But it does not say *how* that is different.  How should "prune"
> behave differently from the two commands above?  How does your
> "prune" decide a tag needs to be removed locally when it is not at
> your "origin" [*1*]?
>
> There is *nothing* in git that lets you look at a local tag that is
> missing from the other side and determine if that is something you
> did not want to push (hence it is missing there) of if that is
> something you forgot to push (hence it is missing there but you
> would rather have pushed if you did not forget).  So you must have
> some new mechanism to record and/or infer that distinction in mind,
> but it is not clear what it is from your message.
>
> So until that is clarified, there is not much more to say if your
> "feature" has any merit---as there is no way to tell what that
> "feature" exactly is, at least not yet ;-)
> <snip>

You're right I didn't clarify, although I feel you're not providing
the most welcome response to someone who isn't as familiar with the
internals of Git as you are.

It was an oversight on my part. What I was expecting is that it would
behave exactly like branch pruning does, but that would require
"remote tracking tags", which we don't have. So, apparently my idea
doesn't hold much water.

The general problem I see in the day to day workflow with my team is
that if tags exist locally and they push, those tags continuously get
recreated on the remote repo even after I delete them remotely. So I
can never truly delete tags until I go to each person and make sure
the tool they're using isn't accidentally pushing tags. For example,
SourceTree pushes all tags by default. Everyone on my team is new to
Git, so they don't know to turn that off. Having git clean up tags
automatically would really help with this, even though you may not
feel it's the responsibility of Git. It's more of a usability issue,
it's just prone to error.

I can setup my config to prune tracking branches after I pull. Having
something like this for tags would be wonderful. However, this
requires a bigger overhaul than what I initially was proposing.
