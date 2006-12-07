X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 07 Dec 2006 13:23:00 -0800
Message-ID: <7v64cns8nf.fsf@assigned-by-dhcp.cox.net>
References: <20061207100152.GA12966@spearce.org>
	<7vlkljsd1k.fsf@assigned-by-dhcp.cox.net>
	<20061207195715.GG12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 21:23:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207195715.GG12143@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 14:57:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33634>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsQhv-0006Yr-OP for gcvg-git@gmane.org; Thu, 07 Dec
 2006 22:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163393AbWLGVXE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 16:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163394AbWLGVXE
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 16:23:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36019 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163393AbWLGVXB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 16:23:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207212300.IOML29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 16:23:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vxPA1V00o1kojtg0000000; Thu, 07 Dec 2006
 16:23:11 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > This introduces a new config option: checkout.requireSourceBranch,
>> 
>> You could turn it around and make it a per-branch configuration,
>> like:
>> 
>> 	[branch "main"]
>>         	allowbranchbydefault = true
>
> Are you suggesting that we change "git-checkout -b" to by default
> require the source branch, but the user can restore the original
> behavior by setting the above per-branch configuration option?

Under my suggestion, the new git-checkout -b (and git-branch)
would:

 (0) proceed if there is an explicit branch point specified on
     the command like, just like now;

 (1) allow omission of branch-point if the current branch has
     allowbranchbydefault configuration set as in above.  A new
     branch is created forking off of the current HEAD;

 (2) allow omission of branch-point if no branch has such
     configuration; in other words, existing repositories that
     do not have the allowbranchbydefault configuration anywhere
     are not affected.  A new branch is created forking off of
     the current HEAD;

 (3) otherwise, it barfs if you do not give an explicit
     branch-point.

and a newly created repository that is newbie friendly has one
such configuration automatically set for 'master' (if created
with git-init) or whatever the primary branch is (if created
with git-clone).

Note that (2) is rather important, although I think the current
implementation of repo-config is cumbersome to use for this
purpose and probably needs to be enhanced.

