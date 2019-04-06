Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1752120248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDFLgb (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33380 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLga (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so150024pfo.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=EGg/gNSYk4Jw+6FM+3h3YnwVbCe33KdcAZqb6jAL2ydZtz3d6Bx4VmiIswAR0WvBgj
         0nNJWs35YqnWr75gf3IghJ0Pi799DjzHLptsyIR9s0LCcprzf8+afmV6ng518tiGsF7y
         yU0qXBo9uGI3XdqrDdQcfQRoftPrrw8/FOnxfgdeR/ZgvNeWTY2E1ssxwYuZ1uNVWdNS
         lRV+RzX7ff0f4GV7jAup8Ypk9zP3mXXt7npb+V5z1QO+0lT/rQFdbTdKS6a3DLSUhcD2
         O3dJDTvyrKRcHwwQvfZuA107zoGif689GwZNvxLyi9KOrOQA+M9ADgUY4xsZ+ucfpdJZ
         tLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3tl6C17iYwwBOSBKh5AtgHHBV5w/wvyG2a5No1/lCw=;
        b=jPk7T42BNFKImBpAOdBK/UeiUHBh3IuVr82e6lrcbVKVhhuhwWxsapfyoMUZxHT++G
         xiI6vnwxb3GHF4yBzYNpeGsKVa6hlBeg7nZzfHIPOXUwGYWrK3pdab2KpugAz7jgurYF
         gqt/X79VKlr3u45X7Mkm2KFlhbn0QYsMy33xMigevRKRm5+Iowq1ST9CAf3X3F7N1eT+
         bbTUG8wQHDIQ0lOUWZDVl+tmP9ZIp6b4bHkUZhUtDR/8ye3fcizfx7lq1yK74enqjz4z
         qneEwXGtWdWIXoNcfocp12BIlqOSKX7s1z4tU1qoY9Ub414tAFututcCxaZa4G52l16Q
         dwpQ==
X-Gm-Message-State: APjAAAXZNqFtwWUuT81aW9idy0Lg6Uv0LroOH3t0SGYy9va7/33QKzv1
        rcBtTYvJLc5XcDD86beW+y6kzH/D
X-Google-Smtp-Source: APXvYqxwf4dBHfHzciGk6+dPRJH8A7FA8TuMl1aKxt4NlQwjycn2bbZCr5+h2P30sPSknoz4crGo4g==
X-Received: by 2002:a65:610a:: with SMTP id z10mr17094792pgu.23.1554550589989;
        Sat, 06 Apr 2019 04:36:29 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id c5sm359340pgh.5.2019.04.06.04.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 14/33] sha1-name.c: add repo_find_unique_abbrev_r()
Date:   Sat,  6 Apr 2019 18:34:34 +0700
Message-Id: <20190406113453.5149-15-pclouds@gmail.com>
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

