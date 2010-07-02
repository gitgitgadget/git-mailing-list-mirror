From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of it.
Date: Fri,  2 Jul 2010 16:15:47 -0300
Message-ID: <bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
References: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
Cc: jrnieder@gmail.com, srabbelier@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 21:16:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUliY-0004Xy-9V
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0GBTP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:15:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41108 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab0GBTP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:15:58 -0400
Received: by gwj21 with SMTP id 21so31217gwj.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ofOuTip2lm34YEYZ4lOeEktAtx1Vsz29PQQvUju23BE=;
        b=OWZicJJhy46p44GJ/QzW6eGn+7IrRXZAzzhPiRqdWgfKGsO+/AmpDoUGMun1J3SKBy
         b/hkOPeN9Xq6mda1vjx6yIUJ9XpxfaYn9ZwbsgZ6WNG9yaIp/CPPGAFmuf4+fMwU+Yww
         CxU57bznPD6K+buz5JbAuXahUeh+KCmnvKPpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PSNkbrh8giPiPPWmwGPxRXQYpF2PA/Buan5syUd9KKUi9H41xSwd/PFN3vc4Ldgahv
         blUfvu6vJa6UASgxWix9CgLNH+A5LYyDUgBQBv5RvZVm0OxFopo0R9b2CHAhrsSWONmB
         owAfR8nO5Bao5eoUA8bETwuzkNm5rYRYDio2I=
Received: by 10.90.55.4 with SMTP id d4mr1644194aga.39.1278098156678;
        Fri, 02 Jul 2010 12:15:56 -0700 (PDT)
Received: from localhost ([189.60.232.11])
        by mx.google.com with ESMTPS id t2sm1129203yba.2.2010.07.02.12.15.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:15:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.576.gafae7.dirty
In-Reply-To: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150149>

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/fast-export.c   |    2 +-
 builtin/fetch.c         |    8 ++++----
 builtin/fmt-merge-msg.c |    6 +++---
 builtin/grep.c          |    2 +-
 builtin/mailsplit.c     |    2 +-
 builtin/mv.c            |    2 +-
 builtin/receive-pack.c  |    2 +-
 builtin/remote.c        |   12 ++++++------
 builtin/rerere.c        |    4 ++--
 builtin/show-ref.c      |    2 +-
 diff-no-index.c         |    3 ++-
 merge-recursive.c       |    3 ++-
 remote.c                |    4 ++--
 rerere.c                |   10 +++++-----
 string-list.h           |    2 ++
 transport-helper.c      |    2 +-
 16 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9fe25ff..44d538f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -566,7 +566,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
-	struct string_list extra_refs = { NULL, 0, 0, 0 };
+	struct string_list extra_refs = STRING_LIST_INIT(0);
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6eb1dfe..b0b2526 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -572,8 +572,8 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list remote_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT(0);
+	struct string_list remote_refs = STRING_LIST_INIT(0);
 	struct tag_data data;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
@@ -667,7 +667,7 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT(0);
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
@@ -890,7 +890,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list list = { NULL, 0, 0, 0 };
+	struct string_list list = STRING_LIST_INIT(0);
 	struct remote *remote;
 	int result = 0;
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bc3c5e6..7133f9f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -38,8 +38,8 @@ void init_src_data(struct src_data *data)
 	data->generic.strdup_strings = 1;
 }
 
