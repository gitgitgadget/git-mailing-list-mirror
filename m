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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0832C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6174D611AE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhEFPDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhEFPDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD1C061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so2980072pjk.0
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPH7IdtULgQg+NKaPXCW3Vke2Zi7jCGJukF3N6k4JoU=;
        b=IE5NPSEGIxgep3UJyKO7S0aGlfc+RpyeD0mljBOwC3VUUl3irk+Ea9gqnZa/9WKE8A
         5lPBolKbaj1zGuIb56OXhjHe2GZOWIL6t0ofamxLwz3qJvKNFsfOrotAFzCinOgDFNIP
         S//M0WqbwpYUt06wf6RZaWWff7vWKldTzLdhwTaHlG2yQjQYnubcKGn3oVBJfD2zXUbg
         e7B0ZJqimyNZk09J67zl485tdL4CvFa+ZXw8HaG2TeHIrcH3DK+SzXLiTi/r8j+/tldz
         fF2rFcxsnx5bsBUdBxyKBm9tjzbq8OEc8q2M+IivY7kCbC1vVQDZ7xCAC2aIeSb6GKzF
         j28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPH7IdtULgQg+NKaPXCW3Vke2Zi7jCGJukF3N6k4JoU=;
        b=FpEh5GPHjaTTNHs0gZ29MnZlLbAL0cEnGCKAgNvgElITuNTAFS/9F1xCrYwVpvIIrw
         YSW/Wbf60ovZR2kgi74AqXy0Dy/bLsqhFzt0qDTyZqxInSl/SkI6ns1sQr/Qrx+9UOA/
         YHM2FqnytzkHwFnAmRDAyIT4kiUWpGN/50tx7M0gVD49COzzlVaAPQRFSJE92GDqJ+vY
         5v7OQ2hZPnbz97CrQZgZqy+mksLLjksRWEsekpTEKQH0ndkerbyGf6jw7n1UeARqMDcd
         NpS0MNgFd7UTF0MTpndSYIm1nJpIHgZY1Vv3O0GDBWPAUNvF3x+FdMsixuW0+w4EdY4r
         xRew==
X-Gm-Message-State: AOAM530srocqQGcrD4tF4TQ5yq4UTSyCuXnUSMwVN8BiVD7InUx7LoBE
        Evj8eUTb9A4dUPvUzE7Avy5yXMxUAlYxCA==
X-Google-Smtp-Source: ABdhPJyIydXmCuemqiQ2vBnfqLPW0X6OGyBO2gxjO8g+QUmaFPmKlIe3ZC4qVEtv9+Lcyhh4kkF55Q==
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id 4-20020a1709020004b02900ee8f40ecbfmr5053771pla.28.1620313357841;
        Thu, 06 May 2021 08:02:37 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/6] mailinfo: stop parse options manually
Date:   Thu,  6 May 2021 22:02:19 +0700
Message-Id: <ba8ac434189ce91314562d93004b2d2b37fe6868.1620309355.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620309355.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620309355.git.congdanhqx@gmail.com>
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
 builtin/mailinfo.c | 87 +++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 71e74bcdcb..a14232a437 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -7,20 +7,37 @@
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
 	enum {
 		CHARSET_DEFAULT,
-		CHARSET_NONE,
+		CHARSET_NO_REENCODE,
 		CHARSET_EXPLICIT,
-	} from;
+	} origin;
 	const char *charset;
 };
 
+static int parse_opt_explicit_encoding(const struct option *opt,
+				       const char *arg, int unset)
+{
+	struct metainfo_charset *meta_charset = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	meta_charset->origin = CHARSET_EXPLICIT;
+	meta_charset->charset = arg;
+
+	return 0;
+}
+
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	struct metainfo_charset meta_charset;
@@ -28,42 +45,40 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	int status;
 	char *msgfile, *patchfile;
 
+	struct option options[] = {
+		OPT_BOOL('k', NULL, &mi.keep_subject, N_("keep subject")),
+		OPT_BOOL('b', NULL, &mi.keep_non_patch_brackets_in_subject,
+			 N_("keep non patch brackets in subject")),
+		OPT_BOOL('m', "message-id", &mi.add_message_id,
+			 N_("copy Message-ID to the end of commit message")),
+		OPT_SET_INT_F('u', NULL, &meta_charset.origin,
+			      N_("re-code metadata to i18n.commitEncoding"),
+			      CHARSET_DEFAULT, PARSE_OPT_NONEG),
+		OPT_SET_INT_F('n', NULL, &meta_charset.origin,
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
-	meta_charset.from = CHARSET_DEFAULT;
-
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "-k"))
-			mi.keep_subject = 1;
-		else if (!strcmp(argv[1], "-b"))
-			mi.keep_non_patch_brackets_in_subject = 1;
-		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
-			mi.add_message_id = 1;
-		else if (!strcmp(argv[1], "-u"))
-			meta_charset.from = CHARSET_DEFAULT;
-		else if (!strcmp(argv[1], "-n"))
-			meta_charset.from = CHARSET_NONE;
-		else if (starts_with(argv[1], "--encoding=")) {
-			meta_charset.from = CHARSET_EXPLICIT;
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
+	meta_charset.origin = CHARSET_DEFAULT;
+
+	argc = parse_options(argc, argv, prefix, options, mailinfo_usage, 0);
 
-	if (argc != 3)
-		usage(mailinfo_usage);
+	if (argc != 2)
+		usage_with_options(mailinfo_usage, options);
 
-	switch (meta_charset.from) {
+	switch (meta_charset.origin) {
 	case CHARSET_DEFAULT:
 		mi.metainfo_charset = get_commit_output_encoding();
 		break;
-	case CHARSET_NONE:
+	case CHARSET_NO_REENCODE:
 		mi.metainfo_charset = NULL;
 		break;
 	case CHARSET_EXPLICIT:
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
2.31.1.500.gbc6bbdd36b

