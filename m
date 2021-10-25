Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E626C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DF460551
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhJYL1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhJYL1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034AAC061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g141so10350514wmg.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwSZhYyrau9nwuLcxzWkCG4Es0SOtFRs2qRa4hKDT3U=;
        b=VVUktnitUT63JL0LUquQbaY/137rLH9LU2DbjIPNKotwzT662Kmvavb9SOWms7HsNu
         1vk4pT/oRz4tgji6BIpbQhGTxfUuqNX8ebYX22Zp9wuPMkAovTpT3P0FtPbaH1tpITeu
         IgRpCyyotTi8JL6rRCMXLTg/o2web+gDiKSO2RtrM7My/sjWJS4fRWAzzHQGBtAt894O
         ee2ab1PyuxZvk5Js+CysIR+ayACyBvb6w6S/gLRcbNPMXUbm1s8dZl0m7RaqG71Bqc0/
         qCLTCh6xnNnRySgmhVLdG+irBOlaWOxU8IxGivuTHq/iAmOixqO+LBuw0vCPAWVbloSl
         L/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwSZhYyrau9nwuLcxzWkCG4Es0SOtFRs2qRa4hKDT3U=;
        b=rvrTUQ2s4tRzQaXVCf70+Vpr/IKzRu2y7u65QRH/gzXQi9HJzs36u9W7laAwolnCjl
         b3mWsqqdYvl6kwnrg9hYirhpipW2vSpL1h8+AZfJ+JTqU+nCfRVj9sWX3ESs/mMJo3oQ
         RO5oaQwud0rFLxh0M8C5pxAn+pQro31rVCv9Tbj86NdsdsKA+4BosZeEkD/mITU/uyOp
         yEzwKWdUYOUa2hYVy6uuBf5UZ6EldMUiL+2DI17+fKNP+mORPtr3g6KGWtFaluIAlj+i
         HBJwdJAHue6v/rvps/05nypErEzjtGIb4BQdq1jBlz7FyxqJ2TZZq1RRmyvl3ESSJeaJ
         Ir5Q==
X-Gm-Message-State: AOAM5314Q9u5SPP49oiMvfRVxhmpvraoEJKSVQUAchduYWG/4K/WlmhQ
        D0P6tlXQQUuYMF/RJQMSOi+VsYFo39bagg==
X-Google-Smtp-Source: ABdhPJyH7i/1UvZBVU4sf9Im53iIeYdhxK7HlWYZEQYUUFx6ZryQ4qrSufECZAvG3S+zcwnAI9O1yg==
X-Received: by 2002:a7b:c0c2:: with SMTP id s2mr19423549wmh.101.1635161115378;
        Mon, 25 Oct 2021 04:25:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/8] various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Mon, 25 Oct 2021 13:25:06 +0200
Message-Id: <patch-v4-7.8-8a18eb40fae-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
only these two used the stdlib.h macros to refer to them.

Let's change these for consistency, and because a subsequent commit's
commit message outlines a recipe to change all of these for ad-hoc
testing, not needing to match these with that ad-hoc regex will make
things easier to explain.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 builtin/bundle.c         | 2 +-
 compat/mingw.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..1727cb051fb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
+	if (!isatty(1))
 		return -1;
 
 	/*
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..df69c651753 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
-	int progress = isatty(STDERR_FILENO);
+	int progress = isatty(2);
 	struct strvec pack_opts;
 	int version = -1;
 	int ret;
diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..0f545c1a7d1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2374,7 +2374,7 @@ int mingw_raise(int sig)
 	switch (sig) {
 	case SIGALRM:
 		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
+			if (isatty(2))
 				fputs("Alarm clock\n", stderr);
 			exit(128 + SIGALRM);
 		} else if (timer_fn != SIG_IGN)
-- 
2.33.1.1510.ge5c82eefb93

