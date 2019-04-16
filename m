Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D9920248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfDPJfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42947 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so10105958pfi.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=magUUhhIVcbhT4v4qv0cgjYyTZDlX+JnXRitifxUKUM=;
        b=u8MZFra4yLqew7dGKOKAjzFx3NqF2oM9rGFnU+1ZqvcBonZTfiUzrlOG/KsbDRCKJk
         DuU11h7hwsK1f1rVo3q9BsB41itHanSwV3ZTyptn49c/pAxJt3adjI5I87EVo5rD3Ojk
         Jy+Dm/A0a20P/hxvppW9KKUwCNGBhbWk08iF6bsBbZvyVQMzkPotLo6YVZZdCFsRzGlk
         mtgblbCjn75oxbwsfQ7Tbjwp/3eMp38VHz8bURjbvplwPSID8z0e6bd0z+VBgPGtoVA6
         PLvwBAPMbrK3Um+aAOsYW24P7x3CbZugp9GXxj1GWXi4L1W3fAG3RmWcRsmFM+6Ln8NG
         XXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=magUUhhIVcbhT4v4qv0cgjYyTZDlX+JnXRitifxUKUM=;
        b=p84o69FHdVIi0FU0TfvZHN1o31g4NknnkaHP6SofyhR2KB4ieQhRXdik5C7y0AzreZ
         LkXePhI1YcvXdsHCpsI8HPlhxejlyrrag7gAdt3hFF/LRpGqdzysthIkUzWuqrZI+05X
         W+NiqzILvKNOAtwd03iu9lm+hafnDEEQPr53Ow1OPq2BXyUMGf0KJ+KsVya8WInjJ6se
         e2/DsEGLTykVtuJtzn/gkWJUuHLBf04y79Wbq5UyaXvcIB8vLiNyk4fiP8rjBn2cbc+L
         +aD0mVPeCwOhgjZZPZ3K5IrnUhiIzLrhtJGZM495HO7fixm1QMLfvpVUJ7aSudQGXGl0
         XOfA==
X-Gm-Message-State: APjAAAUnhMnIuRO49vHacO5AVHT1HnNZEeTiAVeplFysohu3vxPRdHt5
        PiaUQlFhK6IkQwUPJFpa6Mk=
X-Google-Smtp-Source: APXvYqwaF2rN72WedDY2f3hvOL0fHPnDkuDBcerGoxdHHtetZYKSLPFLRHPCHuP2dYQYqxNwNAB/+A==
X-Received: by 2002:a63:7150:: with SMTP id b16mr72493250pgn.83.1555407304533;
        Tue, 16 Apr 2019 02:35:04 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id f1sm74760614pgl.35.2019.04.16.02.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 06/34] refs.c: remove the_repo from substitute_branch_name()
Date:   Tue, 16 Apr 2019 16:33:13 +0700
Message-Id: <20190416093341.17079-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

