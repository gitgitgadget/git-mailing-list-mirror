Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7DC433EC
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5419F619C0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhCWNpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhCWNom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FFC0613E0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d191so11076806wmd.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=tqKL8bTbxiwYaOZYKcT/+olbKatvx19GCky8/rfPhjRp2nOIAcEtx9CimDBIcTyrMs
         lXwTYJvxBqQ3bxsEicSt1kmPRm1ipY27xWkZuBTt6PppKc9MdJJjq+9w7GqBc+ImnJGn
         4uS05PRP9x9KSXVBzNFvRN64mAlShQwUBNulUh1Kf8NN6D+sN+g8MCzJOANJ8Cutt00B
         aDevv8y29lrSJAHJttL8KFwAdSRyPqY+RQuO5oPtyRCDzVYAX8q3idVWZ4wAiT6ScrOW
         ZeCuGtYcrITbmruKUUHyBvKg3iE0bqnnODqPWMIlb9D6lSy56Mkf0NidxA2FFj43u6hf
         nAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d57sN1iwbvl34esKzbNWg9awcmZQjE9yfjMflF8q+sQ=;
        b=cuYBokqLtqMD/TSIm+gdhSmKM6XpUbXQU1SnDKY1Vx/7tZxBFjNEitDBqyoVjRoPZ6
         2geN5pf3z6eqKmXOg0e3QAykLVhpAZp8cOKzGmyJLz0W2RlmuEA9cKzLlRenoFKkzlqz
         pYANI/0Kh3jyKjRBbHcZwwXah4y1MVxtHh5PZKPpmK7hL42qsJlS1VnglR/r8oYyKxCP
         3XQejPbK+0FH9bVZ+kVZwyZfgSBo2OQNnGtSh7UOnU9n9mz3keEU+Ad1w3vYrcPhCAO8
         PYXWc53IDRbKWh/gWhb8jH7TMEvUCF88Q8CRPkzY3cW/GLGLmm/8R0YqrmJCPrXuxwZb
         pr1Q==
X-Gm-Message-State: AOAM5324OVxJvEhikPNaHC8qX/uQKaaDhop4vOOtoz9gp3gmKMrny2NH
        CNnwpVWPG9KLhme1m3z8f8c88waToN8=
X-Google-Smtp-Source: ABdhPJzi44E02l50hUTf725GXYQTvmHF7290Mn2zYYK8KiRhSpMWoPmzQJc9xJFUHS9dTTjDY1RcIg==
X-Received: by 2002:a1c:a7d3:: with SMTP id q202mr3429558wme.93.1616507080483;
        Tue, 23 Mar 2021 06:44:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm25275163wrj.62.2021.03.23.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:40 -0700 (PDT)
Message-Id: <6db36f33e960d6bfd4a156efc2e070dd9c23378b.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:20 +0000
Subject: [PATCH v4 12/20] submodule: sparse-index should not collapse links
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

