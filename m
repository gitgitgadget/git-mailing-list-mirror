Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC9C433FE
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbhKZWsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbhKZWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A4C0613E0
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t9so4581787wrx.7
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s0or04NBUOQMJYTS7TSgT+JE9q+oWY/aPZyD4esmukk=;
        b=S1DU0YTrLhHNhDCWuww5pkTlw02Td/4360X+gPjgoKeDPbAjg1JMpEjVKUTNzjINbE
         6dum2CWX+UAzlMeCBxgIvVDcjJ+a2/KxyevCQVj8gtciw0iH3oELiNHGT0Uryky63PbR
         9lQoFL1lCF+iglYnpM4oCCEYgLFBxhvah5iN+1i/FhIwGK95aQqow9S6SxJORXpCIH63
         5N5kTPrbvf5cHNwmE9DCvG2ktqX8sO7ZhzRNlZ88+d3YkjVEArUjFvRRMCwzUKe2XhTV
         hOSh6kZRhULj/2U+LUZAbaWfrejgwqCc4HjqdW3Cn6p805JlFwGm5bBtxl4MEJByFdNJ
         XGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s0or04NBUOQMJYTS7TSgT+JE9q+oWY/aPZyD4esmukk=;
        b=poOAitRQxwtIGhiqZK4G1anrWI60ZXd0drryZVHg2tCPwhvlQK12rIxnCreMUUM/mg
         SG2+Oev5eDMlePn9AolLnu0dZ2DYsEf8GX4wHB2+62YwvLepUJsXP1V2D3d7TXWy8Gv2
         gTe2EPwcFoyv0JCg1Q3pchIWtYaMGBpGDS2ebPqGr8vclmY+doLOx1vLVFboxVUnXGKp
         +JcTprxiEDMFyq7NRIqsH4t9xYhfoSmXYvzLmluapjAiKMEXgx3ONvtdM14WZycIiFNw
         vVOg7oERu1Niaj0Im4LRjSgxAbgd+UtyOPKX1+YHGSG9smxlUHg5hLiBFO9gml1JYaXA
         Q/Ug==
X-Gm-Message-State: AOAM5337+2x4NT96XYrdvMGlgN2bF6g5jm/heOMSCJJGud2hxZ+QuDJv
        SYgRbyWNPZVbZ3Y/8DNoUtyCcOxM0go=
X-Google-Smtp-Source: ABdhPJy+lQPr8HONXsjhOzxVy/JRNw/gMV+T+Ycq2MqRL8ZPD1Omxp9lB2rod2sdMzBKhI5knc21Gw==
X-Received: by 2002:a05:6000:162b:: with SMTP id v11mr16410541wrb.481.1637966469571;
        Fri, 26 Nov 2021 14:41:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm7759546wri.41.2021.11.26.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:09 -0800 (PST)
Message-Id: <39b1f3a225ec74a79320503eff04ba47ae4259fd.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:58 +0000
Subject: [PATCH v3 07/11] rebase: do not attempt to remove
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since rebase spawns a `checkout` subprocess, make sure we run that from
the startup_info->original_cwd directory, so that the checkout process
knows to protect that directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c          | 3 +++
 t/t2501-cwd-empty.sh | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..b71f7b8a0a6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4228,6 +4228,9 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
+	if (startup_info->original_cwd &&
+	    !is_absolute_path(startup_info->original_cwd))
+		cmd.dir = startup_info->original_cwd;
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index be04b673f6a..acf9646ec6e 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -159,11 +159,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
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

