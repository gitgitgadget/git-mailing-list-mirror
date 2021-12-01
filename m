Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B2C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbhLAGoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346994AbhLAGoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856FAC061758
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so28935667wrw.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kIyA/DPm0opiz15kCJdYQCMwbEBz/tGEH9pDhXEFybM=;
        b=F4BhMuF62JjIJg4zV3C3QtfkD15kH4OJZIFU7562JxEWOOvQal0kKy96aCbOIUQWbn
         robjjHzMcVpo/1spkBHN15RUgNL/Dr/Zc9BgAeO094Rw6ontmuSNf8eB53kDMq1cj0ft
         fZFfqUlE24qasHd5iGbXX01BbbjmYgS6bcee6R8amQgif3+oPwU85d+m/2vwjlT0HHw9
         /P2w2Pfkjlpvwggmksq4WxV+lHgKnP3pJS8Om9bitF83eH/ss68VmHQyuvocpXERJYCl
         /4F3KOQWcLS5m59UP9rF71Wr2LTBJ+BClXSl/dn3NB9s7aT3p8ncPJzxnz0iqHoqdtSt
         x2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kIyA/DPm0opiz15kCJdYQCMwbEBz/tGEH9pDhXEFybM=;
        b=LpPKzz1rvNhfUCX4f5ehZBN3qyjiTHXBxnWtdQA46qtMDh96ZcrqaAMrcZLuAYqUSo
         nUufITy/ska1YTgFGqgWmROuHzFqEpmpH08wpLkxeZ7z2WaFgvbNjIICgFZn7pgV2Q8+
         IbjH40N25f//jOEXc/eiHIO6YSnYKjVgQkt82OHthBd+TU28tcIZMAH9O94Hhd/IfATE
         Jr/t5RvfeelQ7mzyq40eM3ZmuQkmMV6MR6qH70MehD2iuBgx4Kq11E3JAJ7IrKeXXrWV
         KmMLK8RrrKkSZAsp1AZ+Lw3c2uYe140sStwr+wkIyUaB7w8bkPv0yl5Ple4DV/QRcWtt
         WlpA==
X-Gm-Message-State: AOAM531CnckY+gOCN/sV65lPi3aHE5y8FGVOIO8gE++QMaAsJMuBbpNJ
        2EdjWsnr/zQdjWRSxTZQ9LgFxnJVsqE=
X-Google-Smtp-Source: ABdhPJxbrlCm1RiR0byw3xjsCJxIh9pnn36pnhzAJcwUUEM6jxFmsmpgfsagORqr40rSpDwCBTiPwg==
X-Received: by 2002:adf:a319:: with SMTP id c25mr4445163wrb.629.1638340862845;
        Tue, 30 Nov 2021 22:41:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm18040144wrz.23.2021.11.30.22.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:02 -0800 (PST)
Message-Id: <2855ed45112acc2a69a96a13784bff8de87b88d6.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:51 +0000
Subject: [PATCH v5 08/11] stash: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since stash spawns a `clean` subprocess, make sure we run that from the
startup_info->original_cwd directory, so that the `clean` processs knows
to protect that directory.  Also, since the `clean` command might no
longer run from the toplevel, pass the ':/' magic pathspec to ensure we
still clean from the toplevel.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c      | 4 +++-
 t/t2501-cwd-empty.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..de0e432a4ff 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1485,8 +1485,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (startup_info->original_cwd)
+				cp.dir = startup_info->original_cwd;
 			strvec_pushl(&cp.args, "clean", "--force",
-				     "--quiet", "-d", NULL);
+				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 52335a8afe9..be9ef903bd4 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -236,7 +236,7 @@ test_expect_success 'clean does not remove cwd incidentally' '
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
+	test_incidental_untracked_dir_removal success \
 		git stash --include-untracked
 '
 
-- 
gitgitgadget

