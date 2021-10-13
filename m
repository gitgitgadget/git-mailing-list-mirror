Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D9C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA0761130
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJMWaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhJMWal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA39C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e3so13033308wrc.11
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qg+bhkQ+/nS9/6OzsVYyaYV/554zq1Uhg8a990JfRO4=;
        b=bL1RxRF6kKcIdLeXUnDqmwShqQrDDTOLpHfpTB+qPOe17evmGVE1eZ67wC65UP/axs
         BsbTvUPxWY8v5b73NweOijbOR9M/rY/a54xZPuZ9nXfj0DHH7tBxoI9Maw7XIzKASYgJ
         ORQr2Hcdt/PXmPALhRe65IcXTkyjwTe69Rs4VzzTvYQSm1dvYQMcORKS4xX+UBXj3HRd
         SOH3gTuZgKJOIbaGVfQrMA9E4b/OXceVfo7+UFL9lzdDBCgmFiWYn5+hohVU3GWIjP25
         tFABd6pfKLV9NBiPwi4Q0L/KbWL88+xXxi6PlyF7Cbw7nYJBvQyJTfQNSWZjvZ5EdJWb
         KH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qg+bhkQ+/nS9/6OzsVYyaYV/554zq1Uhg8a990JfRO4=;
        b=eTjCZBPBbqxkt/CiZzMbGEEjJJJh2XXEm2rlfkdok/VPy4XdpXZoZIc2ZmtvwyGfZW
         vZBK/XQb79DCraEr9vCL6NyYF90NEoJZsC1Eaq9mP6U6M24WEKOTKJP++yt0X6U62muA
         033HmU52vyQYCeZGVumG4xPeAZ4VGayeWYLGZwA91VLQu+9JDlWYES+2t0W9tAu4prd8
         sK8dU4OsHOOJ+YoI7KRxwUAke+GldSqkmk8+rS5U2z0RyZcGqBZlk5HHKPaQ7bTE+22W
         bkzVP87vDptojIlAsZ7CR8d5d53QU9kR+C157b4AHSYoYv34d9aSM0mUaUozOUBgCIwN
         Gp4w==
X-Gm-Message-State: AOAM5334QaOjS9CoyJEHgMKl2P2yYm4spq7UL+8h1gVu6uPK+i2VuFCX
        950ot1E5K2AYmAg1/XfPYASkX081X/KFiw==
X-Google-Smtp-Source: ABdhPJzrMA0SzUKku5GgMGNdg5ykAdI7W7M/Nj/Gm9ErZvvW9F7iCKgFN60CIPipPxEZoiUlnQjc9g==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr2232793wri.178.1634164115552;
        Wed, 13 Oct 2021 15:28:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Thu, 14 Oct 2021 00:28:25 +0200
Message-Id: <patch-v3-09.10-2cf14881ecf-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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
2.33.1.1346.g48288c3c089

