Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01510C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647C2075B
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/V5/+yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbgHQSL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbgHQSKe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E12C061348
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so14665685wme.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C8PssJ/y3mWpvKmZ2Y8WW8hmj8m1ykoCbJ0QlyT7LeM=;
        b=f/V5/+yvi+1ef1RW2riWBMUOzaiBzX+3DDUNoSTFI9XUagBLozmUzidVYMxF+K7h20
         VYdrmVPVbfpulS8chm3DL0dmGamsLKjVJSBvslw5WJNf09WZlwgiS4aWE5LOoSACtNHL
         MHKlSQe5yXMcLCM1TB7EolQP21NN+1rc3pcHI9Za9Abc7o+AJzlp2ucK1hudCBSFpZkc
         YTllaLJop6M1Bz2p/3CsMB3o+iRMzfpumgpzuI14IZrpk5nxt9B0YMgogEzoiFIUlSsg
         +ZMJaDO1eZoqA93L08TvusSUTVxfDSb968prj4HGUu5eMXQph171i/WLFZlmmXLfsyI1
         dSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C8PssJ/y3mWpvKmZ2Y8WW8hmj8m1ykoCbJ0QlyT7LeM=;
        b=BloPNSwCRck3cn5f/5lcqj2Iq5hpXMQHJWjY5iBH/9Y0fZbn7kdHqd3Ak1lcnPUcq6
         mLblFCbhDMDrdVJxg2Vdja+4SnG5UVRYsQLQnx6SNWBklZzxr5poL8QONh4KBa8cfSBD
         Iv/qFBBpp0B1QKO0W/+XxfR1KrflDxX/Yo85rkswQUDMz6hSzuzIsZ4OXGZgGz9Touhi
         21SoPUExPRd9S410vSr4qXGNclC7ACDDwOS8IHdQPcuxuku9HP3LbJeWe79fUXHPVU9F
         nazckrCOu5RQov7WUv2AFNV/twg3xGal7d7f/lxb6lzPnXyHiX6WUu2d/9ouHXKBnDv0
         4WXQ==
X-Gm-Message-State: AOAM530DrDB3gIULm/xRhxxtfn2UzucHWr3OdeKRlBs+LuZwIheMlmU2
        rqK7dvYN1rONnyHyc/IMuST6CCOe6vk=
X-Google-Smtp-Source: ABdhPJxbZaH8wd3xJn+mRHdRJc/BXhpE5gcewZHOIXtFAXYRce+w5WSQAkAoYTdrywzDecHtTh725A==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr16351289wmf.26.1597687829918;
        Mon, 17 Aug 2020 11:10:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm32229699wmd.3.2020.08.17.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:29 -0700 (PDT)
Message-Id: <7a64495f99ec97258687695d41d106e3f946d551.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:21 +0000
Subject: [PATCH v3 8/9] format-support: move `format_sanitized_subject()` from
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
index 65f8cfb236..4ead4a256c 100644
--- a/Makefile
+++ b/Makefile
@@ -881,6 +881,7 @@ LIB_OBJS += exec-cmd.o
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

