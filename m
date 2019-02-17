Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2011F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBQKJh (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39711 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so7264020pld.6
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPYtTRLwux9hMzUqlJGatGdu9dXwTazzNksmbv6zUi4=;
        b=D/Qw3HO2D49on087p2QXgeTPYh2ttFelfLyFrEHSX5lz5dnAlInzgCCyG20lUm/o6A
         hd8ox2s92PZTmHIGaXOjhbpYnahRxuji2mRwezt3wePmAxObok3Bl8Zrv/kwP/PuX7Mi
         SuxVY7149az+qZjnNQf6hOalxTJ2Coc7FTu5cBIYKqmUWInK1T8745WcdRpm6d3m1gg4
         fGhsL3mtLKOfL4VpmKq7fHt9kxmDW2riYZyDEy/UTdai3QD/Q/v2E5ePUIKcdRY9sjQW
         HZHUFlOvQBkoD6oRHxKv21P+tuB1YLrwlQWS/DByIvoJWodFNzlUl6z7yFgCte1RPWxU
         Mc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPYtTRLwux9hMzUqlJGatGdu9dXwTazzNksmbv6zUi4=;
        b=UdkaSm7guMKqK536mItHPhd8EKQ2YL02lSY/5gTVf7eWbn/UsV1Vxip8MQGl4XH5AZ
         ZIImovS4kcV+e7ImHIaj8rk09YpaBnbUfhHdFfoOwbwlMlYXbbtQzG16Ma7Y0bSc/gnt
         bgmPtLLQbv5vv5bzZoUMjGt+RU1TslzUSLHPiVKCvMEigArTRPX9ADLM7P7ZdLy1+VxQ
         8r409UDx0POopCbfa3ZbkHPXKo9oUyWpjDvGVQWG+tB2A/N5u4zhOnITrEHtXCbTm6FM
         j6YwFVMI+hx6srk1bb1Diino3HP4jG6LUyUAwHqK/+JjxntMLJ1wqbtx325Pz86Mk+jm
         xPMg==
X-Gm-Message-State: AHQUAua0SF8qYWX++rjdbEE1kqTqtGP6xprtvbW1q5NpcUW3K6Zq4ZfO
        wRWTqcVIdGaqgAiJ5QOrm0pmH0Kj
X-Google-Smtp-Source: AHgI3IamyUG8+JlF6n28H9oQ6SYPHB1INxpjLE2CdxbZF+ya+CbXWf1Iz3P0PPih+lOgkIzjgMYkbg==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr9682514pll.110.1550398176444;
        Sun, 17 Feb 2019 02:09:36 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b80sm4720834pfc.20.2019.02.17.02.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/31] refs.c: remove the_repo from substitute_branch_name()
Date:   Sun, 17 Feb 2019 17:08:46 +0700
Message-Id: <20190217100913.4127-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
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
index 27fe635f62..aa52850d84 100644
--- a/cache.h
+++ b/cache.h
@@ -1442,8 +1442,12 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
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
2.21.0.rc0.328.g0e39304f8d

