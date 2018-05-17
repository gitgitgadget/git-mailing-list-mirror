Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7BB1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEQWwh (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:37 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:35327 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQWwe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:34 -0400
Received: by mail-pl0-f51.google.com with SMTP id i5-v6so3402673plt.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LzFojE6SMT7u0b+F2q1xR5YhnVgvyjrQaVBIFRsoaec=;
        b=ZKqAK9RqYvXTzH0GqCn4J6yTLMR8sqZQf+8dAcrnlkOqwTvXthnatvVPTsuNYLR/vy
         LFg3hTJKZjremXQvoD2V9aKGXJJpRL8vTV403EVgfWqWWc/CCQAnWD3vUYEcdhwZu1At
         yIRCEVK21IniUlnBJhUBcmn2iKP5KqiQ0w9yinEaXvdYsq63n0mqCgBB5Q6Xa+yHo6us
         IcPNsyflpSx7Hcgy/Xh0M+rZA0hvQXEFmCnKGQU5iCBV0hJ5qET/o1oSySJqiSlgwVjt
         hhGbtikSORXuS/hUjkGcnh3Ow8KzUHbbmh4prLAcWDIeSQ+WJjslUrl43+nrsPAE10Sz
         m5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LzFojE6SMT7u0b+F2q1xR5YhnVgvyjrQaVBIFRsoaec=;
        b=twOq5nWV1Nu4JQPvdqJ29wqTDba014Ivjf5V9ZueEB0wP0QVRc5NYRVm2qemFHo3mQ
         mNgUhMypZfmTtZVzUarlcCxyDVG8fbfiLT5rSRhHmkRpwN2g+RCVvyQEkadv8B48Wj8I
         kGAfTlaSWR/MDE4JM8UaZcKbRv6eZgJN36dudtcXCs6/qX6j6Je+yn+AqP9Kta0kN8Ye
         3cpuabtcM+WRwFjYxOdhiNfQNum7ei0onZH2AYgcp7/1d+07OTA9cmutd1WKfn6On1ou
         ZJH8zOpylMCobNPfMPyr7WaovXxydod0mFICZsuWYVDzPQ1EuUZ4F+ukvXyc/l3Hh2h3
         9zVA==
X-Gm-Message-State: ALKqPwdSs5iqAb9mQ1lmHX/bVTCOfnCB20hMibUk/0YnmepNFVBYJ+Xn
        n3i1YDdYTxXqUiBWiUv4/nzzHQ==
X-Google-Smtp-Source: AB8JxZrmDiW1bYUuO/CIzTRuG1WdiLP3zvWxndd052AnjPXEAat6V/P/YcLMk9HAj8JZAcTUiJAxdA==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr7054024pll.116.1526597553218;
        Thu, 17 May 2018 15:52:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u16-v6sm11948240pfl.39.2018.05.17.15.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/19] path.c: migrate global git_path_* to take a repository argument
Date:   Thu, 17 May 2018 15:51:51 -0700
Message-Id: <20180517225154.9200-17-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate all git_path_* functions that are defined in path.c to take a
repository argument. Unlike other patches in this series, do not use the
 #define trick, as we rewrite the whole function, which is rather small.

This doesn't migrate all the functions, as other builtins have their own
local path functions defined using GIT_PATH_FUNC. So keep that macro
around to serve the other locations.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 blame.c          |  8 +++++---
 branch.c         | 14 +++++++-------
 builtin/commit.c | 38 +++++++++++++++++++-------------------
 builtin/fetch.c  |  4 ++--
 builtin/merge.c  | 37 +++++++++++++++++++------------------
 builtin/pull.c   |  4 ++--
 builtin/reset.c  |  2 +-
 fetch-pack.c     |  2 +-
 path.c           | 18 +++++++++---------
 path.h           | 40 +++++++++++++++++++++++++++++++---------
 repository.h     |  5 +++++
 rerere.c         |  7 ++++---
 sequencer.c      | 37 +++++++++++++++++++------------------
 shallow.c        | 12 +++++++-----
 wt-status.c      |  8 ++++----
 15 files changed, 135 insertions(+), 101 deletions(-)

diff --git a/blame.c b/blame.c
index f689bde31cd..c22184c2dad 100644
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
index 2672054f0b5..9b2742de32a 100644
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
index 37fcb55ab0a..7c22879777d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -145,9 +145,9 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 
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
@@ -696,21 +696,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (have_option_m)
 			strbuf_addbuf(&sb, &message);
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
@@ -791,8 +791,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					"	%s\n"
 					"and try again.\n"),
 				whence == FROM_MERGE ?
-					git_path_merge_head() :
-					git_path_cherry_pick_head());
+					git_path_merge_head(the_repository) :
+					git_path_cherry_pick_head(the_repository));
 		}
 
 		fprintf(s->fp, "\n");
