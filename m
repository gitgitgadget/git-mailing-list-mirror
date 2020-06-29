Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD0C433E3
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1412053B
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSUDbBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgF2TDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbgF2TCo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C6C02A550
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 06:02:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so12605953qke.9
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ze9fU6zgtlTge6qolZOJHvQIL2kY/OS9l69w4qErMgU=;
        b=IKSUDbBf4OdR1RGySc3y2W8sfUGprohemAyfyeoGKmUsyUiGdMa13VJpnjnYwsNfkc
         sY+tK8OC/fch5hg1HYwkae6FPC2ukJvSCglDFeRNmFhhRy6jQobKlQlD8XSgQMgxJx2i
         UkiUScYLRQKtnLYDpP+BtDa5Qayc4pPKiq7OUa0mETXxxIcZWUC3+/UpP/PB4BLJS9FS
         6WL5NsCx5/zsUumWBooyh6TSQSOh7AGprRGep5eTFp0Hsg2UFfZXO9ZFkt09OrQDbvR2
         VtZo5AJXIz6gHMyPrcon5ewqT50GTNIaz+PUU/CvB2XSiHOB81tmKOjY9JT/6beSco3L
         FQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ze9fU6zgtlTge6qolZOJHvQIL2kY/OS9l69w4qErMgU=;
        b=fTPfPJSXchJ4FIZKOoFwFvnvfxOaptTBblN5Uqn+5jlDzrOoprJcqMAtF0ooNOd7FW
         wdhBGA8j4BPrkN2j7oREMA+/oyEwMGAICGTV0KXAp8EfH3rP7eY54f4S779CGbyVzba3
         j2BIMYvAAEXpjZkdeX6uN7RgUQGcV7HXQwNAMHUD7FZxp5OwP42FN+pFlsYe//JbAPXg
         ZVuyetv3r5zJdRt+MjLGCPwMNIhljJav4+bV/cRyB+LyIvnWn2SGL021cAflIHmaqCaf
         m5wowEi9SnC+cOOORwzd/yXaXCngm4SOc0e4GqzafFHPNqnFOonxhO60RM2qjGxLFIEG
         CI2g==
X-Gm-Message-State: AOAM533JSgMxE4dLE+tY0ZxbSpxNkttkGV7TWuHTBjjl++FFeinHksfW
        eNM2/eOJ4UcrIpGCq8oUTAk=
X-Google-Smtp-Source: ABdhPJw25eS4rlGsNuHEen4Qd8Pw4eAufrIgWRhduXihUeIvXpG5nCXYc3tY72IA7ddCA6XMPpliqw==
X-Received: by 2002:ae9:ee03:: with SMTP id i3mr4103458qkg.83.1593435773826;
        Mon, 29 Jun 2020 06:02:53 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w18sm14519043qtn.3.2020.06.29.06.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 06:02:52 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] bloom: fix logic in get_bloom_filter()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <2f809499abadd83b81b3d38d0cad9a2fd08b5440.1593174637.git.gitgitgadget@gmail.com>
 <20200627163335.GO2898@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e998499b-6c27-e4c8-fa92-d83167ab41b6@gmail.com>
Date:   Mon, 29 Jun 2020 09:02:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200627163335.GO2898@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2020 12:33 PM, SZEDER Gábor wrote:
> On Fri, Jun 26, 2020 at 12:30:29PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The get_bloom_filter() method is a bit complicated in some parts where
>> it does not need to be. In particular, it needs to return a NULL filter
>> only when compute_if_not_present is zero AND the filter data cannot be
>> loaded from a commit-graph file. This currently happens by accident
>> because the commit-graph does not load changed-path Bloom filters from
>> an existing commit-graph when writing a new one. This will change in a
>> later patch.
>>
>> Also clean up some style issues while we are here.
>>
>> Helped-by: René Scharfe <l.s.r@web.de>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  bloom.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/bloom.c b/bloom.c
>> index c38d1cff0c..2af5389795 100644
>> --- a/bloom.c
>> +++ b/bloom.c
>> @@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>>  	struct diff_options diffopt;
>>  	int max_changes = 512;
>>  
>> -	if (bloom_filters.slab_size == 0)
>> +	if (!bloom_filters.slab_size)
>>  		return NULL;
>>
>>  	filter = bloom_filter_slab_at(&bloom_filters, c);
>> @@ -194,16 +194,14 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>>  	if (!filter->data) {
>>  		load_commit_graph_info(r, c);
>>  		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
>> -			r->objects->commit_graph->chunk_bloom_indexes) {
>> -			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
>> -				return filter;
>> -			else
>> -				return NULL;
>> -		}
>> +		    r->objects->commit_graph->chunk_bloom_indexes)
>> +			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
>>  	}
>>  
>> -	if (filter->data || !compute_if_not_present)
>> +	if (filter->data)
>>  		return filter;
>> +	if (!compute_if_not_present)
>> +		return NULL;
> 
> Some callers of get_bloom_filter() invoke it with
> compute_if_not_present=0, but are not prepared to handle a NULL return
> value and dereference it right away:
> 
>   write_graph_chunk_bloom_indexes():
> 
>                 struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>                 cur_pos += filter->len;
> 
>   write_graph_chunk_bloom_data():
> 
>                 struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>                 display_progress(progress, ++i);
>                 hashwrite(f, filter->data, filter->len * sizeof(unsigned char));

