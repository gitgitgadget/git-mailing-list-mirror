Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F10C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 15:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGIPmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGIPmg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 11:42:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B43D585
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 08:42:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m2so1149249plx.3
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Phvkfw8wl/cag2XeSqKzJu4tEeNHTaSonhL7JNi8m2c=;
        b=Lj/sra0CClh6eMWEj8Vt60nDqpiI6kYP80Z3w3hVD6ddPH1SJPKcAgHOs1sE1J0rB1
         Uj6aicvr8oflZIXICZSsFVYodyBPWwFyjFFvRpaTCL9tHw4C8y7stNkdtoTaH7l7yG65
         JZzzgioG5jd9lGqIwwuwdfPxl50RXTbrxmoXQq86DxSG9yJVukuD4xGyL0JkVlLEKxjL
         7vzBBcLuYv0FaM5IVAAxn20rfN1TXYMkIx/Wzu6Ej0q2OGb6p/t715YAK3bURNJ9QWYh
         J5xd3O/csKXDu9rlcppMhk/L5Vp37l8mIJ8lQy5yR5cF6hbSk972OMGx95vhFEDM5Mqg
         tqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Phvkfw8wl/cag2XeSqKzJu4tEeNHTaSonhL7JNi8m2c=;
        b=b88T1aiyPcCfYOspe/y0uiKsUTbK7eGDe+ZPxuFEzRZO6WeMJyCHdY2lYpVD93KHEB
         jAQiRjFaBw3q3OvTf4jBA7nul9Dd8IdSkUiCFLLC4lPDt2DiQE8Yqlp/JHwrmurPW290
         wkC3AmsVM/GkxaieO2dVPsdu00/+AR359gwYmSBN6RUmO4jIgnHa7LI1iP+gsUqsRGkm
         mwv+tgkwu2NfkUN9CRZtrDybQpWuUdU97cYVDTKJQjJ1b7EKYRFCRTNxfcJpE6NRsOH5
         3dYJey6CEWmXByPSi4sqqEwmvzYXsSnshh24+tnqfd2649//1Il7W++fdkSZEzu9VYTf
         C+Vg==
X-Gm-Message-State: AJIora9YmtSlgM0LbQFombb2OwDv7X2Hf00hgafaq8YFnvpUMKvypJzJ
        7L4rNkYl9zjAWccNZ0pIcv9QqiG9mtGsNzwj
X-Google-Smtp-Source: AGRyM1sHwv0LgLq00jxWnKwcxpRKvmCJ1Ca+Qs2AUm6VjX5oNJR/PmKmyO68OkbBRsnrwHdl0oi30A==
X-Received: by 2002:a17:90a:2e03:b0:1ed:2cd5:6c4e with SMTP id q3-20020a17090a2e0300b001ed2cd56c4emr6610491pjd.225.1657381354353;
        Sat, 09 Jul 2022 08:42:34 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016be4d78792sm1473833plb.257.2022.07.09.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:42:33 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 2/4] ident: move commit_rewrite_person() to ident.c
Date:   Sat,  9 Jul 2022 21:11:47 +0530
Message-Id: <20220709154149.165524-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220709154149.165524-1-siddharthasthana31@gmail.com>
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
 ident.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.c | 72 ------------------------------------------------------
 3 files changed, 78 insertions(+), 72 deletions(-)

diff --git a/cache.h b/cache.h
index ac5ab4ef9d..c9dbe1c29a 100644
--- a/cache.h
+++ b/cache.h
@@ -1688,6 +1688,12 @@ struct ident_split {
  */
 int split_ident_line(struct ident_split *, const char *, int);
 
+/*
+ * Given a commit object buffer and the commit headers, replaces the idents
+ * in the headers with their canonical versions using the mailmap mechanism.
+ */
+void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
+
 /*
  * Compare split idents for equality or strict ordering. Note that we
  * compare only the ident part of the line, ignoring any timestamp.
diff --git a/ident.c b/ident.c
index 89ca5b4700..9f4f6e9071 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "date.h"
+#include "mailmap.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
@@ -346,6 +347,77 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
+{
+	char *endp;
+	size_t len, namelen, maillen;
+	const char *name;
+	const char *mail;
+	struct ident_split ident;
+
+	endp = strchr(person, '\n');
+	if (!endp)
+		return 0;
+
+	len = endp - person;
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
+
+		newlen = namemail.len;
+
+		strbuf_release(&namemail);
+
+		return newlen - (ident.mail_end - ident.name_begin + 1);
+	}
+
+	return 0;
+}
+
+void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line;
+		size_t i, linelen;
+
+		line = buf->buf + buf_offset;
+		linelen = strchrnul(line, '\n') - line + 1;
+
+		if (linelen <= 1)
+			/* End of header */
+			return;
+
+		buf_offset += linelen;
+
+		for (i = 0; headers[i]; i++)
+			if (skip_prefix(line, headers[i], &person))
+				buf_offset += rewrite_ident_line(person, buf, mailmap);
+	}
+}
 
 static void ident_env_hint(enum want_ident whose_ident)
 {
diff --git a/revision.c b/revision.c
index 1939c56c67..14dca903b6 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,78 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-/*
- * Returns the difference between the new and old length of the ident line.
- */
-static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)
-{
-	char *endp;
-	size_t len, namelen, maillen;
-	const char *name;
-	const char *mail;
-	struct ident_split ident;
-
-	endp = strchr(person, '\n');
-	if (!endp)
-		return 0;
-
-	len = endp - person;
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
-
-		newlen = namemail.len;
-
-		strbuf_release(&namemail);
-
-		return newlen - (ident.mail_end - ident.name_begin + 1);
-	}
-
-	return 0;
-}
-
-static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
-{
-	size_t buf_offset = 0;
-
-	if (!mailmap)
-		return;
-
-	for (;;) {
-		const char *person, *line;
-		size_t i, linelen;
-
-		line = buf->buf + buf_offset;
-		linelen = strchrnul(line, '\n') - line + 1;
-
-		if (linelen <= 1)
-			/* End of header */
-			return;
-
-		buf_offset += linelen;
-
-		for (i = 0; headers[i]; i++)
-			if (skip_prefix(line, headers[i], &person))
-				buf_offset += rewrite_ident_line(person, buf, mailmap);
-	}
-}
-
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
-- 
2.37.0.6.g69b7ad898b

