Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B73C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347470AbiAXTdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352687AbiAXTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D4CC061A7E
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a13so15476104wrh.9
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FbnsH1HGDpSv3hUkzpcagL9He39C7BCnALhMQYFFCrc=;
        b=KiNdi8n/RnpKZqmvMAVQ1opHBitsn2dXvvbDSNNhUnDCZH8XjdBOR8iawD4x4DqIz8
         w3k5jnFyxXTdSxWHcDEnKGwe3GZJXpflQxNhEdJZuKyE9rVe6xvE5PoVFao1lyffSPwx
         8gVLDB+uGupiKyaT9eX2mcYOOA704LEQ1Fxz2KcVePvYAv6LvGcjo/4xwo+suerjUnoi
         o8eEP4O6ux6WuJfp1aAikbMRDRKAxQN3mUsXjknf4f5BFTA/8IEy7+f49Xl9hpPzfuCx
         J2ZRGRl8Bh5H0BBHN/nq+/5BQjQ88lWMxjZhNNqNdk8Q02snRsraDIJ2sVALmM9M+gSi
         aL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FbnsH1HGDpSv3hUkzpcagL9He39C7BCnALhMQYFFCrc=;
        b=UqJW2Qb8uwEhGyOhCsj01+9s2eMuOocIsvCN2wjgv2eAhA3oinA5e2u9VtFrCLUQYg
         Xq8/sq5f+Ym+3qk2Yr0+aWb9VXsjDOI7RMCzthDxXGLiYKm9Ji4vUdWygloPG+Qhorkx
         S1vnhmg820BDT7RtycoCM4MYblHoSi0eaqrRJKAkbYgokBv5c0u4YOHpxTq9bL/qM+Tu
         UqGeRxzb1WRbRvHEwiTubfyweZk2lmFqlYzNZYwmLxRWYFAIEIXp5576+cXZ5CIvbp21
         U12KuudelAXo3xXP2opVKmR0bPjHDZTqVf1amFABWqmyCoKZ1USBxEHGkvleaBlXqK0X
         NVlg==
X-Gm-Message-State: AOAM532gAYsI8AfM9SoHP34NSdA1zlLnZ5i8tAMPB+KxBxXvONUJ5D9F
        9Xzb2pl4cYvq1hTZI/SD+Ql4zGslJYQ1vA==
X-Google-Smtp-Source: ABdhPJzH73HBaEZYn7YzxEvjaToGK/nj9aiKWnQZ3DtKOC4P1X7cbfKWj1va5flStwWePR26doZknA==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr6703795wrr.173.1643051636631;
        Mon, 24 Jan 2022 11:13:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm192229wmq.24.2022.01.24.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:55 -0800 (PST)
Message-Id: <a83a9cf59b7b3e7200611e067b59866d0b678b46.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:40 +0000
Subject: [PATCH v7 12/16] reftable: implement record equality generically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This simplifies unittests a little, and provides further coverage for
reftable_record_copy().

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c      | 54 +++++++++++++++++++++++++++++++++++++++++-
 reftable/record.h      |  5 +++-
 reftable/record_test.c | 23 +++---------------
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 1ae344c745b..b543585ad39 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -430,6 +430,14 @@ static int reftable_ref_record_is_deletion_void(const void *p)
 		(const struct reftable_ref_record *)p);
 }
 
+static int reftable_ref_record_equal_void(const void *a,
+					  const void *b, int hash_size)
+{
+	struct reftable_ref_record *ra = (struct reftable_ref_record *) a;
+	struct reftable_ref_record *rb = (struct reftable_ref_record *) b;
+	return reftable_ref_record_equal(ra, rb, hash_size);
+}
+
 static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.key = &reftable_ref_record_key,
 	.type = BLOCK_TYPE_REF,
@@ -439,6 +447,7 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.decode = &reftable_ref_record_decode,
 	.release = &reftable_ref_record_release_void,
 	.is_deletion = &reftable_ref_record_is_deletion_void,
+	.equal = &reftable_ref_record_equal_void,
 };
 
 static void reftable_obj_record_key(const void *r, struct strbuf *dest)
@@ -572,6 +581,23 @@ static int not_a_deletion(const void *p)
 	return 0;
 }
 
