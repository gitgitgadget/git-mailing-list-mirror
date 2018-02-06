Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949051F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBFA1L (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:11 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:44202 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeBFA1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:09 -0500
Received: by mail-pg0-f48.google.com with SMTP id r1so164766pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=73hpFD5IVYq4O+DgNXvz9e0xqxvkhz10IS8EpX+LI/g=;
        b=T9al1L7/n2xLNVUBy4PRTX1U0aAmJFtS/P+lJqgrGmoEUboXozNQmKc3mmdfqyjLmA
         6L/YI5cn57fL4ne6t5fqQ+miUA45ZTAPOFgeBi76+nBFzArjLF+QLv628myYJIaZyNG1
         6QhHFPx9Ny9lK3L1C81b3tGNlw3POIrKikB7x9OD8V+S3rSvRkfA8HsVPFz2N2GT7WDB
         +T6SNvXYFINQfd5T0Bf8aalBspYwF2lZf6N3+2t4dNXNxU7/S1AKU0sYBRO/vzxDtvTr
         5VhloR9t1EsjRx46KcWdCtGga3Qb8qZx2a/KbylAsfvxuF9kH1yTv86/PC6p27/hqjxT
         rDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=73hpFD5IVYq4O+DgNXvz9e0xqxvkhz10IS8EpX+LI/g=;
        b=fDDFkXcC9j1OygzTKvjlOOIZURR+jgUXkLy+WKUTftJm380PGNI3255FY+/8imb7KJ
         MshQScP411F2jVaNyV6srtzDNQXHIL+ZapJGurRhCiUWi3d51rBICgQ4pLRLu7D1MmwE
         HWcvzynxZZVCHvQ/5IPAXGG/12S4gcxjU2fVfYJfbC5kXYwF2LQTeq6ZghWlq7m120CW
         AaGAW77XyHblrlolEfiR7XqtRd5JbQw3JXuiq9unXPk/gVnBA6ezGwil0DFwJb6UqmCS
         F58k0kFU+DBffXWx4GSjEGKZRCV9Bx7gVsU/ta3xK8/pZ8ldxCoCn0gdVboiCX+0KDxq
         W5tQ==
X-Gm-Message-State: APf1xPBSSLUHSbwaCYuPKCzDxuurQ7ni2rdXula0GV62GnI9+m2gYPTb
        +BTIIHf7sfw9Sv0yFOPTmK+kF8YdCF8=
X-Google-Smtp-Source: AH8x224AjIsDMSybce29nP/UFzdEY3511QaNVy8fqP8llpz5Mg9xtVoAy8l7bbedet6VnKsM+nfZ7w==
X-Received: by 10.98.225.7 with SMTP id q7mr578585pfh.22.1517876827604;
        Mon, 05 Feb 2018 16:27:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q10sm17531939pff.181.2018.02.05.16.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 156/194] migrate cached path to use the_repository
Date:   Mon,  5 Feb 2018 16:17:11 -0800
Message-Id: <20180206001749.218943-58-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c                              |  8 ++++---
 branch.c                             | 14 ++++++------
 builtin/commit.c                     | 38 +++++++++++++++----------------
 builtin/fetch.c                      |  4 ++--
 builtin/merge.c                      | 37 +++++++++++++++---------------
 builtin/pull.c                       |  4 ++--
 builtin/reset.c                      |  2 +-
 contrib/coccinelle/cached_path.cocci | 44 ++++++++++++++++++++++++++++++++++++
 fetch-pack.c                         |  2 +-
 path.c                               | 18 +++++++--------
 path.h                               | 40 ++++++++++++++++++++++++--------
 repository.c                         |  2 +-
 repository.h                         |  5 ++++
 rerere.c                             |  7 +++---
 sequencer.c                          | 33 ++++++++++++++-------------
 shallow.c                            | 12 ++++++----
 wt-status.c                          |  8 +++----
 17 files changed, 178 insertions(+), 100 deletions(-)
 create mode 100644 contrib/coccinelle/cached_path.cocci

diff --git a/blame.c b/blame.c
index 1cd39e7a17..6832271319 100644
--- a/blame.c
+++ b/blame.c
@@ -112,17 +112,19 @@ static void append_merge_parents(struct commit_list **tail)
 	int merge_head;
 	struct strbuf line = STRBUF_INIT;
 
