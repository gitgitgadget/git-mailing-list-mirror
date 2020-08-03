Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C52C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAF922BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H22p+DGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgHCSl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgHCSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:41:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE291C061756
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:41:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so497734wmg.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BXeq9ERjQ8KnIWUx5zs0u7S0zhJaOTGrl+bzsPdosG4=;
        b=H22p+DGsN9XxBJs2TnPvwwIu9qLy7T44jh2hvFfR067bhrgPJEB/3BRGpBHnucUJNj
         wwRiCkGCwrsq7MQxeEi0x5oK/aEpTCEYZsYYPTeiAg0dUKqFfLX5DF/uYa2iHBI95S2O
         On5+ibqsz7+JzsE5ENEuNO+8bx9B0pBrkTjTo4SMiZljV8voO8WIL7Eg0pV9UWXBo1Sk
         8tiitGOKaekSjS9qQzsDCCBKDX9/INXHltmZaFdQ5M6lu5pBVh2X6bzGFEIivFvrCfjF
         hOuJCEqbpKmLS/4TiYOlOL3jL0iHl78+ospi1zYqRx0TcOBfnmeqvGGI7RtXvw8nQMIL
         ClIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BXeq9ERjQ8KnIWUx5zs0u7S0zhJaOTGrl+bzsPdosG4=;
        b=aJZCy3B67YLXXMZ8mmfUE7dkk/2SMXCVkmWGT44pSihcHufcpZirqjt4mzzdLhCMBv
         YbSLgihKBZGZfmM36hH7WdsQmtIQ3mmx7mEARHROO01ITJSuZZ408LbdiED9aIpwvn64
         R9Q3pzHx34tz43cGQw4TYGXxrmOGx7BfhSYV0juwXjhDJpYwcfBCO/vQphgLUSVs82ko
         10AswRKJtiXnc/UCVaz2azYL9w2Nah7+m4DRLayA0IsnUKIei8b0wdq6eHvH7U4M6HAV
         ckdTQKCr65mATKKr3BjQD8fkNsHq50QZ1SPDt1TjzTwqcikTzvJC4Sw5QEpml4fqNu7V
         bx6Q==
X-Gm-Message-State: AOAM533vUyl4UmlIOyuyODCoW2D8bnNmkqyo/FCDtF4GE9YZorirDI6o
        XyoGeQO93VItx8LpLefO9fiDWEE9
X-Google-Smtp-Source: ABdhPJwoiANdTTm+6W+WJhrgHYG6Wc9UQiNwSkkh5+85lrmUymlno0m2E7qJSzc5HZlA0vxHetwVag==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr478360wml.35.1596480084601;
        Mon, 03 Aug 2020 11:41:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm748039wmk.6.2020.08.03.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:41:24 -0700 (PDT)
Message-Id: <379a87ea825b43645ef35bb0ff880cc3a5e40048.1596480080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 18:41:19 +0000
Subject: [PATCH v2 3/4] merge: make merge.renormalize work for all uses of
 merge machinery
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The 'merge' command is not the only one that does merges; other commands
like checkout -m or rebase do as well.  Unfortunately, the only area of
the code that checked for the "merge.renormalize" config setting was in
builtin/merge.c, meaning it could only affect merges performed by the
"merge" command.  Move the handling of this config setting to
merge_recursive_config() so that other commands can benefit from it as
well.  Fixes a few tests in t6038.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c         | 7 -------
 builtin/merge.c            | 4 ----
 merge-recursive.c          | 3 +++
 t/t6038-merge-text-auto.sh | 4 ++--
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index af849c644f..18c49034c4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -771,13 +771,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(NULL, NULL, 0);
-			/*
-			 * NEEDSWORK: carrying over local changes
-			 * when branches have different end-of-line
-			 * normalization (or clean+smudge rules) is
-			 * a pain; plumb in an option to set
-			 * o.renormalize?
-			 */
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/merge.c b/builtin/merge.c
index 7da707bf55..74829a838e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -72,7 +72,6 @@ static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static char *branch_mergeoptions;
-static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
@@ -621,8 +620,6 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "commit.cleanup"))
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.renormalize"))
-		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_parse_maybe_bool(v);
 		if (0 <= boolval) {
@@ -721,7 +718,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
-		o.renormalize = option_renormalize;
 		o.show_rename_progress =
 			show_progress == -1 ? isatty(2) : show_progress;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 36948eafb7..a1c8b36ddb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3791,9 +3791,12 @@ int merge_recursive_generic(struct merge_options *opt,
 static void merge_recursive_config(struct merge_options *opt)
 {
 	char *value = NULL;
+	int renormalize = 0;
 	git_config_get_int("merge.verbosity", &opt->verbosity);
 	git_config_get_int("diff.renamelimit", &opt->rename_limit);
 	git_config_get_int("merge.renamelimit", &opt->rename_limit);
+	git_config_get_bool("merge.renormalize", &renormalize);
+	opt->renormalize = renormalize;
 	if (!git_config_get_string("diff.renames", &value)) {
 		opt->detect_renames = git_config_rename("diff.renames", value);
 		free(value);
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 9337745793..89c86d4e56 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -158,7 +158,7 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
 	compare_files expected file.fuzzy
 '
 
-test_expect_failure 'checkout -m after setting text=auto' '
+test_expect_success 'checkout -m after setting text=auto' '
 	cat <<-\EOF >expected &&
 	first line
 	same line
@@ -173,7 +173,7 @@ test_expect_failure 'checkout -m after setting text=auto' '
 	git diff --no-index --ignore-cr-at-eol expected file
 '
 
-test_expect_failure 'checkout -m addition of text=auto' '
+test_expect_success 'checkout -m addition of text=auto' '
 	cat <<-\EOF >expected &&
 	first line
 	same line
-- 
gitgitgadget

