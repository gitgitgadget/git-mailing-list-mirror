Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B49D20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDFLfs (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so4757356pfc.7
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=Z5Jn1O/CxigZexavDf6I0ypMD96GUuqVldVlBG5LAojaMJEbJzijdsIH2+hXMEIUr4
         fRRLCNvE6kq04AwUtc37Fuc/b1KQNyygQMDhVOEIHnSo7ds6ixo5YAhgmRwxHxIy+g9S
         rBjN1oa/LGoHmO85dhUmRxnxMdqRli/3irJZnbnZVAiu/LvqXS6Ubv91f/Cka4AYViJr
         fyR1bGe0fttnLicZNmeKQ88PpIaNI4Jod8APYghvA8YGLjwn0ybL+xT2R5LEMTqE4I9P
         bPio1JvPTG3u8x2cuU9Joq8Jxt1+vUaUKyQN2t4Pa8lUZGTr4txlfRekfuk3aqKFbZrH
         30mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=OTf+kraYak8g3OIwqvLHsftMKuIzZDXJqNeKsij95nF9bED5cDvV1Ae0FKOZTTDJ6x
         5EcMWsAhcd1crJ9ixHNQ7oOD1kODMRMrfpcjbpU6dlQ98YvZ9cyugby8sAelO3RhVpOv
         rrFnUTKZ6aAwGXgRfTBFu+UNmd3hCZ1CdtRo5mxU7gIyuTxl4GpjPmnt2SR/UaF+W51R
         JoPtZilj7CwvND/y+GFXClRQeFJwFVXtRBQpcTTIy1fjTza+Y/B8AdmQMHOZV8VrdrqY
         UxiNYQAYK2BArYQDUlCvcTWhadfmKfJQy/BIRom1iFIAWgCeaNK2NY3HdcX8lTRvGmRD
         xG8Q==
X-Gm-Message-State: APjAAAVpeoF/NryhUbXjWA82kHDf/IU/bm0ydo2ndddjo/im18p7kC46
        nhhwSb+CfVFFgyUugH7uRXM=
X-Google-Smtp-Source: APXvYqxpMF0psYAkq8vcx9a5ObaGKP9N7jbOU8t004KT4Mnr7gwfdi6GCQKlqVQH35e4zypfPFRPhw==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr16546992pgk.97.1554550547355;
        Sat, 06 Apr 2019 04:35:47 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id p2sm82386326pfi.73.2019.04.06.04.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 06/33] refs.c: remove the_repo from substitute_branch_name()
Date:   Sat,  6 Apr 2019 18:34:26 +0700
Message-Id: <20190406113453.5149-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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

