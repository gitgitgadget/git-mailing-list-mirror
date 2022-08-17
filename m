Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C610FC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 07:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHQH4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiHQH4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 03:56:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B1879EE2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t22so11813896pjy.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E6+U0kkj2G+sMuADcH8fFN+cFRdSWdPikhTEPZ0+9uU=;
        b=bZqIRA/AJYnAsPy/pzr51+u0ExaZGtu8uqR8Sz+x+Z421Ev7HIVax2Yvj73GDb3EFR
         TFTuouEsT6H6AGx9KfBR4WkxkeKtW4m2e1v+xS3/sIkORkdWOO10ijGKvzO79n3SmYqE
         IzCOsa8ztdDSyok1AhAsJ6rPE7dtIHoX6bdEeLOx1TEj7NumW8LwfkEzQC4992uY6RVt
         nX2kWNCK5T/3ITt3pVd13UDqWAShmfDkH49V0/Gpu2mJMm0kGzXA6Ps0JpRSZpLNAZAq
         hn/NEmketON+WVY/tTxN3EnexN2eUlLMunqbCyYLHrbcWlAF7h3v96f33+xPpMfFe5fR
         5o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E6+U0kkj2G+sMuADcH8fFN+cFRdSWdPikhTEPZ0+9uU=;
        b=hMOk0zUKvZ7KIokAlk9V/ZI9zMkDx2Jc2kt2Q6VMJ4/IuEuw9ClhJ/EXWbzjUqxPFj
         nis9Icgnn7ZOiLvovRahjBOFqkM8ukpCZHIt/QnYGqnVx5WxAhFShNp+w8oeOwKV3m2K
         ujgEWLCq5csoBoShUB2nZMSmO1cmi++eGs2GfV61NWBAwRzdvqDcNWmxnOEvAXFC/HVt
         rw4aKRgNGiiNo6bj9UtqVTFdfvp29ig+tt/GfN1tNB2HsWPSPYNcenVhIOLhIGXGuZm9
         htnQ5HDTEvq3PnlOPQkLbM4rdkIFsmHp+HVqqWad5NefncP5Dyo1PfTfjb/rrmM7PW41
         +2IA==
X-Gm-Message-State: ACgBeo3421nd0evIpvdzi5MuI6XCd3zkkOCAZ83HAfzqOE7lV5XabjZp
        qhHhGnXl/9aLKi7/v4AwtxSpH1JQMCYXiw==
X-Google-Smtp-Source: AA6agR56kt6Q2ao4vXHsK/e3alI64BfGoMaZjo8LBJrWorxc8/HnFcJJp8CCyOow0DDYwbHvjx7AIw==
X-Received: by 2002:a17:90b:1b4a:b0:1f5:5578:6398 with SMTP id nv10-20020a17090b1b4a00b001f555786398mr2567539pjb.122.1660723004309;
        Wed, 17 Aug 2022 00:56:44 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.141])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b0016d1b708729sm743532plg.132.2022.08.17.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:56:44 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Date:   Wed, 17 Aug 2022 15:56:32 +0800
Message-Id: <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --sparse option to `git-grep`. This option is mainly used to:

If searching in the index (using --cached):

With --sparse, proceed the action when the current cache_entry is
marked with SKIP_WORKTREE bit (the default is to skip this kind of
entry). Before this patch, --cached itself can realize this action.
Adding --sparse here grants the user finer control over sparse
entries. If the user only wants to peak into the index without
caring about sparse entries, --cached should suffice; if the user
wants to peak into the index _and_ cares about sparse entries,
combining --sparse with --cached can address this need.

Suggested-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/grep.c                  | 10 +++++++++-
 t/t7817-grep-sparse-checkout.sh | 12 ++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e6bcdf860c..61402e8084 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
+static int grep_sparse = 0;
+
 static void add_work(struct grep_opt *opt, struct grep_source *gs)
 {
 	if (opt->binary != GREP_BINARY_TEXT)
@@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (!cached && ce_skip_worktree(ce))
+		/*
+		 * If ce is a SKIP_WORKTREE entry, look into it when both
+		 * --sparse and --cached are given.
+		 */
+		if (!(grep_sparse && cached) && ce_skip_worktree(ce))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_INTEGER('m', "max-count", &opt.max_count,
 			N_("maximum number of results per file")),
+		OPT_BOOL(0, "sparse", &grep_sparse,
+			 N_("search sparse contents and expand sparse index")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index eb59564565..ca71f526eb 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -118,13 +118,13 @@ test_expect_success 'grep searches unmerged file despite not matching sparsity p
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
 	cat >expect <<-EOF &&
 	a:text
 	b:text
 	dir/c:text
 	EOF
-	git grep --cached "text" >actual &&
+	git grep --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -143,7 +143,7 @@ test_expect_success 'grep --recurse-submodules honors sparse checkout in submodu
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -152,7 +152,7 @@ test_expect_success 'grep --recurse-submodules --cached searches entries with th
 	sub/B/b:text
 	sub2/a:text
 	EOF
-	git grep --recurse-submodules --cached "text" >actual &&
+	git grep --recurse-submodules --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -166,7 +166,7 @@ test_expect_success 'working tree grep does not search the index with CE_VALID a
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
+test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -174,7 +174,7 @@ test_expect_success 'grep --cached searches index entries with both CE_VALID and
 	EOF
 	test_when_finished "git update-index --no-assume-unchanged b" &&
 	git update-index --assume-unchanged b &&
-	git grep --cached text >actual &&
+	git grep --cached --sparse text >actual &&
 	test_cmp expect actual
 '
 
-- 
2.37.0

