Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593DCC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLOJLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLOJLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618302AE1E
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so2311407wrz.12
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRyxpIWW+z3OydWyjnLV2szstKc/52/russrvwVr2S0=;
        b=ZzlqKc7GLMQNRaIUmJEa2QC9+kQXkqJoqTNVdog2rFnU57e1NNBuEovHjmT/Sp/FUY
         MVBrKM0ifCBmWfEJi0gjtC5jv9rAtN51olfvmE6k05vqmoPE7Hrs750rL8Ojju7bdAqT
         skCnQ9e1xLqRWKnubU9MNwV5E2l/QSW/etabOTaIchyzoJdMqeTRSgP+H0rfHufEt+6I
         1Zl5KTC7MRTrB2RfbpJXxLGtiZUMtq1KUf4XuUVfKsFF35QXKGQFL2/aIUe1jAyKs1rR
         TdPf5FoH890XMA7YyEKiQa8EGq6j9MvC8rIs6q/C36Roynl6gSQETuKK/Q0jpSRqyqoJ
         WvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRyxpIWW+z3OydWyjnLV2szstKc/52/russrvwVr2S0=;
        b=B/2K/iMLoVE6l3BJD8oLZf3OwYf4BCV1KZvGLHKDhctNQB9OIALe2832uSNdfdEqvc
         vw3q+yOt/hMoFcaOineb3Wmkt9JUFpcB8SF3M8d9e1bDnTA/LOMRvYvGEtmhnMGvUbUJ
         uHYAzXA2g4n0VkK5rtaImAW4znG/7Qapn2PPVR332wpvCz8isHXpv34dgJdaaTUZGiLs
         VsO0OIYDwmNi6v4MvYpcLad5VVtaBfDwz9hA8512wGSox0RGBeTnYL3Nx+SkHHrViyj8
         SCl+HXa2LaGjQYROKKqCk4x8P7ghnQDBU7+Tg5XOPWZ+dB4V5nnSFh+CZKUpX9cpmv+C
         t79g==
X-Gm-Message-State: ANoB5plQS9W/+hmfrHljABS+z7tbmqHxTxXrk6B4buG/tMnqznVK+zhB
        URi7CtYFdjTvmLXZACUbameSChAN/sbjHw==
X-Google-Smtp-Source: AA0mqf5aFL0sNolYSwfuQSjlo2E2hkFXCZkg2rBYFNyb8djGTQk+uSJO4zGSTWx+Gg9O/qAsklWPEA==
X-Received: by 2002:a5d:4578:0:b0:242:7248:fbe with SMTP id a24-20020a5d4578000000b0024272480fbemr19145680wrc.25.1671095482645;
        Thu, 15 Dec 2022 01:11:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 5/5] strvec API users: fix more leaks by using "STRVEC_INIT_NODUP"
Date:   Thu, 15 Dec 2022 10:11:11 +0100
Message-Id: <RFC-patch-5.5-81742a8a6ed-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com> <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For these cases where most of the the strings we were pushing to the
"struct strvec" were fixed strings, but others are dynamically
allocated. For the latter we keep around a "to_free" list of them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/describe.c       | 22 +++++++++++++++++-----
 builtin/upload-archive.c |  9 +++++++--
 t/t5003-archive-zip.sh   |  1 +
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index cb205f6b561..eda59ebb19a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -596,8 +596,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "--long", "--abbrev=0");
 
 	if (contains) {
+		struct string_list to_free = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
-		struct strvec args = STRVEC_INIT;
+		struct strvec args = STRVEC_INIT_NODUP;
+
 		int ret;
 
 		strvec_pushl(&args, "name-rev",
@@ -607,10 +609,19 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_push(&args, "--always");
 		if (!all) {
 			strvec_push(&args, "--tags");
-			for_each_string_list_item(item, &patterns)
-				strvec_pushf(&args, "--refs=refs/tags/%s", item->string);
-			for_each_string_list_item(item, &exclude_patterns)
-				strvec_pushf(&args, "--exclude=refs/tags/%s", item->string);
+			for_each_string_list_item(item, &patterns) {
+				char *str = xstrfmt("--refs=refs/tags/%s", item->string);
+				const char *item = string_list_append_nodup(&to_free, str)->string;
+
+				strvec_push(&args, item);
+			}
+			for_each_string_list_item(item, &exclude_patterns) {
+				char *str = xstrfmt("--exclude=refs/tags/%s", item->string);
+
+				const char *item = string_list_append_nodup(&to_free, str)->string;
+
+				strvec_push(&args, item);
+			}
 		}
 		if (argc)
 			strvec_pushv(&args, argv);
@@ -618,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_push(&args, "HEAD");
 		ret = cmd_name_rev(args.nr, args.v, prefix);
 		strvec_clear(&args);
+		string_list_clear(&to_free, 0);
 		return ret;
 	}
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 6ef0d06ee8b..95c6cdc4be0 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -19,7 +19,8 @@ static const char deadchild[] =
 
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
-	struct strvec sent_argv = STRVEC_INIT;
+	struct string_list to_free = STRING_LIST_INIT_DUP;
+	struct strvec sent_argv = STRVEC_INIT_NODUP;
 	const char *arg_cmd = "argument ";
 	int ret;
 
@@ -34,6 +35,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	/* put received options in sent_argv[] */
 	strvec_push(&sent_argv, "git-upload-archive");
 	for (;;) {
+		struct string_list_item *item;
 		char *buf = packet_read_line(0, NULL);
 		if (!buf)
 			break;	/* got a flush */
@@ -42,13 +44,16 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 
 		if (!starts_with(buf, arg_cmd))
 			die("'argument' token or flush expected");
-		strvec_push(&sent_argv, buf + strlen(arg_cmd));
+
+		item = string_list_append(&to_free, buf + strlen(arg_cmd));
+		strvec_push(&sent_argv, item->string);
 	}
 
 	/* parse all options sent by the client */
 	ret = write_archive(sent_argv.nr, sent_argv.v, prefix,
 			    the_repository, NULL, 1);
 	strvec_clear(&sent_argv);
+	string_list_clear(&to_free, 0);
 	return ret;
 }
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index fc499cdff01..cc1ce060558 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -2,6 +2,7 @@
 
 test_description='git archive --format=zip test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
-- 
2.39.0.rc2.1048.g0e5493b8d5b

