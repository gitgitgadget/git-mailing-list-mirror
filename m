Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F315C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKDN0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKDNZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA82F65D
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so13190271eje.10
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkZFJLlIobhwxBHNPNoAYqsmk5sNPFxCsyBx9XMhH7E=;
        b=HasEB9nitQFlpOe8BJjh8qNdJ0JcMgffWuzJ91+FzBI3gTyRStz5n+YZ05IjXAOqNP
         gIPzKA6IQryqdeDKXJxaHjBhdzdUTBkAijLkZfrNLRnE5aqrQPm+NxctjqUfrjyE552W
         4YWEXAVvfP/KyBeoGEVm7dmhf1XNAsxQuA3ZJiLh28LN6gnU6GjkzxQpT6LZgGIhTuVp
         z+xd9ftWQpuQSkiUw/Olo4iTRfE2WzjYkPIo1f+zH0Nba1Y5DpJpvHoa14+AsKoD5xKx
         5aZWWbz/WbDFy0Me0cfHpYMlrBFLzYYPgvsBM9OUINi5ejpslM755TN5azWtxEGSW1fM
         gYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkZFJLlIobhwxBHNPNoAYqsmk5sNPFxCsyBx9XMhH7E=;
        b=B6q4OtSbpab+t7n06SkqGaAziFDyb3Mon0BDjHOAukG/FGKzY1EamvgeCiFw6uQwyK
         bEz5rIIbX0Dr2pEktTI1dtVMyTF4wau8aemC9y59Ib0Qo7M8XIN68VVUZWX5GxM8AsBG
         hXrTNfQ7+AIteOLcwqfl5Rxcdf+hnJm8eRJUcc0vzmguoFxW7rvAEegwiY7dWt2Z0d9F
         aRCZKDMR3dt4Lz/uCjKY1/U/oBtaiL84LG+JrxaKXvdp3rN7+j/fW2uJ0ik+gAubMci4
         msFwfLLe3XQUSV+N8Bbrl/qwlwspltMocZXtmgFlDN8tntPYG4Du+tszusRlsAhPncZI
         l9Ig==
X-Gm-Message-State: ACrzQf0LSZUDUGYxy6ijFg3bp0q+qXspaQjk1c+JOmei20CXeBzoGTMt
        dFpV+ALWn19w4aCvSJp3yZuCZT0P9jEVog==
X-Google-Smtp-Source: AMsMyM5c/P6vhLmdXQfo41ettM31/JfdSQZyf4/HFLrrotb5c2LOWoJFX2SRrHMzuVX12IjKib94cA==
X-Received: by 2002:a17:906:d10d:b0:7ad:b7c2:a2f7 with SMTP id b13-20020a170906d10d00b007adb7c2a2f7mr321350ejz.227.1667568299442;
        Fri, 04 Nov 2022 06:24:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/13] bisect--helper: emit usage for "git bisect"
Date:   Fri,  4 Nov 2022 14:22:44 +0100
Message-Id: <patch-07.13-8a78b37dd56-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits we'll be removing "git-bisect.sh" in favor of
promoting "bisect--helper" to a "bisect" built-in.

In doing that we'll first need to have it support "git bisect--helper
<cmd>" rather than "git bisect--helper --<cmd>", and then finally have
its "-h" output claim to be "bisect" rather than "bisect--helper".

Instead of suffering that churn let's start claiming to be "git
bisect" now. In just a few commits this will be true, and in the
meantime emitting the "wrong" usage information from the helper is a
small price to pay to avoid the churn.

Let's also declare "BUILTIN_*" macros, when we eventually migrate the
sub-commands themselves to parse_options() we'll be able to re-use the
strings. See 0afd556b2e1 (worktree: define subcommand -h in terms of
command -h, 2022-10-13) for a recent example.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 51 ++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5c0572d0672..b10ecee64cc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,18 +20,40 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --bisect-reset [<commit>]"),
-	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
-	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	"git bisect--helper --bisect-next",
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
-	N_("git bisect--helper --bisect-replay <filename>"),
-	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	"git bisect--helper --bisect-visualize",
-	N_("git bisect--helper --bisect-run <cmd>..."),
+#define BUILTIN_GIT_BISECT_START_USAGE \
+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]" \
+	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
+	   "    [<pathspec>...]")
+#define BUILTIN_GIT_BISECT_STATE_USAGE \
+	N_("git bisect (good|bad) [<rev>...]")
+#define BUILTIN_GIT_BISECT_TERMS_USAGE \
+	"git bisect terms [--term-good | --term-bad]"
+#define BUILTIN_GIT_BISECT_SKIP_USAGE \
+	N_("git bisect skip [(<rev>|<range>)...]")
+#define BUILTIN_GIT_BISECT_NEXT_USAGE \
+	"git bisect next"
+#define BUILTIN_GIT_BISECT_RESET_USAGE \
+	N_("git bisect reset [<commit>]")
+#define BUILTIN_GIT_BISECT_VISUALIZE_USAGE \
+	"git bisect visualize"
+#define BUILTIN_GIT_BISECT_REPLAY_USAGE \
+	N_("git bisect replay <logfile>")
+#define BUILTIN_GIT_BISECT_LOG_USAGE \
+	"git bisect log"
+#define BUILTIN_GIT_BISECT_RUN_USAGE \
+	N_("git bisect run <cmd>...")
+
+static const char * const git_bisect_usage[] = {
+	BUILTIN_GIT_BISECT_START_USAGE,
+	BUILTIN_GIT_BISECT_STATE_USAGE,
+	BUILTIN_GIT_BISECT_TERMS_USAGE,
+	BUILTIN_GIT_BISECT_SKIP_USAGE,
+	BUILTIN_GIT_BISECT_NEXT_USAGE,
+	BUILTIN_GIT_BISECT_RESET_USAGE,
+	BUILTIN_GIT_BISECT_VISUALIZE_USAGE,
+	BUILTIN_GIT_BISECT_REPLAY_USAGE,
+	BUILTIN_GIT_BISECT_LOG_USAGE,
+	BUILTIN_GIT_BISECT_RUN_USAGE,
 	NULL
 };
 
@@ -1322,12 +1344,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
+	argc = parse_options(argc, argv, prefix, options, git_bisect_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (!cmdmode)
-		usage_with_options(git_bisect_helper_usage, options);
+		usage_with_options(git_bisect_usage, options);
 
 	switch (cmdmode) {
 	case BISECT_RESET:
-- 
2.38.0.1452.g710f45c7951

