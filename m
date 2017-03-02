Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C922023D
	for <e@80x24.org>; Thu,  2 Mar 2017 01:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbdCBBSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 20:18:24 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34483 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbdCBBSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 20:18:16 -0500
Received: by mail-pg0-f41.google.com with SMTP id p5so25985586pga.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 17:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=17o2biyEwuX5S72bVx8uByIiXmuJSuWYZrscy51qXNQ=;
        b=qwy8BVaGXaA8R0hBiLiWjGIw6z758f4R6cK5KwonOOuqNPvRdKr2aEZAhUNkDzPbEl
         2LgIPtgjIxfpRyN1/dVrt/SigzN5ixGVYSiE5n7e7NjL1NhRYWaCQIPTMnNcKPwhY9KD
         3j0gLi9fo4cy9V/tVZ0ln6JWvjP9144yku0YdVV2IrNTPtTGTnwZMjiLsSILqUXYY1Rv
         +0JjhCEddbzZr4D5t4hSUlsRKLV0RwzthQci4kFOroMdoQ3Vk+tc4c8odz03pONGH8Dr
         oDt2jjuIL7N7Qi0XCsWHk8vbzFW/RdswVjNNbe7V1+nYpulGhGWs5WyWYYfT4LGgLQFe
         Eg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=17o2biyEwuX5S72bVx8uByIiXmuJSuWYZrscy51qXNQ=;
        b=cU3FFo+r4lAhpkmhaRswDKp1XzAf/F9RzznshcrVH70dKnbiHIUnHmIEXEor69VqPf
         Ce6XCB6uhapHR2WRY5mKrxtyRMKGtUklMraNtYs/hQeEYXZQ3FSQKga/pkzEOe9L+kh3
         kzuiPWC0HPNvKM5i6+4lQu0xDYN1Q2fdpoTW/tqgEWgeL3BqwxJjq3NOJPbItNizICm+
         86lHRg46pSZAKHcjhot9ZOE7+Wx1IS1GGxk2jaaswir2QgZTkcrxQAs7xJdvYeRlpBMX
         367Q2JQK4TltA8LIBMqmFyjB44ls/r2krtctPl617hEx7XawG+UP8h2cecJ/EK1+mSSb
         t0FA==
X-Gm-Message-State: AMke39kVlrFUrhDY8xulH0C2MB/VGiBEEhvZ6hsB7tosjbPu/55fbpV9XESPCD5Yaj/ouYuj
X-Received: by 10.99.67.130 with SMTP id q124mr12229847pga.221.1488415700403;
        Wed, 01 Mar 2017 16:48:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id b70sm12763905pfc.100.2017.03.01.16.48.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 13/18] unpack-trees: pass old oid to verify_clean_submodule
Date:   Wed,  1 Mar 2017 16:47:54 -0800
Message-Id: <20170302004759.27852-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc1.52.ge239d7e709.dirty

