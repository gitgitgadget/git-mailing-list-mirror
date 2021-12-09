Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A87C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhLIFM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLIFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE1C061D5F
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so7651738wrr.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dA0jEtSi3g2+Nxmv5Z9g89zEVjjZllEVTwBpR2EO9lo=;
        b=HrMBiZNUq1/J1pMyBuumv3NnoGLULpQDw6OY2C4UlFXN8dVmCPrRTMSc8wbO8p8IzB
         9zbC0yahMzL264oW7GbIXgjIFY2614EYsKn+JC1sX1l8ZoBGIWCkk4FEpsd91YkhOl3u
         Jhs8A7sAGkU2wN4cu/gVWgAIFdbCY+S0MI9l5IgjJo49p5bRnGJZ5XGeyeLAiVBQNNla
         3wwJLkO5o6zOVjFG/U/K+l49bjxkEzEqW3mSlJWgwKbbd9x4Q5zEMgOXplDyjS8TTuQR
         cWgfqMt814o+aoxMj7y+QS/gBXtiSpWv/KorN29EDZi0p95wzQtp21PlsQMRh17hhNUu
         mv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dA0jEtSi3g2+Nxmv5Z9g89zEVjjZllEVTwBpR2EO9lo=;
        b=5/BPH10QbAqjzkZvxqYkFhrwLf559z48v3d2IkUxHZWhqBJWi809P1B+kYblgcNo4q
         AnVSAmxpOr+IA5h/K9sZKaBY2nOo/pSg5RPpxJsiYqiz2kVEt2U45FjiTi5eJKFdLShk
         vpmVcA5DSzlU5/PMGdHV/6f7xey6l1dAuS85/XaCOXm10QJgITExLoLIcf2ZuyssZ8fG
         rqYe4qfzoOa6kukMXF8KM1JMdtkukQApV4dPjVioAUKcD6ye8IKofgKqfiMSw5F/Ecpl
         WLhd0+/sq3Wk7/C5vh+qDe472oqKlSZgWVB8a9LS2TSEvVVPJrcVlPeAWuKQ6VJYzKIM
         h0OQ==
X-Gm-Message-State: AOAM531ogT7TwN2cBARktGcYp1W9nYyvg1wPxJQMovkZtz8PMJQ4rBvR
        gujMa1wUhFQQL8I/awWia4nnorKzw0s=
X-Google-Smtp-Source: ABdhPJzAXwgbVbTwiBE8pMqo9v6Tx56Xtwhe+Q2H2snoLySUwWqALerUnrn9bw89hlODlDri1Pysmg==
X-Received: by 2002:a5d:6d0b:: with SMTP id e11mr3920426wrq.16.1639026523355;
        Wed, 08 Dec 2021 21:08:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm4801902wrn.63.2021.12.08.21.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:43 -0800 (PST)
Message-Id: <fd500cc1843826157c79d2823ed26acce40525b0.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:31 +0000
Subject: [PATCH v6 07/11] rebase: do not attempt to remove
 startup_info->original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Since rebase spawns a `checkout` subprocess, make sure we run that from
the startup_info->original_cwd directory, so that the checkout process
knows to protect that directory.

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c          | 2 ++
 t/t2501-cwd-empty.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..83f257e7fa4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
+	if (startup_info->original_cwd)
+		cmd.dir = startup_info->original_cwd;
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index b1182390ba3..52335a8afe9 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git rebase reverted
+	test_incidental_dir_removal success git rebase reverted
 '
 
 test_expect_success 'rebase fails if cwd needs to be removed' '
-	test_required_dir_removal failure git rebase fd_conflict
+	test_required_dir_removal success git rebase fd_conflict
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-- 
gitgitgadget

