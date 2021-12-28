Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B3C4332F
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhL1PTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbhL1PTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C40C06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c66so11810435wma.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBUs1iGzOkHQmrgI8DPplzNLjkZFmmx5p7WRyHF3C7g=;
        b=kCflRiK4mSlaIqKh4CMBhXs997d4mn7pFbM/sKzqRDI8in1QzFawkvK+M6Mr3b/9TI
         lzjGDyuiUzGCH6byPPhsUpwtsTy+SRYURkQ/EUvDRleGVf2RPAkQubV2NHl/zIPKtiHt
         Q073TTNqB9lsk4KJwThASGAwhFzEYi85f/Oh9AUh8rXYKqB8fdLWoKnG3GFC3n/5vTvC
         y+PYBBX0o7xN9i07wQqV+NspD+Xhsszt4NAAAt+0nsdp6aFF/6qYKU+e12mVMmnmXmgZ
         Gdy4pA9igIPgUlSx4yy2rKCLtQ1S9IwTeXJ89OKyN6LkPRP8HQULcCDiZZZI3OrlqS4U
         q0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBUs1iGzOkHQmrgI8DPplzNLjkZFmmx5p7WRyHF3C7g=;
        b=zRRzzHRYZHBIjqsDy/I9/1VlCILJXNXSD3HxW9jH1TYnUr3fPofym1w5daTCWJlW+P
         XyT5kq0BJI/hWnjpzLpWKer1K79f1n67QBmPFsZ3H6qsr44G/a5ODDalbiOHsfOHj+F6
         DlkQHLcxZ7wJuylyFTgyE0o5DVW4b4/gxlIkuz3/n0ABvjtDqsqXDL6NeCWV31CFsfee
         sMjW0QhxmN7Vd+X1L+L8gYoF1yXTdXYeO7kn9XKg2VawDIWmTK/7JuIwF6j/4aBG9pe7
         lspmrOJ2LdSTE67+npT8i251HFROk7JAE9tA+wk08f1mv5VWqOQwyYLZCGU3CnggCYWW
         9rag==
X-Gm-Message-State: AOAM530+461owApUAk/0lcKI5D2UENr8fxQ/WpPEbUjriex8OntCW2B+
        CCldCewiTLmW1NU+LDJvsxDv6ihroYs7ixrk
X-Google-Smtp-Source: ABdhPJys0/wwJ9iPwAHsm+IsbPlvqJGMeEEIOg4LZHxRoda4ADF2X7c6ssX7hiN0haOKb04rxYaUrQ==
X-Received: by 2002:a1c:4641:: with SMTP id t62mr17859362wma.100.1640704768527;
        Tue, 28 Dec 2021 07:19:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 7/7] *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Tue, 28 Dec 2021 16:19:03 +0100
Message-Id: <patch-v8-7.7-060483fb5ce-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
and around 10 "isatty(0)", but three callers used the
{STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
them.

Let's change these for consistency.  This makes it easier to change
all calls to isatty() at a whim, which is useful to test some
scenarios[1].

1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/

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
index e14f2d5f77c..7c55d0f0414 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2376,7 +2376,7 @@ int mingw_raise(int sig)
 	switch (sig) {
 	case SIGALRM:
 		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
+			if (isatty(2))
 				fputs("Alarm clock\n", stderr);
 			exit(128 + SIGALRM);
 		} else if (timer_fn != SIG_IGN)
-- 
2.34.1.1257.g2af47340c7b

