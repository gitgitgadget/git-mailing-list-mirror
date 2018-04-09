Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045591F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDIWqK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34871 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeDIWqA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:46:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id u86so6614886pfd.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PPX8FqrBQSjvVSWiExVNjsPjMQELkZacgabuG6F5KbU=;
        b=X86fgv5ENgpzc7aQ8YYDJtZTyzRlkCiR9NKxZ/2WYXJ5YMblqPdI/b/LKBYtDKa7jG
         JwJO57viYoj7TJcNRpmJiND+d/YbMqTD8qxtNPlS2jA41kkQNl9MgV6LMjsgkU2skS5m
         doPsngqVaZAMrOFkcNLu/vOXAdTnQ6S6wXL1daE4CjR6WVDSTdQRudcj2O52CkPZx5fl
         4ysKiUWoitK+K2LIxVYM7rerRa11pM+yzjUVKiJrozsMI9p9do7azqQwzSGVzDX5Pg6s
         WDv1pO1n0t+1DwLGWVcyoA/l2jqks92fYbX8lCGbzLr+f1kgNc539dJADIMDU/6sb/rS
         MBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PPX8FqrBQSjvVSWiExVNjsPjMQELkZacgabuG6F5KbU=;
        b=nTt0mSP8mi1/hnL1LzAviNkvgkDD5NGaQEPG3wXd66K9m6Z99sEYs50WrsZqqnZk/J
         pQY4ppWACsLtLrLQWnEdZwldX7r1EhmNrhFEHCUNJPH0ppb52FWrPnpuszoH3eZu1Rm/
         t1/TciDeC7RhN86+NZVGA3/kD6puc1qEZ91w+kmajzgs/tUxNW42T6eexuX2J/GraXaz
         y4Nv2gswMjak/OjVTXUbaxNLAwIref8U328BRwk2Z7lXhv+i28gbILpX3gBOGbtEmqSG
         xF71HJ0tMJ8m1ahQMF38kXd/e2Awmh+iREl1KpWXW7gbi6ICzHLKtr2vC33yEN3ccErS
         r+Pw==
X-Gm-Message-State: ALQs6tDl8Net4MaYadDuT9QyV3hS2gRy2hUXIZ/8Dvh+YyusRrNzt3+D
        AzP/7NmVH9yYyXbNUg/Bc9esBw==
X-Google-Smtp-Source: AIpwx490rPgGy1UoLXUjDomb34Vv/GWmFBKoOPvTxVjdMvQn0l0rFLjmSprym6GRcHoP8RM4so5qoQ==
X-Received: by 10.98.58.75 with SMTP id h72mr592600pfa.209.1523313959912;
        Mon, 09 Apr 2018 15:45:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s2sm2226633pfb.66.2018.04.09.15.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 15/16] replace-object: allow do_lookup_replace_object to handle arbitrary repositories
Date:   Mon,  9 Apr 2018 15:45:32 -0700
Message-Id: <20180409224533.17764-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 7 ++++---
 replace-object.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index eae52c66f3..246b98cd4f 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -53,17 +53,18 @@ static void prepare_replace_object(struct repository *r)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid)
+const struct object_id *do_lookup_replace_object(struct repository *r,
+						 const struct object_id *oid)
 {
 	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
 
-	prepare_replace_object(the_repository);
+	prepare_replace_object(r);
 
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
 		struct replace_object *repl_obj =
-			oidmap_get(the_repository->objects->replace_map, cur);
+			oidmap_get(r->objects->replace_map, cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
diff --git a/replace-object.h b/replace-object.h
index dff57bfa1e..3520fd7ff7 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -14,8 +14,8 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
-extern const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid);
+extern const struct object_id *do_lookup_replace_object(struct repository *r,
+						        const struct object_id *oid);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
-- 
2.17.0.484.g0c8726318c-goog