@@ -1523,7 +1523,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = commit_list_append(current_head, pptr);
-		fp = xfopen(git_path_merge_head(), "r");
+		fp = xfopen(git_path_merge_head(the_repository), "r");
 		while (strbuf_getline_lf(&m, fp) != EOF) {
 			struct commit *parent;
 
@@ -1534,8 +1534,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1598,12 +1598,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("%s", err.buf);
 	}
 
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
index 55140671ef3..41d74c7e8d3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -767,7 +767,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
+	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1019,7 +1019,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	const char *filename = git_path_fetch_head();
+	const char *filename = git_path_fetch_head(the_repository);
 	FILE *fp = fopen_for_writing(filename);
 
 	if (!fp)
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16e..e9057c1657b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -245,9 +245,9 @@ static struct option builtin_merge_options[] = {
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
@@ -380,7 +380,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 			oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&ctx, commit, &out);
 	}
-	write_file_buf(git_path_squash_msg(), out.buf, out.len);
+	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
 }
 
@@ -741,7 +741,7 @@ static void add_strategies(const char *string, unsigned attr)
 
 static void read_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path_merge_msg();
+	const char *filename = git_path_merge_msg(the_repository);
 	strbuf_reset(msg);
 	if (strbuf_read_file(msg, filename, 0) < 0)
 		die_errno(_("Could not read from '%s'"), filename);
@@ -778,18 +778,18 @@ static void prepare_to_commit(struct commit_list *remoteheads)
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
@@ -859,7 +859,7 @@ static int suggest_conflicts(void)
 	FILE *fp;
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	filename = git_path_merge_msg();
+	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
 	append_conflicts_hint(&msgbuf);
@@ -939,12 +939,12 @@ static void write_merge_heads(struct commit_list *remoteheads)
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
 
