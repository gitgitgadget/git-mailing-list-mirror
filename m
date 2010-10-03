From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 4/6] Rename get_mode() to decode_tree_mode() and export it
Date: Sun,  3 Oct 2010 14:21:49 +0200
Message-ID: <1286108511-55876-4-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaC-0005Mv-Lq
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab0JCMWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:12 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60851
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184Ab0JCMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:11 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id EEDB2245A752; Sun,  3 Oct 2010 14:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157865>

Other sources (fast-import-helper.c) may want to use this function
to parse trees.

Signed-off-by: Tomas Carnecky <tom@dbservice.com>
---
 tree-walk.c |    4 ++--
 tree-walk.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index a9bbf4e..5f51f4e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -3,7 +3,7 @@
 #include "unpack-trees.h"
 #include "tree.h"
 
-static const char *get_mode(const char *str, unsigned int *modep)
+const char *decode_tree_mode(const char *str, unsigned int *modep)
 {
 	unsigned char c;
 	unsigned int mode = 0;
@@ -28,7 +28,7 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 	if (size < 24 || buf[size - 21])
 		die("corrupt tree file");
 
-	path = get_mode(buf, &mode);
+	path = decode_tree_mode(buf, &mode);
 	if (!path || !*path)
 		die("corrupt tree file");
 	len = strlen(path) + 1;
diff --git a/tree-walk.h b/tree-walk.h
index 7e3e0b5..6bbde1c 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -13,6 +13,8 @@ struct tree_desc {
 	unsigned int size;
 };
 
+const char *decode_tree_mode(const char *str, unsigned int *modep);
+
 static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
 	*pathp = desc->entry.path;
-- 
1.7.3.37.gb6088b
