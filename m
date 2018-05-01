Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89451FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeEAVeP (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39453 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAVeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id z9so9965525pfe.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UY6geknmkQ3HdHhWDXAqEXKR3MTw+v1cHhOPlIiXek=;
        b=SIknMWpLqJ+8AtL9dD1lcfmEmreK5ZSVJmV8x79KlNFHgIZ5C77ECh7QIvaAo01RY/
         SQjJmTcd4ipDFw793Uz/m0GoeuAm36/L0kCr1aH+zDex6qQZENDvrwaVEzQVGESCcOVV
         jtCKwe8xWsRxoeDeSAH6S3HFzBx6SvByIcO2BJ+aKaCH6fk2rnIbavBXyVQs69E9vqyF
         v1mOBc31thwS8+5bOcATG+bQT18gnBV8JO4NJDKmiihLlF4BWr6IWA9Ke5CbMcqTwzIJ
         +20oOEcKac0Mo/lN3QqJ0UMWqcz+7rvMC2PbHVIHq0svlXpx3NO/+zMMbXWbKw9W2btc
         1cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UY6geknmkQ3HdHhWDXAqEXKR3MTw+v1cHhOPlIiXek=;
        b=QIoMfzccRb4Ys2O5alSLxJK4CscZ6nLHT8uLgd6mT/q+8mXnFh/oHC2he01DcuCSKG
         o14iXlVa7yctJ7eC3lQ3KHDsICRzDV3Ej16Fb5PwONOXrf7S3xAJVqkLt5UX3+oiBaBx
         VLaSsfswoeuG9pwGfF6km4nXJMdwf3twvPr29+a9o+iJo6/xXP4zAIpc8TvHjtiMp/Hg
         mVmJ1bDxRhVKQqk8wSX0xE2jxz8f3z/Rb8mCtqKJ9lVj5UOCCPAsBLGDsr1WKOTx1l1X
         YrafoprOnkX7oTt886SYzQbLZJ0L91GUK12E2kJ7BgfK/VT6Gy3AGWKFQxKDcErTCrPE
         hAIw==
X-Gm-Message-State: ALQs6tB7th2OufWXcphPuobNEIYnOMp/p6Z2sS8FyhSbWuPfumPnJywK
        E2bRsgAZ6GmDM+iMEjYjyXAeawhAbOA=
X-Google-Smtp-Source: AB8JxZo6tgtQ7cpRBMalUMpA41OUIIvsWSEo8ZP+UJPGD8v01FQgrnyoHqreQ8Dvh+ar8qZHmNfZLg==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1-v6mr9420951plr.181.1525210452240;
        Tue, 01 May 2018 14:34:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x2sm24756404pfk.113.2018.05.01.14.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/13] object: add repository argument to grow_object_hash
Date:   Tue,  1 May 2018 14:33:53 -0700
Message-Id: <20180501213403.14643-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of grow_object_hash to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 933921e35c9..a6202d11292 100644
--- a/object.c
+++ b/object.c
@@ -116,7 +116,8 @@ struct object *lookup_object(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-static void grow_object_hash(void)
+#define grow_object_hash(r) grow_object_hash_##r()
+static void grow_object_hash_the_repository(void)
 {
 	int i;
 	/*
@@ -147,7 +148,7 @@ void *create_object_the_repository(const unsigned char *sha1, void *o)
 	hashcpy(obj->oid.hash, sha1);
 
 	if (the_repository->parsed_objects->obj_hash_size - 1 <= the_repository->parsed_objects->nr_objs * 2)
-		grow_object_hash();
+		grow_object_hash(the_repository);
 
 	insert_obj_hash(obj, the_repository->parsed_objects->obj_hash,
 			the_repository->parsed_objects->obj_hash_size);
-- 
2.17.0.441.gb46fe60e1d-goog

