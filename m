Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B065C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD65E206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaB41Hmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHEVwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgHEVv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA0C06179F
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7093753wmg.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H7l2w2s3HhCb+5oejFFtuQYCJu1bxocpCZKJxQqgaLA=;
        b=LaB41Hmg4JKLn7V6qgGLqVRbsKSnyJVJ/brpDFxacAEPcYnZ9neydxArXqeve9JKgQ
         lJz8VbL6/ARaOtkqVMS8oAxBRTj9d8a4lpPAXb0ulOsQJEK0RlX+3j8TWumjZXX1mcdT
         faYsSgnv/InDe5AYArSrC51lll7sxv4+XyFyfpcHPwAcGzlnU2B3n5/lEdmdPN+cr/oY
         y/F6pCpOU0qbYfsju8yAHLHFvMw8lmI7F1bGm5rkf3HCfTEVhitCtkoO2deFjxcwAihZ
         urDxrfLtLGBBj5D/eYRiJfI017ylw6682VFXbSm4oDyyGfj56WISXVak29QsHM0vvAwn
         CeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H7l2w2s3HhCb+5oejFFtuQYCJu1bxocpCZKJxQqgaLA=;
        b=JeFsrmUG1NkpbZi51ScHz8AUAe0mag++t9GVFyePCXXU1dIi5WnfMzLi7CJhGi/J9W
         Ej/xChU9Vjcr6h1Z62WTFYu12Z6Q42eH43imwgrxw26J9KyT5UeRA7bBrFy58WMnHMvy
         h/xfJjumInBzaxIgd8NpoZcbUjMm32pBLsMWjYZvepxMDSfwlX+z9fSkL1nwEncP7WcA
         X0PJTXqE3qKBsR6WLhvvVZ6z7pj9kJOr0IQrhfwrdLkmjb6tjUT7iBsmiPfoHC/aGfdn
         reyeOaPjgnHt348ulKKtGMyKFvJqsaCWAOjPGga7eGpCAkuFhWRjT6rtnF9Tta8gedPn
         xPKw==
X-Gm-Message-State: AOAM530D++hrKHXGrP9PoMQ2hU/ZgCi9nhGrH+dCuGcrOdn8dyoPdG6a
        46wvhJUZx8ff5q3h8FCca+BiYZy0
X-Google-Smtp-Source: ABdhPJyA3SOtC4wZlkYK14pnCMVfIQJicN0nbD1heAHgOGbayOT1BZP85CUA48IwYggZEPx7+fw+QQ==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr5330322wmk.17.1596664315348;
        Wed, 05 Aug 2020 14:51:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm4389642wru.27.2020.08.05.14.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:55 -0700 (PDT)
Message-Id: <1c43f55d7c1d5a16031115d5de56b5a5302b5597.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:44 +0000
Subject: [PATCH v2 8/9] format-support: move `format_sanitized_subject()` from
 pretty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

In hope of some new features in `subject` atom, move funtion
`format_sanitized_subject()` and all the function it uses
to new file format-support.{c,h}.

Consider this new file as a common interface between functions that
pretty.c and ref-filter.c shares.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Makefile         |  1 +
 format-support.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 format-support.h |  6 ++++++
 pretty.c         | 40 +---------------------------------------
 4 files changed, 51 insertions(+), 39 deletions(-)
 create mode 100644 format-support.c
 create mode 100644 format-support.h

diff --git a/Makefile b/Makefile
index 372139f1f2..4dfc384b49 100644
--- a/Makefile
+++ b/Makefile
@@ -882,6 +882,7 @@ LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
+LIB_OBJS += format-support.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += gettext.o
diff --git a/format-support.c b/format-support.c
new file mode 100644
index 0000000000..d693aa1744
--- /dev/null
+++ b/format-support.c
@@ -0,0 +1,43 @@
+#include "diff.h"
+#include "log-tree.h"
+#include "color.h"
+#include "format-support.h"
+
+static int istitlechar(char c)
+{
+	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
+		(c >= '0' && c <= '9') || c == '.' || c == '_';
+}
+
+void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
+{
+	char *r = xmemdupz(msg, len);
+	size_t trimlen;
+	size_t start_len = sb->len;
+	int space = 2;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (r[i] == '\n')
+			r[i] = ' ';
+		if (istitlechar(r[i])) {
+			if (space == 1)
+				strbuf_addch(sb, '-');
+			space = 0;
+			strbuf_addch(sb, r[i]);
+			if (r[i] == '.')
+				while (r[i+1] == '.')
+					i++;
+		} else
+			space |= 1;
+	}
+	free(r);
+
+	/* trim any trailing '.' or '-' characters */
+	trimlen = 0;
+	while (sb->len - trimlen > start_len &&
+		(sb->buf[sb->len - 1 - trimlen] == '.'
+		|| sb->buf[sb->len - 1 - trimlen] == '-'))
+		trimlen++;
+	strbuf_remove(sb, sb->len - trimlen, trimlen);
+}
diff --git a/format-support.h b/format-support.h
new file mode 100644
index 0000000000..c344ccbc33
--- /dev/null
+++ b/format-support.h
@@ -0,0 +1,6 @@
+#ifndef FORMAT_SUPPORT_H
+#define FORMAT_SUPPORT_H
+
+void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
+
+#endif /* FORMAT_SUPPORT_H */
diff --git a/pretty.c b/pretty.c
index 8d08e8278a..2de01b7115 100644
--- a/pretty.c
+++ b/pretty.c
@@ -12,6 +12,7 @@
 #include "reflog-walk.h"
 #include "gpg-interface.h"
 #include "trailer.h"
+#include "format-support.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -833,45 +834,6 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
-static int istitlechar(char c)
-{
-	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
-		(c >= '0' && c <= '9') || c == '.' || c == '_';
-}
-
-static void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
-{
-	char *r = xmemdupz(msg, len);
-	size_t trimlen;
-	size_t start_len = sb->len;
-	int space = 2;
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (r[i] == '\n')
-			r[i] = ' ';
-		if (istitlechar(r[i])) {
-			if (space == 1)
-				strbuf_addch(sb, '-');
-			space = 0;
-			strbuf_addch(sb, r[i]);
-			if (r[i] == '.')
-				while (r[i+1] == '.')
-					i++;
-		} else
-			space |= 1;
-	}
-	free(r);
-
-	/* trim any trailing '.' or '-' characters */
-	trimlen = 0;
-	while (sb->len - trimlen > start_len &&
-		(sb->buf[sb->len - 1 - trimlen] == '.'
-		|| sb->buf[sb->len - 1 - trimlen] == '-'))
-		trimlen++;
-	strbuf_remove(sb, sb->len - trimlen, trimlen);
-}
-
 const char *format_subject(struct strbuf *sb, const char *msg,
 			   const char *line_separator)
 {
-- 
gitgitgadget

