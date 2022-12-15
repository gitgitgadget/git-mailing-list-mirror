Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4308C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLOJtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLOJsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FB1A210
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i15so26259964edf.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g14qzqOQmrzhPKkA+Q/2ZjyiCJPPVSjgnglTNRfBbQ=;
        b=j8lpTGNezTq2hl8559lT5gq+WBl2mu7BUPxpvUQX4DdC24nDWBxsKcaCdrdTUEJkQW
         tiRQ7h2AxEG2c3bw5lsDVFuvd10DnSWCP3Q1YVV4auTFFDJ5sr8x1PxPBBddeQGWvUiV
         bV1igD05uEuKkzNV9tuDAf7cqNmJcaGz7/jo1TypNbQPtdOiMLvqSkb2u/Y0buRowX/q
         j0x/AEx8ZgmYBbJqUU714LgEdXGsyU/hqMHtVIRIxWfzTp2k9cS8hnLe4lw8DKg70sQG
         zg673gDpiqD58xr4fl0Uv7zKgV/BHGK+ERttMwn4JcxK83xWuNPBBe92KvrW5xSNREbG
         x8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g14qzqOQmrzhPKkA+Q/2ZjyiCJPPVSjgnglTNRfBbQ=;
        b=dXZv+iIPqIYFUHubc+errYCbFk05t2f/sE/pEgblWe9xVAqty2stWHraTyZencvByu
         TsfeLRCxD0+mGihxHDTFe2iBybAa2epHWpqdFNw/7qpysgdorWmGQnA5K+xLa4UuBi7X
         mnxRV9HMn5Aycd0VV2zCbZlYttTitMYejSjOs4r+b7ePDu1Ps7qYHyyd+NPDYydvioen
         UrN2uHBBODp7BhzYXsUgH5aXe+/9Q5gVQ8YkylJvgSkiao6TD2UxWS9vi0QllwGMo5Tr
         vfxu05LLRpgEUlesUSwibyA5ryamzT8sKu1G9/986Vy+ltDRucEdl95d3nQK+wcdHmmp
         gB+w==
X-Gm-Message-State: AFqh2kpVTwxz9EPTqg71+sMfpatm2XxuX++UmAoziYU8908euFd9oK1m
        +9+2nklJBOqCJDSxQoxKrbGQ1FJcEXBE6A==
X-Google-Smtp-Source: AMrXdXszuI8UBpDwaiU7mY5z2eRibIdDR5ICa6JEQ40mhjhyTebJgM3onKlTt5B1ySJ082TcQn3zOg==
X-Received: by 2002:aa7:d384:0:b0:472:7c75:832 with SMTP id x4-20020aa7d384000000b004727c750832mr4710708edq.16.1671097674724;
        Thu, 15 Dec 2022 01:47:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/6] bisect--helper: make the order consistently `argc, argv`
Date:   Thu, 15 Dec 2022 10:47:45 +0100
Message-Id: <patch-2.6-a0de7ad6836-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In C, the natural order is for `argc` to come before `argv` by virtue of
the `main()` function declaring the parameters in precisely that order.

It is confusing & distracting, then, when readers familiar with the C
language read code where that order is switched around.

Let's just change the order and avoid that type of developer friction.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 09505fc4dce..9fc8db06944 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -678,7 +678,8 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
-static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
+				      const char **argv)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
@@ -908,13 +909,13 @@ static int bisect_autostart(struct bisect_terms *terms)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(terms, empty_strvec, 0);
+		-1 : bisect_start(terms, 0, empty_strvec);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
-				      int argc)
+static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
+				      const char **argv)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -1033,7 +1034,7 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(terms, argv.v, argv.nr);
+		res = bisect_start(terms, argv.nr, argv.v);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1083,7 +1084,8 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	return bisect_auto_next(terms, NULL);
 }
 
-static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
+				     const char **argv)
 {
 	int i;
 	enum bisect_error res;
@@ -1113,13 +1115,14 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(terms, argv_state.v, argv_state.nr);
+	res = bisect_state(terms, argv_state.nr, argv_state.v);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_visualize(struct bisect_terms *terms, int argc,
+			    const char **argv)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -1202,7 +1205,7 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	return rc;
 }
 
-static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
@@ -1271,7 +1274,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(terms, &new_state, 1);
+		res = bisect_state(terms, 1, &new_state);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1328,7 +1331,7 @@ static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNU
 	struct bisect_terms terms = { 0 };
 
 	set_terms(&terms, "bad", "good");
-	res = bisect_start(&terms, argv, argc);
+	res = bisect_start(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
 }
@@ -1372,7 +1375,7 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 
 	set_terms(&terms, "bad", "good");
 	get_terms(&terms);
-	res = bisect_skip(&terms, argv, argc);
+	res = bisect_skip(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
 }
@@ -1383,7 +1386,7 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	struct bisect_terms terms = { 0 };
 
 	get_terms(&terms);
-	res = bisect_visualize(&terms, argv, argc);
+	res = bisect_visualize(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
 }
@@ -1396,7 +1399,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	if (!argc)
 		return error(_("'%s' failed: no command provided."), "git bisect run");
 	get_terms(&terms);
-	res = bisect_run(&terms, argv, argc);
+	res = bisect_run(&terms, argc, argv);
 	free_terms(&terms);
 	return res;
 }
@@ -1432,7 +1435,7 @@ int cmd_bisect(int argc, const char **argv, const char *prefix)
 		if (check_and_set_terms(&terms, argv[0]))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
 				       options, argv[0]);
-		res = bisect_state(&terms, argv, argc);
+		res = bisect_state(&terms, argc, argv);
 		free_terms(&terms);
 	} else {
 		argc--;
-- 
2.39.0.rc2.1048.g0e5493b8d5b

