From: Tony Finch <dot@dotat.at>
Subject: [PATCH] wrapper.c: simplify xread() and xwrite()
Date: Sun, 04 Apr 2010 23:06:59 +0100
Message-ID: <E1NyXy7-0005j7-14@hermes-2.csi.cam.ac.uk>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 05 00:07:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXyd-00056L-G6
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0DDWHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:07:02 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:49157 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0DDWHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:07:00 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:44391)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1NyXy7-0004SX-GI (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Sun, 04 Apr 2010 23:06:59 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1NyXy7-0005j7-14 (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Sun, 04 Apr 2010 23:06:59 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143953>

do/while is more straightforward than while(1)/if/continue/return.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 wrapper.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 9c71b21..f34f492 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -116,12 +116,10 @@ void *xmmap(void *start, size_t length,
 ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
-	while (1) {
+	do {
 		nr = read(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
-		return nr;
-	}
+	} while ((nr < 0) && (errno == EAGAIN || errno == EINTR));
+	return nr;
 }
 
 /*
@@ -132,12 +130,10 @@ ssize_t xread(int fd, void *buf, size_t len)
 ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
-	while (1) {
+	do {
 		nr = write(fd, buf, len);
-		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
-			continue;
-		return nr;
-	}
+	} while ((nr < 0) && (errno == EAGAIN || errno == EINTR));
+	return nr;
 }
 
 ssize_t read_in_full(int fd, void *buf, size_t count)
-- 
1.6.2.1
