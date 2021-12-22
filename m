Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A77C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhLVEAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbhLVD77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A808C061748
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e5so294420wmq.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9Vh4J5qDL1WzbfDPhI8hUBr71+QffQ8cyPXhjCK6l4=;
        b=lif8a4mHvpEYzKjFJbpUztXeK8ecBAUJg9BPUAYd2Qk5RnlLuH+OOhF7/inRJQFX9H
         8aM/sw98gl6kiUDLvft/DNpHMsd2h6Rn8FE7F2O5nZcRV5JqEDmL9CmFQ4OwkSsgjC57
         4TqxYmEf5LMgtWGLMY35qe647d9VR8m4WoBi8ixIGUFI4oopNowqUfmaKEUue5kCoAF3
         pBICWhgVKmEbA5qv7+zK43PXBjGwJwlRyvTCKVtyth90Se2Q5FhWs6xtSWc2p+9O3AwI
         1t90XV+328zHpGgBm/9ma5jC5XYUt1C9N+LyWYT+doMxZcy5qZ7IcuinDM9NrnIsPWXx
         cKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9Vh4J5qDL1WzbfDPhI8hUBr71+QffQ8cyPXhjCK6l4=;
        b=7tK0xYl6XK2jPYXnMtSPQs1Bz4N7Q9s31zR1ERDKIMPVzLlEPrBfwiK/L1KIBV37C7
         F591PGOd8X5pubrV7o+ZeT0f4YMaXVBNmeCeEa0PwfcgWwXeH3MIihSzgy9QptduSeol
         GbF0o67Dkpax1WIy0XuyZ9528biXrSzd7hte6TTEdV6CWUq+T3rPgZfl9HlqxqWHtwRr
         VVrhNArNRYquC2t3GcS4xqXOL6Zq8FV4+AhTgGPL0sH8ACGDx0cnXq1MSqXsA5ihhVBM
         oRF4HIxMK0Irza7BZvZ4LthrhW0d/z9wgL8/08hjX6g88hZBFJa2LsNYItqxLI0F/G+W
         Op5A==
X-Gm-Message-State: AOAM530v8WCshTbFNgcD8d9tj23R9kFDRx+kt1LyqXDsOvGznT7gmNDQ
        mUp6XwZbCe9iTgghrx0xZ4/fnvEAv4egRQ==
X-Google-Smtp-Source: ABdhPJzwcfJ2D/CLM5TFQ51pedgAy0S8O6FTaiDJPOC1Z5hoiZmQeYT6U+CrxDMp1DVIxCGp3tXbsA==
X-Received: by 2002:a05:600c:3c85:: with SMTP id bg5mr764849wmb.58.1640145597734;
        Tue, 21 Dec 2021 19:59:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:57 -0800 (PST)
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
Subject: [PATCH v6 14/17] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Wed, 22 Dec 2021 04:59:40 +0100
Message-Id: <patch-v6-14.17-1a43e50617f-20211222T035755Z-avarab@gmail.com>
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

Move these hooks hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index a348f085b2b..931f65d56d6 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1702,22 +1703,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
-	int ret;
+	const char *arg;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
 
-	return ret;
+	return run_hooks_opt(name, &opt);
 }
-- 
2.34.1.1146.gb52885e7c44

