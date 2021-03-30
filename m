Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F80AC433F7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782B9619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhC3NLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhC3NLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A9EC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso10290410wmq.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=Dh5OZV/tps3Cr+D7KHiA3ccp/PfTWNpmrB5YKUdJ4XGXgjlGwDtrG+bytdEclbpSmK
         ZtWHUSHg68jOQVaa1S2RWuxJdNinJPsgL7D8x6yTRhLn0rpM02peVwlFCg6UvVMdoXlN
         hiTiuGfO2PKB0j2gk5dDZe9ZQRFgVHOylbYhVAQO8+dnhJ9xWl0d6Q3eo+nj/YI06ICN
         Vji3WXcgicthn6aLzllDIvwD8BZVxIMsr13bfJ1jERZFvGylPXVIg+5hf0ShsCqXZtCV
         P0kfxYfQQIYx0s7/8TuoUIDqBFwzx97GYEOr/sK6YF3cIKo3k1wjgW2/ZKf6HK85aU2P
         SK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=uoSotIRaSjXuO9J3oRy5Rmm5/+rp9llEdDxQ1a7SwenEZ8vE1/80JwZi8ycTd6u07H
         ObNfb2FAVNoOt3SxYFxCHPR3BWhD6HSDSZeQKUjmijLXo4PHWqdMkcBPE3aoezCyhHLp
         ICWsvm1Au1ie4SrLAuCNV0LxaYgApKkPoGECR6dCLKfp0HklJO+jKh39wxYXOwmplrOs
         ezIGumDBuIgX5ZLaYvAn0EUgeVdMf2qET3XHrbvF4bEd6qppFhGQ5n/pXYQeuTnAggKz
         ss1fWkpDMXghFhlqDAQDS37G1NhCUrICQSw1jXa+4A62iw2SKFpJBnp8X5Qc/zoaZRP8
         zVlg==
X-Gm-Message-State: AOAM530pzzj6MwbljHwe7UQVZt6r6GG0yJkDRkMHhCEV5DZHEYE/659v
        T3mi/FASkU6S9rejaElRitx2uxfr5ws=
X-Google-Smtp-Source: ABdhPJy+719aGD1zR0Sp7pTEWTZhcsOfWkelAEusgnYNUv2iQVP+7f0PLs1RAB2jFyestlxwIXJKSw==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr3991076wmj.54.1617109876996;
        Tue, 30 Mar 2021 06:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm3690197wmi.22.2021.03.30.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:16 -0700 (PDT)
Message-Id: <bcf0da959ef35f989949b40ae1a386885d116331.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:56 +0000
Subject: [PATCH v5 13/21] submodule: sparse-index should not collapse links
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A submodule is stored as a "Git link" that actually points to a commit
within a submodule. Submodules are populated or not depending on
submodule configuration, not sparse-checkout. To ensure that the
sparse-index feature integrates correctly with submodules, we should not
collapse a directory if there is a Git link within its range.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c                           |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 619ff7c2e217..7631f7bd00b7 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -52,6 +52,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_stage(ce) ||
+		    S_ISGITLINK(ce->ce_mode) ||
 		    !(ce->ce_flags & CE_SKIP_WORKTREE))
 			can_convert = 0;
 	}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 1e888d195122..cba5f89b1e96 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -376,4 +376,21 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
+test_expect_success 'submodule handling' '
+	init_repos &&
+
+	test_all_match mkdir modules &&
+	test_all_match touch modules/a &&
+	test_all_match git add modules &&
+	test_all_match git commit -m "add modules directory" &&
+
+	run_on_all git submodule add "$(pwd)/initial-repo" modules/sub &&
+	test_all_match git commit -m "add submodule" &&
+
+	# having a submodule prevents "modules" from collapse
+	test-tool -C sparse-index read-cache --table >cache &&
+	grep "100644 blob .*	modules/a" cache &&
+	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
+'
+
 test_done
-- 
gitgitgadget

