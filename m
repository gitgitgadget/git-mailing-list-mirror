From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/4] add mode parameter to get_sha1
Date: Sat, 21 Apr 2007 14:26:17 +0200
Message-ID: <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 14:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfEfi-0000Vy-RB
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 14:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbXDUM02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030805AbXDUM02
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 08:26:28 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37244 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030787AbXDUM0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 08:26:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id ABC3573EA3D3;
	Sat, 21 Apr 2007 14:26:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pa5EM9GpuZ9m; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6D82C7000CF2; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: 20070421122348.GA29174@auto.tuwien.ac.at
References: 20070421122348.GA29174@auto.tuwien.ac.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45171>

If the mode parameter is not NULL, get_sha1 will store
the mode of the object in it.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-apply.c         |    2 +-
 builtin-archive.c       |    2 +-
 builtin-blame.c         |    2 +-
 builtin-branch.c        |    2 +-
 builtin-cat-file.c      |    2 +-
 builtin-commit-tree.c   |    4 ++--
 builtin-describe.c      |    2 +-
 builtin-diff.c          |    2 +-
 builtin-fetch--tool.c   |    4 ++--
 builtin-fmt-merge-msg.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-grep.c          |    2 +-
 builtin-log.c           |    2 +-
 builtin-ls-tree.c       |    2 +-
 builtin-merge-base.c    |    4 ++--
 builtin-name-rev.c      |    4 ++--
 builtin-read-tree.c     |    2 +-
 builtin-rev-parse.c     |    8 ++++----
 builtin-revert.c        |    4 ++--
 builtin-rm.c            |    2 +-
 builtin-show-branch.c   |    8 ++++----
 builtin-update-ref.c    |    4 ++--
 cache.h                 |    5 ++++-
 connect.c               |    2 +-
 convert-objects.c       |    2 +-
 fast-import.c           |    8 ++++----
 merge-recursive.c       |    2 +-
 merge-tree.c            |    2 +-
 revision.c              |   14 +++++++-------
 sha1_name.c             |    8 ++++++--
 ssh-upload.c            |    2 +-
 unpack-file.c           |    2 +-
 upload-pack.c           |    2 +-
 wt-status.c             |    2 +-
 34 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 94311e7..a053403 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2159,7 +2159,7 @@ static void show_index_list(struct patch *list)
 		name = patch->old_name ? patch->old_name : patch->new_name;
 		if (0 < patch->is_new)
 			sha1_ptr = null_sha1;
-		else if (get_sha1(patch->old_sha1_prefix, sha1))
+		else if (get_sha1(patch->old_sha1_prefix, sha1, NULL))
 			die("sha1 information is lacking or useless (%s).",
 			    name);
 		else
diff --git a/builtin-archive.c b/builtin-archive.c
index 7f4e409..97b4dcb 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -112,7 +112,7 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 	struct commit *commit;
 	unsigned char sha1[20];
 
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, sha1, NULL))
 		die("Not a valid object name");
 
 	commit = lookup_commit_reference_gently(sha1, 1);
diff --git a/builtin-blame.c b/builtin-blame.c
index 8919b02..7777748 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1935,7 +1935,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	struct cache_entry *ce;
 	unsigned mode;
 
-	if (get_sha1("HEAD", head_sha1))
+	if (get_sha1("HEAD", head_sha1, NULL))
 		die("No such ref: HEAD");
 
 	time(&now);
diff --git a/builtin-branch.c b/builtin-branch.c
index 7408285..66ef90c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -442,7 +442,7 @@ static void create_branch(const char *name, const char *start_name,
 	}
 
 	real_ref = NULL;
-	if (get_sha1(start_name, sha1))
+	if (get_sha1(start_name, sha1, NULL))
 		die("Not a valid object name: '%s'.", start_name);
 
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index d61d3d5..11512da 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -87,7 +87,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config);
 	if (argc != 3)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	if (get_sha1(argv[2], sha1))
+	if (get_sha1(argv[2], sha1, NULL))
 		die("Not a valid object name %s", argv[2]);
 
 	opt = 0;
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 4a8d8d8..1b5a572 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -97,7 +97,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	if (argc < 2)
 		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
+	if (get_sha1(argv[1], tree_sha1, NULL))
 		die("Not a valid object name %s", argv[1]);
 
 	check_valid(tree_sha1, OBJ_TREE);
