Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47077C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 20:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbiE0Uw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiE0Uw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 16:52:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373B4993D
        for <git@vger.kernel.org>; Fri, 27 May 2022 13:52:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so2694134wmq.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ctECrA9tytdR2DH1klQKhs1RCaMALOREXdwfNAE+Fno=;
        b=T+6lRwylxuR8xo25DeIpcmNNLXMMgqLBOKv4TlIrcmDvbvH2fTSvnuxvSaqnVxW2tG
         CeMTmFzhBSu3LhVOnJjBpist4JWF1gWA2po1Eu084ZTSdPA2MhmxFEXVSP2l2F+lkQ9j
         AyY4rdIf5Jhwb6qPYFSldUfkzW4DEdTV8XEQEeyxyVSb9PiX0cE3L3Pr9HsUBY28dgpi
         CM4k9tneY2Z/t3yQsiTqLFkxZuZIa6D0WiwRLAFasv590mAg51pb7ZOjbCaYzzMiNv0l
         haCqFU7IdpEqED6gjUQga7S50bnsuCIfYuDzLxZjROrxF4wb77WBNBKvLMMv55TYXFNq
         PUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ctECrA9tytdR2DH1klQKhs1RCaMALOREXdwfNAE+Fno=;
        b=PwUn5NzUUG4E+XU/GPw4H446LtzMWttcnjXNvwkg68UBuGCThJpLUkNQTUA4jIG7sN
         hFgLNTAXENHuYB0mpNJ3MYxHE9ECMaC0qMx2mcZOJmdj0UEMlncwsMmT+JY0M3thw3h+
         2hTg+1/kD5HQByRLZ2PDsZp/l74S4Bw8z2gpd3v2Kh5H9lvkyW2l2ctAAwUyyDdAD6/O
         1uoGen6pu6i5ykfcV683cqXh8XdBNC8VK2wh7qcNa6NskrczBU/DTW7GD0x8DdpY8FCV
         907gN4Tx2GQDQr5ikAlGxefp8V0dYoCdQv8o3V3Yx/MrvCCJAqO1AubJngIFxMUE2SkG
         xgxQ==
X-Gm-Message-State: AOAM532yGwmPhk9+QbwB9V0qPvbkWjCyDw+MrAlpGSpU5tYPT9RNvTBv
        A52e+eP2DCUoE1RWnXYkrtcYkqjXPwg=
X-Google-Smtp-Source: ABdhPJzB5OvDIzqttAuXHpUOTq1WsbbQNGqVIasWYLiiBoUcG0yfrU247TQx+A3TkCZ2UKyQE6iuYw==
X-Received: by 2002:a1c:4d08:0:b0:397:432c:a262 with SMTP id o8-20020a1c4d08000000b00397432ca262mr8818079wmh.41.1653684773467;
        Fri, 27 May 2022 13:52:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a1c0208000000b003942a244ed1sm3150205wmc.22.2022.05.27.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 13:52:52 -0700 (PDT)
Message-Id: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 20:52:51 +0000
Subject: [PATCH] hook: provide GIT_HOOK for all hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In order to allow users to use one executable for multiple hooks,
provide a GIT_HOOK variable that is set to the hook event that triggered
it.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    hook: Provide GIT_HOOK for all hooks
    
    In order to allow users to use one executable for multiple hooks,
    provide a GIT_HOOK variable that is set to the hook event that triggered
    it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1271%2Fjohn-cai%2Fjc%2Fset-git-hooks-env-var-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1271/john-cai/jc/set-git-hooks-env-var-v1
Pull-Request: https://github.com/git/git/pull/1271

 Documentation/githooks.txt |  4 ++++
 hook.c                     |  2 ++
 t/t1800-hook.sh            | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..b27ed8d11b6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -31,6 +31,10 @@ Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.
 
+The `$GIT_HOOK` environment variable is passed to all hooks and holds the
+triggering hook event, eg: `pre-commit`, `update`, etc. This allows one
+executable to be used for multiple hooks.
+
 `git init` may copy hooks to the new repository, depending on its
 configuration. See the "TEMPLATE DIRECTORY" section in
 linkgit:git-init[1] for details. When the rest of this document refers
diff --git a/hook.c b/hook.c
index 1d51be3b77a..966f2114db4 100644
--- a/hook.c
+++ b/hook.c
@@ -144,6 +144,8 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		cb_data.hook_path = abs_path.buf;
 	}
 
+	strvec_pushf(&cb_data.options->env,"GIT_HOOK=%s", hook_name);
+
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 26ed5e11bc8..a22c1a82a5e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -38,6 +38,18 @@ test_expect_success 'git hook run: basic' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook run: $GIT_HOOK' '
+	test_hook test-hook <<-EOF &&
+	printenv GIT_HOOK
+	EOF
+
+	cat >expect <<-\EOF &&
+	test-hook
+	EOF
+	git hook run test-hook 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 	test_hook test-hook <<-EOF &&
 	echo >&1 Will end up on stderr

base-commit: 8ddf593a250e07d388059f7e3f471078e1d2ed5c
-- 
gitgitgadget
