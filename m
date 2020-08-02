Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E7C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFAF2076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6+bqWIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHBGdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgHBGdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 02:33:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6AC061756
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 23:33:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so31351275wrs.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pstogkd3TviULbOdAJhgLbBOSB6LkNvy1gUwC4s5pss=;
        b=B6+bqWIvY5PLTzHuvFKyGR2KhEHf2nDSmujEb5TiA/wuF1MYt6SrB2/LbDTwbGuY6r
         alb5CEuaVtotfyLgtvISGFkqwyM/fQJy53Ai1RfuGqv5uwQ4/7iD5YAEgLoCn+/lFWYH
         Uz/dbymJx9st5g2fvdrDJFKivjZJPGSCVLyHERthhF3gWHrbkJmNt8SlQff+HXlqVCvP
         EVCiwBl90eLbJg3yEGp3CRHMPFjMD05mQWBYemerFG8W991UJJh52PouWeZ/DmTo3I1Y
         wnglWyQye1J0UgUmSDjFSSs+PkU7Ffkg8ovocxaimrH8091wTbwMivBqinq5OYTb7kKG
         HCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pstogkd3TviULbOdAJhgLbBOSB6LkNvy1gUwC4s5pss=;
        b=CKVeUwYbhlf523KT5sOwZl9oBYTCxjdndS3LacrBBte1rE0WvgKsebarKPblsfpoI9
         CRCMyZuly7CXfc9BXbi4OthhLT/f6zoqkPTU0LQh5gDvGqn/bfPeEVw5N0gwmL+NYUJ4
         UqGsfP+rKqTgbO29pHVFA7NWI8/SXiuFnQeDBNC9ee+r6qmLkmi5737YDrQtRD1PEtfD
         fOQl7QwyjiBcYiQU0nZwCuhzWvv3H9Maav0tsMIFbmOiICn8zo/yNS5oOEwAO2+7dR3k
         xt5krwUJQcsV6GlKfaJbpxiXL0ZZiCIcz5Jyp24KBizt9yPOjlF1TExG/iq4/HQGEUf1
         PNfw==
X-Gm-Message-State: AOAM533Zt/06EVqCvkrYEQY8J0JU0mECHf0o1YYki4yB51qcX98KX0tR
        FF7tfAd27L2IsTroGDdFQeM71KTb
X-Google-Smtp-Source: ABdhPJw1l1YH1UWWMfq9ZO2HRX+4H5cAMKSbvHRDFUEMrwR6DS/B9uCvCgJt7Jcvk8bYaey8nLbYHQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr10009188wrt.154.1596349990277;
        Sat, 01 Aug 2020 23:33:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm20559384wrc.97.2020.08.01.23.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:33:09 -0700 (PDT)
Message-Id: <08c8080b3196a1bd09bbf20ce705ec5ed5180c34.1596349986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 06:33:05 +0000
Subject: [PATCH 3/4] merge: make merge.renormalize work for all uses of merge
 machinery
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
 builtin/merge.c            | 7 +++----
 merge-recursive.c          | 3 +++
 t/t6038-merge-text-auto.sh | 4 ++--
 4 files changed, 8 insertions(+), 13 deletions(-)

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
index 7da707bf55..52f03ea715 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -72,7 +72,7 @@ static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static char *branch_mergeoptions;
-static int option_renormalize;
+static int option_renormalize = -1;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
@@ -621,8 +621,6 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "commit.cleanup"))
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.renormalize"))
-		option_renormalize = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_parse_maybe_bool(v);
 		if (0 <= boolval) {
@@ -721,7 +719,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
-		o.renormalize = option_renormalize;
+		if (option_renormalize != -1)
+			o.renormalize = option_renormalize;
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
index 39413d5b48..8cff0d45a1 100755
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

