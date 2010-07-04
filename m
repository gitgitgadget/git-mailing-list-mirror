From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of it.
Date: Sun,  4 Jul 2010 16:46:19 -0300
Message-ID: <546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
References: <20100702202257.GA7539@burratino>
Cc: srabbelier@gmail.com, gitster@pobox.com, raa.lkml@gmail.com,
	peter.kjellerstedt@axis.com, jrnieder@gmail.com,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 04 21:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVVA6-0000bq-Vl
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957Ab0GDTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 15:47:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40441 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903Ab0GDTrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 15:47:22 -0400
Received: by gye5 with SMTP id 5so1035281gye.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QAukLZT93CssU9eg/ceE4W6Ige3s70y0QTvgYFECTBc=;
        b=V10RSnOR7OJojfS8eGv/5etDmvbTbfxTtCoZrZCNs9XGl8vaB2PMQMi/Xsr1utZndM
         oewyO3fkCgrlgnGC9j5GQbuweaV8ICNUQbgGf2OQNcvJWS0M09DJWpAEcZDgtWXydeoM
         n9vXRNPOd98gnj237ADCy/W7et9+vkWjEOMfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RQ/x8zu6Mhbpiv2XtyfM/f7S6WjBJlm7vYoQt9OOqg+YRSpsxWkDXVqEoDSN9WwOw1
         20knpo9X8g26LxYisCo65V8+/QDh7iO66lb3o15ITnj1IrXbWXn5PAK+4gsBrGlmCUvi
         4JwMpmiQnpujW3T3pBFQuowdO2V6YUYcW4+Jo=
Received: by 10.100.190.3 with SMTP id n3mr2381004anf.254.1278272841612;
        Sun, 04 Jul 2010 12:47:21 -0700 (PDT)
Received: from localhost ([189.60.232.11])
        by mx.google.com with ESMTPS id p12sm30124000ane.14.2010.07.04.12.46.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 12:47:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.576.gafae7.dirty
In-Reply-To: <20100702202257.GA7539@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150228>

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
 string-list.h           |    3 +++
 transport-helper.c      |    2 +-
 16 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9fe25ff..834ec8b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -566,7 +566,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = { 0, 0, NULL };
-	struct string_list extra_refs = { NULL, 0, 0, 0 };
+	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6eb1dfe..9f40511 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -572,8 +572,8 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list remote_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
 	struct tag_data data;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
@@ -667,7 +667,7 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
+	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
@@ -890,7 +890,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list list = { NULL, 0, 0, 0 };
+	struct string_list list = STRING_LIST_INIT_NODUP;
 	struct remote *remote;
 	int result = 0;
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bc3c5e6..a76cd4e 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -38,8 +38,8 @@ void init_src_data(struct src_data *data)
 	data->generic.strdup_strings = 1;
 }
 
