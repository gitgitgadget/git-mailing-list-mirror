From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] merge-recur: Get rid of debug code
Date: Thu, 27 Jul 2006 19:12:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271912310.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:13:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69Ps-0002II-EK
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWG0RMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWG0RMx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:12:53 -0400
Received: from mail.gmx.net ([213.165.64.21]:59777 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750971AbWG0RMx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:12:53 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:12:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 27 Jul 2006 19:12:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24310>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   65 +----------------------------------------------------
 1 files changed, 1 insertions(+), 64 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b0035cc..8d9451f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,56 +22,6 @@ #include "tag.h"
 
 #include "path-list.h"
 
-/*#define DEBUG*/
-
-#ifdef DEBUG
-#define debug(...) fprintf(stderr, __VA_ARGS__)
-#else
-#define debug(...) do { ; /* nothing */ } while (0)
-#endif
-
-#ifdef DEBUG
-#include "quote.h"
-static void show_ce_entry(const char *tag, struct cache_entry *ce)
-{
-	if (tag && *tag &&
-	    (ce->ce_flags & htons(CE_VALID))) {
-		static char alttag[4];
-		memcpy(alttag, tag, 3);
-		if (isalpha(tag[0]))
-			alttag[0] = tolower(tag[0]);
-		else if (tag[0] == '?')
-			alttag[0] = '!';
-		else {
-			alttag[0] = 'v';
-			alttag[1] = tag[0];
-			alttag[2] = ' ';
-			alttag[3] = 0;
-		}
-		tag = alttag;
-	}
-
-	fprintf(stderr,"%s%06o %s %d\t",
-			tag,
-			ntohl(ce->ce_mode),
-			sha1_to_hex(ce->sha1),
-			ce_stage(ce));
-	write_name_quoted("", 0, ce->name,
-			'\n', stderr);
-	fputc('\n', stderr);
-}
-
-static void ls_files(void) {
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		show_ce_entry("", ce);
-	}
-	fprintf(stderr, "---\n");
-	if (0) ls_files(); /* avoid "unused" warning */
-}
-#endif
-
 /*
  * A virtual commit has
  * - (const char *)commit->util set to the name, and
@@ -346,13 +296,9 @@ static int save_files_dirs(const unsigne
 static int get_files_dirs(struct tree *tree)
 {
 	int n;
-	debug("get_files_dirs ...\n");
-	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs) != 0) {
-		debug("  get_files_dirs done (0)\n");
+	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs) != 0)
 		return 0;
-	}
 	n = current_file_set.nr + current_directory_set.nr;
-	debug("  get_files_dirs done (%d)\n", n);
 	return n;
 }
 
@@ -434,11 +380,6 @@ static struct path_list *get_renames(str
 	int i;
 	struct path_list *renames;
 	struct diff_options opts;
-#ifdef DEBUG
-	time_t t = time(0);
-
-	debug("get_renames ...\n");
-#endif
 
 	renames = xcalloc(1, sizeof(struct path_list));
 	diff_setup(&opts);
@@ -479,9 +420,6 @@ #endif
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_queued_diff.nr = 0;
 	diff_flush(&opts);
-#ifdef DEBUG
-	debug("  get_renames done in %ld\n", time(0)-t);
-#endif
 	return renames;
 }
 
@@ -829,7 +767,6 @@ static void conflict_rename_rename_2(str
 	free(new_path1);
 }
 
-/* General TODO: get rid of all the debug messages */
 static int process_renames(struct path_list *a_renames,
 			   struct path_list *b_renames,
 			   const char *a_branch,
-- 
1.4.2.rc2.g6a4e
