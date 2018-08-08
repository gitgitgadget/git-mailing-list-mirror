Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97743208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHHRn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38336 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeHHRn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so1446992edr.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2ChyiUhJrhtK0aqYoOLLeHRuqUtw2m54lv8bKm5g2k=;
        b=ReDp/qqDMXXZT37kinOpyVTvxS7Hd4ImVMfWIBAyiwBAw5iypL1h/Bd/1a10/E12Ty
         i/4jlOxbvuoLOSrwc5Bdo+4Bz4e5EyYO7+d72rmXXL3Y+FPE+mxi3fOZdFKdjygyycFO
         elMJhXpIgvXqjdxQD9mIPGq9TgP2fAX9WEXLNjb/OqDmeW88Ndndh7YaaCGNHWjbuDGX
         U8IoaCtoVrAOIJRlOODNON2sMlGPm/ibrWI7Bj4cDZI2UCPBqqz/zmtQEPO8kOQit+sp
         fGYUPB9Z0s10XOWsDyiePOKUl7q5Vds3jXsKy0yYDz0M02+Pp+RGC2lDRekkmaIL0Pj4
         2dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2ChyiUhJrhtK0aqYoOLLeHRuqUtw2m54lv8bKm5g2k=;
        b=WFn201wjOaZ/gpvDg+fbzqoBrmlpd+P6A6dgappneqzr0cx/HB89JBYQHZ6I8UCNWH
         GrcbSTExVZ3TWzLk3biYNEcNbS8Jv7ENgv1NeJmA8h298aAFOAOMaInqiGRnFc+lvzkg
         V/zRxquIFODnIPWv/Khdo4CsjAJmc34VVNGniToNgla25vDgZOAMcT5LZN7E1HqTXlW9
         xxV9QHk5DDubq2sZvhV1P3Iq13WRFkGJxd8rvZE0d5pkp1Xwqpo4yyuHdTzWLvp08PnK
         64Os0YA2XT1epkzSDD21wUyB12IKhKpu9UGwZIcTWDFch8pkVZw3dhRMaokpqJyglZ6t
         MsQA==
X-Gm-Message-State: AOUpUlEM6Rphkg68yoOAWDC3SA46BluYft8p70IuhLtoSKE3DceBCrDI
        w4BGEgml2hcWbxv7f632QA0mY1e8
X-Google-Smtp-Source: AA+uWPxRmhSeJDYNFqUNqly1hrxz3Kr1v6ltVbIdjbqJgVpV0ThIoJql/bebUWE9MafhVaUaUv+MZw==
X-Received: by 2002:a50:d429:: with SMTP id t41-v6mr3785551edh.75.1533741798208;
        Wed, 08 Aug 2018 08:23:18 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:17 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 11/18] builtin rebase: support `--autostash` option
Date:   Wed,  8 Aug 2018 21:06:33 +0545
Message-Id: <20180808152140.14585-12-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support `--autostash` we introduce a function `apply_autostash()`
just like in `git-legacy-rebase.sh`.

Rather than refactoring and using the same function that exists in
`sequencer.c`, we go a different route here, to avoid clashes with
the sister GSoC project that turns the interactive rebase into a
builtin.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4437c86513..a6bfa73915 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -63,12 +63,6 @@ static int use_builtin_rebase(void)
 	return ret;
 }
 
