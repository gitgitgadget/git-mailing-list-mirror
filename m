From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix a typo in crlf conversion code
Date: Sun, 22 Apr 2007 16:12:22 +0200
Message-ID: <20070422141222.GC2431@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 16:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfcnl-0006Zx-9z
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 16:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030887AbXDVOMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbXDVOMZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 10:12:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40859 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030887AbXDVOMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 10:12:24 -0400
Received: from tigra.home (Fcb6c.f.strato-dslnet.de [195.4.203.108])
	by post.webmailer.de (mrclete mo64) (RZmta 5.6)
	with ESMTP id G03632j3M98SEL ; Sun, 22 Apr 2007 16:12:23 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EFE0F277BD;
	Sun, 22 Apr 2007 16:12:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id EBFDABDDE; Sun, 22 Apr 2007 16:12:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsD+I4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45241>

Also, noticed by valgrind: the code caused a read out-of-bounds.
Some comments updated as well (they still reflected old calling
conventions).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 convert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index 37239ac..ad106ef 100644
--- a/convert.c
+++ b/convert.c
@@ -115,8 +115,8 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 	}
 
 	/*
-	 * Ok, allocate a new buffer, fill it in, and return true
-	 * to let the caller know that we switched buffers on it.
+	 * Ok, allocate a new buffer, fill it in, and return it
+	 * to let the caller know that we switched buffers.
 	 */
 	nsize = size - stats.crlf;
 	buffer = xmalloc(nsize);
@@ -137,7 +137,7 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 	} else {
 		do {
 			unsigned char c = *src++;
-			if (! (c == '\r' && (1 < size && *buffer == '\n')))
+			if (! (c == '\r' && (1 < size && *src == '\n')))
 				*dst++ = c;
 		} while (--size);
 	}
@@ -180,8 +180,8 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	}
 
 	/*
-	 * Ok, allocate a new buffer, fill it in, and return true
-	 * to let the caller know that we switched buffers on it.
+	 * Ok, allocate a new buffer, fill it in, and return it
+	 * to let the caller know that we switched buffers.
 	 */
 	nsize = size + stats.lf - stats.crlf;
 	buffer = xmalloc(nsize);
-- 
1.5.1.1.946.gdb75a
