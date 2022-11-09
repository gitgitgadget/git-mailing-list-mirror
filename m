Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F684C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKIArj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKIArf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5506317A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:47:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k15-20020a170902c40f00b001887cd71fe6so5833258plk.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeR4dEm7EC+Hi2MuKEGYUDm0GjsVRwESUlqokgrh6QA=;
        b=qwXGrUS8mdigMPxVhquX6BBREHgMbWT3NNlWNVIeVMRwotJVWhLaF/VV7t1HMP1o5N
         i4p8LPSwDDd8jqQvT+4J6Q/3oizVon4dux0gMSafq5EqboDkE0x/aj6UPHOrxBQd0G1r
         wNPDgbzjfz/Um9aP8pW/EKSd1PlVdJtNTfm4SzM2I1KZCHa1zoJWhghIjtsmAu2lulaS
         WbMk/h9zeAm0sCusMVZsEwprPba0riV1f8IkW+f0XYPbWdEcxZC2fJ4qGKZOT2fxU+yx
         0EW7SRvgFlO9/TVRxwor9ZExcbqsN/W+V1aX5ZYLKwIrtLavLhIGK1N/wgmEMnukfypX
         eCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeR4dEm7EC+Hi2MuKEGYUDm0GjsVRwESUlqokgrh6QA=;
        b=A1cl6keyT8W4HmZYbU1UVUzmDt2ZrxbBGWb+dQAdVHbCKinb8gxhj5K6ZpjyQCHFLw
         XaMpnrwOBiglA9B2AuK0htn3dtX9r2+25Yq4cmY60ieTVG4Pfxse4dfS286verkcQm/Z
         q+0R3uvjUfyh9Z8zSh3qut1ox6tjLUOTCTYPKTSW1PMWw3b4f9TE9wAHzz6Xdh6UxT2u
         BxWhFsArQ3OpTlI1y5IVFTtapVkrCr7l+BpNRpqwBKMT90EOZ7JIsRs1rR+tp77RBbml
         o0uKSeQFCLHICvIXggV0eXfdQe4u7eHHH+6SCTsZIcIGYabIufP+Zyb3bgOnC9BUB1E7
         Eezg==
X-Gm-Message-State: ACrzQf3VSl027NUVA6fnv006s8sGeMuuBaXjraSj1KjnLxqQKq2rQ7B5
        sDZMBK5gtljfWjEfO0I2RUS8DyIe1Fm5vkwBiLnurYkHJ+Z1jqBDimlyucWGj/rPYpLYumV6M4g
        unEEHtiPAIkXs1YwdqXFPG3IGjc+USlHSZ13ZK4Aan70MBMGij63KWDzNZO71Mww=
X-Google-Smtp-Source: AMsMyM79nCjnmf39QYDlAON3hqg42IMBXlJZXSocB5VVrcgAWUmgD2LECcL3WUJqDfCatF4ykBXNEK5xUtcLeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:be14:0:b0:56d:9eed:61eb with SMTP id
 l20-20020a62be14000000b0056d9eed61ebmr1097146pff.4.1667954850698; Tue, 08 Nov
 2022 16:47:30 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:47:07 -0800
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109004708.97668-4-chooglen@google.com>
Subject: [RFC PATCH 3/4] read-tree: teach --submodule-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the precedent of previous commit, teach "git read-tree" the
"--submodule-prefix" flag, replacing its use of the global
"--super-prefix" flag.

This also fixes an existing bug where "git --super-prefix=<path>
read-tree" (typically invoked by "git restore") in a partial clone with
submodules could fail because we fetch promisor objects with "git
fetch", but "git fetch" doesn't support "--super-prefix".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/read-tree.c         |  4 ++++
 submodule.c                 | 22 +++++++------------
 t/t1001-read-tree-m-2way.sh |  4 ++--
 t/t5616-partial-clone.sh    | 43 +++++++++++++++++++++++++++++++++++++
 unpack-trees.c              | 32 +++++++++++++--------------
 5 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f4cbe460b9..7aedab6951 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -148,6 +148,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_CALLBACK_F(0, "submodule-prefix", NULL, "path",
+			       "internal, path from root of top-level superproject tree to this repo",
+			       PARSE_OPT_HIDDEN, option_parse_submodule_prefix),
+
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
diff --git a/submodule.c b/submodule.c
index d84345a0b4..d3d6abc816 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2073,14 +2073,6 @@ void submodule_unset_core_worktree(const struct submodule *sub)
 	strbuf_release(&config_path);
 }
 
-static const char *get_super_prefix_or_empty(void)
-{
-	const char *s = get_super_prefix();
-	if (!s)
-		s = "";
-	return s;
-}
-
 static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2108,10 +2100,11 @@ static void submodule_reset_index(const char *path)
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
 	/* TODO: determine if this might overwright untracked files */
