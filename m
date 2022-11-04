Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiKDN0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiKDNZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463402FFCF
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n12so13174506eja.11
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4geern8MJmnZTElelnN4Ptyy/8ghPefoeqW4bFu5oQ=;
        b=j8fisUkvS2O6HLov+VASPBosoo0Qee6CuVYWFFxVemBtz8hMhq7O4YR02emRnmgGdY
         mXCXsFLz+RLoAe8lwYBns+dZRiSl4r9mYZCUB+tHf2kmFXQi+l9lK+YUMmWPSXLkWxig
         mdayfCE6g8twIqdOyFDQbZUTDAFzwC66H8KNhnlSkK3WliB8YwquewFeQ1hTKanGJLcI
         7l/qzFOep5dES8Xc7GVLR2dtMagWu89WEsTBptKshO1YJG3GSqNUTxxZsGWX3uwt2+b4
         THXeX1ThEd4g4C0m3WCrPirfFnebRtiqKj2dUSUt1WqEUHNGob9MR8f/vFsqetYKqjPy
         te/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4geern8MJmnZTElelnN4Ptyy/8ghPefoeqW4bFu5oQ=;
        b=REJgDqIsMMvcvfhc6Ex7SwRLvgXgX05R0TEx9XC7NvMD9wvudd5pXcrK0LBvTfexnR
         mFL0Jz8tEcxfcp8ejq3ZYktVIRmY9EgLp14xaidsSBXE1Op4NLCImixkLcgd9XVv2/JE
         aXX1ks532AA+JMvqqk26DbrKKLWDV8FwSoFuEzYPQ+zmQEOj4wbvOxyNq+sZQOjmxDCN
         DyWqv7DdteDmXzxdmbfBZIe9fqKi8oi4YyO0L4NHWIGSx3rfVu7hdpOD5VmIzLbxwZsG
         Yp3O52OEv/a7RF+KJ9POM7CM7zIRnnEQqYviDYFY6vYB/msiDmdDzrshEeVluVSexKVk
         /hOw==
X-Gm-Message-State: ACrzQf2EB73D8qbJBf4mpezOwsSwDBeNOBMae/AqvnGpOmyF0bruyvg2
        shf6UiMuF1V6syQOd57nWiVEa0F/WYUK6w==
X-Google-Smtp-Source: AMsMyM4HcJXj1nS5iM36/dYkYbybaH6SRf/6U2bNQF1eB+ljmDjrubnwyWsYYpA9+lS25waQtyCnVQ==
X-Received: by 2002:a17:906:fe0b:b0:787:f1d3:2105 with SMTP id wy11-20020a170906fe0b00b00787f1d32105mr34713641ejb.83.1667568300438;
        Fri, 04 Nov 2022 06:25:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:00 -0700 (PDT)
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
Subject: [PATCH 08/13] bisect--helper: have all functions take state, argc, argv, prefix
Date:   Fri,  4 Nov 2022 14:22:45 +0100
Message-Id: <patch-08.13-cccad790187-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to use the OPT_SUBCOMMAND() API in a subsequent commit give
all of the bisect_*() functions a consistent prototype we'll be able
to use.

The "prefix" parameter is only used by bisect_next(), bisect_log()
doesn't need any of them, etc. The UNUSED attribute helps us to sanity
check the current use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 70 ++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b10ecee64cc..32e427fa878 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -223,8 +223,10 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(struct bisect_terms *terms UNUSED, int argc, const char **argv,
+			const char *prefix UNUSED)
 {
+	const char *commit = argc ? argv[0] : NULL;
 	struct strbuf branch = STRBUF_INIT;
 
 	if (!commit) {
@@ -492,8 +494,10 @@ static int get_terms(struct bisect_terms *terms)
 	return res;
 }
 
-static int bisect_terms(struct bisect_terms *terms, const char *option)
+static int bisect_terms(struct bisect_terms *terms,  int argc, const char **argv,
+			const char *prefix UNUSED)
 {
+	const char *option = argc ? argv[0] : NULL;
 	if (get_terms(terms))
 		return error(_("no terms defined"));
 
@@ -646,7 +650,8 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static int bisect_next(struct bisect_terms *terms, int argc UNUSED,
+		       const char **argv UNUSED, const char *prefix)
 {
 	enum bisect_error res;
 
@@ -676,10 +681,11 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 		return BISECT_OK;
 	}
 
-	return bisect_next(terms, prefix);
+	return bisect_next(terms, 0, empty_strvec, prefix);
 }
 
-static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_start(struct bisect_terms *terms, int argc,
+			const char **argv, const char *prefix UNUSED)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
@@ -907,13 +913,13 @@ static int bisect_autostart(struct bisect_terms *terms)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(terms, empty_strvec, 0);
+		-1 : bisect_start(terms, 0, empty_strvec, NULL);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
-				      int argc)
+static int bisect_state(struct bisect_terms *terms, int argc,
+			const char **argv, const char *prefix UNUSED)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -993,7 +999,9 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	return bisect_auto_next(terms, NULL);
 }
 