+static int reftable_obj_record_equal_void(const void *a, const void *b, int hash_size)
+{
+	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
+	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
+
+	if (ra->hash_prefix_len != rb->hash_prefix_len
+	    || ra->offset_len != rb->offset_len)
+		return 0;
+
+	if (memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
+		return 0;
+	if (memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
+		return 0;
+
+	return 1;
+}
+
 static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
 	.type = BLOCK_TYPE_OBJ,
@@ -580,7 +606,8 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.encode = &reftable_obj_record_encode,
 	.decode = &reftable_obj_record_decode,
 	.release = &reftable_obj_record_release,
-	.is_deletion = not_a_deletion,
+	.is_deletion = &not_a_deletion,
+	.equal = &reftable_obj_record_equal_void,
 };
 
 void reftable_log_record_print(struct reftable_log_record *log,
@@ -881,6 +908,14 @@ static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
 	return !memcmp(a, b, sz);
 }
 
+static int reftable_log_record_equal_void(const void *a,
+					  const void *b, int hash_size)
+{
+	return reftable_log_record_equal((struct reftable_log_record *) a,
+					 (struct reftable_log_record *) b,
+					 hash_size);
+}
+
 int reftable_log_record_equal(const struct reftable_log_record *a,
 			      const struct reftable_log_record *b, int hash_size)
 {
@@ -924,6 +959,7 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.decode = &reftable_log_record_decode,
 	.release = &reftable_log_record_release_void,
 	.is_deletion = &reftable_log_record_is_deletion_void,
+	.equal = &reftable_log_record_equal_void
 };
 
 struct reftable_record reftable_new_record(uint8_t typ)
@@ -1042,6 +1078,14 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	return start.len - in.len;
 }
 
+static int reftable_index_record_equal(const void *a, const void *b, int hash_size)
+{
+	struct reftable_index_record *ia = (struct reftable_index_record *) a;
+	struct reftable_index_record *ib = (struct reftable_index_record *) b;
+
+	return ia->offset == ib->offset && !strbuf_cmp(&ia->last_key, &ib->last_key);
+}
+
 static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
 	.type = BLOCK_TYPE_INDEX,
@@ -1051,6 +1095,7 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.decode = &reftable_index_record_decode,
 	.release = &reftable_index_record_release,
 	.is_deletion = &not_a_deletion,
+	.equal = &reftable_index_record_equal,
 };
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
@@ -1098,6 +1143,13 @@ int reftable_record_is_deletion(struct reftable_record *rec)
 	return rec->ops->is_deletion(rec->data);
 }
 
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size)
+{
+	if (a->ops != b->ops)
+		return 0;
+	return a->ops->equal(a->data, b->data, hash_size);
+}
+
 void reftable_record_from_ref(struct reftable_record *rec,
 			      struct reftable_ref_record *ref_rec)
 {
diff --git a/reftable/record.h b/reftable/record.h
index 498e8c50bf4..da75d7d1f11 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -58,6 +58,9 @@ struct reftable_record_vtable {
 
 	/* is this a tombstone? */
 	int (*is_deletion)(const void *rec);
+
+	/* Are two records equal? This assumes they have the same type. Returns 0 for non-equal. */
+	int (*equal)(const void *a, const void *b, int hash_size);
 };
 
 /* record is a generic wrapper for different types of records. */
@@ -98,7 +101,7 @@ struct reftable_obj_record {
 };
 
 /* see struct record_vtable */
-
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
 uint8_t reftable_record_type(struct reftable_record *rec);
 void reftable_record_copy_from(struct reftable_record *rec,
diff --git a/reftable/record_test.c b/reftable/record_test.c
index f4ad7cace41..92680848156 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -21,18 +21,7 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	switch (reftable_record_type(&copy)) {
-	case BLOCK_TYPE_REF:
-		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
-						 reftable_record_as_ref(rec),
-						 GIT_SHA1_RAWSZ));
-		break;
-	case BLOCK_TYPE_LOG:
-		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
-						 reftable_record_as_log(rec),
-						 GIT_SHA1_RAWSZ));
-		break;
-	}
+	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
 	reftable_record_destroy(&copy);
 }
 
@@ -346,13 +335,7 @@ static void test_reftable_obj_record_roundtrip(void)
 					   GIT_SHA1_RAWSZ);
 		EXPECT(n == m);
 
-		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
-		EXPECT(in.offset_len == out.offset_len);
-
-		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
-			       in.hash_prefix_len));
-		EXPECT(0 == memcmp(in.offsets, out.offsets,
-				   sizeof(uint64_t) * in.offset_len));
+		EXPECT(reftable_record_equal(&rec, &rec_out, GIT_SHA1_RAWSZ));
 		strbuf_release(&key);
 		reftable_record_release(&rec_out);
 	}
@@ -390,7 +373,7 @@ static void test_reftable_index_record_roundtrip(void)
 	m = reftable_record_decode(&out_rec, key, extra, dest, GIT_SHA1_RAWSZ);
 	EXPECT(m == n);
 
-	EXPECT(in.offset == out.offset);
+	EXPECT(reftable_record_equal(&rec, &out_rec, GIT_SHA1_RAWSZ));
 
 	reftable_record_release(&out_rec);
 	strbuf_release(&key);
-- 
gitgitgadget