-static struct string_list srcs = { NULL, 0, 0, 1 };
-static struct string_list origins = { NULL, 0, 0, 1 };
+static struct string_list srcs = STRING_LIST_INIT_DUP;
+static struct string_list origins = STRING_LIST_INIT_DUP;
 
 static int handle_line(char *line)
 {
@@ -146,7 +146,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	int i, count = 0;
 	struct commit *commit;
 	struct object *branch;
-	struct string_list subjects = { NULL, 0, 0, 1 };
+	struct string_list subjects = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 232cd1c..103f64a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -836,7 +836,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
-	struct string_list path_list = { NULL, 0, 0, 0 };
+	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
 	int nongit = 0, use_index = 1;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index e4560da..99654d0 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -137,7 +137,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	char name[PATH_MAX];
 	int ret = -1;
 	int i;
-	struct string_list list = {NULL, 0, 0, 1};
+	struct string_list list = STRING_LIST_INIT_DUP;
 
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
diff --git a/builtin/mv.c b/builtin/mv.c
index 38574b8..cdbb094 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -63,7 +63,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
-	struct string_list src_for_dst = {NULL, 0, 0, 0};
+	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d634b5a..760817d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -530,7 +530,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 static void check_aliased_updates(struct command *commands)
 {
 	struct command *cmd;
-	struct string_list ref_list = { NULL, 0, 0, 0 };
+	struct string_list ref_list = STRING_LIST_INIT_NODUP;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct string_list_item *item =
diff --git a/builtin/remote.c b/builtin/remote.c
index 6699bc5..48e0a6b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -134,7 +134,7 @@ static int add_branch(const char *key, const char *branchname,
 static int add(int argc, const char **argv)
 {
 	int fetch = 0, mirror = 0, fetch_tags = TAGS_DEFAULT;
-	struct string_list track = { NULL, 0, 0 };
+	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -596,7 +596,7 @@ static int mv(int argc, const char **argv)
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
-	struct string_list remote_branches = { NULL, 0, 0, 0 };
+	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
 	int i;
 
@@ -734,8 +734,8 @@ static int rm(int argc, const char **argv)
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT;
 	struct known_remotes known_remotes = { NULL, NULL };
-	struct string_list branches = { NULL, 0, 0, 1 };
-	struct string_list skipped = { NULL, 0, 0, 1 };
+	struct string_list branches = STRING_LIST_INIT_DUP;
+	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
 	int i, result;
 
@@ -1044,7 +1044,7 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
-	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct string_list info_list = STRING_LIST_INIT_NODUP;
 	struct show_info info;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
@@ -1483,7 +1483,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = { NULL, 0, 0 };
+	struct string_list list = STRING_LIST_INIT_NODUP;
 	int result;
 
 	list.strdup_strings = 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..3c8e458 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -40,7 +40,7 @@ static int git_rerere_gc_config(const char *var, const char *value, void *cb)
 
 static void garbage_collect(struct string_list *rr)
 {
-	struct string_list to_remove = { NULL, 0, 0, 1 };
+	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
 	struct dirent *e;
 	int i, cutoff;
@@ -102,7 +102,7 @@ static int diff_two(const char *file1, const char *label1,
 
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int i, fd, flags = 0;
 
 	if (2 < argc) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 0b2a9ad..be9b512 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -120,7 +120,7 @@ static int add_existing(const char *refname, const unsigned char *sha1, int flag
  */
 static int exclude_existing(const char *match)
 {
-	static struct string_list existing_refs = { NULL, 0, 0, 0 };
+	static struct string_list existing_refs = STRING_LIST_INIT_NODUP;
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 43aeeba..a0ad7ab 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -64,7 +64,8 @@ static int queue_diff(struct diff_options *o,
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		char buffer1[PATH_MAX], buffer2[PATH_MAX];
-		struct string_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
+		struct string_list p1 = STRING_LIST_INIT_DUP;
+                struct string_list p2 = STRING_LIST_INIT_DUP;
 		int len1 = 0, len2 = 0, i1, i2, ret = 0;
 
 		if (name1 && read_directory(name1, &p1))
diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..85eb3f0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -806,7 +806,8 @@ static int process_renames(struct merge_options *o,
 			   struct string_list *b_renames)
 {
 	int clean_merge = 1, i, j;
-	struct string_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
+	struct string_list a_by_dst = STRING_LIST_INIT_NODUP;
+        struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
 	const struct rename *sre;
 
 	for (i = 0; i < a_renames->nr; i++) {
diff --git a/remote.c b/remote.c
index afbba47..9143ec7 100644
--- a/remote.c
+++ b/remote.c
@@ -754,7 +754,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 
 void ref_remove_duplicates(struct ref *ref_map)
 {
-	struct string_list refs = { NULL, 0, 0, 0 };
+	struct string_list refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
 	for (; ref_map; prev = ref_map, ref_map = next) {
@@ -1704,7 +1704,7 @@ static int get_stale_heads_cb(const char *refname,
 struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
-	struct string_list ref_names = { NULL, 0, 0, 0 };
+	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
 	info.remote = remote;
 	info.ref_names = &ref_names;
diff --git a/rerere.c b/rerere.c
index d03a696..78bbcf1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -426,8 +426,8 @@ static int update_paths(struct string_list *update)
 
 static int do_plain_rerere(struct string_list *rr, int fd)
 {
-	struct string_list conflict = { NULL, 0, 0, 1 };
-	struct string_list update = { NULL, 0, 0, 1 };
+	struct string_list conflict = STRING_LIST_INIT_DUP;
+	struct string_list update = STRING_LIST_INIT_DUP;
 	int i;
 
 	find_conflict(&conflict);
@@ -547,7 +547,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 
 int rerere(int flags)
 {
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int fd;
 
 	fd = setup_rerere(&merge_rr, flags);
@@ -585,8 +585,8 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 int rerere_forget(const char **pathspec)
 {
 	int i, fd;
-	struct string_list conflict = { NULL, 0, 0, 1 };
-	struct string_list merge_rr = { NULL, 0, 0, 1 };
+	struct string_list conflict = STRING_LIST_INIT_DUP;
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 	if (read_cache() < 0)
 		return error("Could not read index");
diff --git a/string-list.h b/string-list.h
index 680d600..84cd09d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,6 +12,9 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
+#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
+#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
+
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
diff --git a/transport-helper.c b/transport-helper.c
index 191fbf7..acfc88e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -689,7 +689,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
 	char *export_marks = NULL, *import_marks = NULL;
-	struct string_list revlist_args = { NULL, 0, 0 };
+	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	helper = get_helper(transport);
-- 
1.7.1.576.gafae7.dirty
