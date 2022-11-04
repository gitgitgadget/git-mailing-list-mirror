Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15AC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiKDN0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiKDNZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA02F666
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r14so7591617edc.7
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tRUPQq5fXbEJ35r/Wk5OSA1xNtpfP5gm1R7gCHwtXE=;
        b=GA8OHgJb72vHG87QmGbjXrDXzagIMMHqsWM+7EuvJWb155wSCVur1+IMSPUxpnnRxa
         CW0S67Y5WlALwrmSDR6hMl8jvEwG0NPesSmHJGmxebzphoiyHXjbsdBblAFqWR1lQNWr
         skytF0N83QLcWhQQrqJhldcHY2Vb1XKy9owvqi41dobznPSolQ2TqtL47MYk7Hc8Vb0x
         kTqvbzzCu8kaTYRsqKnTO2IsexYD03VvLznQHL7ubXLsDYL0WUEHSZqcgbENp3YFNaPG
         RQuirhdngVG/Pe7UGg10X22LhKpGHzkk2gEKiB7wkFboxHtih0UUJlunhUs+jonaJQkF
         M4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tRUPQq5fXbEJ35r/Wk5OSA1xNtpfP5gm1R7gCHwtXE=;
        b=7Ti23va2ojI9r9ia88i6qf6ACTokAtfXe/Kn2CXeZXqP7vB7Vx6cLLeA7Jln3WGnCz
         qWMbcKQ2/UDkMid26tC5ykY/Am6HKHsF2AfFEBo2wbg7B6rLr1YVSpoNFu3iOM1wktSr
         JUWoxs3XDbpv/ctoSXDJfb4eMD3ocqr+zMOqZdXUa0R8PDvWiZVxpt2PJyr9H4o33re0
         Jq0vdDENPZSrFqpSj37Iw17vzaAuP2sWMyUXvvevxuDzDzo2BmHhB7au7aixLMfYOzbn
         jUAx7QWHYbr78kewAQRTM1okW5D9wsStUgZsgB4fOuGeHMf9E586A/U+dQzTHwj3Fln6
         c1eg==
X-Gm-Message-State: ACrzQf3R4FOS34L6gGvm3lG+sP5Zl90DaUAbgX+TK1tXMsGZa7cVdZDs
        rZlhS+bRcisNl6NPd5GCcAV1orVFAgKl4A==
X-Google-Smtp-Source: AMsMyM6bF1RIGycjeJuN+6y2dfAjhMf5XnUjOq/EW8UO73Uz9us46C47WvWaITQben5ouyGCbLLNTQ==
X-Received: by 2002:aa7:da0a:0:b0:461:135e:7298 with SMTP id r10-20020aa7da0a000000b00461135e7298mr35385210eds.242.1667568303346;
        Fri, 04 Nov 2022 06:25:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:02 -0700 (PDT)
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
Subject: [PATCH 11/13] bisect--helper: convert to OPT_SUBCOMMAND_CB()
Date:   Fri,  4 Nov 2022 14:22:48 +0100
Message-Id: <patch-11.13-d261c32ddd7-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the "bisect--helper" take arguments like "log" instead of "--log"
by using a new OPT_SUBCOMMAND_CB() variant of OPT_SUBCOMMAND(). As
discussed in a preceding commit this allows for using OPT_SUBCOMMAND()
with custom function signatures.

It would be nice to also convert all of the callbacks to use
parse_options(), [1] does. But due to using the new
OPT_SUBCOMMAND_CB() here we can punt on that for now.

Note that we're intentionally leaving the errors which mention
"--bisect-terms", as opposed to "terms". We've been showing that bad
usage information to users for a while now, and don't need to further
enlarge this change now by changing all of "--bisect-" to "" (which
also occurs outside of this context).

This finally fixes the last obscure regression in "git bisect run" in
v2.30.0. We'd previously addressed it eating the "--log" and
"--no-log" options, but d1bbbe45df8 (bisect--helper: reimplement
`bisect_run` shell function in C, 2021-09-13) also had us conflate the
internal-only "--bisect-*" options with user arguments.

1. https://lore.kernel.org/git/e97e187bbec93b47f35e3dd42b4831f1c1d8658d.1661885419.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c    | 110 ++++++++++++++----------------------
 git-bisect.sh               |  20 +++----
 parse-options.h             |   8 ++-
 t/t6030-bisect-porcelain.sh |   2 +-
 4 files changed, 59 insertions(+), 81 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e13c60d54b2..b62d3f4d418 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1314,107 +1314,79 @@ static int bisect_run(struct bisect_terms *terms,  int argc,
 	return res;
 }
 
+typedef int bisect_fn(struct bisect_terms *terms, int argc, const char **argv,
+		      const char *prefix);
+
+static int pick_subcommand_cb(const struct option *option,
+			      const char *arg UNUSED, int unset UNUSED)
+{
+	bisect_fn *fn = (bisect_fn *)option->defval;
+	*(bisect_fn **)option->value = fn;
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_RESET = 1,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_NEXT,
-		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
-		BISECT_SKIP,
-		BISECT_VISUALIZE,
-		BISECT_RUN,
-	} cmdmode = 0;
+	bisect_fn *fn = NULL;
 	int res = 0;
