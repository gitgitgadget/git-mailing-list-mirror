Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76BF1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDFXW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38622 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbeDFXWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id y69so1795682pfb.5
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ro5bFlTXObFrbqVmPGJVh+Z+yE92k3hJgGJZvT26ns=;
        b=INULVLfGECECgUz4dcHKH6guwWPaiV/RYYurn4W4VB1NGpqO5gZnC7YV6ROfKrZupW
         3DgJMEMT4iGPFEQMr+EFloWVuLWB5k15D5JKU5eIbQS1vX2WdkH0BlljIZ9fj3YyB1w+
         482XUlzEXItA4ujEaF3pW5cZkM6oU6H7lwqUw00f2HAYBg0m3JmyFDDwH7+qlITWTJd4
         21GdhpysWAJdWbwUls0+Gs91LjS7P6LFXkWTYAuxEXrRFHBqHQZ/Bo1JnESSxnsNmNav
         fD6VUu7YTbMkUoZAQRyzFA8Dq4xz5eAN6bGawPiz6mzGwnXCCmFjKL1TKJDfErLTNv+L
         PBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ro5bFlTXObFrbqVmPGJVh+Z+yE92k3hJgGJZvT26ns=;
        b=JbLrsyaD8oxLY+ASTtmAjx2qVcAoYo0XbZ1h0Ta2M31zTjXzK5844pXXVkD+okFQRA
         bVQP8XpdJoopSeTL53HGIhx5OjJWE3Xs41DVwpmXLnbZffC20h4yZpuJPfRbyykWWEdZ
         Nug2IvXUq4l41UqUEPPh1HcO3j45ByndYeesQlTKZ4PVAp0VworqCOKXIj0ahoCPRsHq
         NWvjCITrXxOO32iTQIPzJ4SWoUCSneavfl8Vodvqgusma9ZfG0OZfeVMvVfxVNxsPqEM
         tTELIpAaycEM496JYkSiJ51YpgHJH3aVJTQhGSbVRUoY+l02SpJJzsoKQBL62lkpV7oc
         EDwQ==
X-Gm-Message-State: AElRT7F94s4IionDdeyeuMIQjVnbe6gTLl8iNVckfa0t8/y5Fks4RX9d
        6jdPS1qE8/mYXhD73DshLYi27Q==
X-Google-Smtp-Source: AIpwx48mhRUSZbPfTSDfsUou7JDpnQCs/ZR7m5BntGZbszvHGS317IadvOpZRAEzjR/gl4GQdkQoTw==
X-Received: by 10.98.157.199 with SMTP id a68mr21722154pfk.237.1523056936000;
        Fri, 06 Apr 2018 16:22:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d4sm20753591pgc.43.2018.04.06.16.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/19] replace-object: allow do_lookup_replace_object to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:35 -0700
Message-Id: <20180406232136.253950-19-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 9 +++++----
 replace-object.h | 3 +--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 967d794687..075a48b661 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -91,12 +91,13 @@ static void prepare_replace_object(struct repository *r)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1)
+const unsigned char *do_lookup_replace_object(struct repository *r,
+					      const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
-	prepare_replace_object(the_repository);
+	prepare_replace_object(r);
 
 	/* Try to recursively replace the object */
 	do {
@@ -104,9 +105,9 @@ const unsigned char *do_lookup_replace_object_the_repository(const unsigned char
 			die("replace depth too high for object %s",
 			    sha1_to_hex(sha1));
 
-		pos = replace_object_pos(the_repository, cur);
+		pos = replace_object_pos(r, cur);
 		if (0 <= pos)
-			cur = the_repository->objects->replacements.items[pos]->replacement;
+			cur = r->objects->replacements.items[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
diff --git a/replace-object.h b/replace-object.h
index 6a2d37d717..e15f0725cb 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -14,8 +14,7 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
-extern const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1);
+extern const unsigned char *do_lookup_replace_object(struct repository *r, const unsigned char *sha1);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
-- 
2.17.0.484.g0c8726318c-goog

