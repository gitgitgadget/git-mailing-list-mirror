Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FCC38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349D0218AC
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpYxrzdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBXUqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:46:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34702 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXUqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:46:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id 11so5847747qkd.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=amwnZR0qeqtWXiOL2EofOsq94hfNaKgY0JFiuBsVBYI=;
        b=PpYxrzdhL6ze92+MeIoxh1QkTYhMC8V0vMvPP8Moh+T21WtTQfxitPbtB1rRaswZ/6
         +F3ax9ceDrwLyrASGDRn4/FapfCQ5WHiVFRHayH29FJis9nzMjocW9BDV5xlM+wv3Kvk
         bcA2R/hkbm5zGA4IuMaWleuVsS3Dh9BoSnxn2PZMGxyCHtjxuOT/n6XDo+JWKYrpwItC
         Lyo67D2M7p3A9fwl4ywEHNSEcwcPM/HB5Inrow+D4l0zE0yWhGcHcWpR5p4q56MHANA8
         xmZ4+viVINQHy4zUPOwGJCiJD0WVijAjlnA2Rtke/qIbzmdp6ql++p0/dmJ9/Ys3uik3
         lRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=amwnZR0qeqtWXiOL2EofOsq94hfNaKgY0JFiuBsVBYI=;
        b=gqBgo12XRk8lxYCiSMtqUxQi323KIpQrIe4CO6PV9NkQ+GDnN1yTH4Ds5fzlH2MAjm
         5Y2mwr5lF2AkhhXgizYQkyKnX4MFouE0UCyBCfcvu8siztZ/pN+Jb2G7bQE2tgmD9xf3
         HEOoJwIOEm0YYVIQUbbyZimWpAsKyagDCZDIwkNhRIteY/ayJIFDs69zCtOnKwyhLebr
         fbcU6MTp1g9cI764FSVSs1dgOGiZtlr/KUg9u47wAtRUjknuwIcZbcMTGtyAvMJuB2A9
         B4zpyPA4k+JEBtLd6juJNsr/A5GGA6fLzqe40FJEc7YAkHlvnObbStBZW1NwVvrXX+QJ
         BSUA==
X-Gm-Message-State: APjAAAWCsDeGwx75Qk1rybBCefvKrA6FHPCbueHO8qJNH3TOQtmGwmj6
        iBhhSQabdavfFiYVTa4LMfE=
X-Google-Smtp-Source: APXvYqzfRZrrSX1oiHVfw3qUvLPYGroCYWqTIk/rTWxRnRXaw5kEgj99RuYB5Bi4R0FjgWRpPy2x9A==
X-Received: by 2002:a37:aa0d:: with SMTP id t13mr5848358qke.179.1582577159796;
        Mon, 24 Feb 2020 12:45:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1010:1a08:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id v24sm6330338qkj.33.2020.02.24.12.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 12:45:59 -0800 (PST)
Subject: Re: [PATCH v2 06/11] commit-graph: examine commits by generation
 number
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <58704d81b6b4fbc54715457246aeed783eb32a99.1580943390.git.gitgitgadget@gmail.com>
 <865zg3ju2j.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <b959d5d4-4e9f-1fc9-f06f-40228d56b80c@gmail.com>
Date:   Mon, 24 Feb 2020 15:45:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <865zg3ju2j.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/18/2020 7:32 PM, Jakub Narebski wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When running 'git commit-graph write --changed-paths', we sort the
>> commits by pack-order to save time when computing the changed-paths
>> bloom filters. This does not help when finding the commits via the
>> --reachable flag.
> 
> Minor improvement suggestion: s/--reachable flag/'--reachable' flag/.
> 

Sure. 


>>                     Commits with similar generation are more likely
>> to have many trees in common, making the diff faster.
> 
> Is this what causes the performance improvement, that subsequently
> examined commits are more likely to have more trees in common, which
> means that those trees would be hot in cache, making generating diff
> faster?  Is it what profiling shows?
> 

Yes. 

>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  commit-graph.c | 33 ++++++++++++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index e125511a1c..32a315058f 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -70,6 +70,25 @@ static int commit_pos_cmp(const void *va, const void *vb)
>>  	       commit_pos_at(&commit_pos, b);
>>  }
>>  
>> +static int commit_gen_cmp(const void *va, const void *vb)
>> +{
>> +	const struct commit *a = *(const struct commit **)va;
>> +	const struct commit *b = *(const struct commit **)vb;
>> +
>> +	/* lower generation commits first */
> 
> Shouldn't higher generation commits come first, in recency-like order?
> Or it doesn't matter if it is sorted in ascending or descending order,
> as long as commits with close generation numbers are examined close
> together?
> 

The direction does not matter. Locality is important. 

>> +	if (a->generation < b->generation)
>> +		return -1;
>> +	else if (a->generation > b->generation)
>> +		return 1;
>> +
>> +	/* use date as a heuristic when generations are equal */
>> +	if (a->date < b->date)
>> +		return -1;
>> +	else if (a->date > b->date)
>> +		return 1;
>> +	return 0;
>> +}
> 
> I thought we have had such comparison function defined somewhere in Git
> already, but I think I'm wrong here.
> 

It actually exists in commit.h
I will just use it here. 
Thanks for pointing it out! 

>> +
>>  char *get_commit_graph_filename(const char *obj_dir)
>>  {
>>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
>> @@ -821,7 +840,8 @@ struct write_commit_graph_context {
>>  		 report_progress:1,
>>  		 split:1,
>>  		 check_oids:1,
>> -		 changed_paths:1;
>> +		 changed_paths:1,
>> +		 order_by_pack:1;
>>  
>>  	const struct split_commit_graph_opts *split_opts;
>>  	uint32_t total_bloom_filter_data_size;
>> @@ -1184,7 +1204,11 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>>  
>>  	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
>>  	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
>> -	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
>> +
>> +	if (ctx->order_by_pack)
>> +		QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
>> +	else
>> +		QSORT(sorted_by_pos, ctx->commits.nr, commit_gen_cmp);
> 
> Here 'sorted_b_pos' variable name no longer reflects reality...
> (see comment to the previous patch in the series).
> 

Yup. Fixing. 

Thanks!
Garima Singh
