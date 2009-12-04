From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 04 Dec 2009 16:13:05 +0100
Message-ID: <4B192701.4000308@drmicha.warpmail.net>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZrX-0005fp-1j
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbZLDPOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZLDPOO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:14:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59911 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751168AbZLDPOO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 10:14:14 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A1D37C3FB7;
	Fri,  4 Dec 2009 10:14:20 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 04 Dec 2009 10:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Utun5CqtRXnw3w1WJlsank7ifUk=; b=Lt5Zr/iFA9MGH/cY1PnVOLNQrWHKaElrD9Xpd5Vt2mM89e+pAYr5MqwAKMHHnOjQMFk74mIAdW90A9Qg6uwSIyNs4CTm9aTwWF3u6kiXs37oWyt0QObQas01OcvTaH8BMZ1yxcdhwYFF1pOLh4OO3A8LeyKVI0DfkrWw3/2Caow=
X-Sasl-enc: EpUTzHwwfwD2afmoprZwWVoeOJI16BgF+FjVS3y22R6M 1259939660
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A839532B0E;
	Fri,  4 Dec 2009 10:14:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134515>

Michael Haggerty venit, vidit, dixit 04.12.2009 15:36:
> This patch series adds "fix" to the commands that can be used within
> the "rebase --interactive" patch editor.  "fix" is like "squash"
> except that it discards the log message of the corresponding commit.
> 
> Why I would like this feature:
> 
> One of my favorite aliases is
> 
>     fix = commit --amend -C HEAD
> 
> which I use in those all-too-frequent head-slapping "I just committed
> something with a minor typo" moments.  It amends the last commit with
> whatever is staged, reusing the same commit message.  It can also be
> used with the "-a" option, a list of filenames, etc.
> 
> But sometimes I don't have my head-slapping moments until a few
> commits later.  In this case, my usual practice is to commit the
> trivial typo change on top of the current branch, then "rebase
> --interactive" to move the typo fix on top of the erroneous commit and
> squash it:
> 
> pick 05d3b81 Commit with typo
> pick c29114a Good commit 1
> pick 250b013 Good commit 2
> pick 5eb3299 Fix for typo
> 
>         |
>         V
> 
> pick 05d3b81 Commit with typo
> squash 5eb3299 Fix for typo
> pick c29114a Good commit 1
> pick 250b013 Good commit 2
> 
> But then it is necessary to go into the commit message editor, move
> the cursor down past the first commit message, delete the "Fix for
> typo" commit message, save, and quit.
> 
> This patch implements a "fix" command, similar to "squash", except
> that the corresponding log message is not included in the log message
> suggested for the combined commit.  (In fact, it includes the log
> message, but commented out.)  It therefore saves the editor chores.
> 
> "fix" and "squash" can be used in the same group, in which case the
> "squash" commit messages are preserved and the "fix" commit messages
> are skipped.
> 
> If the idea of a "fix" command is acceptable, then I would like to
> implement a further convenience: if a group of commits to be folded
> together includes *only* "fix" commits, then the first log message
> should be used without even opening an editor.  But I would like to
> get a reaction to the "fix" command in general before doing so.

I'd say that would make a useful command ("fix") even more useful, being
just the right counterpart to "reword" for trivial commit message fixes.

OTOH, it would not be possible any more to squash in a few fixes and
then edit the message. Maybe having to quit the editor is not that much
work after all.

As a bike-shedding side note: So far, all commands are verbs which
describe actions to take on that commit. In that sense a "fix deadbeef"
would be confusing: You don't fix deadbeef, you fix the predecessor
using deadbeef.

A bit of brainstorming (suck/use/smash/apply/join) does not convince me
of any of my alternatives, but maybe they convince someone else :)

Michael

P.S.: I thought there's some heavy rb-i rewrite in progress (sequencer
based or not?), but you cc'ed Dscho anyway who knows best.

> Michael Haggerty (3):
>   Better document the original repository layout.
>   Set a couple more tags in the original repository.
>   Add a command "fix" to rebase --interactive.
> 
>  Documentation/git-rebase.txt  |   13 ++++++++-----
>  git-rebase--interactive.sh    |   39 +++++++++++++++++++++++++++++----------
>  t/lib-rebase.sh               |    7 ++++---
>  t/t3404-rebase-interactive.sh |   41 +++++++++++++++++++++++++++++++++++++----
>  4 files changed, 78 insertions(+), 22 deletions(-)
> 