+#define OPT_BISECT_SUBCMD(l, v, fn) \
+	OPT_SUBCOMMAND_CB((l), (v), (fn), pick_subcommand_cb)
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
+		OPT_BISECT_SUBCMD("reset", &fn, bisect_reset),
+		OPT_BISECT_SUBCMD("terms", &fn, bisect_terms),
+		OPT_BISECT_SUBCMD("start", &fn, bisect_start),
+		OPT_BISECT_SUBCMD("next", &fn, bisect_next),
+		OPT_BISECT_SUBCMD("state", &fn, bisect_state),
+		OPT_BISECT_SUBCMD("log", &fn, bisect_log),
+		OPT_BISECT_SUBCMD("replay", &fn, bisect_replay),
+		OPT_BISECT_SUBCMD("skip", &fn, bisect_skip),
+		OPT_BISECT_SUBCMD("visualize", &fn, bisect_visualize),
+		OPT_BISECT_SUBCMD("run", &fn, bisect_run),
 		OPT_END()
 	};
+#undef OPT_BISECT_SUBCMD
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options, git_bisect_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     0);
 
-	if (!cmdmode)
-		usage_with_options(git_bisect_usage, options);
+	argc--;
+	argv++;
 
-	switch (cmdmode) {
-	case BISECT_RESET:
+	if (fn == bisect_reset) {
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(&terms, argc, argv, prefix);
-		break;
-	case BISECT_TERMS:
+	} else if (fn == bisect_terms) {
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc, argv, prefix);
-		break;
-	case BISECT_START:
+	} else if (fn == bisect_start) {
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argc, argv, prefix);
-		break;
-	case BISECT_NEXT:
+	} else if (fn == bisect_next) {
+		get_terms(&terms);
 		if (argc)
 			return error(_("--bisect-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_next(&terms, argc, argv, prefix);
-		break;
-	case BISECT_STATE:
+	} else if (fn == bisect_state) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		res = bisect_state(&terms, argc, argv, prefix);
-		break;
-	case BISECT_LOG:
+	} else if (fn == bisect_log) {
 		if (argc)
 			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log(&terms, argc, argv, prefix);
-		break;
-	case BISECT_REPLAY:
+	} else if (fn == bisect_replay) {
 		if (argc != 1)
 			return error(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argc, argv, prefix);
-		break;
-	case BISECT_SKIP:
+	} else if (fn == bisect_skip) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		res = bisect_skip(&terms, argc, argv, prefix);
-		break;
-	case BISECT_VISUALIZE:
+	} else if (fn == bisect_visualize) {
 		get_terms(&terms);
-		res = bisect_visualize(&terms, argc, argv, prefix);
-		break;
-	case BISECT_RUN:
+	} else if (fn == bisect_run) {
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms(&terms);
-		res = bisect_run(&terms, argc, argv, prefix);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
 	}
+
+	res = fn(&terms, argc, argv, prefix);
 	free_terms(&terms);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a3..e19847eba0d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -58,26 +58,26 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		git bisect--helper --bisect-start "$@" ;;
+		git bisect--helper start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
+		git bisect--helper state "$cmd" "$@" ;;
 	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
+		git bisect--helper skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
+		git bisect--helper next "$@" || exit ;;
 	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
+		git bisect--helper visualize "$@" || exit;;
 	reset)
-		git bisect--helper --bisect-reset "$@" ;;
+		git bisect--helper reset "$@" ;;
 	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
+		git bisect--helper replay "$@" || exit;;
 	log)
-		git bisect--helper --bisect-log || exit ;;
+		git bisect--helper log || exit ;;
 	run)
-		git bisect--helper --bisect-run "$@" || exit;;
+		git bisect--helper run "$@" || exit;;
 	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
+		git bisect--helper terms "$@" || exit;;
 	*)
 		usage ;;
 	esac
diff --git a/parse-options.h b/parse-options.h
index 61e3016c3fc..4e32b557174 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,10 +237,16 @@ static inline int parse_options_pick_subcommand_cb(const struct option *option,
 	.value = (v), \
 	.flags = (f), \
 	.defval = (intptr_t)(fn), \
-	.subcommand_fn = (fn), \
 	.callback = parse_options_pick_subcommand_cb, \
 }
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
+#define OPT_SUBCOMMAND_CB(l, v, fn, cb) { \
+	.type = OPTION_SUBCOMMAND, \
+	.long_name = (l), \
+	.value = (v), \
+	.defval = (intptr_t)(fn), \
+	.callback = (cb), \
+}
 
 /*
  * parse_options() will filter out the processed options and leave the
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index eace0af637e..de47c87a6ff 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -350,7 +350,7 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
 	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--bisect-start>
 	EOF_ARGS
-- 
2.38.0.1452.g710f45c7951

