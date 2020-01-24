Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEDC32771
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1359A2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4nmwLEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAXVTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35777 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAXVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so847362wmb.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=N4nmwLEsgUPs5rkcZUlmg5TBeWtApjJ5VtFAOUP1F/x/OWJoZYrro6w/Xmu4Sks8yj
         3Qx+CaGAmkOBU9J7T0ahCgcOgh+RuRgRCjwcYtrwPi1JqacLCCG6zkBB5lrXMl1bCS47
         J3PVNRBsz08Jyj5a76olry2SABLBn8T3KvibzOGF0tuoVo5fNINUn8xHOywV1QoeJDHn
         xxl2iIX3u+bK4mhABysPOtomjWLRTMgaUy6tbqfxvhNIhMyrZcgGso96nRe0GF6ANqHU
         z4N3ViotiUYrxWEg6gR0KJ8Pc0F77oMNNolugT30Vmn7dqfs95uPqhePWPx9QVFp/2b9
         0eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=qpGMlt7e5UTrVmqw3eeSf7XFhiGiSCGmpYg6hR5gUD4V0wgbI5pw/r0uYpOnMxN+pS
         /BSOO8F/6TEPnSxEIS5UgAldlKOktteTBxUzhiL3Z7lYAny8V8Xfi0WpAEbc6juUxzB6
         xY2/rB0u4DdF9olhop6/cjirGuzvZkxhFYyRwdSzPaCKO9YoG6sVaAOJZ98en+FcqPnh
         yzOvqXb6wXu7t7MtV2eVU7QH5i7GWyDxvwci95nj5DdkQytkqX/a8jqzU0GsYCZhPrsr
         Z7gSBTgWTcLQfdiyC4Kg6IHXMhV+Q0y99BipWF0zbVGwWZCdYeAFRUmpKtcXsZL72u4M
         VulA==
X-Gm-Message-State: APjAAAUNSDtpqCAZT5MQ9ibIFW0kZK4jRRKNaReeo0nWxyLK/aijTQx3
        Qliuzc9V+L8khkKmplxLxTX11hOb
X-Google-Smtp-Source: APXvYqzDGngFet1TNijVLyNzemUXG36aopaWpN+vBwCb1pi0iT4nQVm9vlt/0xbjPMJHgBus0Rr8MQ==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr1008910wmm.98.1579900785996;
        Fri, 24 Jan 2020 13:19:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm9126598wrp.49.2020.01.24.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:45 -0800 (PST)
Message-Id: <5497ad8778c29ca936206d2ded6773758c236c12.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:33 +0000
Subject: [PATCH v2 03/12] sparse-checkout: create leading directories
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
index e28e1c797f..43d1f7520c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -295,4 +295,14 @@ test_expect_success 'interaction with submodules' '
 	check_files super/modules/child a deep folder1 folder2
 '
 
+test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo worktree add --detach ../worktree &&
+	check_files worktree "a deep folder1 folder2" &&
+	git -C worktree sparse-checkout init --cone &&
+	git -C repo sparse-checkout set folder1 &&
+	git -C worktree sparse-checkout set deep/deeper1 &&
+	check_files repo a folder1 &&
+	check_files worktree a deep
+'
+
 test_done
-- 
gitgitgadget