-	merge_head = open(git_path_merge_head(), O_RDONLY);
+	merge_head = open(git_path_merge_head(the_repository), O_RDONLY);
 	if (merge_head < 0) {
 		if (errno == ENOENT)
 			return;
-		die("cannot open '%s' for reading", git_path_merge_head());
+		die("cannot open '%s' for reading",
+		    git_path_merge_head(the_repository));
 	}
 
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
 		struct object_id oid;
 		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
-			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
+			die("unknown line in '%s': %s",
+			    git_path_merge_head(the_repository), line.buf);
 		tail = append_parent(tail, &oid);
 	}
 	close(merge_head);
diff --git a/branch.c b/branch.c
index 0b7aaa1aca..08d4efc1be 100644
--- a/branch.c
+++ b/branch.c
@@ -339,13 +339,13 @@ void create_branch(const char *name, const char *start_name,
 
 void remove_branch_state(void)
 {
-	unlink(git_path_cherry_pick_head());
-	unlink(git_path_revert_head());
-	unlink(git_path_merge_head());
-	unlink(git_path_merge_rr());
-	unlink(git_path_merge_msg());
-	unlink(git_path_merge_mode());
-	unlink(git_path_squash_msg());
+	unlink(git_path_cherry_pick_head(the_repository));
+	unlink(git_path_revert_head(the_repository));
+	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_rr(the_repository));
+	unlink(git_path_merge_msg(the_repository));
+	unlink(git_path_merge_mode(the_repository));
+	unlink(git_path_squash_msg(the_repository));
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/builtin/commit.c b/builtin/commit.c
index d15592ad45..cceb965569 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -179,9 +179,9 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 
 static void determine_whence(struct wt_status *s)
 {
-	if (file_exists(git_path_merge_head()))
+	if (file_exists(git_path_merge_head(the_repository)))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path_cherry_pick_head())) {
+	else if (file_exists(git_path_cherry_pick_head(the_repository))) {
 		whence = FROM_CHERRY_PICK;
 		if (file_exists(git_path_seq_dir()))
 			sequencer_in_use = 1;
@@ -732,21 +732,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
-	} else if (!stat(git_path_merge_msg(), &statbuf)) {
+	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
 		 */
-		if (!stat(git_path_squash_msg(), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+		if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 				die_errno(_("could not read SQUASH_MSG"));
 			hook_arg1 = "squash";
 		} else
 			hook_arg1 = "merge";
-		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
+		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
-	} else if (!stat(git_path_squash_msg(), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
 		hook_arg1 = "squash";
 	} else if (template_file) {
@@ -827,8 +827,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					"	%s\n"
 					"and try again.\n"),
 				whence == FROM_MERGE ?
-					git_path_merge_head() :
-					git_path_cherry_pick_head());
+					git_path_merge_head(the_repository) :
+					git_path_cherry_pick_head(the_repository));
 		}
 
 		fprintf(s->fp, "\n");
@@ -1732,7 +1732,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = commit_list_append(current_head, pptr);
-		fp = xfopen(git_path_merge_head(), "r");
+		fp = xfopen(git_path_merge_head(the_repository), "r");
 		while (strbuf_getline_lf(&m, fp) != EOF) {
 			struct commit *parent;
 
@@ -1743,8 +1743,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path_merge_mode(), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path_merge_mode(), 0) < 0)
+		if (!stat(git_path_merge_mode(the_repository), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_merge_mode(the_repository), 0) < 0)
 				die_errno(_("could not read MERGE_MODE"));
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
@@ -1820,12 +1820,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	ref_transaction_free(transaction);
 
