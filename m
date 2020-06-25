Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E751420768
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWAgEOVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbgFYO71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405378AbgFYO7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 10:59:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AAC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 07:59:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so5557555qkc.6
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Wd7qwnmwNvRs6lskFy+zW+66yQ6QK3aonrSvZoopyc=;
        b=VWAgEOVJRcCfhsxR+BQX7nJglbQuUOMZpVWTvWFn+7/bPvdYfW9qWd7xjuIDM09VNc
         ZBwNDitl4wmHWuNxF0KB+EULJL7mZ+l8jGy0mqN1k0r9/QpoMLAHf66f8zI2KkmjJZOh
         at14bI63YTCVbqiGTAMMxotmym1oPSPkUuliXl/BtEMoKf8j3EJkHgudlcIKpL1v8qGF
         xeNo8xRZUoRU59ly5/ucb+yu0cpb5c2j0ItC5OdnpMiTQyLn9eBojd7ilB9b7IpgaCEm
         q16ZYDtIR63J4i4XI3G3qpvkpf+OUtMN3LlmN49IAfovBMxOEwZCfstUYo+UNl4H22x1
         OFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Wd7qwnmwNvRs6lskFy+zW+66yQ6QK3aonrSvZoopyc=;
        b=s9thftzHNab4YzgKX1/Vj7zIgC7JcWjZk3PssO3ps7PgkkFMfhPis2alSbqgrliAF1
         LRJJRzyIzNtA+d53dbtX6rcW1qXum4wByFuBQHk0B5K5EaW0Zeo2S3vH4qS8AHeQhOKK
         wbCwGmU709YyJM3CU+LL/BnvmvLtiA/8/VagPJplNvEKWkd4YJxOBVJg8/JyYxmHZm+U
         BK82ZegO7NRa1jXAAT94qHR+y+49wuPSAdseyqPgA8m3W76g4Yn1jzGp//blPeF5gAwc
         RtrQiEgPWcWE+nWHV9Frz835Bs6ursU/w4H9ywNx0KLwnlroHBzuqkZk5q/9JCtaisYP
         IHhg==
X-Gm-Message-State: AOAM533iyHoPToKtbK53OeZTg0MrqzXTX71rmtSw1/Lx/64iWm/qRWSq
        QDmv61TJXAAWXFk1FN5FNgU=
X-Google-Smtp-Source: ABdhPJy/3BhkqCIMHROZlommiPU99znzDeIJfDI4trX3DCh0gzehY1vrJKsvaYEyuh5iYgegiMhgeA==
X-Received: by 2002:a37:8905:: with SMTP id l5mr11899832qkd.302.1593097163464;
        Thu, 25 Jun 2020 07:59:23 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y13sm6524581qto.23.2020.06.25.07.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 07:59:22 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] commit-graph: simplify chunk writes into loop
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <8b959f2f374654aeb87b847560761890c2f9aa2c.1592934430.git.gitgitgadget@gmail.com>
 <675f46df-c57c-bcd6-3f6a-fdd40b2f3066@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <467ecf3b-2635-5d92-c8f9-9e89dd6580ee@gmail.com>
Date:   Thu, 25 Jun 2020 10:59:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <675f46df-c57c-bcd6-3f6a-fdd40b2f3066@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2020 3:25 AM, René Scharfe wrote:
> Am 23.06.20 um 19:47 schrieb SZEDER Gábor via GitGitGadget:
>> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>>
>> In write_commit_graph_file() we now have one block of code filling the
>> array of 'struct chunk_info' with the IDs and sizes of chunks to be
>> written, and an other block of code calling the functions responsible
>> for writing individual chunks.  In case of optional chunks like Extra
>> Edge List an Base Graphs List there is also a condition checking
>> whether that chunk is necessary/desired, and that same condition is
>> repeated in both blocks of code. Other, newer chunks have similar
>> optional conditions.
>>
>> Eliminate these repeated conditions by storing the function pointers
>> responsible for writing individual chunks in the 'struct chunk_info'
>> array as well, and calling them in a loop to write the commit-graph
>> file.  This will open up the possibility for a bit of foolproofing in
>> the following patch.
> 
> You can do that without storing function pointers by selecting the
> function to use based on the chunk ID -- like parse_commit_graph() does
> on the read side.  Advantage: You don't need to press all write
> functions into the same mold and can keep their individual signatures.

I do think that the loop without a switch statement is valuable.
It focuses the updates for new chunks to be localized to the
section that calculates the offset values.

>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  commit-graph.c | 31 +++++++++++++++++++------------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index f33bfe49b3..086fc2d070 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1555,9 +1555,13 @@ static int write_graph_chunk_base(struct hashfile *f,
>>  	return 0;
>>  }
>>
>> +typedef int (*chunk_write_fn)(struct hashfile *f,
>> +			      struct write_commit_graph_context *ctx);
>> +
>>  struct chunk_info {
>>  	uint32_t id;
>>  	uint64_t size;
>> +	chunk_write_fn write_fn;
>>  };
>>
>>  static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>> @@ -1615,27 +1619,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>>
>>  	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
>>  	chunks[0].size = GRAPH_FANOUT_SIZE;
>> +	chunks[0].write_fn = write_graph_chunk_fanout;
>>  	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
>>  	chunks[1].size = hashsz * ctx->commits.nr;
>> +	chunks[1].write_fn = write_graph_chunk_oids;
>>  	chunks[2].id = GRAPH_CHUNKID_DATA;
>>  	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
>> +	chunks[2].write_fn = write_graph_chunk_data;
>>  	if (ctx->num_extra_edges) {
>>  		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
>>  		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
>> +		chunks[num_chunks].write_fn = write_graph_chunk_extra_edges;
>>  		num_chunks++;
>>  	}
>>  	if (ctx->changed_paths) {
>>  		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
>>  		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
>> +		chunks[num_chunks].write_fn = write_graph_chunk_bloom_indexes;
>>  		num_chunks++;
>>  		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
>>  		chunks[num_chunks].size = sizeof(uint32_t) * 3
>>  					  + ctx->total_bloom_filter_data_size;
>> +		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
>>  		num_chunks++;
>>  	}
>>  	if (ctx->num_commit_graphs_after > 1) {
>>  		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
>>  		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
>> +		chunks[num_chunks].write_fn = write_graph_chunk_base;
>>  		num_chunks++;
>>  	}
>>
>> @@ -1671,19 +1682,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>>  			progress_title.buf,
>>  			num_chunks * ctx->commits.nr);
>>  	}
>> -	write_graph_chunk_fanout(f, ctx);
>> -	write_graph_chunk_oids(f, ctx);
>> -	write_graph_chunk_data(f, ctx);
>> -	if (ctx->num_extra_edges)
>> -		write_graph_chunk_extra_edges(f, ctx);
>> -	if (ctx->changed_paths) {
>> -		write_graph_chunk_bloom_indexes(f, ctx);
>> -		write_graph_chunk_bloom_data(f, ctx);
>> -	}
>> -	if (ctx->num_commit_graphs_after > 1 &&
>> -	    write_graph_chunk_base(f, ctx)) {
>> -		return -1;
>> +
>> +	for (i = 0; i < num_chunks; i++) {
>> +		if (chunks[i].write_fn(f, ctx)) {
>> +			error(_("failed writing chunk with id %"PRIx32""),
>> +			      chunks[i].id);
> 
> Of all the write functions only write_graph_chunk_base() can return
> non-zero and it already prints an error message in that case ("failed to
> write correct number of base graph ids").  Why add this one?

Ok, we can require the chunk methods to write an error() message with
appropriate context and simply return -1 here.

Thanks,
-Stolee
