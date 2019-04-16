Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5310B20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfDPJf6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38140 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so10057193plb.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GW5RK2A28Bk23UYgJQJKiSWpoQuMkcXOe9rgigieww=;
        b=XNvDuI4OqzXuOWzvy99FrnYRsfcZsepLjWroQlkBB9S0mEnnDf05b14ebeKcrtMmrM
         PaEzw0Pg38zEgk6EBge2UbbNAWHV5l9rYT6vRxt59z/fyyzt6GJ7l9Oq6CcFmrfwnDcH
         iz93WknTa2QZ/hB9Ex690g/FRJR0lCJzF2HV/tBAxm68YL325btn2GJGcRQkequD7Clz
         w89Hes75+xVyM5R8zsca9W+BiJuJOPXv44wkWiCg4rx4jop6ZquNq080Xz3IScvIZ2ie
         GYG+FZZ33YIgFXJD6kZ22nptoH3rW4mCwZ24I0QflA9TEKRqnvhkA5imISQV1nbCGHPJ
         XJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GW5RK2A28Bk23UYgJQJKiSWpoQuMkcXOe9rgigieww=;
        b=f8UmgfI5v15NraR3krwPdXIc5rkhsKSfU61p7iiKlqadIP7VCyFteLI3DoQzrqmVzl
         NcNNwDlPtZVKp0RT8yrSU3rq7lqKviUmJZfypkeLLzRGfe2V6C2aRNeGdJT1gJkGnaFP
         lKdguSsxZDCXIOEVWCrdLJJeorPvZP6A11QvyxJh4dTGlxJC76+c/7dJxLRIA4lB7/sD
         g9lbrbhsd6lnfVZ+55/DEUzzCJzI66UitpnA4ZYWC8d7VehIgv3wMGHJxDCnd4x0tx7d
         2PLdjbaWoQDNkp2yNAPRAtb9bitDVzlg5XbD8dBP6OB3s2BO4wa/q5kt/9BSjJXV93b4
         AFkQ==
X-Gm-Message-State: APjAAAVvbk4if/0XwwiadiWJqQYJryXgQXgh6LTaaWBAvsMPdj31btUl
        GpqAtS/1LMilHcQvFkbrybimPMl0
X-Google-Smtp-Source: APXvYqziQORUkA+FcRAjuSUnEsXuy+KU5V3i9Hjls585ep3dNzFV0cLJOsi/O862sVGojWetpTvJ6A==
X-Received: by 2002:a17:902:585:: with SMTP id f5mr49815186plf.116.1555407357529;
        Tue, 16 Apr 2019 02:35:57 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id r87sm117241745pfa.71.2019.04.16.02.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 15/34] sha1-name.c: add repo_find_unique_abbrev_r()
Date:   Tue, 16 Apr 2019 16:33:22 +0700
Message-Id: <20190416093341.17079-16-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

