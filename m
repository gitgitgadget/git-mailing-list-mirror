Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80857C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE9360EE9
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKATCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55FC06122B
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso143808wmc.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rprVQrjHJK1jSwtSWPENwFVJJnWQHlIG3ZKVaLRqZLw=;
        b=E2JFLrVhK/ejESV4D/BoATI7vNAEz4U4JGdqrTFBaq7JUnNDF7x44tzkstUdTCRG06
         9ZovbrfWibyqxE2G21sQ5WWwslxf9czrbPeaMoVF1WrCng8Gya3ENJv6cpMDtMonb9xZ
         gwoKWCsm6A9eo7ZwCNU0vbllvheRl9TdE0wqg1lYpFvVG7V0ua6AF/XytdDg63EQQSAc
         /OqtccAALC5WZNAlWqrFmvBfM0TygXGxYOeCEAnjasQrTCG0DoM3L9DDqmNRpdSWW09b
         TejE/+I0ZcGBNRCdkkYvaVxmpVIyqG7YCnNkwVva/2fOqaXZBVb/NztBGg7HnUvXpmCa
         1v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rprVQrjHJK1jSwtSWPENwFVJJnWQHlIG3ZKVaLRqZLw=;
        b=UOBUE0q6oP4q4n4OaoVqFsHwsPh5no4HIq0Xh2XAJpfMmHZMobuxWWJFA85HSxubH/
         6+dJggDvMT/szN4/CviKENeKpWUJunkMif7T2GMs6LFAlzKC4CcldfBH6jy/L2E8rcYj
         ccopV2KhTQHN1QGr4zO10Ng4KFyczvBRNQzyOXKnRh31v4wtdw/GamivpgXu7GEACPYO
         fIanQbU0v97IBvu28COJEOxZwDu0M2qc0GyUhFvPU0E9Atufa8Qd5A/dFTNDS1sa9yiR
         9q+TSJ2hqRaccktWnTOVm7/FLuGMDat+RzcDVspyLkk/OZlq6jXt707pRjWwT8oIoRBB
         1fYA==
X-Gm-Message-State: AOAM533GezCORGLAexzgNuhs+fmSDwn/CVd7T+rf3ANjnJeqQgL1umRK
        wETnR3//PMdejl2X/gxVBdduf3WHDhaPwD6s
X-Google-Smtp-Source: ABdhPJxBAZbhpNiRo6K3Uj0Eh5ciLV6aCgo9NuJb2C1/MmH1pYdHEpwJrqpxwwaMIDdmW8f6z1nyYg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr861588wmj.84.1635792997774;
        Mon, 01 Nov 2021 11:56:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/17] read-cache: convert post-index-change to use hook.h
Date:   Mon,  1 Nov 2021 19:56:20 +0100
Message-Id: <patch-v4-15.17-81612f94707-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
index f3986596623..4352661549f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3129,7 +3130,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
+	run_hooks_l("post-index-change",
 			istate->updated_workdir ? "1" : "0",
 			istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
diff --git a/run-command.c b/run-command.c
index 7ef5cc712a9..d92e670c8ed 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,7 +1323,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index 49878262584..3fa7454cf8a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -239,7 +239,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.33.1.1570.g069344fdd45

