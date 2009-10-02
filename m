From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] MSVC: fix build warnings
Date: Sat, 3 Oct 2009 07:40:08 +1000
Message-ID: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 23:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtpxr-0003K5-HX
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 23:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbZJBVqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbZJBVqt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 17:46:49 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58908 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbZJBVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 17:46:47 -0400
Received: by gxk4 with SMTP id 4so1922279gxk.8
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=QRKLEPMz9PRhZVewBoaPeeGgXoG5h2PSwoklHI+ydM4=;
        b=LSnwCbuFpvlx8Od/j9aRlEnsTGHH19rCgAne/q8s6Ueu2LpVbXfhYX3Thur2IfQi2p
         9wt8orrJ9vCmo54qaqwaH4iaqeeu6xjAX3A7XM09tojqomq/0JUyjZ8L64/CouUQhMHg
         DOuejGhWEwuktOMB8Cq5Bg4L5eST+a3NcY8VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=DBZBgxh6JaFXp9UeZkQ/MHlf2iBDdRl6dRUSWLYEiumRZF2c0YcvStj0eryz/5fwiT
         uSCCYvu+q5O6Oey0C+27pnmo4nb9OfEzPZldOJb3BCEotvNwe3NQFNHhHtEfwx0lL6W0
         WBym7pnC1FWI56yTTDkVqKM9JmLwepqTNqxKc=
Received: by 10.101.176.35 with SMTP id d35mr3402775anp.170.1254519628080; 
	Fri, 02 Oct 2009 14:40:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129460>

When building with MSVC, the following warnings are issued:

  warning C4700: uninitialized local variable 'xxx' used

Where 'xxx' is the name of the uninitialised variable that is being used
to initialise another variable. In all instances, the variable 'xxx' is
being used to initialise itself. Remove the use of initialising a
variable with itself to suppress these warnings with MSVC.

Some of these variables require an initial value. This is to prevent gcc
from issuing a warning about a variable being used before it has been
initialised. Suppress these gcc warnings by explicitly initialising the
required variables.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
This patch is but a small step in removing the build warnings that are
generated when compiling with MSVC.

 builtin-branch.c      |    2 +-
 builtin-cat-file.c    |    2 +-
 builtin-fast-export.c |    2 +-
 builtin-fetch--tool.c |    4 ++--
 builtin-rev-list.c    |    2 +-
 fast-import.c         |    4 ++--
 match-trees.c         |   12 ++++++------
 merge-recursive.c     |    2 +-
 run-command.c         |    2 +-
 transport.c           |    2 +-
 wt-status.c           |    2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..cf6a9ca 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -93,7 +93,7 @@ static const char *branch_get_color(enum color_branch ix)

 static int delete_branches(int argc, const char **argv, int force, int kinds)
 {
-	struct commit *rev, *head_rev = head_rev;
+	struct commit *rev, *head_rev;
 	unsigned char sha1[20];
 	char *name = NULL;
 	const char *fmt, *remote;
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 5906842..669608a 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -152,7 +152,7 @@ static int batch_one_object(const char *obj_name,
int print_contents)
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents = contents;
+	void *contents;

 	if (!obj_name)
 	   return 1;
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b0a4029..07e41ea 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -422,7 +422,7 @@ static void get_tags_and_duplicates(struct
object_array *pending,
 	for (i = 0; i < pending->nr; i++) {
 		struct object_array_entry *e = pending->objects + i;
 		unsigned char sha1[20];
-		struct commit *commit = commit;
+		struct commit *commit;
 		char *full_name;

 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3dbdf7a..8463f66 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -416,14 +416,14 @@ static int expand_refs_wildcard(const char
*ls_remote_result, int numrefs,
 static int pick_rref(int sha1_only, const char *rref, const char
*ls_remote_result)
 {
 	int err = 0;
-	int lrr_count = lrr_count, i, pass;
+	int lrr_count, i, pass;
 	const char *cp;
 	struct lrr {
 		const char *line;
 		const char *name;
 		int namelen;
 		int shown;
-	} *lrr_list = lrr_list;
+	} *lrr_list;

 	for (pass = 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills... */
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..b7b9fe3 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -386,7 +386,7 @@ int cmd_rev_list(int argc, const char **argv,
const char *prefix)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);

 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches, all;

 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
diff --git a/fast-import.c b/fast-import.c
index 7ef9865..6ed1602 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1858,7 +1858,7 @@ static void file_change_m(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;

@@ -2084,7 +2084,7 @@ static int parse_from(struct branch *b)

 static struct hash_list *parse_merge(unsigned int *count)
 {
-	struct hash_list *list = NULL, *n, *e = e;
+	struct hash_list *list = NULL, *n, *e;
 	const char *from;
 	struct branch *s;

diff --git a/match-trees.c b/match-trees.c
index 0fd6df7..99d559e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -72,12 +72,12 @@ static int score_trees(const unsigned char *hash1,
const unsigned char *hash2)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
 	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
+		const unsigned char *elem1 = NULL;
+		const unsigned char *elem2 = NULL;
+		const char *path1 = NULL;
+		const char *path2 = NULL;
+		unsigned mode1 = 0;
+		unsigned mode2 = 0;
 		int cmp;

 		if (one.size)
diff --git a/merge-recursive.c b/merge-recursive.c
index f55b7eb..8d7de22 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1267,7 +1267,7 @@ int merge_recursive(struct merge_options *o,
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
-	struct tree *mrtree = mrtree;
+	struct tree *mrtree;
 	int clean;

 	if (show(o, 4)) {
diff --git a/run-command.c b/run-command.c
index cf2d8f7..014f723 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,7 +19,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno = failed_errno;
+	int failed_errno;

 	/*
 	 * In case of errors we must keep the promise to close FDs
diff --git a/transport.c b/transport.c
index 644a30a..c6bb992 100644
--- a/transport.c
+++ b/transport.c
@@ -102,7 +102,7 @@ static void insert_packed_refs(const char
*packed_refs, struct ref **list)
 		return;

 	for (;;) {
-		int cmp = cmp, len;
+		int cmp, len;

 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
diff --git a/wt-status.c b/wt-status.c
index 38eb245..060ad17 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -133,7 +133,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 {
 	struct wt_status_change_data *d = it->util;
 	const char *c = color(change_type, s);
-	int status = status;
+	int status = 0;
 	char *one_name;
 	char *two_name;
 	const char *one, *two;
-- 
1.6.5.rc2
