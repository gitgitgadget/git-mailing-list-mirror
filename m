Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94461C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhLHTnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhLHTnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9508C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:39:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so5909370wrr.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P83ymSPA3zYRQA1Q95p87N+uvnV0pSZrI9/9u64n4Y8=;
        b=RlpJz5+mYk/QDyxA0Po64bulLon4tqZx4EqvXL/DCjQl28kaj4v5pAWWx60Z0vJ5af
         5r9pq2NWlQBkIin/ORLD/NCmjoV6uDaITt4Rn8KV0T8lIJmBsYvQ6c6AKf694NpQAeth
         3b/68wlAhf9RmHNTBmDi+CiZTXtcPvtJljW1+2M/2QASjADfL0/YMo8NDaWepjvw8X2W
         hkUYLkQ74fYnEMBko+r4tYjWul0cKdgCG9IAopUVCmEUyw3WyefIxZECN1ucAdYevbHB
         aCXmE2/ZQpdIZ/7yvLBUdznD0NwAWF8lP/1H930cjRYTXyLK5GqlabCyS1JEFlcZxtpQ
         HhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P83ymSPA3zYRQA1Q95p87N+uvnV0pSZrI9/9u64n4Y8=;
        b=BoDnAhCL3lEV11AaOXqL83TTxVaKucYbRi9AGpUOGTrfd0vSh267aMmomNIW2X70Nr
         +XKpKypnSLwX3GbAj0YbCW5aK3QPvfmW64j2kHf5j8lgP3p1rr9SWgw2AaAaQ1LKMsc0
         29y1EVaK5gBth6HSqfPrG0oiESuMHWY+IrtvmzxbUdsnBR0hFv8yAAj6Tv2OtJtLE2uk
         KmrZWeoglut2Gf5YpcqDf4abpfCkmXcvtOpNu1X0Pa1OYGlJ0C8+TuZenBIMaqfOVRzM
         kSUDeMXxVMApI43bnIns1o/L2QTzKyhcJc5c+2hTGKk7pVlFOKD8IL2bHp5h9Qs5ocIn
         UvUA==
X-Gm-Message-State: AOAM532epJFzPXNUOf2thrntYmClPT7OsCMirSakpROfm9vi6CeAjNPv
        d5V7fevk1KaADFr3bSQaer224eA3dHI=
X-Google-Smtp-Source: ABdhPJwWXyAGafK1ETqQJHh9uSJ/bliXc3MHP74RENNLSjBW/wuiooXgsvwGLIN6HBHF6hLeatSvLQ==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr807744wre.558.1638992398106;
        Wed, 08 Dec 2021 11:39:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm4930411wrq.20.2021.12.08.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:39:57 -0800 (PST)
Message-Id: <f72001638d1d0865cea0f728e700a4148bf7b37f.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:51 +0000
Subject: [PATCH v2 1/5] fetch/pull: use the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git fetch' and 'git pull' commands parse the index in order to
determine if submodules exist. Without command_requires_full_index=0,
this will expand a sparse index, causing slow performance even when
there is no new data to fetch.

The .gitmodules file will never be inside a sparse directory entry, and
even if it was, the index_name_pos() method would expand the sparse
index if needed as we search for the path by name. These commands do not
iterate over the index, which is the typical thing we are careful about
when integrating with the sparse index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c                          |  2 ++
 builtin/pull.c                           |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff1..1696b7791d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1993,6 +1993,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	git_config(git_fetch_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
diff --git a/builtin/pull.c b/builtin/pull.c
index 1cfaf9f3436..7bce3bd80f9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -994,6 +994,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		set_reflog_message(argc, argv);
 
 	git_config(git_pull_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 83971174ac3..3ba19ba1c14 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -964,6 +964,16 @@ test_expect_success 'sparse index is not expanded: blame' '
 	done
 '
 
+test_expect_success 'sparse index is not expanded: fetch/pull' '
+	init_repos &&
+
+	git -C sparse-index remote add full "file://$(pwd)/full-checkout" &&
+	ensure_not_expanded fetch full &&
+	git -C full-checkout commit --allow-empty -m "for pull merge" &&
+	git -C sparse-index commit --allow-empty -m "for pull merge" &&
+	ensure_not_expanded pull full base
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

