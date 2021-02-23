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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB4C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B8064E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhBWUQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhBWUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C0C0617AB
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v21so3619055wml.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CZ13xCDSSkPH/BzGBaU8yW0L08/FfbyWyFIW94sM8ZY=;
        b=Vm7dg/jghfBBDAilG9YD/7Z2erfmJZjBVnahMLSR36quY8qi0D2W4XtA06XyNWYuqT
         EvqReuFSv353jSli7Pdw89Q8eB0JvhW0vCMc44k9NYdu2c4lWotyixj29SjGJhHFPUSt
         csPCnlcCoD7ziQlpqlEDGNL26iQLjC1jN4suEyQsq4vMvIJyvlyl6CFTRUFLbZFYqcNk
         fiz9U6MFgaMBkyRElRFItwCQ8vjxJqmx08t9VoBaTG+lRjTKanzhU3jb1m/52TqfDucR
         9E9/0vNXVqWRNWFbN2dkrrzlj4lFrE+PZh/UX3OPUYt2/bxoenlAkTArPxAHjjOMKd9T
         DAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CZ13xCDSSkPH/BzGBaU8yW0L08/FfbyWyFIW94sM8ZY=;
        b=OjrIufa19dIRa9w0RoDF7xsLJ/MTnkKpS7ozmVSQXUaq1rzl/aIFIZ8GdnT/7MjQYD
         p6OU4+yxpD7tFs6/M6PYYEzjzvuiHn9tPpKZAWi3nNz8Uhz4E0/va8DaS1J7qkPIyucZ
         jlWQyRfLoe539/uxRIeTpio8Nqr5WU+ktrVPvRzhQG5XrjbbNXVi9LlmmqnFFBr9fVxO
         Boqluuq74wuTBslUaqfv071/d5Ew4QJcPaKjmTga3co18AA3hwOH9GKI2swlRTIOAg+3
         OA+WhDQQ34NLulEpGsOXnG79PGwXoungLHbYtypMLy9QMXVuhCCXbmPY7iZ6p/PlbXtV
         8R8w==
X-Gm-Message-State: AOAM53304ThcyIsM1tsDinrIkk3upDBcaiOJelx0Ojatrb0cNVCuTkPg
        c2nkKnoE0NCZlSb0k2Tpl+UsR1SPgBo=
X-Google-Smtp-Source: ABdhPJwfd1mWlVBXWMeScimQYdEQhRPQfIs2wfl87Pagz0r1hQ4jTRqrkKz8CgPeX6eFHOrUs2JTNg==
X-Received: by 2002:a05:600c:4f46:: with SMTP id m6mr429308wmq.154.1614111278566;
        Tue, 23 Feb 2021 12:14:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm33937227wrx.82.2021.02.23.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:38 -0800 (PST)
Message-Id: <4405a9115c3b65119d7411025a17f0a9fb0cbd1c.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:21 +0000
Subject: [PATCH 12/20] submodule: sparse-index should not collapse links
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index cb1f85635fbc..14029fafc750 100644
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

