X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Fri, 08 Dec 2006 18:24:31 -0800
Message-ID: <7vac1xg61s.fsf@assigned-by-dhcp.cox.net>
References: <20061130115913.EA36C5BA19@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 02:24:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061130115913.EA36C5BA19@nox.op5.se> (Andreas Ericsson's
	message of "Thu, 30 Nov 2006 12:43:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33790>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsrtM-0004fX-87 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 03:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761352AbWLICYd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 21:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761351AbWLICYd
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 21:24:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63435 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761352AbWLICYd (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 21:24:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209022432.HSCG97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Fri, 8 Dec
 2006 21:24:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wSPv1V00L1kojtg0000000; Fri, 08 Dec 2006
 21:23:55 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> 'git diff --cached' still works, but its use is discouraged
> in the documentation. 'git diff --index' does the same thing
> and is consistent with how 'git apply --index' works.

Although I've applied this long time ago (in git timescale
anyway), this patch and the above rationale is wrong.

'diff --cached' is more in line with how 'apply --cached' works,
not how 'apply --index' works.

With apply, --cached and --index both tell the command to be
aware of the index, but --cached means "operate on the index,
and never look at working tree", while --index means "operate
both on the index and working tree at the same time".  In
particular, the former does not care if the file in the working
tree matches the index, while the latter does.

'diff --cached' is about the tree and the index without looking
at the working tree.  Since there is no mode of operation that
looks at both the index and the working tree in the underlying
diff-index, I made the mistake of applying this patch, but it is
conceivable that we may want to have a 'diff --index' that
compares HEAD, the index and the working tree, perhaps in a
combined diff format.

I think we should revert this patch.
