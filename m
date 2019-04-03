Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C8220248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDCLfh (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so8175746pgk.12
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=izHnoUcrjeIrf++/iQQ6msjNZu87Dyzavp0t2wnGFuLclmxxXdUEJPtWXODwK1KH+h
         6E/vte11k1bZqCdlAPercnoTIHwOM1DfLkOHytvCa+RqsqDPd4Rahc7V95QS8aQnGHlK
         d3V8booDZgKYr8zcj3QmyJdKI9S52s6uZGQyBc5tTbsxxWIwZ8YzfnQLk/FCJ8kP0YBh
         gOGtTlV5puw/aQlnK++SI79bgbb3X7wIG5TPyYU4LjDj15YsKeyow//5mFAJK9k9Udnn
         iW0KUllToqNJJBUH0RxW3Iscr2NudZ9PmhLxdEookGvRukxNkvH2kUFBZ/vuNgC2V+gZ
         1oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=IUJHUoDKzIjIaUmnJY2mfuli03wpP53/mrta+iYF2hUiouvB16nfS5MrQlWPe4ET+5
         VJk0KuaQ+W1MTurdAIEjBxdJbCJm/sSt1CEFRNIbMPtAS7M4qvrJa18gPjuj8z6Bl+pf
         1+tF7mxcnCBmYnjtOWOQE+je0o8i/BPW56FKhjHJPdGSrCCZpaB7Z0Idv7JEGU7796Lb
         ZtDEIu9M0JPv9Y5hCP/0oaD/LU52l6u46LWi2fWCSHsoEFsCzG2kqTYTcO+N0taSLTcD
         vIMO/Vt9IUELXx96wkUQwj5lmZDItyzhKHu+2GZQJMyRlwQepNVOku8WZRU8D+db/PrU
         e5fg==
X-Gm-Message-State: APjAAAU4Mn6nYjqxn2NJPeNhNdXx5uPwtiSk7mX608yJWa7Vr3l+yA9o
        bHPyka3A4smX+WAB0VgN1ko=
X-Google-Smtp-Source: APXvYqwKopDwoBoJb1FWDF8LUOlPsDlE5xQEZXt1I3keJPYYv+4bclS2cz05BcJf0sg4xtEwxqjKGg==
X-Received: by 2002:a63:54b:: with SMTP id 72mr71579503pgf.323.1554291336040;
        Wed, 03 Apr 2019 04:35:36 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id x9sm29070765pfn.60.2019.04.03.04.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/32] refs.c: remove the_repo from substitute_branch_name()
Date:   Wed,  3 Apr 2019 18:34:30 +0700
Message-Id: <20190403113457.20399-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 8 ++++++--
 refs.c      | 9 +++++----
 sha1-name.c | 8 ++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index ac92421f3a..fcb24b5781 100644
--- a/cache.h
+++ b/cache.h
@@ -1468,8 +1468,12 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
 #define INTERPRET_BRANCH_LOCAL (1<<0)
 #define INTERPRET_BRANCH_REMOTE (1<<1)
 #define INTERPRET_BRANCH_HEAD (1<<2)
-extern int interpret_branch_name(const char *str, int len, struct strbuf *,
-				 unsigned allowed);
+int repo_interpret_branch_name(struct repository *r,
+			       const char *str, int len,
+			       struct strbuf *buf,
+			       unsigned allowed);
+#define interpret_branch_name(str, len, buf, allowed) \
+	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index 3dde824aab..44df049796 100644
--- a/refs.c
+++ b/refs.c
@@ -539,10 +539,11 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
  * later free()ing) if the string passed in is a magic short-hand form
  * to name a branch.
  */
-static char *substitute_branch_name(const char **string, int *len)
+static char *substitute_branch_name(struct repository *r,
+				    const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf, 0);
+	int ret = repo_interpret_branch_name(r, *string, *len, &buf, 0);
 
 	if (ret == *len) {
 		size_t size;
@@ -556,7 +557,7 @@ static char *substitute_branch_name(const char **string, int *len)
 
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(&str, &len);
+	char *last_branch = substitute_branch_name(the_repository, &str, &len);
 	int   refs_found  = expand_ref(str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
@@ -596,7 +597,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 
 int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 {
-	char *last_branch = substitute_branch_name(&str, &len);
+	char *last_branch = substitute_branch_name(the_repository, &str, &len);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..d535bb82f7 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1427,13 +1427,17 @@ static int interpret_branch_mark(const char *name, int namelen,
 	return len + at;
 }
 
-int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
-			  unsigned allowed)
+int repo_interpret_branch_name(struct repository *r,
+			       const char *name, int namelen,
+			       struct strbuf *buf,
+			       unsigned allowed)
 {
 	char *at;
 	const char *start;
 	int len;
 
+	if (r != the_repository)
+		BUG("interpret_branch_name() does not really use 'r' yet");
 	if (!namelen)
 		namelen = strlen(name);
 
-- 
2.21.0.479.g47ac719cd3

