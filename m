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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F8DC43381
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E86264EF6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhCJTbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhCJTbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:16 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF6C061764
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u16so24612384wrt.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M4rc6Sb5rfy2YSuNLUBtIdiMahkbaMGtXkyzjafEAdw=;
        b=Jj9Ztye5kRTHKbio0h7UvFcJ87PPZZHAhWE5BFkTRvZPil4cT4julxFhBBP/2R4yF6
         Qx4HLYleMrsRoMRKyGO/xOU1tIlIhEzSKfCarjyhRL8PSVNNWZuwd55s6dqVK4ajq9oP
         zdrcSztLMLqrpi/OYSVSRf22zr9Oy7i8U6fNzGbHuXH/3UiWwpgoG4IN1XCrJimdJdkJ
         u9kL4p+jG7mDj7RE1NE+MgZlaY0qOkdfsg3kQ5goh6/eTFfPFPCthbu0nYsmgEfBxTVi
         xbhK/lkQpo6RtR6NHL+dfCHXEdTgac/Y/T8RygBYDYNRVnnCeQhSxDzHWM9Iq6MJAoIN
         VOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M4rc6Sb5rfy2YSuNLUBtIdiMahkbaMGtXkyzjafEAdw=;
        b=d7xINVUjsGuUR76u/D7Sn36/XG3JETXY0hWqAre5g/y3DD3MTK8BAoEn3Un4SC4+a0
         opILSGbUkAmRNYaibQ5QdnECNZxQirmytcD1pDqAG0/H//F4esTqy/bUXROoMdVEbsIE
         zjgdIwWSBfZ67g2HI2urH5KO05pzLah/Y2ZoP5xV5yboGfnj5RA2tEtBPXCCjsulOOkO
         J1ni0hdoCJwtHIPkSgylwwqYgSxMhXiWgf7AVWWQ3ay2n6w13EZ1i2Dno+vEEeedDUv8
         5BzwVC5OSAa8uYLhe7JWJDDYgkEKMItUJ1c8IrUGPRGE2te2ALzbMPB37628bTuEa8Xt
         WTCA==
X-Gm-Message-State: AOAM531se3eX53h0c2UA7pKOGQ3q2vH1uvgJOFs+U69s18ty3u13INMg
        f0BnOASiWWM1Mf/1xLy0pwhvhNCyo5s=
X-Google-Smtp-Source: ABdhPJzTHDBtzR+ja3m/RyIncmC2PhLv9Uc8JARiZg+vpfd4Bj7D/iYMgscjeHvRIGJeJCJ9LSVTGQ==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr5026599wrd.424.1615404674682;
        Wed, 10 Mar 2021 11:31:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c131sm387832wma.37.2021.03.10.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:14 -0800 (PST)
Message-Id: <f2a3e72987988c615fae75032af874735d0e76d8.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:55 +0000
Subject: [PATCH v2 12/20] submodule: sparse-index should not collapse links
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
        Derrick Stolee <derrickstolee@github.com>,
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
index 5eb561259bb1..36b4dde7eeda 100644
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
index ca87033d30b0..b38fab6455d9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -374,4 +374,21 @@ test_expect_success 'clean' '
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

