Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3D20672
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE5PI5f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404982AbgFYNip (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYNio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:38:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFEC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 06:38:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so5263228qke.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s9zv9XwM2YTf2tOTxCAkR+FJqVCGElwyAnnKnBJhJek=;
        b=kE5PI5f1dJ77VbwxxQhmfHiNMQQYzZHqWc0XS0z2O2GgdI7PyhX0Jzd7VFIwJWZpR2
         HsaBU9uS7G/m7qO53Ns86VgcTV+Rwc+O06mCyjsNKXgB49xVN9khfQABBtzBo67cnbdp
         o+5c6QBL5FQzUw6L8YZc9RBw60dYV6BrHHgibDpRNqzH5r5K9Kz41GrKqHsJPf6EREMf
         ahF32FccAzln8jtyJSM2YFpfqo1z4aDKokT7M2Hihm/+0iRdvlDA98vm8YR+SvYiBOXP
         mXULScGOrDtyRJzzetnbiihj5aoq8VtGu0ft1vpCfd8Rafz+fooD0zNIqK93z+9+4D7a
         vXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9zv9XwM2YTf2tOTxCAkR+FJqVCGElwyAnnKnBJhJek=;
        b=mhjy7Qug9BobtcgY8wxqAgE9Tyjnr6jEkvusQpHD4Xj415DaPkHqogBS/+oWnISXdv
         lOxI2OZOFFVIXNtRv1Rb0vSBGA6Gu+YTLkqASd7jr9D8JzoGGSgAVcPPeaCzNuA8XyRC
         4KQ0HScUwnnh4uZzI1wEQIv2XndZZYLB5NlHm00AlAyQIQ2ljOAClw1B3wAwiL0FdQcr
         ZwGYg3+m3tRf3gZ/klw+l6pZnM5cLix8zdGtB4oqRXEnCTd70TnHFq2p3xhih/lD2Za7
         j4x+FglImPDjn0mk5SsBvt6Q/Ee6UEKpbxo5AM0EDamFznNga6NGZdxwmgsiWz8BKgb3
         rHkg==
X-Gm-Message-State: AOAM530pc6mTCRBmLlbRU4Zou3KBLpV6FSEvrvhSA1v8dAN2cnAMTosl
        sprxKfKNoUgKJQ1YjzLxrPQ=
X-Google-Smtp-Source: ABdhPJxp3b/SGcMp/OslonRP3Bg9sd8Ln+YyQCntQd0LNZYLDQS2kvBbNiivNSmUYpcen8S/UMcBoA==
X-Received: by 2002:a37:85c2:: with SMTP id h185mr5646516qkd.131.1593092323754;
        Thu, 25 Jun 2020 06:38:43 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i10sm7172491qkn.126.2020.06.25.06.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:38:43 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        l.s.r@web.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <xmqqftak5aa0.fsf@gitster.c.googlers.com>
 <429f38a2-9346-f6f7-bd69-2fd63828ae7c@gmail.com>
 <xmqq7dvw5699.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4b08360d-04ab-b614-196b-76124f1d54ef@gmail.com>
Date:   Thu, 25 Jun 2020 09:38:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dvw5699.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2020 8:38 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 6/24/2020 7:11 PM, Junio C Hamano wrote:
>>> This does not seem to play well with what is in flight.  Tests seem
>>> to pass with topics up to es/config-hooks merged but not with this
>>> topic merged on top.
>>>
>>>     1b5d3d8260 Merge branch 'ds/commit-graph-bloom-updates' into seen
>>>     32169c595c Merge branch 'es/config-hooks' into seen
>>>     ...
>>>
>>> $ sh t4216-log-bloom.sh -i -v
>>>
>>> ends like so:
>>>
>>> ok 133 - Use Bloom filters if they exist in the latest but not all commit graphs in the chain.
>>>
>>> expecting success of 4216.134 'persist filter settings':
>>>         test_when_finished rm -rf .git/objects/info/commit-graph* &&
>>>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>>>         grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
>>>         cp .git/objects/info/commit-graph commit-graph-before &&
>>>         corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
>>>         corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
>>>         cp .git/objects/info/commit-graph commit-graph-after &&
>>>         test_commit c18 A/corrupt &&
>>>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>>>         grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
>>>
>>> not ok 134 - persist filter settings
>>> # ...
>>>
>>> Thanks.
>>
>> Thanks for letting me know. I'll investigate carefully with the
>> rest of the 'seen' branch. This test is a bit fragile due to
>> computed values for which bytes to replace, so anything that
>> could have changed the length or order of chunks would lead to
>> a failure here.
>>
>> Sorry for the disruption.
> 
> Oh, not at all.  Thanks for helping
I'll squash the patch into my v3, but here it is now to make 'seen'
pass tests again.

The _real_ reason for the failure was that some changes in trace2
pushed the events out of the nesting limits. I also think it is a
good idea to make the test less brittle. Adding GIT_TEST_* variables
will also help anyone who wants to adjust the Bloom filter settings
for testing.

Question: Should these be GIT_BLOOM_SETTINGS_* instead of GIT_TEST_...?
I ask because this _could_ be a way to allow user customization,
without making it as public as a config option. Or, should I just do
the work and add config settings in this series?

Thanks,
-Stolee

-- >8 --
From 9245d31f0431eceec60f0b7a90900d2825787530 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Thu, 25 Jun 2020 09:19:13 -0400
Subject: [PATCH] fixup! commit-graph: persist existence of changed-paths

The previous version of this test was too fragile to subtle changes
in the commit-graph file size. This version now uses two environment
variables to customize the Bloom filter settings before rewriting
without those environment variables. This demonstrates that we
persist the settings correctly.

The issue with the 'seen' branch is due to es/trace-log-progress
adding trace2 regions in the progress indicators. This pushed the
trace2 data that the test was expecting outside the nesting limit.
Set GIT_TRACE2_EVENT_NESTING to ensure we still record those items.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c       |  9 +++++++--
 t/t4216-log-bloom.sh | 34 +++++++++++-----------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1de6800d74..026ec63d38 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1576,10 +1576,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int num_chunks = 3;
 	uint64_t chunk_offset;
 	struct object_id file_hash;
-	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
-	if (!ctx->bloom_settings)
+	if (!ctx->bloom_settings) {
+		bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
+							      bloom_settings.bits_per_entry);
+		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
+							  bloom_settings.num_hashes);
 		ctx->bloom_settings = &bloom_settings;
+	}
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 84f95972ca..d7dd717347 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -156,31 +156,19 @@ test_expect_success 'Use Bloom filters if they exist in the latest but not all c
 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
 '
 
-BASE_BDAT_OFFSET=2240
-BASE_K_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 10))
-BASE_LEN_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 14))
-
-corrupt_graph() {
-	pos=$1
-	data="${2:-\0}"
-	grepstr=$3
-	orig_size=$(wc -c < .git/objects/info/commit-graph) &&
-	zero_pos=${4:-${orig_size}} &&
-	printf "$data" | dd of=".git/objects/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
-	dd of=".git/objects/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null
-}
-
 test_expect_success 'persist filter settings' '
 	test_when_finished rm -rf .git/objects/info/commit-graph* &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
-	cp .git/objects/info/commit-graph commit-graph-before &&
-	corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
-	corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
-	cp .git/objects/info/commit-graph commit-graph-after &&
-	test_commit c18 A/corrupt &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
+	rm -rf .git/objects/info/commit-graph* &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		GIT_TRACE2_EVENT_NESTING=5 \
+		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
+		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
+		git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
+		GIT_TRACE2_EVENT_NESTING=5 \
+		git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
 '
 
 test_done
\ No newline at end of file
-- 
2.27.0



