From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 03/10] Sparse: fix some "symbol not declared" warnings
 (Part 1)
Date: Fri, 08 Jun 2007 23:12:40 +0100
Message-ID: <4669D458.9080403@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 01:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo3c-0007G9-0j
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbXFHXjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbXFHXje
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:39:34 -0400
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:41022 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754579AbXFHXjb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 19:39:31 -0400
X-Greylist: delayed 4179 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2007 19:39:29 EDT
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1523 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-96.mail.demon.net
	with ESMTP id S794982AbXFHWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:32:27 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmxv-0005nR-2g; Fri, 08 Jun 2007 22:29:56 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49523>


The complete warning message reads something like:

    symbol 'whatever' was not declared. Should be static?

In this commit, the answer is no; the various cmd_something()
functions have been correctly declared in "builtin.h". However,
the header file has not been included in the source, which
elicits the above warning from sparse.

Also, cmd_for_each_ref(), cmd_fsck() and cmd_merge_file() required
some tweaks to their declaration, in order to conform to the
correct prototype.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-bundle.c         |    1 +
 builtin-checkout-index.c |    1 +
 builtin-fetch--tool.c    |    1 +
 builtin-for-each-ref.c   |    3 ++-
 builtin-fsck.c           |    3 ++-
 builtin-gc.c             |    1 +
 builtin-merge-base.c     |    1 +
 builtin-merge-file.c     |    7 ++++---
 builtin-pack-refs.c      |    1 +
 builtin-rerere.c         |    1 +
 builtin-runstatus.c      |    1 +
 builtin-show-ref.c       |    1 +
 12 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 306ad29..375e3ef 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -5,6 +5,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "builtin.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 8460f97..3a0c0ac 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -40,6 +40,7 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "builtin.h"
 
 #define CHECKOUT_ALL 4
 static int line_termination = '\n';
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 12adb38..a1d51d0 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
+#include "builtin.h"
 
 #define CHUNK_SIZE 1024
 
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 2b21842..3ca77b5 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -6,6 +6,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "quote.h"
+#include "builtin.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -796,7 +797,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
 
-int cmd_for_each_ref(int ac, const char **av, char *prefix)
+int cmd_for_each_ref(int ac, const char **av, const char *prefix)
 {
 	int i, num_refs;
 	const char *format = NULL;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 44ce629..776a435 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -7,6 +7,7 @@
 #include "pack.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "builtin.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -607,7 +608,7 @@ static const char fsck_usage[] =
 "git-fsck [--tags] [--root] [[--unreachable] [--cache] [--full] "
 "[--strict] <head-sha1>*]";
 
-int cmd_fsck(int argc, char **argv, const char *prefix)
+int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
 
diff --git a/builtin-gc.c b/builtin-gc.c
index 3b1f8c2..2ca5e77 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -12,6 +12,7 @@
 
 #include "cache.h"
 #include "run-command.h"
+#include "builtin.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index e35d362..f026e5a 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "builtin.h"
 
 static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
 {
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 9135773..a3830c3 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -1,13 +1,14 @@
 #include "cache.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "builtin.h"
 
 static const char merge_file_usage[] =
 "git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
-int cmd_merge_file(int argc, char **argv, char **envp)
+int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
-	char *names[3];
+	const char *names[3];
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
@@ -47,7 +48,7 @@ int cmd_merge_file(int argc, char **argv, char **envp)
 		free(mmfs[i].ptr);
 
 	if (ret >= 0) {
-		char *filename = argv[1];
+		const char *filename = argv[1];
 		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
 
 		if (!f)
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index d080e30..1a7d131 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
+#include "builtin.h"
 
 static const char builtin_pack_refs_usage[] =
 "git-pack-refs [--all] [--prune | --no-prune]";
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 8c2c8bd..c4d4178 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -2,6 +2,7 @@
 #include "path-list.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "builtin.h"
 
 #include <time.h>
 
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 4b489b1..d7b04cb 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "wt-status.h"
+#include "builtin.h"
 
 extern int wt_status_use_color;
 
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 9463ff0..f70e9a2 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "path-list.h"
+#include "builtin.h"
 
 static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
 
-- 
1.5.2