-	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+	strvec_push(&cp.args, "read-tree");
+	strvec_pushf(&cp.args, "--submodule-prefix=%s%s/",
+		     get_submodule_prefix(), path);
+	strvec_pushl(&cp.args, "-u", "--reset", NULL);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
 
@@ -2191,9 +2184,10 @@ int submodule_move_head(const char *path,
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
-	strvec_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
+	strvec_push(&cp.args, "read-tree");
+	strvec_pushf(&cp.args, "--submodule-prefix=%s%s/",
+		     get_submodule_prefix(), path);
+	strvec_push(&cp.args, "--recurse-submodules");
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
 		strvec_push(&cp.args, "-n");
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 516a6112fd..9cfba1a2af 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -366,11 +366,11 @@ test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
 	test -f a/b
 '
 
-test_expect_success 'read-tree supports the super-prefix' '
+test_expect_success 'read-tree supports --submodule-prefix' '
 	cat <<-EOF >expect &&
 		error: Updating '\''fictional/a'\'' would lose untracked files in it
 	EOF
-	test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
+	test_must_fail git read-tree --submodule-prefix fictional/ -u -m "$treeH" "$treeM" 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d..9bec57a047 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'setup src repo with submodules' '
+	test_config_global protocol.file.allow always &&
+
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two"
+'
+
+test_expect_success 'lazy-fetch in submodule succeeds' '
+	test_when_finished "rm -rf src-super src-sub client" &&
+
+	test_config_global protocol.file.allow always &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/unpack-trees.c b/unpack-trees.c
index bae812156c..930a2a46f1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -71,7 +71,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
-static const char *super_prefixed(const char *path)
+static const char *submodule_prefixed(const char *path)
 {
 	/*
 	 * It is necessary and sufficient to have two static buffers
@@ -79,28 +79,28 @@ static const char *super_prefixed(const char *path)
 	 * error() using the unpack_*_errors[] templates we see above.
 	 */
 	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
-	static int super_prefix_len = -1;
+	static int submodule_prefix_len = -1;
 	static unsigned idx = ARRAY_SIZE(buf) - 1;
 
-	if (super_prefix_len < 0) {
-		const char *super_prefix = get_super_prefix();
-		if (!super_prefix) {
-			super_prefix_len = 0;
+	if (submodule_prefix_len < 0) {
+		const char *submodule_prefix = get_submodule_prefix();
+		if (!submodule_prefix) {
+			submodule_prefix_len = 0;
 		} else {
 			int i;
 			for (i = 0; i < ARRAY_SIZE(buf); i++)
-				strbuf_addstr(&buf[i], super_prefix);
-			super_prefix_len = buf[0].len;
+				strbuf_addstr(&buf[i], submodule_prefix);
+			submodule_prefix_len = buf[0].len;
 		}
 	}
 
-	if (!super_prefix_len)
+	if (!submodule_prefix_len)
 		return path;
 
 	if (++idx >= ARRAY_SIZE(buf))
 		idx = 0;
 
-	strbuf_setlen(&buf[idx], super_prefix_len);
+	strbuf_setlen(&buf[idx], submodule_prefix_len);
 	strbuf_addstr(&buf[idx], path);
 
 	return buf[idx].buf;
@@ -236,7 +236,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 		return -1;
 
 	if (!o->show_all_errors)
-		return error(ERRORMSG(o, e), super_prefixed(path));
+		return error(ERRORMSG(o, e), submodule_prefixed(path));
 
 	/*
 	 * Otherwise, insert in a list for future display by
@@ -263,7 +263,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), super_prefixed(path.buf));
+			error(ERRORMSG(o, e), submodule_prefixed(path.buf));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -290,7 +290,7 @@ static void display_warning_msgs(struct unpack_trees_options *o)
 			warning_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			warning(ERRORMSG(o, e), super_prefixed(path.buf));
+			warning(ERRORMSG(o, e), submodule_prefixed(path.buf));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -2958,8 +2958,8 @@ int bind_merge(const struct cache_entry * const *src,
 	if (a && old)
 		return o->quiet ? -1 :
 			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
-			      super_prefixed(a->name),
-			      super_prefixed(old->name));
+			      submodule_prefixed(a->name),
+			      submodule_prefixed(old->name));
 	if (!a)
 		return keep_entry(old, o);
 	else
@@ -3020,7 +3020,7 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
 
 	if (worktree && untracked)
 		return error(_("worktree and untracked commit have duplicate entries: %s"),
-			     super_prefixed(worktree->name));
+			     submodule_prefixed(worktree->name));
 
 	return merged_entry(worktree ? worktree : untracked, NULL, o);
 }
-- 
2.38.1.431.g37b22c650d-goog