@@ -109,7 +109,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 		if (parents >= MAXPARENT)
 			die("Too many parents (%d max)", MAXPARENT);
-		if (get_sha1(b, parent_sha1[parents]))
+		if (get_sha1(b, parent_sha1[parents], NULL))
 			die("Not a valid object name %s", b);
 		check_valid(parent_sha1[parents], OBJ_COMMIT);
 		if (new_parent(parents))
diff --git a/builtin-describe.c b/builtin-describe.c
index 165917e..1d5467f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -135,7 +135,7 @@ static void describe(const char *arg, int last_one)
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 
-	if (get_sha1(arg, sha1))
+	if (get_sha1(arg, sha1, NULL))
 		die("Not a valid object name %s", arg);
 	cmit = lookup_commit_reference(sha1);
 	if (!cmit)
diff --git a/builtin-diff.c b/builtin-diff.c
index 21d13f0..5f1b50e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -173,7 +173,7 @@ void add_head(struct rev_info *revs)
 {
 	unsigned char sha1[20];
 	struct object *obj;
-	if (get_sha1("HEAD", sha1))
+	if (get_sha1("HEAD", sha1, NULL))
 		return;
 	obj = parse_object(sha1);
 	if (!obj)
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e9d6764..fe38d34 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -79,7 +79,7 @@ static int update_local_ref(const char *name,
 		return 0;
 	}
 
-	if (get_sha1(name, sha1_old)) {
+	if (get_sha1(name, sha1_old, NULL)) {
 		char *msg;
 	just_store:
 		/* new ref */
@@ -148,7 +148,7 @@ static int append_fetch_head(FILE *fp,
 	char note[1024];
 	const char *what, *kind;
 
-	if (get_sha1(head, sha1))
+	if (get_sha1(head, sha1, NULL))
 		return error("Not a valid object name: %s", head);
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 5c145d2..89224c2 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -89,7 +89,7 @@ static int handle_line(char *line)
 
 	line[40] = 0;
 	sha1 = xmalloc(20);
-	i = get_sha1(line, sha1);
+	i = get_sha1(line, sha1, NULL);
 	line[40] = '\t';
 	if (i)
 		return 3;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 05d98d2..3ed2c50 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -674,7 +674,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 		if (*arg == '-')
 			continue;
 
-		if (!get_sha1(arg, head_sha1)) {
+		if (!get_sha1(arg, head_sha1, NULL)) {
 			struct object *obj = lookup_object(head_sha1);
 
 			/* Error is printed by lookup_object(). */
diff --git a/builtin-grep.c b/builtin-grep.c
index e13cb31..f2ee20f 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -673,7 +673,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		/* Is it a rev? */
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1(arg, sha1, NULL)) {
 			struct object *object = parse_object(sha1);
 			if (!object)
 				die("bad object %s", arg);
diff --git a/builtin-log.c b/builtin-log.c
index 38bf52f..1ca3aa9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -648,7 +648,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
 	unsigned char sha1[20];
-	if (get_sha1(arg, sha1) == 0) {
+	if (get_sha1(arg, sha1, NULL) == 0) {
 		struct commit *commit = lookup_commit_reference(sha1);
 		if (commit) {
 			commit->object.flags |= flags;
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 6472610..40213ee 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -143,7 +143,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	if (argc < 2)
 		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
+	if (get_sha1(argv[1], sha1, NULL))
 		die("Not a valid object name %s", argv[1]);
 
 	pathspec = get_pathspec(prefix, argv + 2);
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index e35d362..7b415a1 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -39,9 +39,9 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	}
 	if (argc != 3)
 		usage(merge_base_usage);
-	if (get_sha1(argv[1], rev1key))
+	if (get_sha1(argv[1], rev1key, NULL))
 		die("Not a valid object name %s", argv[1]);
-	if (get_sha1(argv[2], rev2key))
+	if (get_sha1(argv[2], rev2key, NULL))
 		die("Not a valid object name %s", argv[2]);
 	rev1 = lookup_commit_reference(rev1key);
 	rev2 = lookup_commit_reference(rev2key);
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index c022224..0351185 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -184,7 +184,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			usage(name_rev_usage);
 		}
 
-		if (get_sha1(*argv, sha1)) {
+		if (get_sha1(*argv, sha1, NULL)) {
 			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
 					*argv);
 			continue;
@@ -230,7 +230,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 					forty = 0;
 
 					*(p+1) = 0;
-					if (!get_sha1(p - 39, sha1)) {
+					if (!get_sha1(p - 39, sha1, NULL)) {
 						struct object *o =
 							lookup_object(sha1);
 						if (o)
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 316fb0f..06224aa 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -204,7 +204,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		if (1 < opts.index_only + opts.update)
 			usage(read_tree_usage);
 
-		if (get_sha1(arg, sha1))
+		if (get_sha1(arg, sha1, NULL))
 			die("Not a valid object name %s", arg);
 		if (list_tree(sha1) < 0)
 			die("failed to unpack tree object %s", arg);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..370856b 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -130,7 +130,7 @@ static void show_default(void)
 		unsigned char sha1[20];
 
 		def = NULL;
-		if (!get_sha1(s, sha1)) {
+		if (!get_sha1(s, sha1, NULL)) {
 			show_rev(NORMAL, sha1, s);
 			return;
 		}
@@ -186,7 +186,7 @@ static int try_difference(const char *arg)
 		next = "HEAD";
 	if (dotdot == arg)
 		this = "HEAD";
-	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
+	if (!get_sha1(this, sha1, NULL) && !get_sha1(next, end, NULL)) {
 		show_rev(NORMAL, end, next);
 		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
 		if (symmetric) {
@@ -376,11 +376,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1(arg, sha1, NULL)) {
 			show_rev(NORMAL, sha1, arg);
 			continue;
 		}
-		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
+		if (*arg == '^' && !get_sha1(arg+1, sha1, NULL)) {
 			show_rev(REVERSED, sha1, arg+1);
 			continue;
 		}
diff --git a/builtin-revert.c b/builtin-revert.c
index 4ba0ee6..2db624a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -61,7 +61,7 @@ static void parse_options(int argc, const char **argv)
 	}
 
 	arg = argv[argc - 1];
-	if (get_sha1(arg, sha1))
+	if (get_sha1(arg, sha1, NULL))
 		die ("Cannot find '%s'", arg);
 	commit = (struct commit *)parse_object(sha1);
 	if (!commit)
@@ -257,7 +257,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	} else {
 		struct wt_status s;
 
-		if (get_sha1("HEAD", head))
+		if (get_sha1("HEAD", head, NULL))
 			die ("You do not have a valid HEAD");
 		wt_status_prepare(&s);
 		if (s.commitable || s.workdir_dirty)
diff --git a/builtin-rm.c b/builtin-rm.c
index 4a0bd93..6fc44af 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -190,7 +190,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	if (!force) {
 		unsigned char sha1[20];
-		if (get_sha1("HEAD", sha1))
+		if (get_sha1("HEAD", sha1, NULL))
 			hashclr(sha1);
 		if (check_local_mod(sha1))
 			exit(1);
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c892f1f..9c515db 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -383,7 +383,7 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp, NULL) || hashcmp(tmp, sha1))
 		ofs = 5;
 	return append_ref(refname + ofs, sha1, 0);
 }
@@ -397,7 +397,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp, NULL) || hashcmp(tmp, sha1))
 		ofs = 5;
 	return append_ref(refname + ofs, sha1, 0);
 }
@@ -511,7 +511,7 @@ static int show_independent(struct commit **rev,
 static void append_one_rev(const char *av)
 {
 	unsigned char revkey[20];
-	if (!get_sha1(av, revkey)) {
+	if (!get_sha1(av, revkey, NULL)) {
 		append_ref(av, revkey, 0);
 		return;
 	}
@@ -794,7 +794,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 		if (MAX_REVS <= num_rev)
 			die("cannot handle more than %d revs.", MAX_REVS);
-		if (get_sha1(ref_name[num_rev], revkey))
+		if (get_sha1(ref_name[num_rev], revkey, NULL))
 			die("'%s' is not a valid ref.", ref_name[num_rev]);
 		commit = lookup_commit_reference(revkey);
 		if (!commit)
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 5ee960b..3c56e1b 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -46,7 +46,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (!refname || !value)
 		usage(git_update_ref_usage);
 
-	if (get_sha1(value, sha1))
+	if (get_sha1(value, sha1, NULL))
 		die("%s: not a valid SHA1", value);
 
 	if (delete) {
@@ -56,7 +56,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	hashclr(oldsha1);
-	if (oldval && *oldval && get_sha1(oldval, oldsha1))
+	if (oldval && *oldval && get_sha1(oldval, oldsha1, NULL))
 		die("%s: not a valid old SHA1", oldval);
 
 	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
diff --git a/cache.h b/cache.h
index 53c2341..dc8d7b1 100644
--- a/cache.h
+++ b/cache.h
@@ -24,6 +24,9 @@
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
+/* unknown mode */
+#define S_IFINVALID    0320000
+
 /*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
@@ -316,7 +319,7 @@ static inline unsigned int hexval(unsigned int c)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
 
-extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_sha1(const char *str, unsigned char *sha1, unsigned *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/connect.c b/connect.c
index da89c9c..71ebe3c 100644
--- a/connect.c
+++ b/connect.c
@@ -243,7 +243,7 @@ static struct ref *try_explicit_object_name(const char *name)
 		hashclr(ref->new_sha1);
 		return ref;
 	}
-	if (get_sha1(name, sha1))
+	if (get_sha1(name, sha1, NULL))
 		return NULL;
 	len = strlen(name) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
diff --git a/convert-objects.c b/convert-objects.c
index cefbceb..d3fa9bf 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -320,7 +320,7 @@ int main(int argc, char **argv)
 
 	if (argc != 2)
 		usage("git-convert-objects <sha1>");
-	if (get_sha1(argv[1], sha1))
+	if (get_sha1(argv[1], sha1, NULL))
 		die("Not a valid object name %s", argv[1]);
 
 	entry = convert_entry(sha1);
diff --git a/fast-import.c b/fast-import.c
index cdd629d..a671f77 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1721,7 +1721,7 @@ static void cmd_from(struct branch *b)
 		free(buf);
 		hashcpy(b->branch_tree.versions[0].sha1,
 			b->branch_tree.versions[1].sha1);
-	} else if (!get_sha1(from, b->sha1)) {
+	} else if (!get_sha1(from, b->sha1, NULL)) {
 		if (is_null_sha1(b->sha1)) {
 			hashclr(b->branch_tree.versions[0].sha1);
 			hashclr(b->branch_tree.versions[1].sha1);
@@ -1765,7 +1765,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->sha1);
-		} else if (!get_sha1(from, n->sha1)) {
+		} else if (!get_sha1(from, n->sha1, NULL)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(n->sha1,
 				commit_type, &size, n->sha1);
@@ -1916,7 +1916,7 @@ static void cmd_new_tag(void)
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", from_mark);
 		hashcpy(sha1, oe->sha1);
-	} else if (!get_sha1(from, sha1)) {
+	} else if (!get_sha1(from, sha1, NULL)) {
 		unsigned long size;
 		char *buf;
 
@@ -2011,7 +2011,7 @@ static void import_marks(const char *input_file)
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
-			|| *end != ' ' || get_sha1(end + 1, sha1))
+			|| *end != ' ' || get_sha1(end + 1, sha1, NULL))
 			die("corrupt mark line: %s", line);
 		e = find_object(sha1);
 		if (!e) {
diff --git a/merge-recursive.c b/merge-recursive.c
index cea6c87..8e6daca 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1364,7 +1364,7 @@ static struct commit *get_ref(const char *ref)
 	unsigned char sha1[20];
 	struct object *object;
 
-	if (get_sha1(ref, sha1))
+	if (get_sha1(ref, sha1, NULL))
 		die("Could not resolve ref '%s'", ref);
 	object = deref_tag(parse_object(sha1), ref, strlen(ref));
 	if (object->type == OBJ_TREE)
diff --git a/merge-tree.c b/merge-tree.c
index 3b8d9e6..1831082 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -325,7 +325,7 @@ static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 	unsigned char sha1[20];
 	void *buf;
 
-	if (get_sha1(rev, sha1))
+	if (get_sha1(rev, sha1, NULL))
 		die("unknown rev %s", rev);
 	buf = fill_tree_descriptor(desc, sha1);
 	if (!buf)
diff --git a/revision.c b/revision.c
index ce70f48..8f0ed77 100644
--- a/revision.c
+++ b/revision.c
@@ -614,7 +614,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 		flags ^= UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1(arg, sha1))
+	if (get_sha1(arg, sha1, NULL))
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, sha1, 0);
@@ -684,9 +684,9 @@ static void prepare_show_merge(struct rev_info *revs)
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 
-	if (get_sha1("HEAD", sha1) || !(head = lookup_commit(sha1)))
+	if (get_sha1("HEAD", sha1, NULL) || !(head = lookup_commit(sha1)))
 		die("--merge without HEAD?");
-	if (get_sha1("MERGE_HEAD", sha1) || !(other = lookup_commit(sha1)))
+	if (get_sha1("MERGE_HEAD", sha1, NULL) || !(other = lookup_commit(sha1)))
 		die("--merge without MERGE_HEAD?");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
@@ -743,8 +743,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			next = "HEAD";
 		if (dotdot == arg)
 			this = "HEAD";
-		if (!get_sha1(this, from_sha1) &&
-		    !get_sha1(next, sha1)) {
+		if (!get_sha1(this, from_sha1, NULL) &&
+		    !get_sha1(next, sha1, NULL)) {
 			struct commit *a, *b;
 			struct commit_list *exclude;
 
@@ -796,7 +796,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1(arg, sha1))
+	if (get_sha1(arg, sha1, NULL))
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -1177,7 +1177,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
-		if (get_sha1(def, sha1))
+		if (get_sha1(def, sha1, NULL))
 			die("bad default revision '%s'", def);
 		object = get_reference(revs, def, sha1, 0);
 		add_pending_object(revs, object, def);
diff --git a/sha1_name.c b/sha1_name.c
index 267ea3f..57de683 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -641,13 +641,15 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_sha1(const char *name, unsigned char *sha1)
+int get_sha1(const char *name, unsigned char *sha1, unsigned *mode)
 {
 	int ret, bracket_depth;
 	unsigned unused;
 	int namelen = strlen(name);
 	const char *cp;
 
+	if (mode)
+		*mode = S_IFINVALID;
 	prepare_alt_odb();
 	ret = get_sha1_1(name, namelen, sha1);
 	if (!ret)
@@ -685,6 +687,8 @@ int get_sha1(const char *name, unsigned char *sha1)
 				break;
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
+				if (mode)
+					*mode = ce->ce_mode;
 				return 0;
 			}
 			pos++;
@@ -703,7 +707,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 		unsigned char tree_sha1[20];
 		if (!get_sha1_1(name, cp-name, tree_sha1))
 			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      &unused);
+					      mode ? mode : &unused);
 	}
 	return ret;
 }
diff --git a/ssh-upload.c b/ssh-upload.c
index 2f04572..065cf5d 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -130,7 +130,7 @@ int main(int argc, char **argv)
 		usage(ssh_push_usage);
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	if (get_sha1(commit_id, sha1))
+	if (get_sha1(commit_id, sha1, NULL))
 		die("Not a valid object name %s", commit_id);
 	memcpy(hex, sha1_to_hex(sha1), sizeof(hex));
 	argv[arg] = hex;
diff --git a/unpack-file.c b/unpack-file.c
index 25c56b3..f6aaca0 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 
 	if (argc != 2)
 		usage("git-unpack-file <sha1>");
-	if (get_sha1(argv[1], sha1))
+	if (get_sha1(argv[1], sha1, NULL))
 		die("Not a valid object name %s", argv[1]);
 
 	setup_git_directory();
diff --git a/upload-pack.c b/upload-pack.c
index d3a09e7..9c39231 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -517,7 +517,7 @@ static void receive_needs(void)
 			unsigned char sha1[20];
 			struct object *object;
 			use_thin_pack = 0;
-			if (get_sha1(line + 8, sha1))
+			if (get_sha1(line + 8, sha1, NULL))
 				die("invalid shallow line: %s", line);
 			object = parse_object(sha1);
 			if (!object)
diff --git a/wt-status.c b/wt-status.c
index a055990..a40c5d1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -302,7 +302,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
-	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	s->is_initial = get_sha1(s->reference, sha1, NULL) ? 1 : 0;
 
 	if (s->branch) {
 		const char *on_what = "On branch ";
-- 
1.4.4.4
