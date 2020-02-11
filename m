Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC39C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D82206D6
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZkyN9Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgBKTI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:08:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34814 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBKTI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:08:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so5224765qkm.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbOvro2O0NcC+5cc4MEwln8nXBNck+pymYG75fGxCe0=;
        b=mZkyN9UePT4PusVNV8WxdBrX+fwALeFTFoVyDAuQwDhWfCpulAvmUlTbCatwfa92pS
         HCIolS5iIui83kXb+Pz8cDWnnsfROpRBtecadLzt7VRsJw89IY1Bi4Ghly/8NKT3T901
         Q14iX5dcZOJaOFLVogEV04YKw9XxpmhuiL56Qi4AbjxMYuWsFbIWQwB99Wgx9Fuvz/7q
         yVV17WW8PH5lxn/ESycHzy8QtS4cYkmhzdZu//4D+NfFZ5HCjVVyG0I91AB19ZDsQgnh
         P9NrCOUQEOY1XuMScjkyUAAByDp3CmMcKj0bM4OjiqD7TFf4n3Lpyp3ElkBMMNHvmpcy
         5tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbOvro2O0NcC+5cc4MEwln8nXBNck+pymYG75fGxCe0=;
        b=n/Dha80CxginGslPC4Ob6gVcHO+yrS7KcQXL2X47hdxD68VjEmMkk99aCaf3XANF3l
         sXGX08NS5GKXCVk038nyn8U6vu/AQRnCx0ZQpMNX6MyJjgeLLPq+ySnrM536annePv5a
         UfoRYMMgOmY3F+pw45x56xQvfuLK/7ZCzHcwYCQiwB51SPjnpWZ/+KCLfa1dRNhd9BbS
         G/XDFsozu8eTDkx/z6ikomwSmPi+0oQNZlLuZfbLd5RR3p9V9MB7PI5HhNPRxGT/Vfeb
         0Kv2IJKtv7BCAe9a4Yc7j7X5IA8OL6xCUKYpSbsTwYjYA1PibZeCphViHtTHp+pefJaV
         Brig==
X-Gm-Message-State: APjAAAXMXJNvkgXjwZGBEXEQGZJl0caXhfL+47rvD1xNPjqL+FKPck+e
        vB/XFehhaeeFMi9YyvRRZ5o=
X-Google-Smtp-Source: APXvYqzLaBguYOXD3hTeHa4+9U5D+AaQzLLRnwQZLigfra1Zl62RflHfQIUUlCywnJ5HvpY92xGe+A==
X-Received: by 2002:ae9:f719:: with SMTP id s25mr7507182qkg.209.1581448134775;
        Tue, 11 Feb 2020 11:08:54 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:4033:f853:2b3b:f1c9? ([2001:4898:a800:1010:f169:f853:2b3b:f1c9])
        by smtp.gmail.com with ESMTPSA id t29sm2428283qkt.36.2020.02.11.11.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:08:54 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
From:   Garima Singh <garimasigit@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        jnareb@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <20200207135249.GD2868@szeder.dev>
 <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
Message-ID: <ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com>
Date:   Tue, 11 Feb 2020 14:08:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/7/2020 10:09 AM, Garima Singh wrote:
> 
> On 2/7/2020 8:52 AM, SZEDER Gábor wrote:
>>>  * Added unit tests for the bloom filter computation layer
>>
>> This fails on big endian, e.g. in Travis CI's s390x build:
>>
>>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210
>>
>> (The link highlights the failure, but I'm afraid your browser won't
>> jump there right away; you'll have to click on the print-test-failures
>> fold at the bottom, and scroll down a bit...)
>>
> 
> Thank you so much for running this pipeline and pointing out the error!
> 
> We will carefully review our interactions with the binary data and 
> hopefully solve this in the next version. 
> 
> Cheers!
> Garima Singh
> 

Hey! 

The patch below carries the fix for the failure on Big-endian architectures.
We now treat bloom filter data as a simple binary stream of 1 byte words 
instead of 8 byte words. This avoids the Big-endian vs Little-endian 
confusion on different CPU architectures. 

Here is the successful run of SZEDER's Travis CI s390x build. 

 https://travis-ci.org/szeder/git/jobs/649044879

I will be squashing this patch into the appropriate commits in the series
in v3, which I will send out after people have had a chance to complete
their review of v2. 

A special thanks to SZEDER for helping us test our patches on his CI 
pipeline and saving us the overhead of setting up a Big-endian machine!

Cheers!
Garima Singh

-->8--

From ee72310dd8c3ad2b810914edb651008f637e7c2a Mon Sep 17 00:00:00 2001
From: Garima Singh <garima.singh@microsoft.com>
Date: Tue, 11 Feb 2020 13:55:03 -0500
Subject: [PATCH] Process bloom filter data as 1 byte words