-static enum bisect_error bisect_log(void)
+static int bisect_log(struct bisect_terms *terms UNUSED,
+		      int argc UNUSED, const char **argv UNUSED,
+		      const char *prefix UNUSED)
 {
 	int fd, status;
 	const char* filename = git_path_bisect_log();
@@ -1032,7 +1040,7 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(terms, argv.v, argv.nr);
+		res = bisect_start(terms, argv.nr, argv.v, NULL);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1045,7 +1053,7 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
+		res = bisect_terms(terms, argv.nr, argv.v, NULL);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1054,8 +1062,10 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	return -1;
 }
 
-static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *filename)
+static int bisect_replay(struct bisect_terms *terms, int argc UNUSED,
+			 const char **argv, const char *prefix UNUSED)
 {
+	const char *filename = argv[0];
 	FILE *fp = NULL;
 	enum bisect_error res = BISECT_OK;
 	struct strbuf line = STRBUF_INIT;
@@ -1063,7 +1073,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, 0, empty_strvec, NULL))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1082,7 +1092,9 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	return bisect_auto_next(terms, NULL);
 }
 
-static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_skip(struct bisect_terms *terms,  int argc,
+				     const char **argv,
+				     const char *prefix UNUSED)
 {
 	int i;
 	enum bisect_error res;
@@ -1112,13 +1124,14 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(terms, argv_state.v, argv_state.nr);
+	res = bisect_state(terms, argv_state.nr, argv_state.v, NULL);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_visualize(struct bisect_terms *terms, int argc,
+			    const char **argv, const char *prefix UNUSED)
 {
 	struct strvec args = STRVEC_INIT;
 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
@@ -1195,7 +1208,8 @@ static int verify_good(const struct bisect_terms *terms,
 	return rc;
 }
 
-static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_run(struct bisect_terms *terms,  int argc,
+		      const char **argv, const char *prefix UNUSED)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
@@ -1269,7 +1283,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(terms, &new_state, 1);
+		res = bisect_state(terms, 1, &new_state, NULL);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1354,53 +1368,53 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(&terms, argc, argv, prefix);
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+		res = bisect_terms(&terms, argc, argv, prefix);
 		break;
 	case BISECT_START:
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
+		res = bisect_start(&terms, argc, argv, prefix);
 		break;
 	case BISECT_NEXT:
 		if (argc)
 			return error(_("--bisect-next requires 0 arguments"));
 		get_terms(&terms);
-		res = bisect_next(&terms, prefix);
+		res = bisect_next(&terms, argc, argv, prefix);
 		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
+		res = bisect_state(&terms, argc, argv, prefix);
 		break;
 	case BISECT_LOG:
 		if (argc)
 			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
+		res = bisect_log(&terms, argc, argv, prefix);
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
 			return error(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argv[0]);
+		res = bisect_replay(&terms, argc, argv, prefix);
 		break;
 	case BISECT_SKIP:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
+		res = bisect_skip(&terms, argc, argv, prefix);
 		break;
 	case BISECT_VISUALIZE:
 		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
+		res = bisect_visualize(&terms, argc, argv, prefix);
 		break;
 	case BISECT_RUN:
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
+		res = bisect_run(&terms, argc, argv, prefix);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
-- 
2.38.0.1452.g710f45c7951

