Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892BC38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8A21556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSreLOvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXVpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:45:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36482 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:45:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so7644457qto.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pxT+rY9WknY30CnuXCkv+W5oXVyV3SzdQawbzS/FkTY=;
        b=ZSreLOvIgJ9a5D1ZZxoR+qZI7ZzXJ66Ln3kqMocAYlyefGq0tp7rxREMcgyka91aJe
         Pl/krnOzP9ZM9dBxPq9w5lB8YCzdCjfTSXN932umOoi/8rMwI0gNTNdbYYm5TE/8ouOY
         dz7C03Y4N/rfHDa1gozCyaLBmtKP6Dy7Gba+JfeEftW9MwkNDJmjUFsV7Gp5pGvfnbiI
         kFmOvmNDtR5Npig5sM833Fk+59tZN1GcBY38jVGYkNYg8DbJPgNgdTGKswIMsWuyWHUg
         XaW7v2qVh0rh/Xcq9YTQHRU6l74iT4ve6+F549BTTunPa/X0uiaXvtj77WodZzfUgk4t
         Ag4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxT+rY9WknY30CnuXCkv+W5oXVyV3SzdQawbzS/FkTY=;
        b=emTMrkDAEposMSDuNUxC41JBiMK/Au/Zau8kY6JfXBQRqUkn+2ReFwCj2AWO2cdrAP
         Nh6+JN/4qD30CKQg/u2+qhptBiI8t2AY548n9kpxux+4Q6pXP6whJJXvsSlb7+XqYZ68
         qV+zg48My+GwDK7Ris/qe92WnxoqdQeQQf/nq/ENL7Y0VsWE7N6NKvfAbtJDmbHH4pUr
         TvWVz55Mpm03iYd/RHaAx7Lh+RbPDekKoAWxJ6szT2kzjpERFcxbbJQ8nHhs96S9IpaW
         sKe7LmBNxwQ5RQ4a65FmbeFSvdpt3zFpQoaf7IgBRI0OqbAdccwX5fU7od0oqoSne+6N
         WM0A==
X-Gm-Message-State: APjAAAU+50BE+AFthnf1jsDk3XUtiw3kpXNpL5LzRaYFjidQ1SWeupXo
        RxzLcwgGUJD7+rkaCE1OmNk=
X-Google-Smtp-Source: APXvYqw9mBaN8+jNiqYFEC5Yu44WcfzZmojJodG+ihaOA00fdZVNUfYmFidNIK5wiNFa6QpuPH65ww==
X-Received: by 2002:ac8:65da:: with SMTP id t26mr50387213qto.5.1582580703944;
        Mon, 24 Feb 2020 13:45:03 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1010:1a08:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id x23sm3048956qki.124.2020.02.24.13.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:45:03 -0800 (PST)
Subject: Re: [PATCH v2 08/11] commit-graph: reuse existing Bloom filters
 during write.
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <b20c8d2b2096bf10fe1a5f37a5181c57873a9676.1580943390.git.gitgitgadget@gmail.com>
 <86r1ypf62y.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <2ca9f6ab-41c4-37d2-7681-8f973204d6a2@gmail.com>
Date:   Mon, 24 Feb 2020 16:45:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86r1ypf62y.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/20/2020 1:48 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Read previously computed Bloom filters from the commit-graph file if
>> possible to avoid recomputing during commit-graph write.
> 
> All right, what is written makes sense for this point in patch series.
> 
> But it my opinion it is more important to state that this commit adds
> "parsing" of the Bloom filter data from commit-graph file.  This means
> that it needs to be calculated only once, then stored in commit-graph,
> ready to be re-used.
> 

Good point. Incorporated in v3.

>>
>> See Documentation/technical/commit-graph-format for the format in which
>> the Bloom filter information is written to the commit graph file.
>>
>> To read Bloom filter for a given commit with lexicographic position
>> 'i' we need to:
>> 1. Read BIDX[i] which essentially gives us the starting index in BDAT for
>>    filter of commit i+1. It is essentially the index past the end
>>    of the filter of commit i. It is called end_index in the code.
>>
>> 2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
>>    for filter of commit i. It is called the start_index in the code.
>>    For the first commit, where i = 0, Bloom filter data starts at the
>>    beginning, just past the header in the BDAT chunk. Hence, start_index
>>    will be 0.
>>
>> 3. The length of the filter will be end_index - start_index, because
>>    BIDX[i] gives the cumulative 8-byte words including the ith
>>    commit's filter.
>>
>> We toggle whether Bloom filters should be recomputed based on the
>> compute_if_null flag.
> 
> Nitpick: the flag (the parameter) is called compute_if_not_present, not
> compute_if_null.
> 
Oops. Fixed in v3. 

>> +
>> +	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
>> +
>> +	if (lex_pos)
> 
> Wouldn't it be better to be more explicit, and write
> 
>   +	if (lex_pos > 0)
> 
> 

Sure. 

>> +		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
>> +	else
>> +		start_index = 0;
> 
> All right, here we find start_index and end_index.
> 
> It might be good idea to at least assert() that start_index <= end_index,
> though that should not happen (that is why I propose for this check to
> be compiled on only for debug builds).
> 

I will look into this. Thanks! 


>> @@ -1304,7 +1304,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>>  
>>  	for (i = 0; i < ctx->commits.nr; i++) {
>>  		struct commit *c = sorted_by_pos[i];
>> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
>> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
>>  		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
>>  		display_progress(progress, i + 1);
>>  	}
>> @@ -2314,6 +2314,7 @@ void free_commit_graph(struct commit_graph *g)
>>  		g->data = NULL;
>>  		close(g->graph_fd);
>>  	}
>> +	free(g->bloom_filter_settings);
>>  	free(g->filename);
>>  	free(g);
> 
> Shouldn't this fixup be added to earlier commit?
> 

Yes. 

>>  }
>> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
>> index 331957011b..9b4be97f75 100644
>> --- a/t/helper/test-bloom.c
>> +++ b/t/helper/test-bloom.c
>> @@ -47,7 +47,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
>>  	struct bloom_filter *filter;
>>  	setup_git_directory();
>>  	c = lookup_commit(the_repository, commit_oid);
>> -	filter = get_bloom_filter(the_repository, c);
>> +	filter = get_bloom_filter(the_repository, c, 1);
>>  	print_bloom_filter(filter);
>>  }
> 
> I would like to see some tests, but that needs to wait for patch that
> adds --changed-paths option to the 'write' subcommand.
> 
> Things to be tested:
> 1. That after reading commit-graph with Bloom filter:
>    - that commit(s) in commit-graph have Bloom filter
>    - that commits outside commit-graph do not have Bloom filter
> 2. That incremental commit-graph feature works:
>    - for commits in deeper layer that have Bloom filter chunks
>    - for commits in deeper layer that do not have Bloom filter chunks
> 

Included in later commits. 

> Best,
> 
