Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337EC2D0E7
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9329206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnAb46Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgC3Abr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgC3Abq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id f74so8817267wmf.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vU8KsqMF4jrOIHiDLFv6tiZ3pZ9gGp87uv6xrWTW7Dg=;
        b=ZnAb46TzhqDsdZGLp97GTl0A57cBdw1RPJBjIOs95qiys4xSS7UwzJ3Dlj2M4gDNS0
         WLB3O0WurlbgzsAKCprHkpgXi2x+s8UcRuRUPaaWtBsNe1wS1m2ve4wKkmbRZztT3RJR
         NcUT2xqjxNlJlmhRCvN/b2OZyNZk0+TTf3o7d03Rix414HTuHIEgU8EcmtBfTHC9tAnu
         nFSUYnzyBrv2IYyOPX8n5aeDKHNZBA9pYlU0A0R1sIrck+yDAHkx4glAaixSxd52u74e
         Zsgp7/CGu/heqUJYlJiqiPHlWX+kg/bX7OwLHW0xvg0dwenBg7sCrCQaZKJIi39y8xpi
         ReCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vU8KsqMF4jrOIHiDLFv6tiZ3pZ9gGp87uv6xrWTW7Dg=;
        b=IM0ZcDuEBPqzGGq2GCK0NyjruK7o1tuTVVDEOgoZZXegmWgEAMhaC5AMwi4mUohkpK
         7pqLFE39vZezW8Ggoctd3ugM3KuLQ9+5Zfnz4AaK4R+/wQodT1H+tGzSoMetcb05DpSr
         37IjUeivmWMzaAsuF8jarFglTW/Xk4ii174wDIS0MteTJgTL/ph1iVXQUq/wA3Gxqm9a
         sNzL+qwD+bZpXC37gFO8NoIq+rcQnQJSeqleqw6XRKfgt2Rrdrle8PYHrGGAhxaCL81j
         hDkaY7H0sjqmv6FM3byGXWiH7hUHg6PfkEkgnWm/Mu7kZ0v3XCfRAFxwGjk4RqCOqjR3
         02lw==
X-Gm-Message-State: ANhLgQ1GMQ0R9htOb0sZpzclZ9jWrdjWHEowVuK3qFaazxxYLmIcZACp
        U463y4K+EiZZMiW0Ru8xChZxUzd5
X-Google-Smtp-Source: ADFU+vuAnFSCJOu07qAL0GefzeOXObH8TwGysGh2vFxjmvSeQ2bVYIacsyRwxjp8UAITGgsanjgTeQ==
X-Received: by 2002:a1c:ac88:: with SMTP id v130mr10675787wme.34.1585528303744;
        Sun, 29 Mar 2020 17:31:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o67sm19410925wmo.5.2020.03.29.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:43 -0700 (PDT)
Message-Id: <a7702c1afde1ce9d4c628a831927b4e75bff8515.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:25 +0000
Subject: [PATCH v3 03/16] bloom.c: introduce core Bloom filter constructs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Introduce the constructs for Bloom filters, Bloom filter keys
and Bloom filter settings.
For details on what Bloom filters are and how they work, refer
to Dr. Derrick Stolee's blog post [1]. It provides a concise
explanation of the adoption of Bloom filters as described in
[2] and [3].

Implementation specifics:
1. We currently use 7 and 10 for the number of hashes and the
   size of each entry respectively. They served as great starting
   values, the mathematical details behind this choice are
   described in [1] and [4]. The implementation, while not
   completely open to it at the moment, is flexible enough to allow
   for tweaking these settings in the future.

   Note: The performance gains we have observed with these values
   are significant enough that we did not need to tweak these
   settings. The performance numbers are included in the cover letter
   of this series and in the commit message of the subsequent commit
   where we use Bloom filters to speed up `git log -- path`.

2. As described in [1] and [3], we do not need 7 independent hashing
   functions. We use the Murmur3 hashing scheme, seed it twice and
   then combine those to procure an arbitrary number of hash values.

3. The filters will be sized according to the number of changes in
   each commit, in multiples of 8 bit words.

[1] Derrick Stolee
      "Supercharging the Git Commit Graph IV: Bloom Filters"
      https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/

[2] Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, George Varghese
    "An Improved Construction for Counting Bloom Filters"
    http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
    https://doi.org/10.1007/11841036_61

[3] Peter C. Dillinger and Panagiotis Manolios
    "Bloom Filters in Probabilistic Verification"
    http://www.ccs.neu.edu/home/pete/pub/Bloom-filters-verification.pdf
    https://doi.org/10.1007/978-3-540-30494-4_26

[4] Thomas Mueller Graf, Daniel Lemire
    "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
    https://arxiv.org/abs/1912.08258

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c               | 38 +++++++++++++++++++++++++-
 bloom.h               | 63 +++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-bloom.c | 48 +++++++++++++++++++++++++++++++++
 t/t0095-bloom.sh      | 40 +++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index 40e87632aeb..888b67f1ea6 100644
--- a/bloom.c
+++ b/bloom.c
@@ -8,6 +8,11 @@ static uint32_t rotate_left(uint32_t value, int32_t count)
 	return ((value << count) | (value >> ((-count) & mask)));
 }
 
+static inline unsigned char get_bitmask(uint32_t pos)
+{
+	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
+}
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
@@ -70,4 +75,35 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 	seed ^= (seed >> 16);
 
 	return seed;