-static int apply_autostash(void)
-{
-	warning("TODO");
-	return 0;
-}
-
 struct rebase_options {
 	enum rebase_type type;
 	const char *state_dir;
@@ -98,6 +92,7 @@ struct rebase_options {
 	int keep_empty;
 	int autosquash;
 	char *gpg_sign_opt;
+	int autostash;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -224,13 +219,56 @@ static int read_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
+static int apply_autostash(struct rebase_options *opts)
+{
+	const char *path = state_dir_path("autostash", opts);
+	struct strbuf autostash = STRBUF_INIT;
+	struct child_process stash_apply = CHILD_PROCESS_INIT;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (read_one(state_dir_path("autostash", opts), &autostash))
+		return error(_("Could not read '%s'"), path);
+	argv_array_pushl(&stash_apply.args,
+			 "stash", "apply", autostash.buf, NULL);
+	stash_apply.git_cmd = 1;
+	stash_apply.no_stderr = stash_apply.no_stdout =
+		stash_apply.no_stdin = 1;
+	if (!run_command(&stash_apply))
+		printf("Applied autostash.\n");
+	else {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		int res = 0;
+
+		argv_array_pushl(&args,
+				 "stash", "store", "-m", "autostash", "-q",
+				 autostash.buf, NULL);
+		if (run_command_v_opt(args.argv, RUN_GIT_CMD))
+			res = error(_("Cannot store %s"), autostash.buf);
+		argv_array_clear(&args);
+		strbuf_release(&autostash);
+		if (res)
+			return res;
+
+		fprintf(stderr,
+			_("Applying autostash resulted in conflicts.\n"
+			  "Your changes are safe in the stash.\n"
+			  "You can run \"git stash pop\" or \"git stash drop\" "
+			  "at any time.\n"));
+	}
+
+	strbuf_release(&autostash);
+	return 0;
+}
+
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
 	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	apply_autostash();
+	apply_autostash(opts);
 	close_all_packs(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
@@ -345,7 +383,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
 
-		apply_autostash();
+		apply_autostash(opts);
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
@@ -480,6 +518,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.autostash")) {
+		opts->autostash = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -646,6 +689,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				N_("whitespace"), N_("passed to 'git apply'")),
 		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
 			    REBASE_AM),
+		OPT_BOOL(0, "autostash", &options.autostash,
+			 N_("automatically stash/stash pop before and after")),
 		OPT_END(),
 	};
 
@@ -975,6 +1020,62 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (read_index(the_repository->index) < 0)
 		die(_("could not read index"));
 
+	if (options.autostash) {
+		struct lock_file lock_file = LOCK_INIT;
+		int fd;
+
+		fd = hold_locked_index(&lock_file, 0);
+		refresh_cache(REFRESH_QUIET);
+		if (0 <= fd)
+			update_index_if_able(&the_index, &lock_file);
+		rollback_lock_file(&lock_file);
+
+		if (has_unstaged_changes(0) || has_uncommitted_changes(0)) {
+			const char *autostash =
+				state_dir_path("autostash", &options);
+			struct child_process stash = CHILD_PROCESS_INIT;
+			struct object_id oid;
+			struct commit *head =
+				lookup_commit_reference(the_repository,
+							&options.orig_head);
+
+			argv_array_pushl(&stash.args,
+					 "stash", "create", "autostash", NULL);
+			stash.git_cmd = 1;
+			stash.no_stdin = 1;
+			strbuf_reset(&buf);
+			if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
+				die(_("Cannot autostash"));
+			strbuf_trim_trailing_newline(&buf);
+			if (get_oid(buf.buf, &oid))
+				die(_("Unexpected stash response: '%s'"),
+				    buf.buf);
+			strbuf_reset(&buf);
+			strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
+
+			if (safe_create_leading_directories_const(autostash))
+				die(_("Could not create directory for '%s'"),
+				    options.state_dir);
+			write_file(autostash, "%s", buf.buf);
+			printf(_("Created autostash: %s\n"), buf.buf);
+			if (reset_head(&head->object.oid, "reset --hard",
+				       NULL, 0) < 0)
+				die(_("could not reset --hard"));
+			printf(_("HEAD is now at %s"),
+			       find_unique_abbrev(&head->object.oid,
+						  DEFAULT_ABBREV));
+			strbuf_reset(&buf);
+			pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
+			if (buf.len > 0)
+				printf(" %s", buf.buf);
+			putchar('\n');
+
+			if (discard_index(the_repository->index) < 0 ||
+				read_index(the_repository->index) < 0)
+				die(_("could not read index"));
+		}
+	}
+
 	if (require_clean_work_tree("rebase",
 				    _("Please commit or stash them."), 1, 1)) {
 		ret = 1;
-- 
2.18.0

