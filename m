X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 02:10:01 -0800
Message-ID: <7vpsapwhl2.fsf@assigned-by-dhcp.cox.net>
References: <200612120641.52556.andyparkins@gmail.com>
	<457E6C65.4B6D131@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 10:10:17 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457E6C65.4B6D131@eudaptics.com> (Johannes Sixt's message of
	"Tue, 12 Dec 2006 09:46:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34076>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu4aP-0007ba-BM for gcvg-git@gmane.org; Tue, 12 Dec
 2006 11:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932181AbWLLKKE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 05:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWLLKKE
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 05:10:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48617 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751098AbWLLKKC (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 05:10:02 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212101002.WLEM15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 05:10:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xmAC1V00n1kojtg0000000; Tue, 12 Dec 2006
 05:10:13 -0500
To: Johannes Sixt <J.Sixt@eudaptics.com>
Sender: git-owner@vger.kernel.org

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Andy Parkins wrote:
>> This patch chooses green for local, red for remote and bold green for
>> current.
>
> Sorry for chiming in so late, but red and green are usually poor choices
> since red-green color-blindness is surprisingly frequent...
>
> Maybe its sufficient to have just the remote branches (dark-)red, and
> the rest in the default color, with the current branch bold?

Even without red-green blindness issue, I think that makes
sense.  colored-diff uses green/red for added/deleted but that
is shown against the context in plain.  A sane thing to do for
branch listing would be to show the usual case (i.e. local) in
plain and show the remote ones differently.

Something like this on top of Andy's?

If we keep '*' prefix for the current one, I do not see a reason
to show it in a different color from other local branches, by
the way, but I did not go that far in this patch.

---
diff --git a/builtin-branch.c b/builtin-branch.c
index 7c87b8d..d1c243d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -23,8 +23,8 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
 	"",		/* PLAIN (normal) */
 	"\033[31m",	/* REMOTE (red) */
-	"\033[32m",	/* LOCAL (green) */
-	"\033[1;32m",	/* CURRENT (boldgreen) */
+	"",		/* LOCAL (normal) */
+	"\033[32m",	/* CURRENT (green) */
 };
 enum color_branch {
 	COLOR_BRANCH_RESET = 0,