Process bloom filter data as 1 byte words instead of 8 byte
words to avoid the Big-endian vs Little-endian confusion on
different CPU architectures

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c               |  24 ++++-----
 bloom.h               |   4 +-
 commit-graph.c        |   4 +-
 t/helper/test-bloom.c |   4 +-
 t/t0095-bloom.sh      | 118 +++++++++++++++++++++---------------------
 5 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/bloom.c b/bloom.c
index 90d84dc713..6d5d6bb2ef 100644
--- a/bloom.c
+++ b/bloom.c
@@ -45,12 +45,13 @@ static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
 
 	int len4 = len / sizeof(uint32_t);
 
-	const uint32_t *blocks = (const uint32_t*)data;
-
 	uint32_t k;
-	for (i = 0; i < len4; i++)
-	{
-		k = blocks[i];
+	for (i = 0; i < len4; i++) {	
+		uint32_t byte1 = (uint32_t)data[4*i];
+		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
+		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
+		uint32_t byte4 = ((uint32_t)data[4*i + 3]) << 24;
+		k = byte1 | byte2 | byte3 | byte4;
 		k *= c1;
 		k = rotate_right(k, r1);
 		k *= c2;
@@ -61,8 +62,7 @@ static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
 
 	tail = (data + len4 * sizeof(uint32_t));
 
-	switch (len & (sizeof(uint32_t) - 1))
-	{
+	switch (len & (sizeof(uint32_t) - 1)) {
 	case 3:
 		k1 ^= ((uint32_t)tail[2]) << 16;
 		/*-fallthrough*/
@@ -88,9 +88,9 @@ static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
 	return seed;
 }
 
-static inline uint64_t get_bitmask(uint32_t pos)
+static inline unsigned char get_bitmask(uint32_t pos)
 {
-	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
+	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
 void load_bloom_filters(void)
@@ -152,8 +152,8 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 		start_index = 0;
 
 	filter->len = end_index - start_index;
-	filter->data = (uint64_t *)(g->chunk_bloom_data +
-					sizeof(uint64_t) * start_index +
+	filter->data = (unsigned char *)(g->chunk_bloom_data +
+					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
 
 	return 1;
@@ -234,7 +234,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
-		filter->data = xcalloc(filter->len, sizeof(uint64_t));
+		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/bloom.h b/bloom.h
index 76f8a9ad0c..9604723ce0 100644
--- a/bloom.h
+++ b/bloom.h
@@ -12,7 +12,7 @@ struct bloom_filter_settings {
 };
 
 #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
-#define BITS_PER_WORD 64
+#define BITS_PER_WORD 8
 #define BLOOMDATA_CHUNK_HEADER_SIZE 3*sizeof(uint32_t)
 
 /*
@@ -22,7 +22,7 @@ struct bloom_filter_settings {
  * 'data'.
  */
 struct bloom_filter {
-	uint64_t *data;
+	unsigned char *data;
 	int len;
 };
 
diff --git a/commit-graph.c b/commit-graph.c
index c0e9834bf2..f5f9a23c9a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1125,7 +1125,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		display_progress(progress, ++i);
-		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
+		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
 		list++;
 	}
 
@@ -1305,7 +1305,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_by_pos[i];
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
-		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
+		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 9b4be97f75..8fa2d8fc25 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -23,7 +23,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
 	printf("Filter_Length:%d\n", filter->len);
 	printf("Filter_Data:");
 	for (i = 0; i < filter->len; i++){
-		printf("%"PRIx64"|", filter->data[i]);
+		printf("%02x|", filter->data[i]);
 	}
 	printf("\n");
 }
@@ -57,7 +57,7 @@ int cmd__bloom(int argc, const char **argv)
 		struct bloom_filter filter;
 		int i = 2;
 		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
-		filter.data = xcalloc(filter.len, sizeof(uint64_t));
+		filter.data = xcalloc(filter.len, sizeof(unsigned char));
 
 		if (!argv[2]){
 			die("at least one input string expected");
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 424fe4fc29..58273219ff 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -3,58 +3,11 @@
 test_description='test bloom.c'
 . ./test-lib.sh
 
-test_expect_success 'get bloom filters for commit with no changes' '
-	git init &&
-	git commit --allow-empty -m "c0" &&
-	cat >expect <<-\EOF &&
-	Filter_Length:0
-	Filter_Data:
-	EOF
-	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'get bloom filter for commit with 10 changes' '
-	rm actual &&
-	rm expect &&
-	mkdir smallDir &&
-	for i in $(test_seq 0 9)
-	do
-		echo $i >smallDir/$i
-	done &&
-	git add smallDir &&
-	git commit -m "commit with 10 changes" &&
-	cat >expect <<-\EOF &&
-	Filter_Length:4
-	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|
-	EOF
-	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
-	rm actual &&
-	rm expect &&
-	mkdir bigDir &&
-	for i in $(test_seq 0 512)
-	do
-		echo $i >bigDir/$i
-	done &&
-	git add bigDir &&
-	git commit -m "commit with 513 changes" &&
-	cat >expect <<-\EOF &&
-	Filter_Length:0
-	Filter_Data:
-	EOF
-	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'compute bloom key for empty string' '
 	cat >expect <<-\EOF &&
 	Hashes:5615800c|5b966560|61174ab4|66983008|6c19155c|7199fab0|771ae004|
-	Filter_Length:1
-	Filter_Data:11000110001110|
+	Filter_Length:2
+	Filter_Data:11|11|
 	EOF
 	test-tool bloom generate_filter "" >actual &&
 	test_cmp expect actual
@@ -63,8 +16,8 @@ test_expect_success 'compute bloom key for empty string' '
 test_expect_success 'compute bloom key for whitespace' '
 	cat >expect <<-\EOF &&
 	Hashes:1bf014e6|8a91b50b|f9335530|67d4f555|d676957a|4518359f|b3b9d5c4|
-	Filter_Length:1
-	Filter_Data:401004080200810|
+	Filter_Length:2
+	Filter_Data:71|8c|
 	EOF
 	test-tool bloom generate_filter " " >actual &&
 	test_cmp expect actual
@@ -73,8 +26,8 @@ test_expect_success 'compute bloom key for whitespace' '
 test_expect_success 'compute bloom key for a root level folder' '
 	cat >expect <<-\EOF &&
 	Hashes:1a21016f|fff1c06d|e5c27f6b|cb933e69|b163fd67|9734bc65|7d057b63|
-	Filter_Length:1
-	Filter_Data:aaa800000000|
+	Filter_Length:2
+	Filter_Data:a8|aa|
 	EOF
 	test-tool bloom generate_filter "A" >actual &&
 	test_cmp expect actual
@@ -83,8 +36,8 @@ test_expect_success 'compute bloom key for a root level folder' '
 test_expect_success 'compute bloom key for a root level file' '
 	cat >expect <<-\EOF &&
 	Hashes:e2d51107|30970605|7e58fb03|cc1af001|19dce4ff|679ed9fd|b560cefb|
-	Filter_Length:1
-	Filter_Data:a8000000000000aa|
+	Filter_Length:2
+	Filter_Data:aa|a8|
 	EOF
 	test-tool bloom generate_filter "file.txt" >actual &&
 	test_cmp expect actual
@@ -93,8 +46,8 @@ test_expect_success 'compute bloom key for a root level file' '
 test_expect_success 'compute bloom key for a deep folder' '
 	cat >expect <<-\EOF &&
 	Hashes:864cf838|27f055cd|c993b362|6b3710f7|0cda6e8c|ae7dcc21|502129b6|
-	Filter_Length:1
-	Filter_Data:1c0000600003000|
+	Filter_Length:2
+	Filter_Data:c6|31|
 	EOF
 	test-tool bloom generate_filter "A/B/C/D/E" >actual &&
 	test_cmp expect actual
@@ -103,11 +56,58 @@ test_expect_success 'compute bloom key for a deep folder' '
 test_expect_success 'compute bloom key for a deep file' '
 	cat >expect <<-\EOF &&
 	Hashes:07cdf850|4af629c7|8e1e5b3e|d1468cb5|146ebe2c|5796efa3|9abf211a|
-	Filter_Length:1
-	Filter_Data:4020100804010080|
+	Filter_Length:2
+	Filter_Data:a9|54|
 	EOF
 	test-tool bloom generate_filter "A/B/C/D/E/file.txt" >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'get bloom filters for commit with no changes' '
+	git init &&
+	git commit --allow-empty -m "c0" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:0
+	Filter_Data:
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get bloom filter for commit with 10 changes' '
+	rm actual &&
+	rm expect &&
+	mkdir smallDir &&
+	for i in $(test_seq 0 9)
+	do
+		echo $i >smallDir/$i
+	done &&
+	git add smallDir &&
+	git commit -m "commit with 10 changes" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:25
+	Filter_Data:c2|0b|b8|c0|10|88|f0|1d|c1|0c|01|a4|01|28|81|80|01|30|10|d0|92|be|88|10|8a|
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
+	rm actual &&
+	rm expect &&
+	mkdir bigDir &&
+	for i in $(test_seq 0 512)
+	do
+		echo $i >bigDir/$i
+	done &&
+	git add bigDir &&
+	git commit -m "commit with 513 changes" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:0
+	Filter_Data:
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.22.0.windows.1

