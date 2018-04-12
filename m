Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AA81F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeDLAVr (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46905 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeDLAVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so2592888plc.13
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oscdVrbBQakyLmMOi/235wZiYM+25clbn87DDSQnAFc=;
        b=MuqUedCU4m2yelhTnqgZQwysN+UOGXZmLxYAdUAZTWodsI0KZwaLa7VmFNQdB8S4gz
         PbETLy5B+n7zsvtnRsMG/7HEg7yDFFQohEL9uub7/2I0xJ0Ba06EL+Lk65ThfIuPZOmR
         p0Y1fSOo7NDITVLpF2DPwQwpY6Ytbn6E0S1FrHZF8izQSOQG6TpXlcp+fTiJ10yIN84E
         fU1lxkNNedtpp8s3z7rpAocmIP/DtPIuUbpPzNF0T8KuOx1BN8RZEdch57SDsPWr9xg9
         3zwEsgQaarBg5scvotK4q1FWFZ6rvoJ1HskBYnSyn21i81uO4OxJpPVoq/5KFPAaGh3c
         1/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oscdVrbBQakyLmMOi/235wZiYM+25clbn87DDSQnAFc=;
        b=lNmhh3pnjlvTjNnUk2+sLQjD0pD9MLLKCzOuC/LKw7wV24RSxRYJ3y52+qZZlaTEqF
         iLYpLAMX23MRhI0jTEhVKg/UFuyINiKxqSB79xqoNQfYwuMCjMfe+TgNSQR44+9zoHG9
         8Ocr4HL7UOCcrdMqCwmYfOt0q4Q/CQc7XCkp29hToVNyNbSdcnRpgslzZoeMBuMRiFJF
         oeg93omnDxqNOQIYUYvjtcZ0vOIq2JikGXRvH+iR5zXUUkcW2bcPMHD81X56ykBaPgI5
         0QnoR0Ctq1YwtJc79JtvuFD9ecuV7SeE8zB8etat1Jfktkri+gf7ZcLEn1pjKkAC9H/7
         RNBg==
X-Gm-Message-State: ALQs6tCbD2BmImT71aZFHDLmb2C+TkpE3spkpYoQKGyNCovCgCz9UFcT
        KyhZojVO0APTq7py7aZmF99INFsmQ0E=
X-Google-Smtp-Source: AIpwx4+0qNh2hN62jz+CsBLP/dtR1fQcVXZf+SzBj59JbZIoCrDPlXMx08p+KWSoo/PJ7zKXd9oghw==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr7286367pla.328.1523492504870;
        Wed, 11 Apr 2018 17:21:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p21sm3985451pgv.4.2018.04.11.17.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 14/15] replace-object: allow do_lookup_replace_object to handle arbitrary repositories
Date:   Wed, 11 Apr 2018 17:21:17 -0700
Message-Id: <20180412002118.102976-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.h | 4 ++--
 replace_object.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

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
diff --git a/replace_object.c b/replace_object.c
index eae52c66f3..246b98cd4f 100644
--- a/replace_object.c
+++ b/replace_object.c
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
-- 
2.17.0.484.g0c8726318c-goog

