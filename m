From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] resolve-undo.c: silence compiler complaints by casting void * to char *
Date: Mon,  1 Feb 2010 17:00:00 -0600
Message-ID: <qzbyPiTgRGI0lsxvEmFa0WtwK5ko5snXQDNffxC66y9v0rlie5pcKzGT28WpzfQlFd0OvJNY_jo@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 02 00:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc5G6-0003NB-5P
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0BAXAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:00:35 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54107 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0BAXAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:00:35 -0500
Received: by mail.nrlssc.navy.mil id o11N0LQx005178; Mon, 1 Feb 2010 17:00:21 -0600
X-OriginalArrivalTime: 01 Feb 2010 23:00:21.0701 (UTC) FILETIME=[54D0E750:01CAA392]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138655>

From: Brandon Casey <drafnel@gmail.com>

Some compilers produce errors when arithmetic is attempted on pointers to
void.  We want computations done on byte addresses, so cast them to char *
to work them around.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 resolve-undo.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 37d73cd..c259fe6 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -75,7 +75,7 @@ struct string_list *resolve_undo_read(void *data, unsigned long size)
 			lost->util = xcalloc(1, sizeof(*ui));
 		ui = lost->util;
 		size -= len;
-		data += len;
+		data = (char*) data + len;
 
 		for (i = 0; i < 3; i++) {
 			ui->mode[i] = strtoul(data, &endptr, 8);
@@ -85,7 +85,7 @@ struct string_list *resolve_undo_read(void *data, unsigned long size)
 			if (size <= len)
 				goto error;
 			size -= len;
-			data += len;
+			data = (char*) data + len;
 		}
 
 		for (i = 0; i < 3; i++) {
@@ -95,7 +95,7 @@ struct string_list *resolve_undo_read(void *data, unsigned long size)
 				goto error;
 			hashcpy(ui->sha1[i], data);
 			size -= 20;
-			data += 20;
+			data = (char*) data + 20;
 		}
 	}
 	return resolve_undo;
-- 
1.6.6