In theory, these _should_ be safe, because we already computed
the filters in an earlier step, right? We should have generated
the filter and populated it in the slab.

> I don't know whether this was an issue before, but I didn't really
> tried.  Unfortunately, starting with this patch this causes
> segmentation faults basically in all real repositories I use for
> testing.
> 
>   expecting success of 9999.1 'test': 
>           for i in $(test_seq 1 513)
>           do
>                   >file-$i || return 1
>           done &&
>           git add file-* &&
>           git commit -q -m one &&
>   
>           git commit-graph write --reachable --changed-paths
>   
>   Segmentation fault
>   not ok 1 - test

However, you are demonstrating a failure that doesn't appear
in our test suite. I was able to reproduce it.

I can confirm that this patch causes a SIGSEGV when writing
the commit-graph in the Git repository, too.

So, what is wrong with my earlier assumption? There are
two problems.

The thing I notice is that an empty filter (no changes
with respect to the first parent) will have NULL
filter->data, so we are returning NULL instead of a
correctly-empty filter (with len zero).

But what you are hitting here is the max number of changes
limit. That also returns a NULL filter, because we mark
the filter as "TOO LARGE" to store. We store that as a
zero-length filter.

The following fixup corrects the bug and adds a test
similar to yours, but with extra care around ensuring the
revision walk still works appropriately for that large
commit.

In the next version, I will include more in the commit
message about these side-effect changes, especially around
the stats for zero-length filters. The trace2 message will
no longer differentiate between zero-length filters and
NULL filters.

Thanks,
-Stolee

-- >8 --

From f9867adc5de8a072f41b91fd6cd87edfcc92e05e Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 29 Jun 2020 08:52:33 -0400
Subject: [PATCH] fixup! bloom: fix logic in get_bloom_filter()

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c       |  8 ++++++--
 revision.c           |  7 -------
 t/t4216-log-bloom.sh | 24 ++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a0766a86f5..6752916c1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1108,7 +1108,8 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
-		cur_pos += filter->len;
+		size_t len = filter ? filter->len : 0;
+		cur_pos += len;
 		display_progress(progress, ++i);
 		hashwrite_be32(f, cur_pos);
 		list++;
@@ -1154,8 +1155,11 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		size_t len = filter ? filter->len : 0;
 		display_progress(progress, ++i);
-		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
+
+		if (len)
+			hashwrite(f, filter->data, len * sizeof(unsigned char));
 		list++;
 	}
 
diff --git a/revision.c b/revision.c
index b40bc5b51b..b9118001f9 100644
--- a/revision.c
+++ b/revision.c
@@ -633,7 +633,6 @@ static unsigned int count_bloom_filter_maybe;
 static unsigned int count_bloom_filter_definitely_not;
 static unsigned int count_bloom_filter_false_positive;
 static unsigned int count_bloom_filter_not_present;
-static unsigned int count_bloom_filter_length_zero;
 
 static void trace2_bloom_filter_statistics_atexit(void)
 {
@@ -641,7 +640,6 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 	jw_object_begin(&jw, 0);
 	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
-	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
 	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
 	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
 	jw_object_intmax(&jw, "false_positive", count_bloom_filter_false_positive);
@@ -765,11 +763,6 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	if (!filter->len) {
-		count_bloom_filter_length_zero++;
-		return -1;
-	}
-
 	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
 		result = bloom_filter_contains(filter,
 					       &revs->bloom_keys[j],
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index d7dd717347..4892364e74 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -60,7 +60,7 @@ setup () {
 
 test_bloom_filters_used () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
+	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"maybe\""
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom &&
@@ -146,7 +146,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":8"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":8"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
@@ -171,4 +171,24 @@ test_expect_success 'persist filter settings' '
 	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
 '
 
+test_expect_success 'correctly report changes over limit' '
+	git init 513changes &&
+	(
+		cd 513changes &&
+		for i in $(test_seq 1 513)
+		do
+			echo $i >file$i.txt || return 1
+		done &&
+		git add . &&
+		git commit -m "files" &&
+		git commit-graph write --reachable --changed-paths &&
+		for i in $(test_seq 1 513)
+		do
+			git -c core.commitGraph=false log -- file$i.txt >expect &&
+			git log -- file$i.txt >actual &&
+			test_cmp expect actual || return 1
+		done
+	)
+'
+
 test_done
\ No newline at end of file
-- 
2.27.0.203.gf402ea6816