-static struct string_list srcs = { NULL, 0, 0, 1 };
-static struct string_list origins = { NULL, 0, 0, 1 };
+static struct string_list srcs = STRING_LIST_INIT(1);
+static struct string_list origins = STRING_LIST_INIT(1);
 
 static int handle_line(char *line)
 {
@@ -146,7 +146,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	int i, count = 0;
 	struct commit *commit;
 	struct object *branch;
-	struct string_list subjects = { NULL, 0, 0, 1 };
+	struct string_list subjects = STRING_LIST_INIT(1);
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 232cd1c..9b01145 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -836,7 +836,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
-	struct string_list path_list = { NULL, 0, 0, 0 };
+	struct string_list path_list = STRING_LIST_INIT(0);
 	int i;
 	int dummy;
 	int nongit = 0, use_index = 1;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index e4560da..c95e17a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -137,7 +137,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	char name[PATH_MAX];
 	int ret = -1;
 	int i;
-	struct string_list list = {NULL, 0, 0, 1};
+	struct string_list list = STRING_LIST_INIT(1);
 
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
diff --git a/builtin/mv.c b/builtin/mv.c
index 38574b8..c7832dd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -63,7 +63,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
-	struct string_list src_for_dst = {NULL, 0, 0, 0};
+	struct string_list src_for_dst = STRING_LIST_INIT(0);
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d634b5a..190157a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -530,7 +530,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 static void check_aliased_updates(struct command *commands)
 {
 	struct command *cmd;
-	struct string_list ref_list = { NULL, 0, 0, 0 };
+	struct string_list ref_list = STRING_LIST_INIT(0);
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct string_list_item *item =
diff --git a/builtin/remote.c b/builtin/remote.c
index 6699bc5..e2c2102 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -134,7 +134,7 @@ static int add_branch(const char *key, const char *branchname,
 static int add(int argc, const char **argv)
 {
 	int fetch = 0, mirror = 0, fetch_tags = TAGS_DEFAULT;
-	struct string_list track = { NULL, 0, 0 };
+	struct string_list track = STRING_LIST_INIT(0);
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -596,7 +596,7 @@ static int mv(int argc, const char **argv)
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
-	struct string_list remote_branches = { NULL, 0, 0, 0 };
+	struct string_list remote_branches = STRING_LIST_INIT(0);
 	struct rename_info rename;
 	int i;
 
@@ -734,8 +734,8 @@ static int rm(int argc, const char **argv)
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT;
 	struct known_remotes known_remotes = { NULL, NULL };
-	struct string_list branches = { NULL, 0, 0, 1 };
-	struct string_list skipped = { NULL, 0, 0, 1 };
+	struct string_list branches = STRING_LIST_INIT(1);
+	struct string_list skipped = STRING_LIST_INIT(1);
 	struct branches_for_remote cb_data;
 	int i, result;
 
@@ -1044,7 +1044,7 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
-	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct string_list info_list = STRING_LIST_INIT(0);
 	struct show_info info;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
@@ -1483,7 +1483,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = { NULL, 0, 0 };
+	struct string_list list = STRING_LIST_INIT(0);
 	int result;
 
 	list.strdup_strings = 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..9995388 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -40,7 +40,7 @@ static int git_rerere_gc_config(const char *var, const char *value, void *cb)
 
 static void garbage_collect(struct string_list *rr)
 {
-	struct string_list to_remove = { NULL, 0, 0, 1 };
+	struct string_list to_remove = STRING_LIST_INIT(1);
 	DIR *dir;
 	struct dirent *e;
 	int i, cutoff;
@@ -102,7 +102,7 @@ static int diff_two(const char *file1, const char *label1,
 
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = STRING_LIST_INIT(1);
 	int i, fd, flags = 0;
 
 	if (2 < argc) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 0b2a9ad..41b7eb5 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -120,7 +120,7 @@ static int add_existing(const char *refname, const unsigned char *sha1, int flag
  */
 static int exclude_existing(const char *match)
 {
-	static struct string_list existing_refs = { NULL, 0, 0, 0 };
+	static struct string_list existing_refs = STRING_LIST_INIT(0);
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 43aeeba..2d09e37 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -64,7 +64,8 @@ static int queue_diff(struct diff_options *o,
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		char buffer1[PATH_MAX], buffer2[PATH_MAX];
-		struct string_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
+		struct string_list p1 = STRING_LIST_INIT(1);
+                struct string_list p2 = STRING_LIST_INIT(1);
 		int len1 = 0, len2 = 0, i1, i2, ret = 0;
 
 		if (name1 && read_directory(name1, &p1))
diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..6311b53 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -806,7 +806,8 @@ static int process_renames(struct merge_options *o,
 			   struct string_list *b_renames)
 {
 	int clean_merge = 1, i, j;
-	struct string_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
+	struct string_list a_by_dst = STRING_LIST_INIT(0);
+        struct string_list b_by_dst = STRING_LIST_INIT(0);
 	const struct rename *sre;
 
 	for (i = 0; i < a_renames->nr; i++) {
diff --git a/remote.c b/remote.c
index afbba47..9f3dc52 100644
--- a/remote.c
+++ b/remote.c
@@ -754,7 +754,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 
 void ref_remove_duplicates(struct ref *ref_map)
 {
-	struct string_list refs = { NULL, 0, 0, 0 };
+	struct string_list refs = STRING_LIST_INIT(0);
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
 	for (; ref_map; prev = ref_map, ref_map = next) {
@@ -1704,7 +1704,7 @@ static int get_stale_heads_cb(const char *refname,
 struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
-	struct string_list ref_names = { NULL, 0, 0, 0 };
+	struct string_list ref_names = STRING_LIST_INIT(0);
 	struct stale_heads_info info;
 	info.remote = remote;
 	info.ref_names = &ref_names;
diff --git a/rerere.c b/rerere.c
index d03a696..1424dbb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -426,8 +426,8 @@ static int update_paths(struct string_list *update)
 
 static int do_plain_rerere(struct string_list *rr, int fd)
 {
-	struct string_list conflict = { NULL, 0, 0, 1 };
-	struct string_list update = { NULL, 0, 0, 1 };
+	struct string_list conflict = STRING_LIST_INIT(1);
+	struct string_list update = STRING_LIST_INIT(1);
 	int i;
 
 	find_conflict(&conflict);
@@ -547,7 +547,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 
 int rerere(int flags)
 {
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = STRING_LIST_INIT(1);
 	int fd;
 
 	fd = setup_rerere(&merge_rr, flags);
@@ -585,8 +585,8 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 int rerere_forget(const char **pathspec)
 {
 	int i, fd;
-	struct string_list conflict = { NULL, 0, 0, 1 };
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list conflict = STRING_LIST_INIT(1);
+	struct string_list merge_rr = STRING_LIST_INIT(1);
 
 	if (read_cache() < 0)
 		return error("Could not read index");
diff --git a/string-list.h b/string-list.h
index 680d600..21969d3 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,6 +12,8 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
+#define STRING_LIST_INIT(dup_string) { NULL, 0, 0, (dup_string) }
+
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
diff --git a/transport-helper.c b/transport-helper.c
index 191fbf7..054576b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -689,7 +689,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
 	char *export_marks = NULL, *import_marks = NULL;
-	struct string_list revlist_args = { NULL, 0, 0 };
+	struct string_list revlist_args = STRING_LIST_INIT(0);
 	struct strbuf buf = STRBUF_INIT;
 
 	helper = get_helper(transport);
-- 
1.7.1.576.gafae7.dirty
