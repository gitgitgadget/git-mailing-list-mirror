From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] file_exists(): dangling symlinks do exist
Date: Sun, 18 Nov 2007 02:21:24 -0800
Message-ID: <1195381287-26823-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthHr-0007vO-16
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXKRKVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXKRKVb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:21:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44235 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbXKRKVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:21:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 273FC2EF
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DB19196153
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:51 -0500 (EST)
X-Mailer: git-send-email 1.5.3.5.1815.g9445b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65357>

This function is used to see if a path given by the user does exist
on the filesystem.  A symbolic link that does not point anywhere does
exist but running stat() on it would yield an error, and it incorrectly
said it does not exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 01790ab..87e5dec 100644
--- a/dir.c
+++ b/dir.c
@@ -688,11 +688,10 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 	return dir->nr;
 }
 
-int
-file_exists(const char *f)
+int file_exists(const char *f)
 {
-  struct stat sb;
-  return stat(f, &sb) == 0;
+	struct stat sb;
+	return lstat(f, &sb) == 0;
 }
 
 /*
-- 
1.5.3.5.1815.g9445b
