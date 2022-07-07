Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42466C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiGGQQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGGQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:16:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222ED83
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:16:54 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so13446487pgb.4
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb3Xt4/FdJpTEiPP63gXzuOYKvNKA1S1+kZ+WSpAdoY=;
        b=hI7tN6y9Hg6FQOKftvnX053MPCNmv5EjIoYUxXJvhsTuPYDPCoiCziGoSVQWiEPgF6
         bsiDAS4MHsUFQ/FUjSYdoVTDtUbj6Yx9D1SdTzxiHnXs6ZDZ8AK/lQo1IlsEyFKij5bl
         Qh0d8vdes6jYph04j2/M9QYnJt+aH/Jmk6rc7TQiicFkf9E23TbvbPr2g0KeVLoAbZfg
         oi0RRDhaZi93co5Fjrw2UzvUZXe4agI5EMuR50kNt9YkXPoGwAgHNpm6evD6wfi7kd/n
         TaxJSKixryGJ0w60cgyZJi8E28TUrROkDOArRPsgWX9n05MuTaCEwRL1S46XFkVajlvn
         xDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb3Xt4/FdJpTEiPP63gXzuOYKvNKA1S1+kZ+WSpAdoY=;
        b=H8G4SC7/lCIIcShKuuyztwSvWqHwvo1KusS3UdJvt/7gEJ4c6GUBWbp2HsQHQjQCop
         CRGMz4wpI7GDkBDyuMXXRX52cMndzNGYxqXfIO+ufUjflMA/Dz78FaQXPx85mYRpdwmS
         wkd6lsyb6IRBTmNPlWD7bDthd68vSRRHvpIyaacAvkfCffrEe1qD+Pa1PF8WXzshIGmh
         uHwMgn/uNNGJ7A1EROKeA36S/WkgOaVoZ9KIuzAGjs/EiRhFs307YxqjoznEexQWN9eg
         fsRdBjrAdHz1sH4OTbvaOCHz/VJ3hopPeFZSRybLW3UVEUyvCsf0KSIxR8wG44dnHwoX
         LgXg==
X-Gm-Message-State: AJIora8N5t0U7W7JKRYUxjXmTGFiT3FJEZm7WhPyDJGf5kF981YNJ8NN
        Ir+7WaKOlInrLrfvfLZiY/idDlm4czBbLYAF
X-Google-Smtp-Source: AGRyM1vNz4Rzq18Jjsd+d+hGfNfE9FMaA/xZvCEV7lk7eB5/Tx6tPQx4nm96IhRXCyITzNK492SvTg==
X-Received: by 2002:a17:902:7807:b0:16b:e3d5:b2ce with SMTP id p7-20020a170902780700b0016be3d5b2cemr22632204pll.18.1657210613870;
        Thu, 07 Jul 2022 09:16:53 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm27996199plr.97.2022.07.07.09.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:16:53 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH v2 2/4] ident: move commit_rewrite_person() to ident.c
Date:   Thu,  7 Jul 2022 21:45:52 +0530
Message-Id: <20220707161554.6900-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.ga6a61a26c1.dirty
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
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
 ident.c    | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.c | 69 ------------------------------------------------------
 3 files changed, 75 insertions(+), 69 deletions(-)

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
index 89ca5b4700..26cc60b2e1 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "date.h"
+#include "mailmap.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
@@ -346,6 +347,74 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
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
+		const char *person, *line = buf->buf + buf_offset;
+		int i, linelen = strchrnul(line, '\n') - line + 1;
+
+		if (!linelen || linelen == 1)
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
index 83e68c1f97..49d15e74ff 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,75 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
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
-		const char *person, *line = buf->buf + buf_offset;
-		int i, linelen = strchrnul(line, '\n') - line + 1;
-
-		if (!linelen || linelen == 1)
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
2.37.0.6.ga6a61a26c1.dirty

