Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhLJPQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbhLJPQv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:16:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB4C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so15407269wrg.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P83ymSPA3zYRQA1Q95p87N+uvnV0pSZrI9/9u64n4Y8=;
        b=c3b47Zz1RRipRvS05xDYo1M08uPqoZ1TjWkz5+TvKkUwdOGjwkPWEtXuuWkcM0nvLm
         DvwUCQ7FkSKpZ12FHa0qr6XXhIcGWg3zrYQ0fSIt7NupUt3/QqdntGb/LsesLQCwBHz6
         k+UEvzGgdZKFWHPIP+XTpWl0J0tqdDhTMkzw0KkO0WMNuWURTmtfjgotohhwDqp4+LuA
         xlJ50z2Mw2P7enRxh7ZXow4DlzGqZ89WGDdM8AAeK1h0E/yrUAJEOq0zJURJjPy0XCRj
         Umj5eoFYg9avYgqeS+jTl7lspACBS8oAyPCwXF3hHLWYMn+b64VgBgVH/UDC/LIamJn2
         z7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P83ymSPA3zYRQA1Q95p87N+uvnV0pSZrI9/9u64n4Y8=;
        b=gT/GW2n+d5WX7Oi7JPiX7VXgsef1JJDWNfePwTSf+nWfwkgqFXSl1YSrgS89AolMtP
         i+cQBa6EGGBp/Ch249prQCzTN3qZnwiD0wRl1f1qelESEz8Ljv5KuysDd5myp5XmDh4b
         5xGQslPpUB3z9VKx9ZXzZIot75XiUPQEde8mGmKGt8opXeOjWphL9Vk+Vo7sL1l+oDs2
         RZGSPxQ9CEu2EVKm/rkxZ/QkenOV+Jw2ib7zM8rJ6IIpNQzO+jm3BNKG3g/GXERbO+M5
         COgO0cZtEwAnbfFHeFyqmmu4MdrYJzmbLCuQalTyFsdngYQx0NYsQGmREuMVs+nfG9xC
         LllQ==
X-Gm-Message-State: AOAM531SgzEG336J7zPhQUpkd3e9qqWxUlqtI4SGbJ9erUbjo9lKiLhC
        ntFLnMRC5mWClV5Eo5zM60UomBN9xik=
X-Google-Smtp-Source: ABdhPJyc1xAj20O1o75psZLXi8mD+cre1QFa87BNp5MAT87id5lHJEPULnzce0ZmBSKS0lJZn8f1DQ==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr14341906wry.279.1639149194477;
        Fri, 10 Dec 2021 07:13:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm14022300wmq.14.2021.12.10.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:13:14 -0800 (PST)
Message-Id: <f72001638d1d0865cea0f728e700a4148bf7b37f.1639149192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
        <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:13:08 +0000
Subject: [PATCH v3 1/5] fetch/pull: use the sparse index
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

