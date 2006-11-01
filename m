X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [RFHC] _XOPEN_SOURCE and OpenBSD 3.9
Date: Wed, 01 Nov 2006 00:16:01 -0800
Message-ID: <7vbqnr8tvi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 08:16:15 +0000 (UTC)
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30619>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBGe-00012Z-8i for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946696AbWKAIQF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946697AbWKAIQF
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:16:05 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29180 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1946696AbWKAIQC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:16:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101081602.LEJE18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Wed, 1
 Nov 2006 03:16:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id hLFh1V00A1kojtg0000000 Wed, 01 Nov 2006
 03:15:42 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was futzing with an OpenBSD 3.9 bochs today, and it appears
that without __BSD_VISIBILITY we get a complaint from the
compiler that says S_ISLNK() is implicitly declared function
(cache.h has an inline create_ce_mode() that uses this macro).

I do not think this breaks things on Linux boxes, but I do not
have access to other archs, hence this request for help and
comments.

Jason Riedy CC'ed who did the initial _XOPEN_SOURCE=500 for AIX
portability.

Oh, yes, I know OpenBSD 4.0 is very soon coming...

diff --git a/convert-objects.c b/convert-objects.c
index 631678b..2ff19d2 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,4 +1,4 @@
-#define _XOPEN_SOURCE 500 /* glibc2 and AIX 5.3L need this */
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500; 600 for OBSD */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #define _GNU_SOURCE
 #include <time.h>
