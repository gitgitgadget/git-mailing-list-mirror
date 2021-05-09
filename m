Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57632C43460
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BD86140A
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhEIRNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIRNc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 13:13:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1151C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 10:12:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k19so12013698pfu.5
        for <git@vger.kernel.org>; Sun, 09 May 2021 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8iY5go8vQPeeCur26C/uXnuJ/W0z5Jvi2wjVCYgpSI=;
        b=QTOK4TUV2bZtYxAL3b/aCqTADgtE1y5LZQFbqt8+/1fv4OE/T8n1u/a1ZnYOeR6mrN
         jyOHAaoTzqrRYSkIEyjjHPQxNvuob7uDv3UAyjol2+rZ7mYCJMcRR1HsZ7ri2GuGxRM2
         K4W6Aiz5apD7DxrD5GNaDLQhYIuvPiA4OW9KfaST6P6W09Jx3H3fQJJaB1WOczNY68W7
         ppdpLRXegWhYq+UwC34rPd5+Q1mvt9g7ayNM2kzG2+x7Je0/PjteWb3XlVRDWBp/c+7O
         7LmLZw+kyPa2Uzbh3sFgBXEi3hL+jcWuYT8h5fZ2nrOIMZFHfUf+/8uVVHN9YcS4/jKi
         2Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8iY5go8vQPeeCur26C/uXnuJ/W0z5Jvi2wjVCYgpSI=;
        b=FNkqX9kiO3U3PNX/7VC7i8rvMYnEEGHrc3gnnCy2A06pfhghhIg2mIp/VleLWI3NLj
         U7N3ZJYQCVGRdkDGSTffrrShQjL9g9vNU7ZzcPRA8eVE2KWsN1fhoLNQUeOUMD9w8K97
         32ENpsFmoCryBtsCgXC9LJE1+SoO9ioI3/00L6Gxvq7Ld69BvMduZi21MgS3cGFNwr2N
         kXD7igy2GgtMbL9T44M3D2DVRzzRwf4d/B0yXboxN6hdOZjXt6k3Ua/OmbM9BYlY5Bqs
         8AUxhhYpiVj9PSV+dMCpaiqAmi1VOUnHPJDCv1MeKUXY6ixXMA6t5DALLR8fj2xPTsRh
         wRcg==
X-Gm-Message-State: AOAM530WCAOepDtGaZxqxGd2JZXvQEzGFHlXp9ESAfYWblPfhe2N4I1i
        GoyTcQpfScxsM2hSNGb34BCYpE0cacoE6Q==
X-Google-Smtp-Source: ABdhPJzC/Qt+CCZmCzplCbxQaXGD9RU8p5a35xczUlbFTf4eSd2KZSFq0Jhu1O1LiutK+prV3BExsA==
X-Received: by 2002:a63:1b5e:: with SMTP id b30mr20947363pgm.254.1620580347291;
        Sun, 09 May 2021 10:12:27 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l126sm9249374pga.41.2021.05.09.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:12:27 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 2/6] mailinfo: stop parsing options manually
Date:   Mon, 10 May 2021 00:12:09 +0700
Message-Id: <1fb08bb37dc534296b3bf89efc9bfaad67a9b068.1620580178.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620580178.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620580178.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, mailinfo will learn more options, let's switch to our
robust parse_options framework before that step.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/mailinfo.c | 75 +++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 77f96177cc..f55549a097 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -7,9 +7,13 @@
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
+#include "parse-options.h"
 
-static const char mailinfo_usage[] =
-	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
+static const char * const mailinfo_usage[] = {
+	/* TRANSLATORS: keep <> in "<" mail ">" info. */
+	N_("git mailinfo [<options>] <msg> <patch> < mail >info"),
+	NULL,
+};
 
 struct metainfo_charset
 {
@@ -21,6 +25,19 @@ struct metainfo_charset
 	const char *charset;
 };
 
+static int parse_opt_explicit_encoding(const struct option *opt,
+				       const char *arg, int unset)
+{
+	struct metainfo_charset *meta_charset = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	meta_charset->policy = CHARSET_EXPLICIT;
+	meta_charset->charset = arg;
+
+	return 0;
+}
+
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	struct metainfo_charset meta_charset;
@@ -28,36 +45,34 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	int status;
 	char *msgfile, *patchfile;
 
+	struct option options[] = {
+		OPT_BOOL('k', NULL, &mi.keep_subject, N_("keep subject")),
+		OPT_BOOL('b', NULL, &mi.keep_non_patch_brackets_in_subject,
+			 N_("keep non patch brackets in subject")),
+		OPT_BOOL('m', "message-id", &mi.add_message_id,
+			 N_("copy Message-ID to the end of commit message")),
+		OPT_SET_INT_F('u', NULL, &meta_charset.policy,
+			      N_("re-code metadata to i18n.commitEncoding"),
+			      CHARSET_DEFAULT, PARSE_OPT_NONEG),
+		OPT_SET_INT_F('n', NULL, &meta_charset.policy,
+			      N_("disable charset re-coding of metadata"),
+			      CHARSET_NO_REENCODE, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "encoding", &meta_charset, N_("encoding"),
+			       N_("re-code metadata to this encoding"),
+			       PARSE_OPT_NONEG, parse_opt_explicit_encoding),
+		OPT_BOOL(0, "scissors", &mi.use_scissors, N_("use scissors")),
+		OPT_HIDDEN_BOOL(0, "inbody-headers", &mi.use_inbody_headers,
+			 N_("use headers in message's body")),
+		OPT_END()
+	};
+
 	setup_mailinfo(&mi);
 	meta_charset.policy = CHARSET_DEFAULT;
 
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "-k"))
-			mi.keep_subject = 1;
-		else if (!strcmp(argv[1], "-b"))
-			mi.keep_non_patch_brackets_in_subject = 1;
-		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
-			mi.add_message_id = 1;
-		else if (!strcmp(argv[1], "-u"))
-			meta_charset.policy = CHARSET_DEFAULT;
-		else if (!strcmp(argv[1], "-n"))
-			meta_charset.policy = CHARSET_NO_REENCODE;
-		else if (starts_with(argv[1], "--encoding=")) {
-			meta_charset.policy = CHARSET_EXPLICIT;
-			meta_charset.charset = argv[1] + 11;
-		} else if (!strcmp(argv[1], "--scissors"))
-			mi.use_scissors = 1;
-		else if (!strcmp(argv[1], "--no-scissors"))
-			mi.use_scissors = 0;
-		else if (!strcmp(argv[1], "--no-inbody-headers"))
-			mi.use_inbody_headers = 0;
-		else
-			usage(mailinfo_usage);
-		argc--; argv++;
-	}
+	argc = parse_options(argc, argv, prefix, options, mailinfo_usage, 0);
 
-	if (argc != 3)
-		usage(mailinfo_usage);
+	if (argc != 2)
+		usage_with_options(mailinfo_usage, options);
 
 	switch (meta_charset.policy) {
 	case CHARSET_DEFAULT:
@@ -75,8 +90,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	mi.input = stdin;
 	mi.output = stdout;
 
-	msgfile = prefix_filename(prefix, argv[1]);
-	patchfile = prefix_filename(prefix, argv[2]);
+	msgfile = prefix_filename(prefix, argv[0]);
+	patchfile = prefix_filename(prefix, argv[1]);
 
 	status = !!mailinfo(&mi, msgfile, patchfile);
 	clear_mailinfo(&mi);
-- 
2.31.1.448.g9c2f8508d1

