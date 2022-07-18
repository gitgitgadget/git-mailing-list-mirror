Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA584C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiGRTv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGRTv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8A31DFE
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so11589541pfb.7
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ll246e7O3IOFMGZ13KC/ppTRCoTgg67ztaj2y+kPCIw=;
        b=G/MjKxbcvngP0N+DCwj2MlpjAMeOTMx2eHzoTaC12N1+7CxYI1Tib4WHxS743xvwXD
         89gW+gTU0Fh6Qwr2LgCu6coPmALRMadJdYB7Jz5OznsJmlnqxEGxOFMHtxFfsUx2zAJ2
         g8PdhPg4he39UIDln/QMpZakEEcc4qEVAlk6EXS0muCQzjzxg4lpstDMKx/ZAgN7JiSV
         0PoQg1muLd0xo/cOB9Ft1qXnKfT0bmkNxDb/WxCrELtYqQBya1WI2qm9G5s4uKGopg73
         HncDSKiMM8ESEeDobkR+mnu5LFJrGsBiw52ADZDrfIx3P6K9mHTjBq8Ei/t9vJVlEyg+
         /2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ll246e7O3IOFMGZ13KC/ppTRCoTgg67ztaj2y+kPCIw=;
        b=ktFFXJm8npQbup1qaJm9J/SyMwd5ViVGY8eCO1MsYCa8A8RDqafgSCirfCmiX5+Od7
         2FNJegCBYINcWS7Io5HzW+wIMa9w+A4bxi8DQhkR03RX8I1Zj6LplFjmsnNVY+4exv8V
         UA3COzLM3qXGlOJgiXakiDiQXfqaSapRgfCueb3dkaHWDhgIco5vx//F+O6/8L+qaLK0
         xT6kTz12I/UPKcNY8fD8+2nvPArumrTjJ38H/4jXiZQRhjJ7JZ5+TMRKNMLIUWKOzsSl
         K4SJ539qYsAAADKLE3nZuAF0O5BkzjAEyD3RpgBYPT4eQBFj06XisQVW5ayX9jd3xMpP
         i52A==
X-Gm-Message-State: AJIora9QjQqbHqmOBNrk8zKF7A/q8qpH8aTRn1e04ZyDBAmPubsaOSSn
        B81vWSie/HlvgoPht+w839/83S0nbEl+bQ==
X-Google-Smtp-Source: AGRyM1vfNtuZtBqgvsibSj2VOcQMJ8swMn6H1XL4LNADt2iDuOsPkTZ7yDto7L+yGg7NskSW9NT/SQ==
X-Received: by 2002:a05:6a00:198f:b0:52a:dc25:cc78 with SMTP id d15-20020a056a00198f00b0052adc25cc78mr29763694pfl.20.1658173884100;
        Mon, 18 Jul 2022 12:51:24 -0700 (PDT)
