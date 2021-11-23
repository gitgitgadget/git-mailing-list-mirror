Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C9C4332F
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhKWLte (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhKWLtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94121C061714
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so38412057wrd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GO0ZFMe/NSOGk9Bn4gj5ngKAwcEssKVuldI55usff28=;
        b=AGXKQyfUAx1P3C/GNqgHUCcZ5sNYy6XodCIEpLTfP0EF7qgd9kafa1ILa/C6jvDW43
         6jURmexxaBiRBY9rcvRZAVgXvYMiYxdR/1uX8Bu9M+LnTHvIMe98u7pZSDr9j4EIriXX
         8GO9qBeacu+VA6/fMSJMEgzB4qLev7rf6/VAua61mxGbfwFw7SzAk/bwBcQDv6XDjvCT
         oBKsvCHRLDCUo9rZK7BhfSiqsz8si0PwystR3/RYsU4KqsiSwL65OKI1zgikJ2fG/Ozs
         Zl2x04Inm5kwdTUMpkVBDrr0ZdMHS93MM+q9cGLo42bBLR/QU6pO6d8JYwI/xk3+KZrw
         xNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GO0ZFMe/NSOGk9Bn4gj5ngKAwcEssKVuldI55usff28=;
        b=078733k4BoZzf0ofjAg3N28r7olM3TlAIQG7oVF/J75xXXdrFnJsDAPzSula/TUK3e
         jbIyd5C+XI+zLkvF7x7mWK+lKse9TzHoJniXPkMrlelG8WIMGP6Ud5D2wwkMrl7zy+Ow
         7Mm6vWrchhQiN0AxCrVH5xhdJChxyDq4iYzf1KJNac18d3/4a5d5Znn2oIeSGQ2cCvD5
         PzdDCDaryE/PVBu+a8aPcUEbSUCYS+8FydpWG+84qT0k8SCHdXGVJ7jfQa6/7abOXHv8
         psDlRAXnYqJ1zCfdERG2R/48mh7G2km10CRRE2dgCt32/DGZVO/UUKmQE1BxigSrrA2o
         u+SA==
X-Gm-Message-State: AOAM531VBmZ2lPexFXOIRgdPq3MzDEaOEJjrSufAQDlZBiHI9ns6GVuH
        NwIRUbjiQZORy4l6MELq03Da4AyB30KQ/g==
X-Google-Smtp-Source: ABdhPJx+CzeToh1HgNdAIeNZyCBwA4g89lrPt0mIY6IV3GxsmlYD0696q5tZ2ftu9JMDFkomlRiwtw==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr6535078wrs.26.1637667982958;
        Tue, 23 Nov 2021 03:46:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:22 -0800 (PST)
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
Subject: [PATCH v5 03/17] gc: use hook library for pre-auto-gc hook
Date:   Tue, 23 Nov 2021 12:46:02 +0100
Message-Id: <patch-v5-03.17-b5b3051b2e5-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library. This uses the new run_hooks() wrapper.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..4bbc58aae5b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -394,7 +395,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc"))
 		return 0;
 	return 1;
 }
-- 
2.34.0.831.gd33babec0d1

