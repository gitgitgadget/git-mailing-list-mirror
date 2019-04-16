Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A4220248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDPJg6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39387 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfDPJg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so10119831pfo.6
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jfpWtAW9KfCmy61rbndmy23CFcMW3p+iYAbx0X/NMY=;
        b=U+I6OPiOLtSR7eh7m5fu3a14aFwsEr3Tj1CXKEjJ0nzKaWEfKtdcbNUc0QVYpTdiFx
         sXftMrL/6xTm9QLqSDJd+DzcEN0nGBtQKjZXl4KdJuN9OelAvWK9CxJQ7ciLZoNu0m9x
         1/qY7FrbJaxQdgBzA9FN5VbB6ETj4p8QMomTaKAhy8pYf3ZMSQtJOm8sgVuuH1Z3XZxZ
         jPBrKgZSwyM7XyHc88nRyuy3Brz3/49Gmj0P/99qD5cQdrTXPbZffD8o8Z1K714aVUWj
         PQ/85h6T/BxavBJCKFXGmR41x3m4H4cc8I2fpVt5Exn7+Zla0RBo0Aq1vufVq00Dg9nJ
         Kp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jfpWtAW9KfCmy61rbndmy23CFcMW3p+iYAbx0X/NMY=;
        b=jWEssfx4mxakpmnytrSiVpsu/9rqlpWfw7hrf3u8GeP8NeyvpB4JVTEZSSN+7Ovv+7
         q5mP38yJC0K7FObsLN/4iTxogvv4ceOIon2BA9oTgIWehxkoVStivdupiL0y2ayYhR18
         rFbPUNnJ2RqyYogPCXWKRIzeS89Uoa3gmpwpIwOrHus/3Ra/dAhPctaJht42gXawur8o
         i55UvHGsGAJkPU6EDEVmNWuQoos4UkpuwAlpcraqWxhocCQ/31u+rF2VPtoyJVVUqKgD
         daKFkcbLP22BWlpFHLclVxEdLm8xfb7Jb5DwM8BCNn4wX50XeWldPm23fX4etm+QBcrp
         3KUw==
X-Gm-Message-State: APjAAAXYOtXvoQXlj6tFBplFql5rvmV36xbizVVvkhYQ9dmE+zOsBGlp
        qpeEhEo+z9DdkAlsMV/7O/E=
X-Google-Smtp-Source: APXvYqzdz37t+zMOljYEBXjHhhjDZXN7OU2ari2EU14elOrxsIUs4zQrvOrDF4p7ujKo7MbE+BMxRw==
X-Received: by 2002:a63:4101:: with SMTP id o1mr71980018pga.17.1555407417799;
        Tue, 16 Apr 2019 02:36:57 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id q80sm100644765pfa.66.2019.04.16.02.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 24/34] sha1-name.c: remove the_repo from get_oid_basic()
Date:   Tue, 16 Apr 2019 16:33:31 +0700
Message-Id: <20190416093341.17079-25-pclouds@gmail.com>
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
 sha1-name.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 1cda854f02..d4c135aea8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -773,8 +773,8 @@ static inline int push_mark(const char *string, int len)
 static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
-static int get_oid_basic(const char *str, int len, struct object_id *oid,
-			  unsigned int flags)
+static int get_oid_basic(struct repository *r, const char *str, int len,
+			 struct object_id *oid, unsigned int flags)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	static const char *object_name_msg = N_(
@@ -792,9 +792,9 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
-	if (len == the_hash_algo->hexsz && !get_oid_hex(str, oid)) {
+	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = dwim_ref(str, len, &tmp_oid, &real_ref);
+			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -835,8 +835,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(the_repository, str, len, &buf) > 0) {
-			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
+		if (interpret_nth_prior_checkout(r, str, len, &buf) > 0) {
+			detached = (buf.len == r->hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
 				return 0;
@@ -845,19 +845,18 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = dwim_ref("HEAD", 4, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
-		refs_found = dwim_log(str, len, oid, &real_ref);
+		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = dwim_ref(str, len, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref);
 
 	if (!refs_found)
 		return -1;
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(the_repository,
-			    str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(r, str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -889,7 +888,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(get_main_ref_store(the_repository),
+		if (read_ref_at(get_main_ref_store(r),
 				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
@@ -1159,7 +1158,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	ret = get_oid_basic(name, len, oid, lookup_flags);
+	ret = get_oid_basic(the_repository, name, len, oid, lookup_flags);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.682.g30d2204636

