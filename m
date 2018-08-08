Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CEF208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeHHR2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39550 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHR2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so1425106edi.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDE/smkhR9lCraIjOQQofSERBhDmVR4+rSnTl0Bb3FY=;
        b=Cl7dZtq+mvdHzQ+602Fi7EbrNBRbbULr7A9s1kGy7khyne2/5DxQMLVvgTJRyFeNvp
         HsUp15neBbW9lI0ngwqSKNqeWj3rtZnrNiew92ZXtq6T+c+CrayCuIoCBOFS2JwUdTmN
         /wcAyld2/hWj0dxECLeKE03V5bFwbmMK1/wXlsiriWw8LVGQgE2RUzKChwQyODkUeD2T
         Jct6MlQ9d6AVI5ruCX4dwLHN+1WFBWMoaNqwGr1VsnuhZ8AzAATI8KdesTYErQRvw1kO
         +BgvbSuMxeHQx8n7YA+YqvoGAmnfU7uxzcfnP4K00QToTFXs6njtll9v0gyykrykNTeD
         ew0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDE/smkhR9lCraIjOQQofSERBhDmVR4+rSnTl0Bb3FY=;
        b=Axr9C1K0NWjGGBAsvtApv2AXjbHzjesiS8xVXkXealke67hY4+WGddjDFAjOUJyHKH
         HATfNIwBSZGo0rS85TcZZkxzJSdo5hFbCZiDybavgC3tILFuxd3N4DodNBdxHKjBTQCd
         WF3VhHqQPpYraQN1EERgPP8fIPvH+1L8itKjOCDg3p/AXmCGsCzSc26fvlXxZC0cVqMa
         tVwZsIjOMGcVvfuLXv9nS0slEGoO0c4VSDmU2j003Trok4e7L2BFeEtnrYlchPaa9jQr
         wgyPPx/tY3fYABNttfIrolX9K7x5kt2R8YJx+jqxpST6cUBHbHoOhUY+P64lpzcLaxWB
         5H4A==
X-Gm-Message-State: AOUpUlF72iw2txmt5SgTznEXWg1JxHBNl+bt5/q+hE219oblEDcihYVM
        ieS9WmoiqtFEDmSGgjIKBx0vEudt
X-Google-Smtp-Source: AA+uWPzr5wz+plbvTf71epWEPt0FFLRhQ8A0B6yUAJjm/k+SAkOxlwTd/85+xSOyw4pTqHagSI/Q2g==
X-Received: by 2002:aa7:c306:: with SMTP id l6-v6mr3627520edq.53.1533740917518;
        Wed, 08 Aug 2018 08:08:37 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:36 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 1/7] builtin rebase: support --continue
Date:   Wed,  8 Aug 2018 20:51:16 +0545
Message-Id: <20180808150622.9614-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds the option `--continue` which is used to resume
rebase after merge conflicts. The code tries to stay as close to
the equivalent shell scripts found in `git-legacy-rebase.sh` as
possible.

When continuing a rebase, the state variables are read from state_dir.
Some of the state variables are not actually stored there, such as
`upstream`. The shell script version simply does not set them, but for
consistency, we unset them in the builtin version.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 115 +++++++++++++++++++++++++++++++++++++++++++++--
 strbuf.c         |   9 ++++
 strbuf.h         |   3 ++
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b2ddfa8dbf..10da4c978b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -91,6 +91,7 @@ struct rebase_options {
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strbuf git_am_opt;
+	const char *action;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -115,6 +116,62 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
 	return path.buf;
 }
 
+/* Read one file, then strip line endings */
+static int read_one(const char *path, struct strbuf *buf)
+{
+	if (strbuf_read_file(buf, path, 0) < 0)
+		return error_errno(_("could not read '%s'"), path);
+	strbuf_trim_trailing_newline(buf);
+	return 0;
+}
+
+/* Initialize the rebase options from the state directory. */
+static int read_basic_state(struct rebase_options *opts)
+{
+	struct strbuf head_name = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+
+	if (read_one(state_dir_path("head-name", opts), &head_name) ||
+	    read_one(state_dir_path("onto", opts), &buf))
+		return -1;
+	opts->head_name = starts_with(head_name.buf, "refs/") ?
+		xstrdup(head_name.buf) : NULL;
+	strbuf_release(&head_name);
+	if (get_oid(buf.buf, &oid))
+		return error(_("could not get 'onto': '%s'"), buf.buf);
+	opts->onto = lookup_commit_or_die(&oid, buf.buf);
+
+	/*
+	 * We always write to orig-head, but interactive rebase used to write to
+	 * head. Fall back to reading from head to cover for the case that the
+	 * user upgraded git with an ongoing interactive rebase.
+	 */
+	strbuf_reset(&buf);
+	if (file_exists(state_dir_path("orig-head", opts))) {
+		if (read_one(state_dir_path("orig-head", opts), &buf))
+			return -1;
+	} else if (read_one(state_dir_path("head", opts), &buf))
+		return -1;
+	if (get_oid(buf.buf, &opts->orig_head))
+		return error(_("invalid orig-head: '%s'"), buf.buf);
+
+	strbuf_reset(&buf);
+	if (read_one(state_dir_path("quiet", opts), &buf))
+		return -1;
+	if (buf.len)
+		opts->flags &= ~REBASE_NO_QUIET;
+	else
+		opts->flags |= REBASE_NO_QUIET;
+
+	if (file_exists(state_dir_path("verbose", opts)))
+		opts->flags |= REBASE_VERBOSE;
+
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -168,12 +225,13 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "state_dir", opts->state_dir);
 
 	add_var(&script_snippet, "upstream_name", opts->upstream_name);
