X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Tue, 12 Dec 2006 22:33:21 -0800
Message-ID: <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 06:34:09 +0000 (UTC)
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 13 Dec 2006 04:05:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34184>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuNgo-0003b9-6B for gcvg-git@gmane.org; Wed, 13 Dec
 2006 07:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964945AbWLMGd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWLMGd1
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 01:33:27 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:65038 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964945AbWLMGd0 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 01:33:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213063322.RDVU7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 13
 Dec 2006 01:33:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id y6Yj1V00A1kojtg0000000; Wed, 13 Dec 2006
 01:32:43 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unify the handling for cases C (add/add) and D (modify/modify).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Tue, 12 Dec 2006, Junio C Hamano wrote:
>
> 	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 	> 
> 	> > How about this: if there is an add/add conflict, we treat it 
> 	> > as if there _was_ an empty file, and we let the shiny new 
> 	> > xdl_merge() find the _true_ conflicts, _instead of_ removing 
> 	> > the file from the index, adding both files with different 
> 	> > "~blabla" markers appended to their file names to the working 
> 	> > directory.
> 	> 
> 	> I was not thinking about this t6024 test failure problem but was
> 	> wondering about doing exactly that in merge-recursive to match
> 	> the "two file merge" magic we have in git-merge-one-file.sh
>
> 	As can be seen with the test case, the result is more pleasing.

This fixes the behaviour in "both branches add the path
differently" case.  Previously merge-recursive did not create
the working tree file, but now it does just like merge-resolve.

Although I would feel very happy about this change, Catalin
might want to be informed about potential interaction this
change might have with his commit 8d41555 in StGIT.
