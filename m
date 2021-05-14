Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70967C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6276141F
	for <git@archiver.kernel.org>; Fri, 14 May 2021 14:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhENOhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhENOhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 10:37:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87DC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 07:36:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k127so28882696qkc.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsVTUU+qgjq41r/L/f0DE/C/bMjrdpnEykjHQ9uE44Q=;
        b=VlrUs+EfQhsiyJkCIk+gv7qDP9K3lkw1UkQtmvdzOGz3u9xul0kzAdB1ZEdczzJaZ6
         YnEUsoYihwcS5T9fSq6xeWccbOx23ndqIq2qd97AXLPG06KDRjbs//oXGJ2zr4QP3Y9S
         T7A2yiKaPQ5FRUYkusW9L9UEbHQxDC9C828HpGrMi+6yN2zBbQ7HxqzmI8y87B+L0Sga
         ajdVyKLRYxD1UPi/bbH4eVD51szSXl7O7V6JWZSMTYmroZylK8wrtazdlIq8ZeUpwmtO
         9GPHCuK6g36YMxptcfsrgVmbWi880YVdNcoxVQ+yyzWHBoXhu2fn+RbHO7dJzC9qteEj
         d7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsVTUU+qgjq41r/L/f0DE/C/bMjrdpnEykjHQ9uE44Q=;
        b=f47LbYHVAlnGN5UWhN/D83S4tAe9wiyivgRwRxnPHFB59IySv07wgaNzRHdpeI9EUW
         uI6tLs2SHuITow8/wz8FcPWfQzR4MuPIL857pQ3lCLesDwZ7pA+xx2jhQYpW1E6+mPzU
         uhn3AAGALmGG03CR74lQnG7+/z5AoYIdvbjHIMwUJHUc/kdd2C4JJxH5J48Cud7rnJrx
         TiSCe6tWufr/Y6Yo6WVynmwnwE6Pl5ZUh0S+rb9Jo2T6BlxnucL68E/ikRbqA2pHbmoM
         jTroZ/96OzJe+HmAkLZe1wtPFVbyo6XNTuJVXz+j6zQLoQX2XPZQigqDVxHp2VhHbERP
         Phvw==
X-Gm-Message-State: AOAM530fRYsVo9WfcFEK9vuwBCejjoRkCSNDnhIRXt7u/Db+ujJa4prs
        Y6GNhSQC8iEng9pOL8ZrfXN6Wt1MMkG55Q==
X-Google-Smtp-Source: ABdhPJzNaOpfBNWuCpDMqA2Cz8hvVgWuvv4ifTHuAhnTzLy6IABeZTTQDbdnZor4h1E3wfD3TBB4gw==
X-Received: by 2002:a37:785:: with SMTP id 127mr43924753qkh.58.1621002967049;
        Fri, 14 May 2021 07:36:07 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id i5sm4813228qki.115.2021.05.14.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:36:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org
Subject: [RFC PATCH] parallel-checkout: send the new object_id algo field to the workers
Date:   Fri, 14 May 2021 11:36:00 -0300
Message-Id: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
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

Hi, brian

I've read the hash transition plan, but I'm not confident to say that I
fully understand it yet, so maybe this patch is not exactly what we need
here. Mainly, I'm not sure I understand in which cases we will have an
object_id.algo that is not the_hash_algo. Is it for the early transition
phases, where we have a SHA-256 repo that accepts user input as SHA-1? 

Also, the object_id's copied here at send_one_item() always come from a
`struct cache_entry`. In this case, can they still have different
`algo`s or do we expect them to be the_hash_algo?

Thanks!

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
index 09e8b10a35..684cbb9ab4 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -393,7 +393,7 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
 		   working_tree_encoding_len;
 
-	data = xcalloc(1, len_data);
+	data = xmalloc(len_data);
 
 	fixed_portion = (struct pc_item_fixed_portion *)data;
 	fixed_portion->id = pc_item->id;
@@ -403,13 +403,12 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
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

