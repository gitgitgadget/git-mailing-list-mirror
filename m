Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E2C64EC6
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBHTV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjBHTVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25251C60
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so2583033ejb.7
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4IqOqJFnNv43KcGny+BezwjI5ZJOkPyfhzT7Mevgag=;
        b=pQJSeb6zRZMFhKBCDcC6vpDvlptxSmL/BFGZ+WNqyGtFTjiEnPhMmjvpUKZkowaw/i
         coDaNTsm1k21Z2PU26AZxyFBHFEOuoXbStx7jVImCwOsco7hV/v6k6fRNOrbomoU6I1e
         I2Ed5VvmX2XS2BpVeIAqZ+LDd0qu9C5IIoD+/BgcTcGrIA9zkVKU4RMpc4VaKCi69g9+
         5ofECuJVYKkn/Xjzrv2XUVpIdgApf8AYHAYJOXRtXeZ7msQMLa72DpZCoJkfrsUqU/kQ
         lGeazzNLx9Ee8Sm3DxrsvtYW/XB8KbhUrV5whNhUSN3mduIsgEjifYv7PT9VmKdKk46D
         lOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4IqOqJFnNv43KcGny+BezwjI5ZJOkPyfhzT7Mevgag=;
        b=78mAJZjaz+Kbxgvi8NjaMGFmFamH8ZxvG7Wlq/DD1y7JoBEyHOnDq/UmBXzz0vves3
         pYMcw4gkiA/4O6W9AiLEMcvbyevUdaBnbDmFi3/gv6bwGgDIhbIgOfxmQWqxyzMtgcS2
         AMDKtbHzxOkf1LpHyfr0MnEdNSRnoYwbZNT0P/cSo5cusq151P3HS8pJ4gyaF8O52gnw
         U7cxLQE3+anS9+XPDGdOgfCQolaAkjqbHkx+NJn/1RUN1rfNrDLdwUlQWrgHC2oMaY6h
         fnq74V3dpsd442IFK1fJ1U96z/ofCpm4MNBosw/1p9Xi5xqiuZRC4Crkc5PMYPPPivm/
         PA/g==
X-Gm-Message-State: AO0yUKVvmmgx1OwJm3fsFC2HqyP3tFTr/pFH+wLq90a5QBbkSomQQtB2
        mqyDwxvsabZi3or1GCl3T1rnSqfZbqEjXbB+
X-Google-Smtp-Source: AK7set/1P3RO4291sjEy8XLQiHHIxuZ1ti0SeV9TaVrpJbf3GbspSj/kTXmxCvUfde4JjB7QAriuGg==
X-Received: by 2002:a17:906:71c3:b0:888:4f0e:bb72 with SMTP id i3-20020a17090671c300b008884f0ebb72mr8005536ejk.40.1675884097487;
        Wed, 08 Feb 2023 11:21:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] sequencer: use the new hook API for the simpler "post-rewrite" call
Date:   Wed,  8 Feb 2023 20:21:14 +0100
Message-Id: <patch-v2-4.5-b96522d593f-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Change the invocation of the "post-rewrite" hook added in
795160457db (sequencer (rebase -i): run the post-rewrite hook, if
needed, 2017-01-02) to use the new hook API.

This leaves the more complex "post-rewrite" invocation added in
a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
here in sequencer.c unconverted.

Here we can pass in a file's via the "in" file descriptor, in that
case we don't have a file, but will need to write_in_full() to an "in"
provide by the API. Support for that will be added to the hook API in
the future, but we're not there yet.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..d8d59d05dd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4834,8 +4834,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -4845,18 +4844,9 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&child);
 
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks_opt("post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.39.1.1475.gc2542cdc5ef

