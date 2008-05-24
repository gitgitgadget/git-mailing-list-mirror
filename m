From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/5] Make verbosity configurable in reset_index_file()
Date: Sat, 24 May 2008 02:01:06 +0200
Message-ID: <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
 <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
 <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhD2-00012y-L2
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943AbYEXABK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758939AbYEXABK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:10 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36660 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYEXABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:07 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 90FEF1DDC5E
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AFCC7185E19; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
In-Reply-To: <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82774>

Till now reset_index_file() was always verbose. Add a new argument to be
able to disable this behaviour.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-reset.c |    2 +-
 reset.c         |    5 +++--
 reset.h         |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 6e6e168..179c59c 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -216,7 +216,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
 	}
-	else if (reset_index_file(sha1, (reset_type == HARD)))
+	else if (reset_index_file(sha1, (reset_type == HARD), 1))
 		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
diff --git a/reset.c b/reset.c
index a75fec6..baae947 100644
--- a/reset.c
+++ b/reset.c
@@ -11,13 +11,14 @@
 #include "cache.h"
 #include "run-command.h"
 
-int reset_index_file(const unsigned char *sha1, int is_hard_reset)
+int reset_index_file(const unsigned char *sha1, int is_hard_reset, int verbose)
 {
 	int i = 0;
 	const char *args[6];
 
 	args[i++] = "read-tree";
-	args[i++] = "-v";
+	if (verbose)
+		args[i++] = "-v";
 	args[i++] = "--reset";
 	if (is_hard_reset)
 		args[i++] = "-u";
diff --git a/reset.h b/reset.h
index 4ae235b..c43ae22 100644
--- a/reset.h
+++ b/reset.h
@@ -1,6 +1,6 @@
 #ifndef RESET_H
 #define RESET_H
 
-int reset_index_file(const unsigned char *sha1, int is_hard_reset);
+int reset_index_file(const unsigned char *sha1, int is_hard_reset, int verbose);
 
 #endif
-- 
1.5.5.1.357.g1af8b.dirty
