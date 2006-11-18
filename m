X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 10:49:13 -0800
Message-ID: <7vfycgegk6.fsf@assigned-by-dhcp.cox.net>
References: <455F1595.9020009@lsrfire.ath.cx>
	<20061118092644.a9f15669.seanlkml@sympatico.ca>
	<20061118143511.GM7201@pasky.or.cz> <455F210B.8000107@lsrfire.ath.cx>
	<BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 18:49:24 +0000 (UTC)
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 18 Nov 2006 11:04:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31790>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVFe-0008L4-SU for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756368AbWKRStQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbWKRStQ
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:49:16 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:2301 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1756367AbWKRStP
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:49:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118184914.UECS21630.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 13:49:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oJom1V0011kojtg0000000; Sat, 18 Nov 2006
 13:48:46 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> On Sat, 18 Nov 2006 16:04:43 +0100
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>
>> git-status is a wrapper around git-runstatus that takes the same
>> options as git-commit.  It could have been named 'git-commit --dry-run'.
>
> What could be said in the docs as to when the use of one is preferred
> over the other?

You should treat git-runstatus the same way as you would treat
"git-merge-recursive".  It strictly is a helper and you never
use it by itself.

It takes the parts that are too cumbersome to be enhanced in
shell script from the old git-status script, and rewrites it in
C.

"git-status $args" is to give a preview of the commit that would
be made with "git-commit $args" (where $args can be things like
-a, $paths...).  The part that still remain as script in
git-commit and git-status performs the gory details of index
preparation for the next commit, and tells git-runstatus to show
the status of that index and the working tree relative to the
current HEAD.

Most notably, running "git-update-index --refresh" part is still
done in the script part that calls runstatus, so in a
cache-dirty but otherwise clean tree, running git-runstatus and
then git-status (without any parameters) in this order would
show cache dirty paths in the former but not in the latter (nor
after the latter runs once, since it calls --refresh).
 

