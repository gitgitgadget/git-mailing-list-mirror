From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: suggest "reset --keep" to undo a commit
Date: Fri, 21 Jan 2011 13:14:59 -0600
Message-ID: <20110121191459.GC16325@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino>
 <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <20110121073730.GA26276@burratino>
 <7voc7ap3dp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 20:15:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgMSJ-0002rl-In
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 20:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab1AUTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 14:15:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36513 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1AUTPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 14:15:23 -0500
Received: by fxm20 with SMTP id 20so2109077fxm.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 11:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DjcMR/9LxGU+xf0hgwsd3wSA+7/Mxb4iPhFpgaRwzNo=;
        b=fIdTtyfZEmRwptHs9A4w8qhwdjzXnNU50Q/O9gBuE8Vxh2iuO0bA9ECtmQB2oKEBmG
         hwRWEW6f5YKIXiGBXmnCydye9pmgn/jJfa38st++DkbqjHKBLcoLjl/si4yZQd7jWsTR
         oJy/c6pIP+o8w450XPsZ2thfrj6W3rQpbGfwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tGMIy3jVr1wPLG+oOpA8mEFmVrWs857800lC4CGqO7bjDcGPqYVD1HZ3JGnQqLmoMT
         uOyCs8Wme7/xxf8QM1q24IViNxPHOwKoabvAKsso8+wrH/QZm95ngJTt7RkJG+Sp+RXT
         6lRj9FlseLMSndmChyxnV6SE0umaao8AvE1RM=
Received: by 10.223.110.77 with SMTP id m13mr1028988fap.86.1295637321542;
        Fri, 21 Jan 2011 11:15:21 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id a6sm275120fak.1.2011.01.21.11.15.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 11:15:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7voc7ap3dp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165390>

Junio C Hamano wrote:

> But the user could do the reviewing and thinking with some local changes
> still in the working tree (they are incredients for the fourth commit yet
> to be made) and decide to branch at that point.  The description in <1>
> needs to be updated to hint that there can be uncommitted changes, e.g.
>
> 	You have worked for some time, made a few commits, and may have
> 	uncommitted changes.  After reviewing the current state, you
> 	realized that ...
>
> Using --keep may help the user do so, but only if the local changes do not
> conflict with the changes in the recent commits to be discarded, right?

I think this explanation misses out on something.

I may be abusing git in a certain way, but I find myself in the
following situation fairly often:

	... hack hack hack ...
	git add -p;	# hmm, looks like multiple features.
	git stash -k
	... test ...
	git commit;	# commit feature #1
	git stash pop

	git add -p
	git stash -k
	... test ...
	git commit; # commit feature #2
	git stash pop

	# hmm, feature #2 is not suitable for this branch.
	git branch wip/feature-2
	git reset --keep HEAD^;	# <*>
	git add -p
	git stash -k
	... test ...
	git commit; # commit feature #3

On line <*>, I am just not thinking about the uncommitted changes.
They may be there or they may not.  If they are in the way of what I
am trying to do, "git reset --keep" will politely inform me so I can
act accordingly (usually stash, commit, or discard them).

> By the way, a more natural way to do this would actually be:
>
>     $ git checkout -b topic/wip
>     $ git branch -f @{-1} HEAD~3

True.  (I think the intended scenario was

	git branch topic/wip; # save the tip for later
	git reset --keep HEAD~3
	# now what was I working on?
	... hack hack hack ...

	# okay, now we have time for that diversion.
	git checkout topic/wip

but it would be nice to contrast it with the one you described.)

> or using the stash:
>
>     $ git stash ;# save local changes
>     $ git branch topic/wip ;# and mark the tip before rewinding
>     $ git reset --hard HEAD~3 ;# you could say --keep here too
>     $ git checkout topic/wip ;# and then continue
>     $ git stash pop ;# with the local changes

This approach leaves more files touched and more targets to be rebuilt
by "make".

> Please tell a story where keep makes more sense than hard by enhancing the
> explanatory text <1> associated with this section.  The current text says
> that the three topmost commit representing what you have recently worked
> so far are all unwanted, strongly hinting that hard is more appropriate
> thing to do than keep, which is not what we want if we are changing the
> example to use keep.

Maybe the best story would be "you have just explored a blind alley
and decided the last three commits are not a good idea at all", with
reference to a new section explaining that

 * --soft is for when the commit in preparation has the right content
   but should be on top of a different parent (e.g., squashing commits)

 * --keep is for transporting your local changes to a different commit
   (e.g., rewinding a branch or transplanting changes)

 - --merge is a limited and low-level tool for recovering from a
   conflicted merge and most often will take ORIG_HEAD as its argument.

   Maybe in the future merges will save more information so reset --merge
   can error out more often.

 - --hard is for resetting to a known state

 - --mixed is for resetting to a known state but leaving the worktree
   alone

> It would be sufficient to just hint that the uncommitted changes that you
> have in your working tree are unrelated to what these three commits wanted
> to do (e.g. you always keep small changes around, such as debugging
> printf's

That use case is less interesting to me --- it is relatively harmless
to clobber such content.
