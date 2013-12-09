From: Brett Randall <javabrett@gmail.com>
Subject: Re: A couple of rebase --autosquash proposals
Date: Mon, 9 Dec 2013 20:52:21 +1100
Message-ID: <CALeEUB5kaJ0j2qqzDN4ZcZbQ1W3Zttvmuqr73Jv+i79FM=b4eg@mail.gmail.com>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
	<52A56887.4070909@viscovery.net>
	<52A58CBB.6040809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 10:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpxVr-0001XW-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 10:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab3LIJwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 04:52:24 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54253 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132Ab3LIJwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 04:52:22 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so5645688ieb.39
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gSGV5pOnNEx/guyqlup1nxRIkGqbx4ifvgLNDXYizYc=;
        b=Jg/Y09MQvczBMciY81UyQB9OYNPoPUci4lIf56mN0iX4b+UGTmhxblCcwIf7rRwjhL
         zZxnQppJZykSsna9c4SY2FAjMzx66nnV+BPKRmO7f/g16Obfz/zjGasVL4zv3znuyAPw
         ZEMME/EILYkxtEwJcBYKQEj4bHgqqMuEluhfSKrzNm43djq4wlG9mZ8e9Vq2ukG/y7+D
         UnX8C9Cm2JbF6nQpB6eKDxPFUbNhRrMzhjLlWp7otjs3TQAbrTwlkI6cvwUEy/wtJW+Y
         suBvTIVhlDjVq9r4zigb6QWcuQZpAU4jyRkC/ptYCeIo5miqIjTwf8e4GGaV0Up8tffh
         p48g==
X-Received: by 10.42.113.66 with SMTP id b2mr51272175icq.21.1386582741254;
 Mon, 09 Dec 2013 01:52:21 -0800 (PST)
Received: by 10.64.126.169 with HTTP; Mon, 9 Dec 2013 01:52:21 -0800 (PST)
In-Reply-To: <52A58CBB.6040809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239064>

This aims to support code-review workflows of teams that prefer rebase
over merge, when committing a new peer-reviewed feature.

* Developer starts with commit OM, commits A.
* During testing, the developer may make further changes, either
through --amend or new commits, but either way, all work is rebased to
a single new commit for review, OM -> A' .
* A' is pushed as a new branch to origin for team review.  The review
system facilitates the review of the change, and review comments are
made.
* The developer responds to the review comments by making changes in
commits B and C, and pushes OM -> A' -> B -> C.  Reviewers can
understand the feedback that has been addressed in the changes with
through the commit-log in B and C.
* Code passes review.  Because the team prefers rebased commits, A'..C
is rebased onto the current OM (which may now be OM+10) and committed.

If the commit-log entries for B and C allow simultaneous
fixup!/squash! syntax together with and free-text log-text, they can
serve both purposes: 1) they communicate that the change is a
feedback-generated fix (rather than a new feature), and describe which
parts of the feedback each commit addresses, and 2) they pre-empt and
support the eventual rebase-before-origin-push, through --autosquash
annotation.

Brett

On 9 December 2013 20:26, Chris Packham <judge.packham@gmail.com> wrote:
> On 09/12/13 19:51, Johannes Sixt wrote:
>> Am 12/9/2013 3:23, schrieb Brett Randall:
>>> * fixup! or squash! on it's own would default to fixing-up the
>>> previous commit (or result of previous step of rebase if that was a
>>> squash/fixup).
>>
>> Why would you want that? To fixup the previous commit, just use 'git
>> commit --amend'. What am I missing?
>
> In the past I've used this kind of approach when doing merging/porting
> work with 3rd party code (or just large integrations). The first (and
> eventually final) commit introduces the new code. The subsequent fixups
> address build issues which are either errors in the 3rd party code
> (which I will want to submit bug reports for later and carry in my tree
> as real commits) or errors in my merging (which I want to squash into
> the merge commit). When faced with a screen full of compilation errors
> I'm not sure which of these 2 categories are applicable at the time so I
> tend to have lots of little fixups that I need to juggle around with git
> rebase once I've got the code compiling and passing some tests.
>
> All that being said I think allowing multiple "fixup!\n" stack up on
> each other might be a bit dangerous. There are cases where
> fixup!-fixup!-real might be useful but those would be hard to
> distinguish those from cases where someone absent mindedly forgot to put
> something after "fixup!".
