Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0FBC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A23214AF
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/tmfG2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgANT0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56018 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so15194062wmj.5
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g+aJH265+hXbJtYjMi4nOLqur59yZuVvGpG8XV4VIU=;
        b=o/tmfG2c8gtAkxvtCMyIoTAnRIymQAe/ZT0n6nIArwMLBz2tQMnyGs6na8ToC9U0jU
         0R/bGDafjXqqi+2tG8OI3vm5tDVJHDaSjhYlfnopi3HHYd4l5veCAbV1z40lCZv50VtJ
         S0m8Xa0E+vgcJcJu1VDQdo1SN01usZ8KLn9ntnYzN7Xz9TH9L2/rmsi4pE4xZOsAOEsb
         ibsdVqJMH5Pjn+GCOu3FhdCYMAnaeqMTFb4Tzwhh/oFW3gTII4anLtWZgSQ12lUhEL+Q
         AWIODG0SYz+NqV24ezbjMxnyLzSPAJ2kxRh+W0U6HYLEAdJfi+F6RYFtk3/SuBxchAst
         TP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g+aJH265+hXbJtYjMi4nOLqur59yZuVvGpG8XV4VIU=;
        b=bLI3nXPxITJHRS/jEYRZyy7CoV9ZbJrC4/fPVCBcYGtpS1b7Jaj9QJ2Swt1Jy719FN
         xXscipCJrgK4UaWSMneQUwjZt7YWM0g3nQHQMU/EPvoa5OtUqoBfKLO6Zz/9wrqWAUhd
         +S59fSNyOL77j80TT/jtrYC1rlEpc1XlDMC1EQ8/9wuHiyptRpf5eqlXDvPVudOzGLlA
         hjDjfBY45MR0WTF5YnXtGSm086ES6YTvGXgLLDuZCcJKbsgNfFBdxPQ1HYRn9nprpn4B
         Wcrunj2TNpiW3uW52bxuLqAmD/3iwJbhW8sjphWdPBwttcNFU2yqw0bGc9ixqivl8lzU
         3FGQ==
X-Gm-Message-State: APjAAAWRY/3MiG06hZAD9cMPlG0ifQVYlDhkYzbif95Eau3jdW5Hzquk
        CW6WMyIQ9L9vHMTGyvVaWb3uCWcr
X-Google-Smtp-Source: APXvYqysZDlFQ1RgNzd/Q5Fl+Jrium48VuBSlP1op8AjVyIxsmlZUxt0KB2zVYnK1MkEqJ7m7JIT9w==
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr27048700wmc.88.1579029965782;
        Tue, 14 Jan 2020 11:26:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm20881832wrx.42.2020.01.14.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:05 -0800 (PST)
Message-Id: <53a266f9aab5f4331c35b3ff15fb0628e2131c56.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:56 +0000
Subject: [PATCH 2/8] sparse-checkout: create leading directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git init' command creates the ".git/info" directory and fills it
with some default files. However, 'git worktree add' does not create
the info directory for that worktree. This causes a problem when running
"git sparse-checkout init" inside a worktree. While care was taken to
allow the sparse-checkout config to be specific to a worktree, this
initialization was untested.

Safely create the leading directories for the sparse-checkout file. This
is the safest thing to do even without worktrees, as a user could delete
their ".git/info" directory and expect Git to recover safely.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  4 ++++
 t/t1091-sparse-checkout-builtin.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b3bed891cb..3cee8ab46e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -199,6 +199,10 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	int result;
 
 	sparse_filename = get_sparse_checkout_filename();
+
+	if (safe_create_leading_directories(sparse_filename))
+		die(_("failed to create directory for sparse-checkout file"));
+
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 20caefe155..37365dc668 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -295,4 +295,14 @@ test_expect_success 'interaction with submodules' '
 	check_files super/modules/child "a deep folder1 folder2"
 '
 
+test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo worktree add --detach ../worktree &&
+	check_files worktree "a deep folder1 folder2" &&
+	git -C worktree sparse-checkout init --cone &&
+	git -C repo sparse-checkout set folder1 &&
+	git -C worktree sparse-checkout set deep/deeper1 &&
+	check_files repo "a folder1" &&
+	check_files worktree "a deep"
+'
+
 test_done
-- 
gitgitgadget

