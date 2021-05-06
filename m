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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9738CC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731AB611AE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhEFPDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhEFPDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553DC0613ED
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v20so3531708plo.10
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8iY5go8vQPeeCur26C/uXnuJ/W0z5Jvi2wjVCYgpSI=;
        b=dMvvCpAsfom5E8uGzNgN1ubJ/Vth3oAjsQTBmEDv0U46S958xUCa6fGG3zlppmH2mD
         BUIIrEaPryN2Ki5mTs8l8L7FscoEJRNf8qD6VWkjSeLyBLBzbc+0Dfxm72RlVO7/B0OC
         WmNOIEZfWjNu2LOhiZafbWRiyO0i+mKD1v4L1dYGRBOsUdD21gAfs0OerA5zzSi4WjOF
         IM9pzP8z8JCY8j7IeOJ4APsI3ozMXQrfYsaxa0TLFrdq3UgOTjBHk+OCtxMdjcEvs7dw
         W60rS0Oi25qTtT/cLYuuwlF9WEaJBnSbInT2HjlwsC62tQi5/t6svr6B1xS8xA2WMnMA
         t5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8iY5go8vQPeeCur26C/uXnuJ/W0z5Jvi2wjVCYgpSI=;
        b=QotQXIJnzsyWYE2LxU8zxJOXok+VX/Me69hD7cq7lhLPGLtQI0nUQBVtyysoZGzdsj
         mFFRcqfnKSL3xmrlut3eJmE9FYATM/QPRWjRdEB7qG3FXaad32tf8cKBsp/+w/fgQb7U
         jkVI4WWGRzrk1QaDoAuq0wHjz0FiZdMOjTgt1j6tovMMQqXMnwNO6US7oZ4gjPhC2KUh
         XqPH5yoEur65XzKVNKwmcnhTl/e4ZixkZWb0EZGRkZ0zoQm89SpQF5L84Wm5p8Srm2JB
         p4UGwg0JAB2X27NVHnfhRxefzGp/vgLpKnHbXq2rpEfAqJg1KM8WpPjDDC2pIQDLXA5z
         07dg==
X-Gm-Message-State: AOAM532/ZiGu34kN5AB4etPxl1vbHVZB8c9QCGzIKwk+HM9VOr/7bgF2
        M+QiMEBN5ssSrCFPthtXtg9d54ms91oaoQ==
X-Google-Smtp-Source: ABdhPJzGjk5MdyeIm5VjBifFpua/UXZP5yJesdyis4NN6ZdWvdzgP/J6tsawH7uw6ZiYdVgnuvOvpg==
X-Received: by 2002:a17:902:a614:b029:ed:3d5f:768 with SMTP id u20-20020a170902a614b02900ed3d5f0768mr5042242plq.18.1620313359601;
        Thu, 06 May 2021 08:02:39 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/6] mailinfo: stop parsing options manually
Date:   Thu,  6 May 2021 22:02:20 +0700
Message-Id: <1fb08bb37dc534296b3bf89efc9bfaad67a9b068.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
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

