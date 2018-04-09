Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E9E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeDIWqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46243 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeDIWpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so6084484plc.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Efh4LJcu7GQO0HOSYnYOXx37Z3AhB6F7CiCNve/hAEI=;
        b=YCzUsB9W0WL4vGT/8Ga/A2B76gTJB25QjZeUQx2z1wVSFrNKtb/2Rc3HO6f2UAicVx
         9EtfnqOBFnKDEWY7zxoRCj7gmuJUV8n9vJ+YP2gGsItJd5Bu2FlsAA3xAhPECQbnU7Fn
         B8NXlUZHY13mk5rTApDze9+ipq0VZ8Vqw0dZmyq1YvlNVZzxq5qGykTwF/OEx3eAU2SP
         UMENS+6cHDNy0EK24SCVwbal0ONBJ13JyAZy0930r2XlLHaHkCsTZvYmsY641dJB3Q2R
         JcHLNBv+2dV+m5jCbZ3bgylPZda/nYLrUsmHpCU3a8CoETWZg7YcAPtlz6od75q0YJS8
         3dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Efh4LJcu7GQO0HOSYnYOXx37Z3AhB6F7CiCNve/hAEI=;
        b=UXwsdRYlHVesoF70GPy1u7rPAqyR+X6Rz4E9q+VNYBpPow/txFB9DRZeeba17UQWJF
         kwnaVCLMlZRpS6GBsmK00lqts9nMC3fjWBU1/aNXNAwV2zQ3IKAyauA8OQgUvy5eGu+2
         y8G6mG7IubL4fujT6pSqkJdXOQbnFP1yWZEs3CNjvxcU1Luv6sZtSfkd8Qgb4EOlR7qy
         VwgsEuSpS9tUfN3KBBKZUoi3DX4FCwqy+plH7p+RwxciANRBOImTBzgM/9d5MwzKvvlP
         0e767X1ffRax8DZALnVpo25LMqszU8Tax0Wca0X8uT9cgdSU4mYIctR+NBd+DNcjUsj+
         BQJg==
X-Gm-Message-State: ALQs6tB8rCx9GxRkjlbjqMOpx8CgVTaTMrDZk3WM0Q2Xnzsbum4mKO/o
        BcCHd6hdls8U2n0POKFna0592w==
X-Google-Smtp-Source: AIpwx497F0h+sDyUrzRKcnZxhENacTTIchOOTTE5H+jbWaQ+YGmnVWX2UGVu2aJadKBbIJJ7seCBnQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10-v6mr4061795plb.329.1523313952326;
        Mon, 09 Apr 2018 15:45:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o123sm2557282pga.76.2018.04.09.15.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/16] replace-object: add repository argument to do_lookup_replace_object
Date:   Mon,  9 Apr 2018 15:45:27 -0700
Message-Id: <20180409224533.17764-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the do_lookup_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 2 +-
 replace-object.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 567d9da708..adfed78901 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -55,7 +55,7 @@ static void prepare_replace_object_the_repository(void)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const struct object_id *do_lookup_replace_object(const struct object_id *oid)
+const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid)
 {
 	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
diff --git a/replace-object.h b/replace-object.h
index dbc51265ec..ddeb0470bd 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -14,7 +14,8 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const struct object_id *do_lookup_replace_object(const struct object_id *oid);
+#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
+extern const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
@@ -28,7 +29,7 @@ static inline const struct object_id *lookup_replace_object(const struct object_
 	    (the_repository->objects->replace_map &&
 	     the_repository->objects->replace_map->map.tablesize == 0))
 		return oid;
-	return do_lookup_replace_object(oid);
+	return do_lookup_replace_object(the_repository, oid);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog

