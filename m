Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB601C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiF3OgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiF3Ofp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2F4F189
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 136so13199901pfy.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pS/oMbX0GopjQKiNX9G/TBgwz77h33cTqzOQGGuynbk=;
        b=dweKjQCI4pvHgpxAiU2f4RTPwJV97YqHFQ7TZ0pu3cxTcjIoSX/I3t7rBP6x6xKOiG
         m0ft9Mq8T6b2H2uUy78rzC0oZZgYp4NQ9cHEDDbyWWXoP/UY0vWKcAjbRq8G8yQdby93
         ANW+cQtVgpQPBZXbuSghtotrkGQ+SNuogm+AVsMX5a9lHbun/mtO8mo0be+1bDGpWO58
         3lHP91znI/pPM3bUANxQ0w4M4H5DjYcQZP+diuBegnW0LLH3vy6n/lAMvllTMsBOQFrA
         WWAybiy37sZ9HuSy2gsnlOjFkfanVKk73uG5GE2tv2aZU5bo+ZMaxYK+kEuqHqcy2UHP
         bjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pS/oMbX0GopjQKiNX9G/TBgwz77h33cTqzOQGGuynbk=;
        b=iFu2Kr9FrMNxsGjIU6mL58X9eC5MCjSYYuWf3kslUElRn7kdBweJ6bFv6ojWRNNSo3
         Yqjngsgpan72XY+IzOLG6Jq5Qu/Rvu9K39fdb04bXMibCY+m4k8TM3ObtTkJrDz0/GDp
         akZV50ibPH2Kvmstg3X2k8AE2pLzSsvJsWJhhRNMjxlFOzqcHKlH7a1iNouQxxT9ucLs
         EwddoxBbT7Qaazc/uoldNQzkK5cXDb+jaWFmmviedMYxuVJ+YgzUxdIJWMW7IlzohJ9e
         5b26Th/puPwVQfuS0j0cOk7volVkjkwG6KtRznxjY7kXRGjpt39sq4+fO72UubdHcKhL
         kf/A==
X-Gm-Message-State: AJIora+PItaiBghybI3RrYxPtfFkKiU6ltsBuVzSncmt8eic9LhqtSWw
        unPC9uvVi+DCj7CVr38Jh8BXSAwdTpPJSxjO
X-Google-Smtp-Source: AGRyM1tAGegcQWZil7IyXk2kigGpFNNPSALed3pt9iqRHxSRguspz3/RHO2fKozbBu+O5Nphx3HDXg==
X-Received: by 2002:a05:6a00:c94:b0:525:7deb:6933 with SMTP id a20-20020a056a000c9400b005257deb6933mr15009869pfv.76.1656599103321;
        Thu, 30 Jun 2022 07:25:03 -0700 (PDT)
Received: from HB2.. ([106.212.243.72])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm13647377ple.292.2022.06.30.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:25:02 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH 1/3] ident: move commit_rewrite_person() to ident.c
Date:   Thu, 30 Jun 2022 19:54:42 +0530
Message-Id: <20220630142444.651948-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.3.gdab82d6f0b
In-Reply-To: <20220630142444.651948-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit_rewrite_person() is a static function defined in revision.c.
As the name suggests, this function can be used to replace author's,
committer's or tagger's name in the commit/tag object buffer.

This patch moves this function from revision.c to ident.c which contains
many other functions related to identification like split_ident_line. By
moving this function to ident.c, we intend to use it in git-cat-file to
replace committer's, author's and tagger's names and emails with their
canonical name and email using the mailmap mechanism. The function
is moved as is for now to make it clear that there are no other changes,
but will be renamed in a following commit.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
---
 cache.h    |  8 ++++++++
 ident.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 revision.c | 45 ---------------------------------------------
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index ac5ab4ef9d..442bfe5f6a 100644
--- a/cache.h
+++ b/cache.h
@@ -1688,6 +1688,14 @@ struct ident_split {
  */
 int split_ident_line(struct ident_split *, const char *, int);
 
+/*
+ * Given a commit or tag object buffer, replaces the person's
+ * (author/committer/tagger) name and email with their canonical
+ * name and email using mailmap mechanism. Signals a success with
+ * 1 and failure with a 0.
+ */
+int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap);
+
 /*
  * Compare split idents for equality or strict ordering. Note that we
  * compare only the ident part of the line, ignoring any timestamp.
diff --git a/ident.c b/ident.c
index 89ca5b4700..8c890bd474 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "date.h"
+#include "mailmap.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
@@ -346,6 +347,50 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
+int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+{
+	char *person, *endp;
+	size_t len, namelen, maillen;
+	const char *name;
+	const char *mail;
+	struct ident_split ident;
+
+	person = strstr(buf->buf, what);
+	if (!person)
+		return 0;
+
+	person += strlen(what);
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
+
+		strbuf_addf(&namemail, "%.*s <%.*s>",
+			    (int)namelen, name, (int)maillen, mail);
+
+		strbuf_splice(buf, ident.name_begin - buf->buf,
+			      ident.mail_end - ident.name_begin + 1,
+			      namemail.buf, namemail.len);
+
+		strbuf_release(&namemail);
+
+		return 1;
+	}
+
+	return 0;
+}
 
 static void ident_env_hint(enum want_ident whose_ident)
 {
diff --git a/revision.c b/revision.c
index 211352795c..da49e73cd6 100644
--- a/revision.c
+++ b/revision.c
@@ -3755,51 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
-{
-	char *person, *endp;
-	size_t len, namelen, maillen;
-	const char *name;
-	const char *mail;
-	struct ident_split ident;
-
-	person = strstr(buf->buf, what);
-	if (!person)
-		return 0;
-
-	person += strlen(what);
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
-
-		strbuf_addf(&namemail, "%.*s <%.*s>",
-			    (int)namelen, name, (int)maillen, mail);
-
-		strbuf_splice(buf, ident.name_begin - buf->buf,
-			      ident.mail_end - ident.name_begin + 1,
-			      namemail.buf, namemail.len);
-
-		strbuf_release(&namemail);
-
-		return 1;
-	}
-
-	return 0;
-}
-
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
-- 
2.37.0.3.g2093cce7fe.dirty