-	add_var(&script_snippet, "upstream",
-				 oid_to_hex(&opts->upstream->object.oid));
+	add_var(&script_snippet, "upstream", opts->upstream ?
+		oid_to_hex(&opts->upstream->object.oid) : NULL);
 	add_var(&script_snippet, "head_name",
 		opts->head_name ? opts->head_name : "detached HEAD");
 	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
-	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
+	add_var(&script_snippet, "onto", opts->onto ?
+		oid_to_hex(&opts->onto->object.oid) : NULL);
 	add_var(&script_snippet, "onto_name", opts->onto_name);
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
@@ -189,6 +247,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->flags & REBASE_FORCE ? "t" : "");
 	if (opts->switch_to)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
+	add_var(&script_snippet, "action", opts->action ? opts->action : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -400,12 +459,16 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.git_am_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
-	int ret, flags, in_progress = 0;
+	int ret, flags, total_argc, in_progress = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
+	enum {
+		NO_ACTION,
+		ACTION_CONTINUE,
+	} action = NO_ACTION;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -427,6 +490,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-ff", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
+		OPT_CMDMODE(0, "continue", &action, N_("continue"),
+			    ACTION_CONTINUE),
 		OPT_END(),
 	};
 
@@ -480,14 +545,55 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.type != REBASE_UNSPECIFIED)
 		in_progress = 1;
 
+	total_argc = argc;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (action != NO_ACTION && total_argc != 2) {
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
+	}
+
 	if (argc > 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	switch (action) {
+	case ACTION_CONTINUE: {
+		struct object_id head;
+		struct lock_file lock_file = LOCK_INIT;
+		int fd;
+
+		options.action = "continue";
+
+		/* Sanity check */
+		if (get_oid("HEAD", &head))
+			die(_("Cannot read HEAD"));
+
+		fd = hold_locked_index(&lock_file, 0);
+		if (read_index(the_repository->index) < 0)
+			die(_("could not read index"));
+		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
+			      NULL);
+		if (0 <= fd)
+			update_index_if_able(the_repository->index,
+					     &lock_file);
+		rollback_lock_file(&lock_file);
+
+		if (has_unstaged_changes(1)) {
+			puts(_("You must edit all merge conflicts and then\n"
+			       "mark them as resolved using git add"));
+			exit(1);
+		}
+		if (read_basic_state(&options))
+			exit(1);
+		goto run_rebase;
+	}
+	default:
+		die("TODO");
+	}
+
 	/* Make sure no rebase is in progress */
 	if (in_progress) {
 		const char *last_slash = strrchr(options.state_dir, '/');
@@ -719,6 +825,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	options.revisions = revisions.buf;
 
+run_rebase:
 	ret = !!run_specific_rebase(&options);
 
 cleanup:
diff --git a/strbuf.c b/strbuf.c
index 030556111d..fdc0ffbafb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -120,6 +120,15 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_newline(struct strbuf *sb)
+{
+	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
+		if (--sb->len > 0 && sb->buf[sb->len - 1] == '\r')
+			--sb->len;
+		sb->buf[sb->len] = '\0';
+	}
+}
+
 void strbuf_ltrim(struct strbuf *sb)
 {
 	char *b = sb->buf;
diff --git a/strbuf.h b/strbuf.h
index 60a35aef16..b7aea8a966 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -190,6 +190,9 @@ extern void strbuf_ltrim(struct strbuf *);
 /* Strip trailing directory separators */
 extern void strbuf_trim_trailing_dir_sep(struct strbuf *);
 
+/* Strip trailing LF or CR/LF */
+extern void strbuf_trim_trailing_newline(struct strbuf *sb);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
-- 
2.18.0

