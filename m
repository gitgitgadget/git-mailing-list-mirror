Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE3C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4EB61285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhEQTu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhEQTu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:50:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8275C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 12:49:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q10so7021395qkc.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRWUWGQOzy6Gx8UL2hpuSzK/JXn/cIj3K4kcMXr/CAg=;
        b=S+iGu4oyeziiCe8xSnBCTcePHgozKkqwLZESh58Mqwa8i6Vr6/lVWRz1XQk5Q/ryDW
         IrXzwvmJIZ6A3ZV14l1+plNGe10ycyq93hvQPA2M5A/2aL8xcj/UHzzPaavMWqocB20K
         Mvj7nohJjQQg4ShONTS+FHyL/CKQq/bBwiLSlkgnChF3EPdm+uUV5/bCpsAsJ7rmjF5S
         UqURHuPGD1zYYwrKAOYJdAN4ofNvIZBzK8lqH6rL7HUzZZ6fPaKxpOwCwjXzqUgXHVLX
         nkiM18XOWx4dJlp155HhflU9LXDMK6N+UHihxTWLfGli1oJRHJ9c6AdPJTN2BYnssp8g
         2ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRWUWGQOzy6Gx8UL2hpuSzK/JXn/cIj3K4kcMXr/CAg=;
        b=OqxhJT4Rw9NO1aAklKhT9Im9ltB1Njky+t8PQY4eKbJLWaguUyMgtGikjyoPBU1t42
         862NEOPSF/C04Ht0zhIDQhD4XDTi/qUjlLcBCZMlMvRYIsj1WzWs8THG/Db6gn1kd3kV
         FdGL90kda01K8tGpvfP3iWf3kXQmFoYg0YZLXSOgu7W4vYwYDKvSAoXaxpraOKfqqmyq
         KLRzgZClcFEBKM7Mv0t0iFe+wYyxPahoIa3yZ41gW3fsZVfsxnTl7p6ZtVm5k7iTIu7Y
         Q3gCnBicdWN38H7yowPHBWlWW7WnooXBpLC7IA6ZnJPx2cmKU8R3eCagV9oWo7o27t+m
         9+uA==
X-Gm-Message-State: AOAM532+y1927FIsNAylPM/lPQwjNgSZajfalR6KwZQ4RL8/kSJt7iq9
        ajg7P6Bmf3LfqJLVThmLg9q15GYy3HBVqA==
X-Google-Smtp-Source: ABdhPJx+KTVFo46UM2Xzk4nPZ53lkPKPBY0nBOcV/Vcw9Vc1Jhlap0+F9ARAPFfeAeJsOMjZ52pgRw==
X-Received: by 2002:a05:620a:13ac:: with SMTP id m12mr1563023qki.77.1621280950934;
        Mon, 17 May 2021 12:49:10 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f127sm11174822qkd.81.2021.05.17.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:49:10 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, stolee@gmail.com
Subject: [PATCH v2] parallel-checkout: send the new object_id algo field to the workers
Date:   Mon, 17 May 2021 16:49:03 -0300
Message-Id: <4e113550d595925e4f458cdcb63c7d90205b389b.1621280649.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
References: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An object_id storing a SHA-1 name has some unused bytes at the end of
the hash array. Since these bytes are not used, they are usually not
initialized to any value either. However, at
parallel_checkout.c:send_one_item() the object_id of a cache entry is
copied into a buffer which is later sent to a checkout worker through a
pipe write(). This makes Valgrind complain about passing uninitialized
bytes to a syscall. The worker won't use these uninitialized bytes
either, but the warning could confuse someone trying to debug this code;
So instead of using oidcpy(), send_one_item() uses hashcpy() to only
copy the used/initialized bytes of the object_id, and leave the
remaining part with zeros.

However, since cf0983213c ("hash: add an algo member to struct
object_id", 2021-04-26), using hashcpy() is no longer sufficient here as
it won't copy the new algo field from the object_id. Let's add and use a
new function which meets both our requirements of copying all the
important object_id data while still avoiding the uninitialized bytes,
by padding the end of the hash array in the destination object_id. With
this change, we also no longer need the destination buffer from
send_one_item() to be initialized with zeros, so let's switch from
xcalloc() to xmalloc() to make this clear.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

There is no change since v1, I'm just dropping the RFC status :)


 hash.h              | 16 ++++++++++++++++
 parallel-checkout.c | 13 ++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hash.h b/hash.h
index 2986f991c6..9c6df4d952 100644
--- a/hash.h
+++ b/hash.h
@@ -263,6 +263,22 @@ static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 	dst->algo = src->algo;
 }
 
+/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
+static inline void oidcpy_with_padding(struct object_id *dst,
+				       struct object_id *src)
+{
+	size_t hashsz;
+
+	if (!src->algo)
+		hashsz = the_hash_algo->rawsz;
+	else
+		hashsz = hash_algos[src->algo].rawsz;
+
+	memcpy(dst->hash, src->hash, hashsz);
+	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
+	dst->algo = src->algo;
+}
+
 static inline struct object_id *oiddup(const struct object_id *src)
 {
 	struct object_id *dst = xmalloc(sizeof(struct object_id));
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 6b1af32bb3..ddc0ff3c06 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -411,7 +411,7 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
 		   working_tree_encoding_len;
 
-	data = xcalloc(1, len_data);
+	data = xmalloc(len_data);
 
 	fixed_portion = (struct pc_item_fixed_portion *)data;
 	fixed_portion->id = pc_item->id;
@@ -421,13 +421,12 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	fixed_portion->name_len = name_len;
 	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
 	/*
-	 * We use hashcpy() instead of oidcpy() because the hash[] positions
-	 * after `the_hash_algo->rawsz` might not be initialized. And Valgrind
-	 * would complain about passing uninitialized bytes to a syscall
-	 * (write(2)). There is no real harm in this case, but the warning could
-	 * hinder the detection of actual errors.
+	 * We pad the unused bytes in the hash array because, otherwise,
+	 * Valgrind would complain about passing uninitialized bytes to a
+	 * write() syscall. The warning doesn't represent any real risk here,
+	 * but it could hinder the detection of actual errors.
 	 */
-	hashcpy(fixed_portion->oid.hash, pc_item->ce->oid.hash);
+	oidcpy_with_padding(&fixed_portion->oid, &pc_item->ce->oid);
 
 	variant = data + sizeof(*fixed_portion);
 	if (working_tree_encoding_len) {
-- 
2.30.1