-}
\ No newline at end of file
+}
+
+void fill_bloom_key(const char *data,
+					size_t len,
+					struct bloom_key *key,
+					const struct bloom_filter_settings *settings)
+{
+	int i;
+	const uint32_t seed0 = 0x293ae76f;
+	const uint32_t seed1 = 0x7e646e2c;
+	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
+	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
+
+	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
+	for (i = 0; i < settings->num_hashes; i++)
+		key->hashes[i] = hash0 + i * hash1;
+}
+
+void add_key_to_filter(const struct bloom_key *key,
+					   struct bloom_filter *filter,
+					   const struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_WORD;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
+
+		filter->data[block_pos] |= get_bitmask(hash_mod);
+	}
+}
diff --git a/bloom.h b/bloom.h
index d0fcc5f0aa6..b9ce422ca2d 100644
--- a/bloom.h
+++ b/bloom.h
@@ -1,6 +1,60 @@
 #ifndef BLOOM_H
 #define BLOOM_H
 
+struct bloom_filter_settings {
+	/*
+	 * The version of the hashing technique being used.
+	 * We currently only support version = 1 which is
+	 * the seeded murmur3 hashing technique implemented
+	 * in bloom.c.
+	 */
+	uint32_t hash_version;
+
+	/*
+	 * The number of times a path is hashed, i.e. the
+	 * number of bit positions tht cumulatively
+	 * determine whether a path is present in the
+	 * Bloom filter.
+	 */
+	uint32_t num_hashes;
+
+	/*
+	 * The minimum number of bits per entry in the Bloom
+	 * filter. If the filter contains 'n' entries, then
+	 * filter size is the minimum number of 8-bit words
+	 * that contain n*b bits.
+	 */
+	uint32_t bits_per_entry;
+};
+
+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
+#define BITS_PER_WORD 8
+
+/*
+ * A bloom_filter struct represents a data segment to
+ * use when testing hash values. The 'len' member
+ * dictates how many entries are stored in
+ * 'data'.
+ */
+struct bloom_filter {
+	unsigned char *data;
+	size_t len;
+};
+
+/*
+ * A bloom_key represents the k hash values for a
+ * given string. These can be precomputed and
+ * stored in a bloom_key for re-use when testing
+ * against a bloom_filter. The number of hashes is
+ * given by the Bloom filter settings and is the same
+ * for all Bloom filters and keys interacting with
+ * the loaded version of the commit graph file and
+ * the Bloom data chunks.
+ */
+struct bloom_key {
+	uint32_t *hashes;
+};
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
@@ -10,4 +64,13 @@
  */
 uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
 
+void fill_bloom_key(const char *data,
+		    size_t len,
+		    struct bloom_key *key,
+		    const struct bloom_filter_settings *settings);
+
+void add_key_to_filter(const struct bloom_key *key,
+					   struct bloom_filter *filter,
+					   const struct bloom_filter_settings *settings);
+
 #endif
\ No newline at end of file
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 60ee2043689..20460cde775 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -2,6 +2,36 @@
 #include "bloom.h"
 #include "test-tool.h"
 
+struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+
+static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
+		struct bloom_key key;
+		int i;
+
+		fill_bloom_key(data, strlen(data), &key, &settings);
+		printf("Hashes:");
+		for (i = 0; i < settings.num_hashes; i++){
+			printf("0x%08x|", key.hashes[i]);
+		}
+		printf("\n");
+		add_key_to_filter(&key, filter, &settings);
+}
+
+static void print_bloom_filter(struct bloom_filter *filter) {
+	int i;
+
+	if (!filter) {
+		printf("No filter.\n");
+		return;
+	}
+	printf("Filter_Length:%d\n", (int)filter->len);
+	printf("Filter_Data:");
+	for (i = 0; i < filter->len; i++){
+		printf("%02x|", filter->data[i]);
+	}
+	printf("\n");
+}
+
 int cmd__bloom(int argc, const char **argv)
 {
 	if (!strcmp(argv[1], "get_murmur3")) {
@@ -9,5 +39,23 @@ int cmd__bloom(int argc, const char **argv)
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
+    if (!strcmp(argv[1], "generate_filter")) {
+		struct bloom_filter filter;
+		int i = 2;
+		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter.data = xcalloc(filter.len, sizeof(unsigned char));
+
+		if (!argv[2]){
+			die("at least one input string expected");
+		}
+
+		while (argv[i]) {
+			add_string_to_filter(argv[i], &filter);
+			i++;
+		}
+
+		print_bloom_filter(&filter);
+	}
+
 	return 0;
 }
\ No newline at end of file
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 2dad8c4a94e..36a086c7c60 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -27,4 +27,44 @@ test_expect_success 'compute unseeded murmur3 hash for test string 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'compute bloom key for empty string' '
+	cat >expect <<-\EOF &&
+	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
+	Filter_Length:2
+	Filter_Data:11|11|
+	EOF
+	test-tool bloom generate_filter "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for whitespace' '
+	cat >expect <<-\EOF &&
+	Hashes:0xf178874c|0x5f3d6eb6|0xcd025620|0x3ac73d8a|0xa88c24f4|0x16510c5e|0x8415f3c8|
+	Filter_Length:2
+	Filter_Data:51|55|
+	EOF
+	test-tool bloom generate_filter " " >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for test string 1' '
+	cat >expect <<-\EOF &&
+	Hashes:0xb270de9b|0x1bb6f26e|0x84fd0641|0xee431a14|0x57892de7|0xc0cf41ba|0x2a15558d|
+	Filter_Length:2
+	Filter_Data:92|6c|
+	EOF
+	test-tool bloom generate_filter "Hello world!" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for test string 2' '
+	cat >expect <<-\EOF &&
+	Hashes:0x20ab385b|0xf5237fe2|0xc99bc769|0x9e140ef0|0x728c5677|0x47049dfe|0x1b7ce585|
+	Filter_Length:2
+	Filter_Data:a5|4a|
+	EOF
+	test-tool bloom generate_filter "file.txt" >actual &&
+	test_cmp expect actual
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

