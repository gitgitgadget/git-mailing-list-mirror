Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033AEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbhLVOVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbhLVOVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A82C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so5244420wrg.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vmoaaXJ+MYXx7Ti9375WCn8U2vmzd0IxNp++fHCascg=;
        b=nWsLh1XloFuZtLOkfAFj27aM8VDuZSISpbqnGTFaBJzfOZKiuDjsHGXYgRh7XyFsms
         zXM5CpFWuHz/6k5bKJ0Eaq43an0eGvpBWXtAC0MXWID+3t8uLqGuC+YIbB7ca/LPLYrT
         CGwwAQVEMQqFR2CKppBmg7hfc6swyIo893UYzf7G2nZxiCoEb5mONBfKCnGR4TvYiZ5p
         4La87mvCgiMd5kqHljaAbOJyXbm6fm7n1FdKBsfGjwbLJvprynw0XDBUJTOKKEZefDZ8
         7nftmkaJ80Gm+6wi6tPXMLSYw+QwRTxPSO4RPCFYzNQFTUsdH1UKJfwrxW/pPsLl/alW
         agBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vmoaaXJ+MYXx7Ti9375WCn8U2vmzd0IxNp++fHCascg=;
        b=BuzJWwb4hDN0NkFak1M+3GURniEfswLlegAYFqfdgnz7GTISDIMKu6nS8aHJfsAadg
         mNFta1pZfr+sbxGLusNWwLxdfLpuBYsyOPB9P9tI+rNgo5zZ4hdgYTgqVXzSLxPFaV1g
         HXZ+diltpDWfFOwja836ojwVX0kQEVwgldsbJCDcBGFuc0FE5xUms1Sy6eKCKE+U/GoE
         uEz/WwEpecuATeV5p6tewRwSoImU9RfyzKn+VbU/tjNUPjbo7VQGFBxoZU+h7MrUduPx
         3ko+tGPbtudhVycZaDnny59jRtEHyEHgwt/osA8YE7av/5Z55uiCPdPxnGA4+Z+pLiq0
         vO4Q==
X-Gm-Message-State: AOAM533Ntyz4gTNVqJxpFE8dLGokV4OpyZjNkNJXuS3gx2YYmwPPxoqQ
        y84tP/5V7LXoaNwv2eA36GDfjfOo498=
X-Google-Smtp-Source: ABdhPJztgHBp7Ha6zqDqFknN2WvFSrFjMdZUzmJ/eSQQ7Kk82hgMXaOCmJLq4I4UBl0sxmesbuGT7w==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr2191034wrw.445.1640182858921;
        Wed, 22 Dec 2021 06:20:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm1907645wmd.42.2021.12.22.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:20:58 -0800 (PST)
Message-Id: <1043a1927d220345c3a2fdba518708869f71b542.1640182856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:52 +0000
Subject: [PATCH v4 1/5] fetch/pull: use the sparse index
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
index e45185cf9cf..a0757dd0158 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1999,6 +1999,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	git_config(git_fetch_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
diff --git a/builtin/pull.c b/builtin/pull.c
index c8457619d86..100cbf9fb85 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -994,6 +994,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		set_reflog_message(argc, argv);
 
 	git_config(git_pull_config, NULL);
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 49f70a65692..8d3c21fc84c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1009,6 +1009,16 @@ test_expect_success 'sparse index is not expanded: blame' '
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

