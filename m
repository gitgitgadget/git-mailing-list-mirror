Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C64C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhLVEAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhLVEAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:00:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A18C061751
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so2059126wrc.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNxjASHtk7FYsm8QZXDSWsHyExGJQmszv61J0Vq/jSI=;
        b=iqBQ8kd2Qmr+dfRXxJfkk5MtjvjQBY6culQs2ZGqnpvhWVSVmllO9G4JrMkenYrzy+
         tiUSak4FM1fnDiy/UPpuFNrc7J63q9b5El/PzRCQNqZ2lP7WeUgJNIstrtS1fKhmLVhf
         R10yUVRW2Jz5epTDG5XKz6tPKlCIQ9xHP1N+wQIF8u43XKpw9VMbiN+KYVAnW3JvJzYk
         cSdDHEGiEOpq8twnHnRsnwX6kL8lVlW2opTT+hwTsk84mHXHDrynOXnykFDn8ElUSVXA
         LWVAUzZ/LfdD/wEtJMx4P+V4yMEDrpDz9zmKNftFLXfvYhOvm2TnyBezrPeb0zugqT7Y
         bvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNxjASHtk7FYsm8QZXDSWsHyExGJQmszv61J0Vq/jSI=;
        b=atldTa0CDXU+b+zkRp2aYuS79R2LhzmqRKwm6jqtB2T1Qqe5vL0YxfoT+3OZDymDUy
         mEAer2vmQo/zeiMvrdZEYclmI7VZWeS+KwzrBYCJ6RUGnTcnHODlOcAH1sO97r4Bz5Jl
         hN4dVX3BZ2jmV7KzYjr7xe0ZQcCl/fCas1sjDe9iWcXu4xpn2EERCmx9Np+bTc559yvR
         Iwx8a/FwSYUl4qZlHary3KP+Qi9gkrM3om5zKmEURE2CKgMvbZiDC7SKXpEdIpgdJDgq
         MPddFcnviDp+Wfzs9RDNjRrqK7466FWh7/1CfFVVjIMpcqpHIbYpfyaxrcn6tsEq3ipJ
         CPNg==
X-Gm-Message-State: AOAM530HZ3NUw2EK6IYq1dmAZR73E5h4EB5j/q7ELUWx/3g278vg/j00
        6SjQse9/XHVZPJ+5R4tSbk+sDNglKWhpFw==
X-Google-Smtp-Source: ABdhPJwWS1onCRFtKjTBOXKyJvSSlMd18yHgI2RNP7UaZWM1YOfiqa7GsgdybBJBCEnGlgiKTLgdeQ==
X-Received: by 2002:adf:e10e:: with SMTP id t14mr733610wrz.272.1640145598665;
        Tue, 21 Dec 2021 19:59:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/17] read-cache: convert post-index-change to use hook.h
Date:   Wed, 22 Dec 2021 04:59:41 +0100
Message-Id: <patch-v6-15.17-08b7e63ba5b-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of "run_hook_ve()" outside of
run-command.c ("run_hook_le()" still uses it). So we can make the
function static now. A subsequent commit will remove this code
entirely when "run_hook_le()" itself goes away.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 3 ++-
 run-command.c | 2 +-
 run-command.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..a7fbf144fec 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3150,7 +3151,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
+	run_hooks_l("post-index-change",
 			istate->updated_workdir ? "1" : "0",
 			istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
diff --git a/run-command.c b/run-command.c
index 3ea2c2fc101..ea09de040a7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1313,7 +1313,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index 2be5f5d6422..88a398c300a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -235,7 +235,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.34.1.1146.gb52885e7c44

