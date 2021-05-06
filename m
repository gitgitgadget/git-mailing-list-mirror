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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC6C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492DE61176
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhEFPDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhEFPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C4C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x188so5330428pfd.7
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8BP0qExcG0FrEfDfLsQkmEa/B5z6sIKx/Gs9+7DUi4=;
        b=Ujwk1AaS7mDAEDEh5UJH69TTBQBoQ/noskSCWvNOl7B7T6QNgozB809IxyAwFNfoIM
         WdaLL5+v3ARkKffLVs22yD7khEnmxj4pQbHNYNX4fekTszSis+VogCVmrYKd4IiGZG/E
         ko8njWwRtskp3oWMUwLlnzgix6W5/YC9LRWG+FJJVx1JDwydVB+JmpS3fybAGfoEovxY
         +xWny1udb21edLD/VU6IqOgo1K4NCEl6wd/I5XI8LgZvBUfqL3Nrhmzt9J+6aVGaVmq2
         ww4QL8Agr2naXPu5HTn673q5JoDKXCZT80xmn+dU0wwgjH8/dSdVI+2VbFOc0ch+EaMZ
         74XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8BP0qExcG0FrEfDfLsQkmEa/B5z6sIKx/Gs9+7DUi4=;
        b=CYvvpODogRtFIdCScaselJy2ds6Tlfk17fBEy25q94iKzDRP+Lmj8GUjvX3SPD4i21
         kiLFV2aqXkJiNUAfTP/pvgHb780LjCNzkHhl6Sn5cjl5FzHWD9rb6QFE/VmZuPy7doX+
         +HSyRVhJgt80gxT4VWHR9UL98NJPp5ngwXq7j2rdl6TLt6AHTGcPOHCmIq7qkhnr/eyV
         mZdD7ZR/k1izAsOkHLaodFdDtSvF0VaXSg7+iErPNtG5AJHed+766R1QXmW6Nf1E/p99
         w3bTTp+E9C84gpVf4TtTGRsXGSdq1+Uy1KWqxTS7BM5lsNWzAfYzkPKs6yE8zojIKkez
         fR8A==
X-Gm-Message-State: AOAM5307mabuIWhnonXTRbXlzsSKIK7NpHgpoC/BHC/e5v2Q87XnG4zq
        5j+F/ED0rOe2Xvkn05kTfCRNNEEanGxUWQ==
X-Google-Smtp-Source: ABdhPJyX8jdWUEowlJ7uLjSMoc1Chvs5ocrjCOk5peN6FsFl8tZP+h4J0i1RYtAhgDwT58/+YUuYIg==
X-Received: by 2002:a62:8208:0:b029:289:112f:d43d with SMTP id w8-20020a6282080000b0290289112fd43dmr4876345pfd.61.1620313355715;
        Thu, 06 May 2021 08:02:35 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:35 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/6] mailinfo: load default metainfo_charset lazily
Date:   Thu,  6 May 2021 22:02:18 +0700
Message-Id: <fac95392df0b1428c32874a1faff0c86d58af0bb.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we will use parse_option to parse mailinfo's options.
In mailinfo, both "-u", "-n", and "--encoding" try to set the same
field, with "-u" reset that field to some default value from
configuration variable "i18n.commitEncoding".

Let's delay the setting of that field until we finish processing all
options. By doing that, "i18n.commitEncoding" can be parsed on demand.
More importantly, it cleans the way for using parse_option.

This change introduces some inconsistent brackets "{}" in "if/else if"
construct, however, we will rewrite them in the next few changes.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/mailinfo.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cfb667a594..77f96177cc 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -11,17 +11,25 @@
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
+struct metainfo_charset
+{
+	enum {
+		CHARSET_DEFAULT,
+		CHARSET_NO_REENCODE,
+		CHARSET_EXPLICIT,
+	} policy;
+	const char *charset;
+};
+
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
-	const char *def_charset;
+	struct metainfo_charset meta_charset;
 	struct mailinfo mi;
 	int status;
 	char *msgfile, *patchfile;
 
 	setup_mailinfo(&mi);
-
-	def_charset = get_commit_output_encoding();
-	mi.metainfo_charset = def_charset;
+	meta_charset.policy = CHARSET_DEFAULT;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
@@ -31,12 +39,13 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
 			mi.add_message_id = 1;
 		else if (!strcmp(argv[1], "-u"))
-			mi.metainfo_charset = def_charset;
+			meta_charset.policy = CHARSET_DEFAULT;
 		else if (!strcmp(argv[1], "-n"))
-			mi.metainfo_charset = NULL;
-		else if (starts_with(argv[1], "--encoding="))
-			mi.metainfo_charset = argv[1] + 11;
-		else if (!strcmp(argv[1], "--scissors"))
+			meta_charset.policy = CHARSET_NO_REENCODE;
+		else if (starts_with(argv[1], "--encoding=")) {
+			meta_charset.policy = CHARSET_EXPLICIT;
+			meta_charset.charset = argv[1] + 11;
+		} else if (!strcmp(argv[1], "--scissors"))
 			mi.use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
 			mi.use_scissors = 0;
@@ -50,6 +59,19 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage(mailinfo_usage);
 
+	switch (meta_charset.policy) {
+	case CHARSET_DEFAULT:
+		mi.metainfo_charset = get_commit_output_encoding();
+		break;
+	case CHARSET_NO_REENCODE:
+		mi.metainfo_charset = NULL;
+		break;
+	case CHARSET_EXPLICIT:
+		break;
+	default:
+		BUG("invalid meta_charset.policy");
+	}
+
 	mi.input = stdin;
 	mi.output = stdout;
 
-- 
2.31.1.448.g9c2f8508d1

