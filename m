Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B9C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbhLVS47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbhLVS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A6C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so6814263wrd.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ifvX/FZZWEtWmoSJwuxEfFvFGzduSB4zEMVZ/LX8/Lk=;
        b=o0PBrs+VhHpw0ZMchb3trUY88rjSWUXHs0jR7iXZBnPL93MdSkIwOPmkuOinKsqlqS
         Jyso2ZtjeSTj0EIcqT4U1nyvOVWGqOYpQEHcUOWqTVM/2fu9g5zrLXmcIHfahI59k1kR
         csEQHa/gLEA1T2lO8aJJrJV/uFthtJav5+w1SIz2mTCEC4FBF2gzIX+rdcXt2jLNrEXt
         axcsn/FbdekmprwtAlPH5RzXkKFe1Rfq0q+ITt4d8ZSy1diZjbi3oO5PrxIFGgo3hWEX
         05AleM+5kn3bhxeRJ2SBl/PCBjnf1JTVhqXGK0AgxpCwK9nqAMCvhFwhyf37ZeNcZhx8
         xD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ifvX/FZZWEtWmoSJwuxEfFvFGzduSB4zEMVZ/LX8/Lk=;
        b=LnE2ovX+C0c6mT48sJ8pAkBH3E2kD+Q9MyjgqLsXoCuYAikZIhKFOPTwfLfHrxQwSg
         U4dr/NKXzEIRIiTfeMdl1Axnm1iW1a2shiOlO2MjnAGUfxRL41GGauj9RMRSzOw59hVn
         nXAuf2KxtJj5mTplwojwDMdGibaX3LNPtQ4GUNI1h3sx32nveuYcKwC1gcKrWyn1SbE2
         NQI4EezxqLV1NJU9dt0mEBnv71EQciTL8kgeZYqGDFwnOGbj9pNdTXbkhJz4tJVSlPCO
         aBZtBRF5eT4lJG4hhZWidekQfpiWOMg+V6knKKN/brZw6Mb7cSGmX3hvXFBF8SOq2r5P
         oucQ==
X-Gm-Message-State: AOAM531oDueDtdAsgHGqqKuyWSIqeR1xiqSvgh+V2/SKaBWGout1+Nrf
        kXjUTiRdrDqUn+aS+gimS4EdBKW0Oro=
X-Google-Smtp-Source: ABdhPJxJ4WdIVWG5+e+9i7m9RBSZ5kEbPVDiT8mirFTQ4ADyF81Irqt+HGm8mu6UK086iOlSyXMzVg==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr2911481wrv.83.1640199404975;
        Wed, 22 Dec 2021 10:56:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm3104699wrd.10.2021.12.22.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:44 -0800 (PST)
Message-Id: <c81b17ad57e2ac82bca8d8705099fc6d343cae81.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:32 +0000
Subject: [PATCH v5 12/16] reftable: implement record equality generically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This simplifies unittests a little, and provides further coverage for
reftable_record_copy().

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c      | 57 +++++++++++++++++++++++++++++++++++++++++-
 reftable/record.h      |  5 +++-
 reftable/record_test.c | 23 +++--------------
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index f7c77c51539..2a9e41a992e 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -430,6 +430,15 @@ static int reftable_ref_record_is_deletion_void(const void *p)
 		(const struct reftable_ref_record *)p);
 }
 
+
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
@@ -439,6 +448,7 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.decode = &reftable_ref_record_decode,
 	.release = &reftable_ref_record_release_void,
 	.is_deletion = &reftable_ref_record_is_deletion_void,
+	.equal = &reftable_ref_record_equal_void,
 };
 
 static void reftable_obj_record_key(const void *r, struct strbuf *dest)
@@ -572,6 +582,25 @@ static int not_a_deletion(const void *p)
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
+	if (ra->hash_prefix_len &&
+	    memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
+		return 0;
+	if (ra->offset_len &&
+	    memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
+		return 0;
+
+	return 1;
+}
+
 static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
 	.type = BLOCK_TYPE_OBJ,
@@ -580,7 +609,8 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.encode = &reftable_obj_record_encode,
 	.decode = &reftable_obj_record_decode,
 	.release = &reftable_obj_record_release,
-	.is_deletion = not_a_deletion,
+	.is_deletion = &not_a_deletion,
+	.equal = &reftable_obj_record_equal_void,
 };
 
 void reftable_log_record_print(struct reftable_log_record *log,
@@ -881,6 +911,14 @@ static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
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
@@ -924,6 +962,7 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.decode = &reftable_log_record_decode,
 	.release = &reftable_log_record_release_void,
 	.is_deletion = &reftable_log_record_is_deletion_void,
+	.equal = &reftable_log_record_equal_void
 };
 
 struct reftable_record reftable_new_record(uint8_t typ)
@@ -1042,6 +1081,14 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
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
@@ -1051,6 +1098,7 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.decode = &reftable_index_record_decode,
 	.release = &reftable_index_record_release,
 	.is_deletion = &not_a_deletion,
+	.equal = &reftable_index_record_equal,
 };
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
@@ -1098,6 +1146,13 @@ int reftable_record_is_deletion(struct reftable_record *rec)
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