-	unlink(git_path_cherry_pick_head());
-	unlink(git_path_revert_head());
-	unlink(git_path_merge_head());
-	unlink(git_path_merge_msg());
-	unlink(git_path_merge_mode());
-	unlink(git_path_squash_msg());
+	unlink(git_path_cherry_pick_head(the_repository));
+	unlink(git_path_revert_head(the_repository));
+	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_msg(the_repository));
+	unlink(git_path_merge_mode(the_repository));
+	unlink(git_path_squash_msg(the_repository));
 
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index da99363067..b516b176f0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -756,7 +756,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
+	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1009,7 +1009,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	const char *filename = git_path_fetch_head();
+	const char *filename = git_path_fetch_head(the_repository);
 	FILE *fp = fopen_for_writing(filename);
 
 	if (!fp)
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..4f5c01c41c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -244,9 +244,9 @@ static struct option builtin_merge_options[] = {
 /* Cleans up metadata that is uninteresting after a succeeded merge. */
 static void drop_save(void)
 {
-	unlink(git_path_merge_head());
-	unlink(git_path_merge_msg());
-	unlink(git_path_merge_mode());
+	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_msg(the_repository));
+	unlink(git_path_merge_mode(the_repository));
 }
 
 static int save_state(struct object_id *stash)
@@ -379,7 +379,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 			oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&ctx, commit, &out);
 	}
-	write_file_buf(git_path_squash_msg(), out.buf, out.len);
+	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
 }
 
@@ -742,7 +742,7 @@ static void add_strategies(const char *string, unsigned attr)
 
 static void read_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path_merge_msg();
+	const char *filename = git_path_merge_msg(the_repository);
 	strbuf_reset(msg);
 	if (strbuf_read_file(msg, filename, 0) < 0)
 		die_errno(_("Could not read from '%s'"), filename);
@@ -779,18 +779,18 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
-	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
+	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
-			    git_path_merge_msg(), "merge", NULL))
+			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
-		if (launch_editor(git_path_merge_msg(), NULL, NULL))
+		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
 
 	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
 					  "commit-msg",
-					  git_path_merge_msg(), NULL))
+					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
 	read_merge_msg(&msg);
@@ -861,7 +861,7 @@ static int suggest_conflicts(void)
 	FILE *fp;
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	filename = git_path_merge_msg();
+	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
 	append_conflicts_hint(&msgbuf);
@@ -941,12 +941,12 @@ static void write_merge_heads(struct commit_list *remoteheads)
 		}
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
-	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
+	write_file_buf(git_path_merge_head(the_repository), buf.buf, buf.len);
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
 		strbuf_addstr(&buf, "no-ff");
-	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
+	write_file_buf(git_path_merge_mode(the_repository), buf.buf, buf.len);
 	strbuf_release(&buf);
 }
 
