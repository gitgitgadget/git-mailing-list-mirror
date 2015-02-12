From: David Glasser <glasser@davidglasser.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 14:16:25 -0800
Message-ID: <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net> <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com> <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM253-0000Ae-TL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbbBLWQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 17:16:49 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62096 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbBLWQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 17:16:47 -0500
Received: by mail-wi0-f172.google.com with SMTP id l15so7857436wiw.5
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WPKCrw+91ORCDVb6qit25e7g7L1RsDaM+hh7Cl1GpIQ=;
        b=DAG+Kf5Ud0SmwqKQgp8K2mbkwbdYdOZiNdIyT/e7UKV3l9qGgJZmyeT/Vs1prQ5LX4
         calviZUVXZ3oURerDnBJCB82JEdwHGlL7mXM4wJQVbsNaRPTloQMuw3DHmrC6zdt76lu
         laFllQ1+f8L/Bk+mSiZdvsVAHIMeuDwuasx8SaBbx9x871FR94XeIM8ydpf9PprifMB7
         isaMGVPDf4m7Fn/xNQZZqRg3IAOEhzwdTgZju4h2oYVy7BaKZ4T5d5279uiTFJqO5lae
         SOGupTQvtFmDLtpbde1Xjf3eDW0g4vi2h3MukbB1R20ZfhqRwn1fnaV5jjqEzvhfTDu0
         Ql+w==
X-Received: by 10.194.192.4 with SMTP id hc4mr12177138wjc.59.1423779406067;
 Thu, 12 Feb 2015 14:16:46 -0800 (PST)
Received: by 10.194.29.200 with HTTP; Thu, 12 Feb 2015 14:16:25 -0800 (PST)
In-Reply-To: <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 4uX8odx9b48gtyzY8BClXocSfVI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263773>

On Thu, Feb 12, 2015 at 1:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Glasser <glasser@davidglasser.net> writes:
>
>> Well, using -c appears to override SQUASH_MSG entirely; it replaces
>> the message as well as the author.  Often I do want to make my own
>> message based on all the messages provided by the submitter.  (And
>> typically the branch's tip is the least useful message anyway: it's
>> usually something like "respond to code review".)
>
> I wonder if there is a bug in the workflow.  Isn't the contributor
> forcing more work to the integrator that way and making it a
> responsibility of the integrator to squash multiple commits into
> one, instead of asking a cleaned-up branch to be merged in the first
> place?  It is a key to keep your project scalable to push as much
> work out of the integrator's plate to the contributors' plates.
>
> But that is an unrelated tangent.  Among the ideas floated in the
> thread, I tend to like something like what Peff mentioned earlier.

Yes, I agree that the GitHub pull request workflow has some major
disadvantages. It does a good job of enabling unsophisticated
contributors who aren't git experts to propose changes to a codebase,
but not a very good job of encouraging them to do the work of
massaging what may be a series of changes as the patch undergoes code
review into a single patch (or well-structured series of patches).  At
this point in time, the tradeoff of requiring a little more integrator
work makes sense for my project.  I'd rather spend my limited "educate
potential contributors" energy on ensuring that they include actual
reproductions with their bug reports than on getting them to do
administrative git work that isn't hard for me.

So to be concrete: What I'm proposing (and I'm excited to implement
it!) is the following:

When running "git commit" and:
- You've fallen into the case where the message was read from SQUASH_MSG
- You haven't used another method of specifying the author (--author,
  -C, -c, --amend)
- You have not specified --reset-author
- You have set the "commit.useSquashAuthor" option
- Before invoking prepare-commit-msg, all of the `Author:` lines found
  in SQUASH_MSG have the same value

then that author is used, as if it were specified with --author.  (And
this will show up, commented-out, at the bottom of COMMIT_EDITMSG.)

If you have the config option set but you don't want this logic to
take place for a particular post-squash merge, just specify
--reset-author.

I think this makes git more internally consistent, since it makes
`merge --squash` act more like the squash rebase action.  (Personally
I'd be happy if this behavior was the default, but since it is not
backwards-compatible I've included a config option in my
proposal.)

(It is my understanding, based on reading the code, that the format of
SQUASH_MSG is not user-configurable, and that scanning for Author:
lines in it is straightforward.)

--dave

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
