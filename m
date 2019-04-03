Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB28202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCLgU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44109 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so8179901pgj.11
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=L1eEl/42XtHRVUa4ZQukAtR2EAQVs3vgb/tK/OKJ/jBBhSum7Tr+hyZs+KLx8zoEoI
         6nR5aJQxLoFUWXbYoWmmDL0uJzXlbAIc3/RHuTWBa8BXskrRgKmyPk1AP4fPdZI7kCa4
         fMMGwLPIRaKMJGSDpE5/Dm8gYFL3YUPghvxRmGG+sMKKHJj0bWvVrMIxP3aVEJbHTpVj
         yV3nQPPQNX+0L+1mjNAG455WYGuDesQNvdmE4+a9tLukPWPkgmt5KWxYurT7XNuZrNTk
         ujj537NSZnMOUop09KCPi16F4ZoiwJJ5Ik7bIOu//3CydBf1tdftbesecT400W7bDkWu
         pJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=fKskH4nz98ujnAL9Tl62mU/vZ5XNUkbc90vPn0icRv2PaBRvwc9nR7JsTaF4p6Co0T
         ekL3erOaH+gti3CovsF1gum4rgde1dISoNdKg0HOdaXJfVJVyYNPQ/mbgRYB2Ncn7dib
         tGtWWFITcQsQ2Bf+4KxOkzLSwkP00JBH1UcDCAl+4v3STyNYskKjuh7an939aqcUszbQ
         REJ8iY8CdWxaDHy/KUwCRORoezRyZ1ADRUeupIeghaUWIZNZge4+x6oVuSv50jD7aai7
         Uku+nm+Du7pBluS4kTYKz/oazdAkCHkQ02tk14IoNCOQYdZhG0SB31MqaONnh9/PZJdq
         UfMA==
X-Gm-Message-State: APjAAAV5pAMtigJkrzSn7BjltoDMe1xUfESMIeLq8MOvPcacVD8IUD3W
        dJRStgFepnmg8yPoXK8W+dE=
X-Google-Smtp-Source: APXvYqz+r5ZBeQh7gdpWpBYGUf6Xd5x9zBkTLI31SI+W+dX9b+t7DwqEnqVkTWmaSaSrDTyGZtF07Q==
X-Received: by 2002:a63:360e:: with SMTP id d14mr58972259pga.188.1554291379167;
        Wed, 03 Apr 2019 04:36:19 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id a12sm17881795pgq.21.2019.04.03.04.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 13/32] sha1-name.c: add repo_find_unique_abbrev_r()
Date:   Wed,  3 Apr 2019 18:34:38 +0700
Message-Id: <20190403113457.20399-14-pclouds@gmail.com>
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
 cache.h     |  6 ++++--
 sha1-name.c | 15 +++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index fcb24b5781..4f8ebb0a67 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,8 +1045,10 @@ extern void check_repository_format(void);
  * Note that while this version avoids the static buffer, it is not fully
  * reentrant, as it calls into other non-reentrant git code.
  */
-extern const char *find_unique_abbrev(const struct object_id *oid, int len);
-extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
+const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
+#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
diff --git a/sha1-name.c b/sha1-name.c
index b9381aaba6..9b57787b76 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -626,15 +626,16 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+			      const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	const unsigned hexsz = r->hash_algo->hexsz;
 
 	if (len < 0) {
-		unsigned long count = approximate_object_count();
+		unsigned long count = repo_approximate_object_count(r);
 		/*
 		 * Add one because the MSB only tells us the highest bit set,
 		 * not including the value of all the _other_ bits (so "15"
@@ -659,7 +660,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
-	mad.repo = the_repository;
+	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
@@ -681,13 +682,15 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	return mad.cur_len;
 }
 
-const char *find_unique_abbrev(const struct object_id *oid, int len)
+const char *repo_find_unique_abbrev(struct repository *r,
+				    const struct object_id *oid,
+				    int len)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	find_unique_abbrev_r(hex, oid, len);
+	repo_find_unique_abbrev_r(r, hex, oid, len);
 	return hex;
 }
 
-- 
2.21.0.479.g47ac719cd3

