Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B5BC433E5
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EB220759
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaQw4yPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG0UnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgG0UnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2047C0619D4
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so15299532wmh.4
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oOrQOujXNyWnbrMCB1K8NItg5OijsC09i1jMW68z0ZU=;
        b=BaQw4yPS2lT1MU9OdKJiZ0Cp7Yl1ovRYQp4d8m6v3oMJgfP5xOWO4tQR8mC1W3KSEe
         XOavZyE1qAMAuVRWbh+TwzXLy3XsQSy3yL94qwZZBNstKdTtRL5mddeIO9WLy62VnaTo
         o3nn4naXA78wbnAvqJhyn4DiXVr7cbKwpKQ8/pjc6TUZKqAg6F6U7510nYPb+dU4otl2
         VctiskjjqkhJIYO1j7mViIBJWYXPc3YRYKXyNOe1fkbO1YcQUuUFh4YkF67AX5+mv2dg
         DMnb+0P7Xwb40ywxqs2TcJmVSWBvYhVxbSNqSbaRzalnYMTdLKOb1bgNfpJvqxBxAPVw
         paXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oOrQOujXNyWnbrMCB1K8NItg5OijsC09i1jMW68z0ZU=;
        b=V0CTwjdj/uHo8ViABy+43VLb2xAfbxPQX8sJD0L+gSJc/rYZLjtffw8UHb+SqlyNi7
         V8EC7CzAorhAoZjN/4RVTe10t6yVMgTPN7lX6PD0e+E5TwgdgBruM1Gzj5GcgOSTxQLH
         LvSUhPO25rR3guNcecNGuGfq/xlvV9TMgd8kpnI2IDlMP/LnYDeGrvcFQ1ixQaZT2/KG
         vxHngUTWVpiN8VViYCF/rvJdxDXnjmEFvwKO8/72r+oVS1wGonx4fhghdjivqeCUyu2e
         ygdmhEV+H/AtEiUl6qgIpGnCbJ7VJlNNIPutgbOndWJTO21BjmocH/VDRZYONq5WWicR
         ef3g==
X-Gm-Message-State: AOAM533djk0tw+EDQUHOBCVO56wdpSvFYFZR3Ya2Ene1AhKG/SnsxMzo
        spTJCbVYrdtIHgMp4+CpIfG/Ul+I
X-Google-Smtp-Source: ABdhPJxrQJfEW1XBCxoBwoLOSqfsNl1pwx2z+I0+lZZYZNrrNq7pKurp1GBqCDOo9OhsN6Efmwiy1A==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr907707wml.180.1595882593509;
        Mon, 27 Jul 2020 13:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm903903wml.30.2020.07.27.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:13 -0700 (PDT)
Message-Id: <9dc619b44888024201d9ae1f83a4b34c81fa693f.1595882588.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.1595882588.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:07 +0000
Subject: [PATCH 4/5] format-support: move `format_sanitized_subject()` from
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
to new file format-support.[c/h].

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

