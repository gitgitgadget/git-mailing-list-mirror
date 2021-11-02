Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D8C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CD460F24
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhKBMa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKBMaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3BC06120A
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d27so15059101wrb.6
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rnv5pB5SWWZ9ugmJbSK7qYIu1BxBbdO31Y3eDKu2/hA=;
        b=nvwt86CZA5j9kPk713oRk+oCL2cdiMRutWDHq+kUC7FjXXqo+UcfQFYdQDmOyLca3J
         H/JSa5ruEyaG28mvWCUQ0ii3Fh3hOq4xfsYD0jFNLJG3PcYUBRTBposajZO35bAdDfeN
         4l5Ry+sDq32ekyTZcrmb9Bh8EZbgguWeh/sg8BaBhjqWRuCd6DD6DEHS4tNdoFmqVEHE
         JjZ1m/gHHwbEebzKBdg5TyOEoU2AsF4+gaaT5CQDOOaVWOdHMMbLFX1z3wpJw4+C4Jh5
         kH/obe7OHwkIpAqlDHl7EOkEqDx+y4RCETY3EwTZ5x9yFQLcDgSpIHLrjihHplShbwQW
         bs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rnv5pB5SWWZ9ugmJbSK7qYIu1BxBbdO31Y3eDKu2/hA=;
        b=1wWqLKydtnMACfEHKlsgBS89jBz+T6WRTFeFnk+AzJwuoleEyk9BRQuP4Z88tAEtUl
         zPWCSoJf+Dkpewo/dgkqdrwkAtF/sfbBcIWQlsGewrCm/rJgLjDUtZaCmwtsCXMoGUrk
         J5Fxswg5YW6FBnlrUmHz8H3zjHcEfLfX5yhl+Eane5jYBCMv/qX5geWMnUWtKX6Gi8mi
         czQnzrt3GCSGkzVGbr1jSXbFGwug1oI9xodb5jEWgFUiQn1qNcDpb+W8sSL8dnHO+m30
         sC4/LPfTWxIFw7AeJew1Tanor0fsKAAlrrWz3wpCPNkW+eRQ6h7jyWfojuRFBuzW5QeG
         TOHw==
X-Gm-Message-State: AOAM532fDzV8DkfPvjK3azIrnXjO6uEODAqrcCaswPLOCeV4mNd/JjiN
        LQTBlXKjwViC5nd7Tyo0OPoTPcepfkgKLw==
X-Google-Smtp-Source: ABdhPJz44FVM1Mo12QuBbspGvPXbsJ8utpBG2xcpuYlgwGKYilvcF89dRbrxJeba2Mlcaqh3x2dWJw==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr20305318wry.238.1635856059410;
        Tue, 02 Nov 2021 05:27:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 7/8] various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Tue,  2 Nov 2021 13:27:29 +0100
Message-Id: <patch-v6-7.8-1a2eadf28d0-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
and around 10 "isatty(0)", but these used the
{STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
them.

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
index 28a2e6a5750..21360a4e70b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
+	if (!isatty(0))
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
2.33.1.1570.g069344fdd45