Received: from HB2.. ([106.212.244.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm9855838plr.195.2022.07.18.12.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:51:23 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 2/4] ident: move commit_rewrite_person() to ident.c
Date:   Tue, 19 Jul 2022 01:21:00 +0530
Message-Id: <20220718195102.66321-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g63d6f8c201
In-Reply-To: <20220718195102.66321-1-siddharthasthana31@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit_rewrite_person() and rewrite_ident_line() are static functions
defined in revision.c.

Their usages are as follows:
- commit_rewrite_person() takes a commit buffer and replaces the author
  and committer idents with their canonical versions using the mailmap
  mechanism
- rewrite_ident_line() takes author/committer header lines from the
  commit buffer and replaces the idents with their canonical versions
  using the mailmap mechanism.

This patch moves commit_rewrite_person() and rewrite_ident_line() to
ident.c which contains many other functions related to idents like
split_ident_line(). By moving commit_rewrite_person() to ident.c, we
also intend to use it in git-cat-file to replace committer and author
idents from the headers to their canonical versions using the mailmap
mechanism. The function is moved as is for now to make it clear that
there are no other changes, but it will be renamed in a following
commit.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 cache.h    |  6 +++++
 ident.c    | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.c | 74 ------------------------------------------------------
 3 files changed, 80 insertions(+), 74 deletions(-)

diff --git a/cache.h b/cache.h
index ac5ab4ef9d..16a08aada2 100644
--- a/cache.h
+++ b/cache.h
@@ -1688,6 +1688,12 @@ struct ident_split {
  */
 int split_ident_line(struct ident_split *, const char *, int);
 
+/*
+ * Given a commit object buffer and the commit headers, replaces the idents
+ * in the headers with their canonical versions using the mailmap mechanism.
+ */
+void commit_rewrite_person(struct strbuf *, const char **, struct string_list *);
+
 /*
  * Compare split idents for equality or strict ordering. Note that we
  * compare only the ident part of the line, ignoring any timestamp.
diff --git a/ident.c b/ident.c
index 89ca5b4700..1eee4fd0e3 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "date.h"
+#include "mailmap.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
@@ -346,6 +347,79 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char *person, size_t len,
+				   struct strbuf *buf,
+				   struct string_list *mailmap)
+{
+	size_t namelen, maillen;
+	const char *name;
+	const char *mail;
+	struct ident_split ident;
+
+	if (split_ident_line(&ident, person, len))
+		return 0;
+
+	mail = ident.mail_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+	name = ident.name_begin;
+	namelen = ident.name_end - ident.name_begin;
+
+	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
+		struct strbuf namemail = STRBUF_INIT;
+		size_t newlen;
+
+		strbuf_addf(&namemail, "%.*s <%.*s>",
+			    (int)namelen, name, (int)maillen, mail);
+
+		strbuf_splice(buf, ident.name_begin - buf->buf,
+			      ident.mail_end - ident.name_begin + 1,
+			      namemail.buf, namemail.len);
+		newlen = namemail.len;
+
+		strbuf_release(&namemail);
+
+		return newlen - (ident.mail_end - ident.name_begin);
+	}
+
+	return 0;
+}
+
+void commit_rewrite_person(struct strbuf *buf, const char **header,
+			    struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line;
+		size_t i;
+		int found_header = 0;
+
+		line = buf->buf + buf_offset;
+		if (!*line || *line == '\n')
+			return; /* End of headers */
+
+		for (i = 0; header[i]; i++)
+			if (skip_prefix(line, header[i], &person)) {
+				const char *endp = strchrnul(person, '\n');
+				found_header = 1;
+				buf_offset += endp - line;
+				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
+				break;
+			}
+
+		if (!found_header) {
+			buf_offset = strchrnul(line, '\n') - buf->buf;
+			if (buf->buf[buf_offset] == '\n')
+				buf_offset++;
+		}
+	}
+}
 
 static void ident_env_hint(enum want_ident whose_ident)
 {
diff --git a/revision.c b/revision.c
index 3418a1b7f1..14dca903b6 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,80 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-/*
- * Returns the difference between the new and old length of the ident line.
- */
-static ssize_t rewrite_ident_line(const char *person, size_t len,
-				   struct strbuf *buf,
-				   struct string_list *mailmap)
-{
-	size_t namelen, maillen;
-	const char *name;
-	const char *mail;
-	struct ident_split ident;
-
-	if (split_ident_line(&ident, person, len))
-		return 0;
-
-	mail = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
-	name = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
-
-	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
-		struct strbuf namemail = STRBUF_INIT;
-		size_t newlen;
-
-		strbuf_addf(&namemail, "%.*s <%.*s>",
-			    (int)namelen, name, (int)maillen, mail);
-
-		strbuf_splice(buf, ident.name_begin - buf->buf,
-			      ident.mail_end - ident.name_begin + 1,
-			      namemail.buf, namemail.len);
-		newlen = namemail.len;
-
-		strbuf_release(&namemail);
-
-		return newlen - (ident.mail_end - ident.name_begin);
-	}
-
-	return 0;
-}
-
-static void commit_rewrite_person(struct strbuf *buf, const char **header,
-				   struct string_list *mailmap)
-{
-	size_t buf_offset = 0;
-
-	if (!mailmap)
-		return;
-
-	for (;;) {
-		const char *person, *line;
-		size_t i;
-		int found_header = 0;
-
-		line = buf->buf + buf_offset;
-		if (!*line || *line == '\n')
-			return; /* End of headers */
-
-		for (i = 0; header[i]; i++)
-			if (skip_prefix(line, header[i], &person)) {
-				const char *endp = strchrnul(person, '\n');
-				found_header = 1;
-				buf_offset += endp - line;
-				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
-				break;
-			}
-
-		if (!found_header) {
-			buf_offset = strchrnul(line, '\n') - buf->buf;
-			if (buf->buf[buf_offset] == '\n')
-				buf_offset++;
-		}
-	}
-}
-
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
-- 
2.37.1.120.g63d6f8c201