@@ -952,7 +952,8 @@ static void write_merge_state(struct commit_list *remoteheads)
 {
 	write_merge_heads(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
+	write_file_buf(git_path_merge_msg(the_repository), merge_msg.buf,
+		       merge_msg.len);
 }
 
 static int default_edit_option(void)
@@ -1035,7 +1036,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	if (!merge_names)
 		merge_names = &fetch_head_file;
 
-	filename = git_path_fetch_head();
+	filename = git_path_fetch_head(the_repository);
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		die_errno(_("could not open '%s' for reading"), filename);
@@ -1209,7 +1210,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			usage_msg_opt(_("--abort expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
-		if (!file_exists(git_path_merge_head()))
+		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
 		/* Invoke 'git reset --merge' */
@@ -1225,7 +1226,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			usage_msg_opt(_("--continue expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
-		if (!file_exists(git_path_merge_head()))
+		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
 
 		/* Invoke 'git commit' */
@@ -1236,7 +1237,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
-	if (file_exists(git_path_merge_head())) {
+	if (file_exists(git_path_merge_head(the_repository))) {
 		/*
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
@@ -1247,7 +1248,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path_cherry_pick_head())) {
+	if (file_exists(git_path_cherry_pick_head(the_repository))) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/builtin/pull.c b/builtin/pull.c
index e32d6cd5b4c..d21239cd9f3 100644
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
@@ -857,7 +857,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-	if (file_exists(git_path_merge_head()))
+	if (file_exists(git_path_merge_head(the_repository)))
 		die_conclude_merge();
 
 	if (get_oid("HEAD", &orig_head))
diff --git a/builtin/reset.c b/builtin/reset.c
index 7f1c3f02a30..a9136a163c0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -39,7 +39,7 @@ static const char *reset_type_names[] = {
 
 static inline int is_merge(void)
 {
-	return !access(git_path_merge_head(), F_OK);
+	return !access(git_path_merge_head(the_repository), F_OK);
 }
 
 static int reset_index(const struct object_id *oid, int reset_type, int quiet)
diff --git a/fetch-pack.c b/fetch-pack.c
index 90befd370fe..8f3aacaaaa2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1136,7 +1136,7 @@ static void update_shallow(struct fetch_pack_args *args,
 
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
-			unlink_or_warn(git_path_shallow());
+			unlink_or_warn(git_path_shallow(the_repository));
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
diff --git a/path.c b/path.c
index 3308b7b9582..3c06e258b4c 100644
--- a/path.c
+++ b/path.c
@@ -1358,12 +1358,12 @@ char *xdg_cache_home(const char *filename)
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
+REPO_GIT_PATH_FUNC(cherry_pick_head, "CHERRY_PICK_HEAD")
+REPO_GIT_PATH_FUNC(revert_head, "REVERT_HEAD")
+REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
+REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
+REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
+REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
+REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
+REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
+REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index 1ccd0373c9d..5263f40519a 100644
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
+	const char *git_path_##var(struct repository *r) \
+	{ \
+		if (!r->cached_paths.var) \
+			r->cached_paths.var = git_pathdup(filename); \
+		return r->cached_paths.var; \
+	}
+
+struct path_cache {
+	const char *cherry_pick_head;
+	const char *revert_head;
+	const char *squash_msg;
+	const char *merge_msg;
+	const char *merge_rr;
+	const char *merge_mode;
+	const char *merge_head;
+	const char *fetch_head;
+	const char *shallow;
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
diff --git a/repository.h b/repository.h
index 6d199819905..83f9ef15103 100644
--- a/repository.h
+++ b/repository.h
@@ -38,6 +38,11 @@ struct repository {
 	/* The store in which the refs are held. */
 	struct ref_store *refs;
 
+	/*
+	 * Contains path to often used file names.
+	 */
+	struct path_cache cached_paths;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
diff --git a/rerere.c b/rerere.c
index fcb99cc9542..a3af88939a2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -201,7 +201,7 @@ static struct rerere_id *new_rerere_id(unsigned char *sha1)
 static void read_rr(struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen_or_warn(git_path_merge_rr(), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(the_repository), "r");
 
 	if (!in)
 		return;
@@ -897,7 +897,8 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	if (flags & RERERE_READONLY)
 		fd = 0;
 	else
-		fd = hold_lock_file_for_update(&write_lock, git_path_merge_rr(),
+		fd = hold_lock_file_for_update(&write_lock,
+					       git_path_merge_rr(the_repository),
 					       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
 	return fd;
@@ -1247,6 +1248,6 @@ void rerere_clear(struct string_list *merge_rr)
 			rmdir(rerere_path(id, NULL));
 		}
 	}
-	unlink_or_warn(git_path_merge_rr());
+	unlink_or_warn(git_path_merge_rr(the_repository));
 	rollback_lock_file(&write_lock);
 }
diff --git a/sequencer.c b/sequencer.c
index cf6456ab75d..eb0bef45e2a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -322,7 +322,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path_cherry_pick_head());
+		unlink(git_path_cherry_pick_head(the_repository));
 		return;
 	}
 
@@ -1191,8 +1191,8 @@ static int do_commit(const char *msg_file, const char *author,
 				    &oid);
 		strbuf_release(&sb);
 		if (!res) {
-			unlink(git_path_cherry_pick_head());
-			unlink(git_path_merge_msg());
+			unlink(git_path_cherry_pick_head(the_repository));
+			unlink(git_path_merge_msg(the_repository));
 			if (!is_rebase_i(opts))
 				print_commit_summary(NULL, &oid,
 						SUMMARY_SHOW_AUTHOR_DATE);
@@ -1459,7 +1459,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
 	unsigned int flags = opts->edit ? EDIT_MSG : 0;
-	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
+	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(the_repository);
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
@@ -1594,12 +1594,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
@@ -1616,13 +1616,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
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
@@ -2168,8 +2168,8 @@ static int rollback_single_pick(void)
 {
 	struct object_id head_oid;
 
-	if (!file_exists(git_path_cherry_pick_head()) &&
-	    !file_exists(git_path_revert_head()))
+	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
+	    !file_exists(git_path_revert_head(the_repository)))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -2397,10 +2397,11 @@ static int error_failed_squash(struct commit *commit,
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
 
@@ -2756,8 +2757,8 @@ static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path_cherry_pick_head()) &&
-	    !file_exists(git_path_revert_head()))
+	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
+	    !file_exists(git_path_revert_head(the_repository)))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -2769,7 +2770,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
 	if (!has_uncommitted_changes(0)) {
-		const char *cherry_pick_head = git_path_cherry_pick_head();
+		const char *cherry_pick_head = git_path_cherry_pick_head(the_repository);
 
 		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
@@ -2823,8 +2824,8 @@ int sequencer_continue(struct replay_opts *opts)
 
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
index e903651202b..a0e338459f9 100644
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
@@ -223,7 +223,7 @@ static void check_shallow_file_for_update_the_repository(void)
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path_shallow()))
+	if (!stat_validity_check(&shallow_stat, git_path_shallow(the_repository)))
 		die("shallow file has changed since we read it");
 }
 
@@ -318,7 +318,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
+	fd = hold_lock_file_for_update(shallow_lock,
+				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
@@ -365,7 +366,8 @@ void prune_shallow(int show_only)
 		strbuf_release(&sb);
 		return;
 	}
-	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
+	fd = hold_lock_file_for_update(&shallow_lock,
+				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
@@ -374,7 +376,7 @@ void prune_shallow(int show_only)
 				  get_lock_file_path(&shallow_lock));
 		commit_lock_file(&shallow_lock);
 	} else {
-		unlink(git_path_shallow());
+		unlink(git_path_shallow(the_repository));
 		rollback_lock_file(&shallow_lock);
 	}
 	strbuf_release(&sb);
diff --git a/wt-status.c b/wt-status.c
index 50815e5faff..e35cdfeb4be 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1309,7 +1309,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(), &st)) {
+	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(the_repository), &st)) {
 		print_rebase_state(s, state, color);
 		if (s->hints)
 			status_printf_ln(s, color,
@@ -1544,17 +1544,17 @@ void wt_status_get_state(struct wt_status_state *state,
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
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
-	if (!stat(git_path_revert_head(), &st) &&
+	if (!stat(git_path_revert_head(the_repository), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
-- 
2.17.0.582.gccdcbd54c44.dirty

