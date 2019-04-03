Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B878220248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCLgJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so8012912pfd.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=MEb+WwOLBxK/06qx28qxXXa2s1b5HOex5/3ABt+LjdJ6Cq3BQ7zzu0zW2LuVxW0dlD
         G7k7AF+nw3+c8AFzg4Hm52ua70GzDcW7enLkOcT/9Uy7hFbf2gXSjxLgolqiYvLOLEhe
         XjvwpbZzrlQ8+XrOn7wsKWKG9cW76uh07nCNP8Te147NwvtsnY7DcMcSpWHB2drsneCg
         m9bojM3Vvr1Xgw/kwGbXbCkUHZ45K/LR0zaIddnraAgkezBhBjcJadrCmpYNFnWfwF3N
         +HhHXBrfI07Ey0i2uCYYjkAbo+OYC4hSwGGasDMEga4ZsCev071WctJdulGX1f9ozrTx
         Mfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=JshuOcxflG3zrFlLMgj2YLmqCMq/VQYiwmHeBi6uEsgTN/opK24SyUTIfa8HdrErvF
         gp2HUm9rPfZOK8+m/dAxMiC0wIwCrz3ZVeT3HaGQkKWnER7we0U+2egMpvpBOVeJMHlS
         ZxxjMEhmJguUxGfr5SGnCPdHI7Kb47kI1DuKPkvU3mSsCmQXcxRmUi5gZtRiBqPM9Bh2
         0W8M2RlXFY4BwCCxdlrzOhT6HPiupUaNs+7ZVlCSE3tOhkUs1xLHFXy7UlqWrXgA+p1N
         /FvckNh8cdYK9nvfFaphaPMqCcKH6ncKl4Ka4KE5O0z1W7krVz3fdYjT478doJRGyJnr
         Mq0w==
X-Gm-Message-State: APjAAAWOMp6kE2aZZ9H96SFbdtcTndJtz1LOxbGOVkkYw8xiv8N3Hq3t
        p9Pfuk/tMLaPsZ83CA7umLs=
X-Google-Smtp-Source: APXvYqxAegG51H1MAAdlADCyAUDQnkNVrzjtwCyBxQ/bp+PXNFFK2+o0hD+V6ep3evFX9l3u+HerAw==
X-Received: by 2002:a63:2015:: with SMTP id g21mr48802444pgg.226.1554291367622;
        Wed, 03 Apr 2019 04:36:07 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id l74sm25042238pfi.174.2019.04.03.04.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/32] sha1-name.c: remove the_repo from sort_ambiguous()
Date:   Wed,  3 Apr 2019 18:34:36 +0700
Message-Id: <20190403113457.20399-12-pclouds@gmail.com>
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
 sha1-name.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 15a1107998..7558ce51a3 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -383,10 +383,11 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
-	int a_type = oid_object_info(the_repository, a, NULL);
-	int b_type = oid_object_info(the_repository, b, NULL);
+	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
@@ -411,6 +412,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
+{
+	/* mutex will be needed if this code is to be made thread safe */
+	sort_ambiguous_repo = r;
+	QSORT(a->oid, a->nr, sort_ambiguous);
+	sort_ambiguous_repo = NULL;
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -458,7 +467,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous_oid_array(the_repository, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.21.0.479.g47ac719cd3

