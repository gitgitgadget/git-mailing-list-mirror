X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t6024: fix timing problem
Date: Tue, 12 Dec 2006 15:23:16 -0800
Message-ID: <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 23:38:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 898 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 18:38:15 EST
In-Reply-To: <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 12 Dec 2006 23:49:34 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34167>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHCj-0006aa-VH for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932562AbWLLXiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWLLXiQ
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:38:16 -0500
Received: from fed1rmmtai01.cox.net ([68.230.241.58]:56213 "EHLO
 fed1rmmtai01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932562AbWLLXiP (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 18:38:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212232317.NSYL20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 18:23:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xzPU1V00F1kojtg0000000; Tue, 12 Dec 2006
 18:23:28 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This script tests a complicated merge, where _all_ files conflict. In
> these circumstances, the ordering of the commits -- which is affected
> not by the timestamps in the commit message -- becomes a deciding factor
> of the merge result.

"not by the timestamps", or "by the timestamps"?  I am
confused...

Do you mean the commit timestamps affect which merge base commit
becomes ours and theirs during the computation of the virtual
merge base commit?  That certainly explains the problem.

> 	How about this: if there is an add/add conflict, we treat it as
> 	if there _was_ an empty file, and we let the shiny new xdl_merge()
> 	find the _true_ conflicts, _instead of_ removing the file from
> 	the index, adding both files with different "~blabla" markers
> 	appended to their file names to the working directory.

I was not thinking about this t6024 test failure problem but was
wondering about doing exactly that in merge-recursive to match
the "two file merge" magic we have in git-merge-one-file.sh ---
I guess great minds do think alike ;-).


