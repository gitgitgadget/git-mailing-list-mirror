From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 2/9] builtin-write-tree.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:05 +0200
Message-ID: <1216849332-26813-3-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1Z-00026o-5t
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbYGWVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbYGWVfv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:51 -0400
Received: from smtp.katamail.com ([62.149.157.154]:36982 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755836AbYGWVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:47 -0400
Received: (qmail 11472 invoked by uid 89); 23 Jul 2008 21:35:38 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:37 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89777>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-write-tree.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 52a3c01..25f3d8a 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -7,9 +7,12 @@
 #include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
+#include "parse-options.h"
 
-static const char write_tree_usage[] =
-"git write-tree [--missing-ok] [--prefix=<prefix>/]";
+static const char * const write_tree_usage[] = {
+	"git write-tree [--missing-ok] [--prefix=<directory>/]",
+	NULL
+};
 
 int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
@@ -19,19 +22,19 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	const char *me = "git-write-tree";
 
 	git_config(git_default_config, NULL);
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--missing-ok"))
-			missing_ok = 1;
-		else if (!prefixcmp(arg, "--prefix="))
-			prefix = arg + 9;
-		else
-			usage(write_tree_usage);
-		argc--; argv++;
-	}
 
-	if (argc > 2)
-		die("too many options");
+	const struct option options[] = {
+		OPT_BOOLEAN(0, "missing-ok", &missing_ok,
+			    "disable existence check"),
+		OPT_STRING(0, "prefix", &prefix, "directory",
+			   "write a tree object for <directory>"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, write_tree_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(write_tree_usage, options);
 
 	ret = write_cache_as_tree(sha1, missing_ok, prefix);
 	switch (ret) {
-- 
1.5.6.3