@@ -954,7 +954,8 @@ static void write_merge_state(struct commit_list *remoteheads)
 {
 	write_merge_heads(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
+	write_file_buf(git_path_merge_msg(the_repository), merge_msg.buf,
+		       merge_msg.len);
 }
 
 static int default_edit_option(void)
@@ -1037,7 +1038,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	if (!merge_names)
 		merge_names = &fetch_head_file;
 
-	filename = git_path_fetch_head();
+	filename = git_path_fetch_head(the_repository);
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		die_errno(_("could not open '%s' for reading"), filename);
@@ -1174,7 +1175,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			usage_msg_opt(_("--abort expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
-		if (!file_exists(git_path_merge_head()))
+		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
 		/* Invoke 'git reset --merge' */
@@ -1190,7 +1191,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			usage_msg_opt(_("--continue expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
-		if (!file_exists(git_path_merge_head()))
+		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
 
 		/* Invoke 'git commit' */
@@ -1201,7 +1202,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
-	if (file_exists(git_path_merge_head())) {
+	if (file_exists(git_path_merge_head(the_repository))) {
 		/*
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
@@ -1212,7 +1213,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path_cherry_pick_head())) {
+	if (file_exists(git_path_cherry_pick_head(the_repository))) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/builtin/pull.c b/builtin/pull.c
index 90aa922260..0fb48a33be 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -351,7 +351,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
  */
 static void get_merge_heads(struct oid_array *merge_heads)
 {
-	const char *filename = git_path_fetch_head();
+	const char *filename = git_path_fetch_head(the_repository);
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
@@ -858,7 +858,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-	if (file_exists(git_path_merge_head()))
+	if (file_exists(git_path_merge_head(the_repository)))
 		die_conclude_merge();
 
 	if (get_oid("HEAD", &orig_head))
diff --git a/builtin/reset.c b/builtin/reset.c
index 891dd77a5f..7c57309adc 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -39,7 +39,7 @@ static const char *reset_type_names[] = {
 
 static inline int is_merge(void)
 {
-	return !access(git_path_merge_head(), F_OK);
+	return !access(git_path_merge_head(the_repository), F_OK);
 }
 
 static int reset_index(const struct object_id *oid, int reset_type, int quiet)
diff --git a/contrib/coccinelle/cached_path.cocci b/contrib/coccinelle/cached_path.cocci
new file mode 100644
index 0000000000..41f38fe922
--- /dev/null
+++ b/contrib/coccinelle/cached_path.cocci
@@ -0,0 +1,44 @@
+@@ @@
+ git_path_cherry_pick_head(
++the_repository
+ )
+
+@@ @@
+ git_path_revert_head(
++the_repository
+ )
+
+@@ @@
+ git_path_squash_msg(
++the_repository
+ )
+
+@@ @@
+ git_path_merge_msg(
++the_repository
+ )
+
+@@ @@
+ git_path_merge_rr(
++the_repository
+ )
+
+@@ @@
+ git_path_merge_mode(
++the_repository
+ )
+
+@@ @@
+ git_path_merge_head(
++the_repository
+ )
+
+@@ @@
+ git_path_fetch_head(
++the_repository
+ )
+
+@@ @@
+ git_path_shallow(
++the_repository
+ )
diff --git a/fetch-pack.c b/fetch-pack.c
index 01e5b36661..74265554c3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1070,7 +1070,7 @@ static void update_shallow(struct fetch_pack_args *args,
 
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
-			unlink_or_warn(git_path_shallow());
+			unlink_or_warn(git_path_shallow(the_repository));
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
diff --git a/path.c b/path.c
index da8b655730..8a88f145cd 100644
--- a/path.c
+++ b/path.c
@@ -1357,12 +1357,12 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
-GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
-GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
-GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-GIT_PATH_FUNC(git_path_merge_msg, "MERGE_MSG")
-GIT_PATH_FUNC(git_path_merge_rr, "MERGE_RR")
-GIT_PATH_FUNC(git_path_merge_mode, "MERGE_MODE")
-GIT_PATH_FUNC(git_path_merge_head, "MERGE_HEAD")
-GIT_PATH_FUNC(git_path_fetch_head, "FETCH_HEAD")
-GIT_PATH_FUNC(git_path_shallow, "shallow")
+REPO_GIT_PATH_FUNC(path_cherry_pick_head, "CHERRY_PICK_HEAD")
+REPO_GIT_PATH_FUNC(path_revert_head, "REVERT_HEAD")
+REPO_GIT_PATH_FUNC(path_squash_msg, "SQUASH_MSG")
+REPO_GIT_PATH_FUNC(path_merge_msg, "MERGE_MSG")
+REPO_GIT_PATH_FUNC(path_merge_rr, "MERGE_RR")
+REPO_GIT_PATH_FUNC(path_merge_mode, "MERGE_MODE")
+REPO_GIT_PATH_FUNC(path_merge_head, "MERGE_HEAD")
+REPO_GIT_PATH_FUNC(path_fetch_head, "FETCH_HEAD")
+REPO_GIT_PATH_FUNC(path_shallow, "shallow")
diff --git a/path.h b/path.h
index 1ccd0373c9..0fa6172f96 100644
--- a/path.h
+++ b/path.h
@@ -160,14 +160,36 @@ extern void report_linked_checkout_garbage(void);
 		return ret; \
 	}
 
-const char *git_path_cherry_pick_head(void);
-const char *git_path_revert_head(void);
-const char *git_path_squash_msg(void);
-const char *git_path_merge_msg(void);
-const char *git_path_merge_rr(void);
-const char *git_path_merge_mode(void);
-const char *git_path_merge_head(void);
-const char *git_path_fetch_head(void);
-const char *git_path_shallow(void);
+#define REPO_GIT_PATH_FUNC(var, filename) \
+	const char *git_##var(struct repository *r) \
+	{ \
+		if (!r->cached_paths.var) \
+			r->cached_paths.var = git_pathdup(filename); \
+		return r->cached_paths.var; \
+	}
+
+struct path_cache {
+	const char *path_cherry_pick_head;
+	const char *path_revert_head;
+	const char *path_squash_msg;
+	const char *path_merge_msg;
+	const char *path_merge_rr;
+	const char *path_merge_mode;
+	const char *path_merge_head;
+	const char *path_fetch_head;
+	const char *path_shallow;
+};
+
+#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
+
+const char *git_path_cherry_pick_head(struct repository *r);
+const char *git_path_revert_head(struct repository *r);
+const char *git_path_squash_msg(struct repository *r);
+const char *git_path_merge_msg(struct repository *r);
+const char *git_path_merge_rr(struct repository *r);
+const char *git_path_merge_mode(struct repository *r);
+const char *git_path_merge_head(struct repository *r);
+const char *git_path_fetch_head(struct repository *r);
+const char *git_path_shallow(struct repository *r);
 
 #endif /* PATH_H */
diff --git a/repository.c b/repository.c
index 0cf019bb9b..3ee47b4c5d 100644
--- a/repository.c
+++ b/repository.c
@@ -7,7 +7,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, RAW_OBJECT_STORE_INIT, OBJECT_PARSER_INIT, NULL,
+	NULL, NULL, NULL, RAW_OBJECT_STORE_INIT, OBJECT_PARSER_INIT, PATH_CACHE_INIT, NULL,
 	NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
diff --git a/repository.h b/repository.h
index 74b2b27986..8de14137b4 100644
--- a/repository.h
+++ b/repository.h
@@ -43,6 +43,11 @@ struct repository {
 	 */
 	struct object_parser parsed_objects;
 
+	/*
+	 * Contains path to often used file names.
+	 */
+	struct path_cache cached_paths;
+
 	/*
 	 * The store in which the refs are hold.
 	 */
diff --git a/rerere.c b/rerere.c
index 30ca5fa56d..dc79b940c5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -202,7 +202,7 @@ static struct rerere_id *new_rerere_id(unsigned char *sha1)
 static void read_rr(struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen_or_warn(git_path_merge_rr(), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(the_repository), "r");
 
 	if (!in)
 		return;
@@ -900,7 +900,8 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	if (flags & RERERE_READONLY)
 		fd = 0;
 	else
-		fd = hold_lock_file_for_update(&write_lock, git_path_merge_rr(),
+		fd = hold_lock_file_for_update(&write_lock,
+					       git_path_merge_rr(the_repository),
 					       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
 	return fd;
@@ -1251,6 +1252,6 @@ void rerere_clear(struct string_list *merge_rr)
 			rmdir(rerere_path(id, NULL));
 		}
 	}
-	unlink_or_warn(git_path_merge_rr());
+	unlink_or_warn(git_path_merge_rr(the_repository));
 	rollback_lock_file(&write_lock);
 }
diff --git a/sequencer.c b/sequencer.c
index fbbe5267f7..521da238b5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -274,7 +274,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path_cherry_pick_head());
+		unlink(git_path_cherry_pick_head(the_repository));
 		return;
 	}
 
@@ -951,7 +951,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
 	unsigned int flags = opts->edit ? EDIT_MSG : 0;
-	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
+	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(the_repository);
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
@@ -1083,12 +1083,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			flags |= CLEANUP_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
-			const char *dest = git_path_squash_msg();
+			const char *dest = git_path_squash_msg(the_repository);
 			unlink(dest);
 			if (copy_file(dest, rebase_path_squash_msg(), 0666))
 				return error(_("could not rename '%s' to '%s'"),
 					     rebase_path_squash_msg(), dest);
-			unlink(git_path_merge_msg());
+			unlink(git_path_merge_msg(the_repository));
 			msg_file = dest;
 			flags |= EDIT_MSG;
 		}
@@ -1102,13 +1102,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		if (res < 0)
 			return res;
 		res |= write_message(msgbuf.buf, msgbuf.len,
-				     git_path_merge_msg(), 0);
+				     git_path_merge_msg(the_repository), 0);
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
 		res = write_message(msgbuf.buf, msgbuf.len,
-				    git_path_merge_msg(), 0);
+				    git_path_merge_msg(the_repository), 0);
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
@@ -1644,8 +1644,8 @@ static int rollback_single_pick(void)
 {
 	struct object_id head_oid;
 
-	if (!file_exists(git_path_cherry_pick_head()) &&
-	    !file_exists(git_path_revert_head()))
+	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
+	    !file_exists(git_path_revert_head(the_repository)))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -1870,10 +1870,11 @@ static int error_failed_squash(struct commit *commit,
 		return error(_("could not rename '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
 	unlink(rebase_path_fixup_msg());
-	unlink(git_path_merge_msg());
-	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
+	unlink(git_path_merge_msg(the_repository));
+	if (copy_file(git_path_merge_msg(the_repository), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
-			     rebase_path_message(), git_path_merge_msg());
+			     rebase_path_message(),
+			     git_path_merge_msg(the_repository));
 	return error_with_patch(commit, subject, subject_len, opts, 1, 0);
 }
 
@@ -2228,8 +2229,8 @@ static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path_cherry_pick_head()) &&
-	    !file_exists(git_path_revert_head()))
+	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
+	    !file_exists(git_path_revert_head(the_repository)))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -2241,7 +2242,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
 	if (!has_uncommitted_changes(0)) {
-		const char *cherry_pick_head = git_path_cherry_pick_head();
+		const char *cherry_pick_head = git_path_cherry_pick_head(the_repository);
 
 		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
@@ -2295,8 +2296,8 @@ int sequencer_continue(struct replay_opts *opts)
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
-		if (file_exists(git_path_cherry_pick_head()) ||
-		    file_exists(git_path_revert_head())) {
+		if (file_exists(git_path_cherry_pick_head(the_repository)) ||
+		    file_exists(git_path_revert_head(the_repository))) {
 			res = continue_single_pick();
 			if (res)
 				goto release_todo_list;
diff --git a/shallow.c b/shallow.c
index 18c6f063c1..2849046477 100644
--- a/shallow.c
+++ b/shallow.c
@@ -52,7 +52,7 @@ int is_repository_shallow_the_repository(void)
 		return is_shallow;
 
 	if (!path)
-		path = git_path_shallow();
+		path = git_path_shallow(the_repository);
 	/*
 	 * fetch-pack sets '--shallow-file ""' as an indicator that no
 	 * shallow file should be used. We could just open it and it
@@ -225,7 +225,7 @@ static void check_shallow_file_for_update_the_repository(void)
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path_shallow()))
+	if (!stat_validity_check(&shallow_stat, git_path_shallow(the_repository)))
 		die("shallow file has changed since we read it");
 }
 
@@ -320,7 +320,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
+	fd = hold_lock_file_for_update(shallow_lock,
+				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
@@ -367,7 +368,8 @@ void prune_shallow(int show_only)
 		strbuf_release(&sb);
 		return;
 	}
-	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
+	fd = hold_lock_file_for_update(&shallow_lock,
+				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
@@ -376,7 +378,7 @@ void prune_shallow(int show_only)
 				  get_lock_file_path(&shallow_lock));
 		commit_lock_file(&shallow_lock);
 	} else {
-		unlink(git_path_shallow());
+		unlink(git_path_shallow(the_repository));
 		rollback_lock_file(&shallow_lock);
 	}
 	strbuf_release(&sb);
diff --git a/wt-status.c b/wt-status.c
index 6655bc6f67..6b2885a2f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1286,7 +1286,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(), &st)) {
+	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(the_repository), &st)) {
 		print_rebase_state(s, state, color);
 		if (s->hints)
 			status_printf_ln(s, color,
@@ -1521,17 +1521,17 @@ void wt_status_get_state(struct wt_status_state *state,
 	struct stat st;
 	struct object_id oid;
 
-	if (!stat(git_path_merge_head(), &st)) {
+	if (!stat(git_path_merge_head(the_repository), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
-	} else if (!stat(git_path_cherry_pick_head(), &st) &&
+	} else if (!stat(git_path_cherry_pick_head(the_repository), &st) &&
 			!get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		hashcpy(state->cherry_pick_head_sha1, oid.hash);
 	}
 	wt_status_check_bisect(NULL, state);
-	if (!stat(git_path_revert_head(), &st) &&
+	if (!stat(git_path_revert_head(the_repository), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		hashcpy(state->revert_head_sha1, oid.hash);
-- 
2.15.1.433.g936d1b9894.dirty

