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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B75C432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E639B65111
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhCPQn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhCPQnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C9DC061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1841066wmq.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=V2TSPi8IlodrET6lbbThOOSI7/AKHMnKK8J78IkO68eOA3JzCqrokp3ZdmHaWnWhDL
         zUq4W7kBDQ2DFGB0uKdC/nN/lmx768TkxrCVzGhZXEVEYl/MjjallCI3OOpdkEoKyNwX
         tKhqISXVFbeeM+i5cQBM9QAvd6okbGUBZGtUigXXOq4hpWaeOaLWsoFl7ORIOWkav00v
         ILEVB5kffSxFEBg87LggddmwI4GZBOW6DdPm368Xf6pPWg2sZOiTuDZVNPoUP2ygVQ+u
         061gd5d7XXVpFup6zXLPbELFS1pBe4IXJaTTZER6wQjrj27I0i45yqFg2RbhtkKVWDj8
         2pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=c3p0vZY6uX1A32ApziI0CDh3GxCvKsMiHlWBFqKzRv3WDV+ZcBUhQQpu+EHunOutm5
         lgOzHlLyO7Wh5Aigm04E5Zh+qqgk1jcmnr0vfgcwnMt0JPq2dZrq9jc/3WNk67KI+gxI
         1yAnw5T/eKrqTqbZhiulc/T6pgA2Ej9E8crKh4OZC8sx/Uf7DXdzSgxWXOOeB2n9vsy4
         TFxDgUd7tMydNtE0yvJieZzkoo9lcBQv0XCDwhIpobkfAkgETo+qfMacAiC13b58Qtb/
         4LnhsQ0T/iJ4Xs1gCIT3QBPfRhScLwA6qG9nqLr2Rp6rSrZPxayeLMz1CjCAry7Ihg5s
         GmPQ==
X-Gm-Message-State: AOAM531Zc1r799c32EavRsmFuPhPypKD8jpSnDFhr4i6X7yJ4I46TPbo
        QQBtJfJcg46toA7gjADe1FahPhpik8g=
X-Google-Smtp-Source: ABdhPJwkUoLz7ygwah6K5SXyc5VwkY0iKBcyI1+IoU//ZMNdWtcHFBn80bhSE4vHbZ38+JhVIU1f0A==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1230wmj.26.1615912993781;
        Tue, 16 Mar 2021 09:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t23sm24747658wra.50.2021.03.16.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:13 -0700 (PDT)
Message-Id: <b77cd6b02265cf0eab0f9936d19ad99f0ffea3b9.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:55 +0000
Subject: [PATCH v3 12/20] submodule: sparse-index should not collapse links
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

