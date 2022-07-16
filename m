Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F95C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiGPHl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:41:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1799D32445
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso13508643pjc.1
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5isKAruz8q9i+ThNIdKLFl6xNmH33iy/FzynZD77eQ=;
        b=kypfWmytyTaxic7pXNp58TTBAs5e2WEixsizBdXn5G+KDPfNjVU+UljExLd+pTN5Ht
         moR5qSpKuwP4TrVYrBk0ISAtY+r0yGwJmKYdtYjVjcV1mss86RS952YROv/m2H1vffoY
         WR1OPDWYLwFwq6eMjgxnYx/Ql/0mmfLd5O2j3zWjUGskurt52vdnKJnHzxow3Yd45aJ+
         XurTYcW9LtXymtwfYtvLs3pZznB3DI0/njiPCG7EYZahi/utGfQ68nPTMreahYxr9mFN
         wDWEkcOycYgqrRGVYI3G0/ZWwG1wYYaGEjXcdePu1CVX5En3tA0nyuWsyM00b5jdmU3a
         nHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5isKAruz8q9i+ThNIdKLFl6xNmH33iy/FzynZD77eQ=;
        b=hJIjCrvTGwqzxoDKr2kxXhQ8eaAbemargVZPh6FxtPS8Ky+YZHJonkcVvEjspDukpH
         Vhwqi2mmZ9yYpJKNypkqSbfTjFTnt4lqwE/xOFOjcNCoZPRfQakdm3I0O0Z2ke0yPkfN
         6JD+7vom6gqytJiU0OrrfPrKSdemmX1YNHoEB7muiNfFJTLd84Hi2/8KWZhh+QHI8vm0
         WlbC0JmHQ2Y1dAGclsLvg+iv9aNp0bfzFwJRiZzLe+lRx4z7KueWh4NjXPssocGgmj6Z
         emP4FoulDJj1iXJJc1uXTVZ63dXHoO8C1CAl1RoF4GAeRl0Xntlqg22w2fOPBn6YgBFu
         z1Zw==
X-Gm-Message-State: AJIora/EDH39IU8GRqdjYAwYs8502YNpcHj+cWKOG035HcRKicHa8cw2
        3kNIe/CqeDUCusI/5TjpAcu7HqPPLIhPRD1T
X-Google-Smtp-Source: AGRyM1vba2I/lfroJDZJExsHjNSyMS2gB35uRViiv0rFpk+JJzeo2wxY186EJgA9fa5QR6gGoBMpmg==
X-Received: by 2002:a17:90b:e95:b0:1ef:825f:cb40 with SMTP id fv21-20020a17090b0e9500b001ef825fcb40mr26246147pjb.29.1657957282053;
        Sat, 16 Jul 2022 00:41:22 -0700 (PDT)
Received: from HB2.. ([110.225.168.189])
        by smtp.gmail.com with ESMTPSA id i27-20020a63541b000000b004161e62a3a5sm4325923pgb.78.2022.07.16.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:41:21 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 2/4] ident: move commit_rewrite_person() to ident.c
Date:   Sat, 16 Jul 2022 13:10:53 +0530
Message-Id: <20220716074055.1786231-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g001f220fb8
In-Reply-To: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220716074055.1786231-1-siddharthasthana31@gmail.com>
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
 ident.c    | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.c | 75 ------------------------------------------------------
 3 files changed, 81 insertions(+), 75 deletions(-)

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
index 89ca5b4700..83007e3e5d 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "date.h"
+#include "mailmap.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
@@ -346,6 +347,80 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
+/*
+ * Returns the difference between the new and old length of the ident line.
+ */
+static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
+								  struct string_list *mailmap)
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
+void commit_rewrite_person(struct strbuf *buf, const char **header,
+						   struct string_list *mailmap)
+{
+	size_t buf_offset = 0;
+
+	if (!mailmap)
+		return;
+
+	for (;;) {
+		const char *person, *line;
+		size_t i;
+
+		line = buf->buf + buf_offset;
+		if (!*line || *line == '\n')
+			return; /* End of header */
+
+		for (i = 0; header[i]; i++)
+			if (skip_prefix(line, header[i], &person)) {
+				rewrite_ident_line(person, buf, mailmap);
+				break;
+			}
+
+		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
+		if (buf->buf[buf_offset] == '\n')
+			++buf_offset;
+	}
+}
 
 static void ident_env_hint(enum want_ident whose_ident)
 {
diff --git a/revision.c b/revision.c
index 9909da928e..14dca903b6 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,81 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-/*
- * Returns the difference between the new and old length of the ident line.
- */
-static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
-								  struct string_list *mailmap)
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
-static void commit_rewrite_person(struct strbuf *buf, const char **header,
-								  struct string_list *mailmap)
-{
-	size_t buf_offset = 0;
-
-	if (!mailmap)
-		return;
-
-	for (;;) {
-		const char *person, *line;
-		size_t i;
-
-		line = buf->buf + buf_offset;
-		if (!*line || *line == '\n')
-			return; /* End of header */
-
-		for (i = 0; header[i]; i++)
-			if (skip_prefix(line, header[i], &person)) {
-				rewrite_ident_line(person, buf, mailmap);
-				break;
-			}
-
-		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;
-		if (buf->buf[buf_offset] == '\n')
-			++buf_offset;
-	}
-}
-
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
-- 
2.37.1.120.g001f220fb8

