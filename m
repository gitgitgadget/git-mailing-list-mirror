X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Mon, 27 Nov 2006 16:09:53 -0800
Message-ID: <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
	<Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 00:10:17 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 28 Nov 2006 00:46:33 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32467>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoqXv-0008P8-JX for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933563AbWK1AJz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbWK1AJz
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:09:55 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15329 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S933563AbWK1AJy
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:09:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128000953.UHYU9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 19:09:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s09M1V00W1kojtg0000000; Mon, 27 Nov 2006
 19:09:22 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As for reducing the number of lines in the shortlog: taking myself as an 
> example, I often touch the same code several times, just to fix bugs. So, 
> if the same code was touched several times, just take the first oneline, 
> and add "(+fixes)". Of course, this is more like a wedding between 
> shortlog and annotate, and likely to be slow.

Interesting.  While driving to work this morning I had the same
thought.  A revision that does not appear in the output from

	for file in $(list of files the commit touches)
        do
		git blame v2.6.17..v2.6.18 -- $file
	done

can safely be omitted from the shortlog, because later changes
fully supersedes it.

I think the list of "important" changes is an interesting
problem, but the importance may not directly be related to the
number of paths a patch touches (e.g. "you reorder the members
of a structure everybody uses in one include file and everything
starts performing faster due to better cache behaviour" would be
a few lines of a single header file).  Also better clues to
judge the importance would be found outside the repository.
"The patch discussed by many people on the list" and "the patch
that had very many iteration to get in the final shape" would
certainly be interesting ones, but that information is often not
found in the repository.

