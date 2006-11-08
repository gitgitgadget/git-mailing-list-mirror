X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Return non-zero status from pull if merge fails.
Date: Tue, 07 Nov 2006 21:36:00 -0800
Message-ID: <7vu01av6tb.fsf@assigned-by-dhcp.cox.net>
References: <20061107181053.GA26856@spearce.org>
	<7vy7qmzttk.fsf@assigned-by-dhcp.cox.net>
	<20061108051035.GA28498@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:36:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061108051035.GA28498@spearce.org> (Shawn Pearce's message of
	"Wed, 8 Nov 2006 00:10:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31118>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghg6r-00034v-D0 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754308AbWKHFgE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbWKHFgE
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:36:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4788 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1754308AbWKHFgB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:36:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061108053600.UXLI2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 8
 Nov 2006 00:36:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k5bd1V00D1kojtg0000000; Wed, 08 Nov 2006
 00:35:37 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Yes.  Without it:
>
>   $ git checkout -b 931233bc666b^
>   $ echo broken >builtin-pickaxe.c
>   $ git pull . next && echo good merge
>   Updating c2e525d..522da27
>   builtin-pickaxe.c: needs update
>   fatal: Entry 'builtin-pickaxe.c' not uptodate. Cannot merge.
>   good merge
>
> Say what?  There's no way that fast forward was good!  Granted this
> use case is horrible but that fast forward went very, very badly,
> but the caller now thinks it was good.

I think fast forward went Ok in that "git-ls-tree HEAD" gives
the correct merge result from pulling next on top of 931233^ (or
whatever).  I am undecided if we want to keep what dropsave is
supposed to remove in that case, but exiting with non-zero to
indicate an error condition is needed.

> Hmm; apparently you are correct.  But that seems like magic shell
> voodoo to me.  I honestly didn't expect exit to behave like that.

Get used to it and learn the real shell programming from a
traditionalist ;-).

	something-that-could-fail || exit

is a well established idiom.

But I do not mind the extra explicit non-zero exit status too
much as long as you are consistent.
