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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62717C38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206B121556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjfS2mJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXVOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:14:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36789 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:14:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so7583418qto.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 13:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5pz+T3wItZGWxLzAoP9pBftDyxI1Ni/zcWIQtyOQ0+4=;
        b=CjfS2mJ2CmWIR0WmU4vmaIx3XswbYLJIbKAjE1W95TwRleyyk8sHYjStsaDxIscqYW
         zUrZj+eJI8GUOCp7un8sxe3+BG8mVjZ9hJ5DRfz/gNbiZjg89xULxQnjOZr8HTN3K6LC
         XQQQgPB465eePQD9JgHlIR1gRX5rv/0aHrZYXEv+arCxmQa3x0ntrvrUQZqNlVgqWPZg
         Aaq8EjuoPGX5qqtkODb5TOQbCxDknzljnLEXEpZgtxsAtIhOqtHusVmjfUZ4mzJ9uTRZ
         BGHyhdGU62vtrM4wyqf6HdUZASjJTXO9GML7jDrPen7V8ITTCF5EbqhNSWS4uiTszZsX
         Ey0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pz+T3wItZGWxLzAoP9pBftDyxI1Ni/zcWIQtyOQ0+4=;
        b=YavYV9pJoURxe1Ghn7w8cXB1yGHVW1efo9389LO+ou1IydNXeikz8KW/z84eX9u4N0
         B4B7TG+8bihCO96VfvxRhuF8oTbFaXywcbTgRsbrySB7CgrLRtMJOAwxCWx9cmVSvNT0
         4ypHx0bWhpNMUVx7mhBF6kIylectrgu53nkis8fszEiKx4hoklJXAbyngX0n0FaEvNUp
         vqiRg0Y6SA2HmXJZbxUMRRq+9KgblWygRdzaK2Oblnek47wEpuSZOoSdBOoCqrimPUoF
         uoS6yeeOF5Oh+mUouPn3SSlp3MpbOlixkz2fbUgeAqGjaQ9HEvnIQmk0dmTq5kyXV0eK
         w1eQ==
X-Gm-Message-State: APjAAAVc5OsurRAyNrYiRVSv/e5YUR9IdlBHYAigv/kHqfvnyDSiHi7L
        aJS46WM1opT+p0Ml5DgeJFuPRpz9
X-Google-Smtp-Source: APXvYqxCoY07qG6VmpUVCDUjND7IxDDNmQR5eofn34tZ47Qpczpep13GR9NmlFnECkWIOi+aOGirTg==
X-Received: by 2002:ac8:37e6:: with SMTP id e35mr49284158qtc.302.1582578882180;
        Mon, 24 Feb 2020 13:14:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1010:1a08:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id u49sm6594524qtb.37.2020.02.24.13.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:14:41 -0800 (PST)
Subject: Re: [PATCH v2 07/11] commit-graph: write Bloom filters to commit
 graph file
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
 <39ee0610800d7d2d92785d392df941fc5a0b231b.1580943390.git.gitgitgadget@gmail.com>
 <86pneahaop.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <de3f1f7e-0f2f-6c5d-6290-3ba5d37a0ea5@gmail.com>
Date:   Mon, 24 Feb 2020 16:14:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86pneahaop.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/19/2020 10:13 AM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Update the technical documentation for commit-graph-format with the formats for
>> the Bloom filter index (BIDX) and Bloom filter data (BDAT) chunks. Write the
>> computed Bloom filters information to the commit graph file using this format.
> 
> Nice description.
> 
> The only minor nitpick is with the formating: it is 80-character wide,
> which is a bit wide.
> 

Fixed in v3. Thanks! 

>>
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  .../technical/commit-graph-format.txt         |  24 ++++
>>  commit-graph.c                                | 118 +++++++++++++++++-
>>  commit-graph.h                                |   7 +-
>>  3 files changed, 145 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
>> index a4f17441ae..22e511643d 100644
>> --- a/Documentation/technical/commit-graph-format.txt
>> +++ b/Documentation/technical/commit-graph-format.txt
>> @@ -17,6 +17,9 @@ metadata, including:
>>  - The parents of the commit, stored using positional references within
>>    the graph file.
>>  
>> +- The Bloom filter of the commit carrying the paths that were changed between
>> +  the commit and its first parent.
>> +
> 
> All right.
> 
> Should we also state that it is optional (meta)data?  This would be
> first optional piece of data stored in commit-graph, I think.
> 

However the entire commit graph file is non critical metadata since git commands
work just fine without it, just slower. The same applies to the changed path
bloom filters. 

Based on the definition of optional you are suggesting, edge data is optional
because not every commit-graph has octopus merges. 

>> +
>> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>> +    * It starts with header consisting of three unsigned 32-bit integers:
>> +      - Version of the hash algorithm being used. We currently only support
>> +	value 1 which implies the murmur3 hash implemented exactly as described
>> +	in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
> 
> First a minor issue: shouldn't this nested unordered list be indented
> with a hanging indent formatted with spaces?  That is be formatted like
> the following:
> 
>   +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>   +    * It starts with header consisting of three unsigned 32-bit integers:
>   +      - Version of the hash algorithm being used. We currently only support
>   +        value 1 which implies the murmur3 hash implemented exactly as
>   +        described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
> 
> But the existing formatting with spaces and tabs might be fine as it is,
> that is it renders as nested list with Asciidoc; it only looks a bit
> weird as patch, not so as text.
> 
> Second, and more important: it is in my opinion not enough information,
> at least if we are assuming that the information in this document should
> be enough for clean-room reimplementation of Bloom filter functionality
> (for example by JGit).  To generate compatible Bloom filters, one needs
> also the information on how to create $k$ functionally-independent hash
> functions out of murmur3 hash.  We do it currently using double hashing
> technique; if that changes then the exact set of bits in the Bloom
> filter would also change.
> 
> The additional description could look something like the following:
> 
>   +    * It starts with header consisting of three unsigned 32-bit integers:
>   +      - Version of the hash algorithm being used. We currently only support
>   +        value 1 which implies the murmur3_32 hash implemented exactly as
>   +        described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>   +        and double hashing technique with 0x293ae76f and 0x7e646e2c seeds
>   +        as described in https://doi.org/10.1007/978-3-540-30494-4_26
>   +        "Bloom Filters in Probabilistic Verification"
> 
> Also, it should be explicitly noted that we use murmur3_32, because
> there is also 128-bit version of murmur3 hash.
> 

I will incorporate this in. Thanks! 


>> +    * The BDAT chunk is present iff BIDX is present.
> 
> Perhaps we should spell 'iff' in full, that is 'if and only if'?
> 

Sure. 

>> +
>>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>>        This list of H-byte hashes describe a set of B commit-graph files that
>>        form a commit-graph chain. The graph position for the ith commit in this
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 32a315058f..4585b3b702 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -24,8 +24,10 @@
>>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>> +#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>> +#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
>> -#define MAX_NUM_CHUNKS 5
>> +#define MAX_NUM_CHUNKS 7
>>  
>>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>>  
>> @@ -325,6 +327,32 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>>  				chunk_repeated = 1;
>>  			else
>>  				graph->chunk_base_graphs = data + chunk_offset;
>> +			break;
>> +
>> +		case GRAPH_CHUNKID_BLOOMINDEXES:
>> +			if (graph->chunk_bloom_indexes)
>> +				chunk_repeated = 1;
>> +			else
>> +				graph->chunk_bloom_indexes = data + chunk_offset;
>> +			break;
>> +
>> +		case GRAPH_CHUNKID_BLOOMDATA:
>> +			if (graph->chunk_bloom_data)
>> +				chunk_repeated = 1;
>> +			else {
>> +				uint32_t hash_version;
>> +				graph->chunk_bloom_data = data + chunk_offset;
>> +				hash_version = get_be32(data + chunk_offset);
>> +
>> +				if (hash_version != 1)
>> +					break;
> 
> Shouldn't we mark Bloom filter as not to be used?  Or is it left for
> later commit?
> 

We take care of this in line 375. 

> In the future it might be good idea to notify the user (perhaps
> protected with some advice.* option) that there is problem with Bloom
> filter data, namely that we have encountered unsupported hash version.
> 
>> +
>> +				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
> 
> Why is this structure allocated dynamically?  We are leaking admittedly
> a small amount of memory because we never free this xmalloc() result.
> 
> If we need this field being a pointer to struct to have NULL mean no
> supported Bloom filter data, we could have instead use chunk_bloom_*
> fields instead - we can set at least one of them to NULL.
> 

I am freeing this up in free_commit_graph but I messed up putting it in the right commit. 
Sorry about that. Fixed in v3. 

Also as discussed in https://lore.kernel.org/git/3b7d77a1-aed9-d202-8646-4b964cb965db@gmail.com/
there is a bug in commit-graph.c where we should be calling free_commit_graph() instead of 
just free(graph). I will do this in a separate series. 

>> +			}
>> +			break;
>>  		}
>>  
>>  		if (chunk_repeated) {
>> @@ -343,6 +371,17 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>>  		last_chunk_offset = chunk_offset;
>>  	}
>>  
>> +	/* We need both the bloom chunks to exist together. Else ignore the data */
>> +	if ((graph->chunk_bloom_indexes && !graph->chunk_bloom_data)
>> +		 || (!graph->chunk_bloom_indexes && graph->chunk_bloom_data)) {
>> +		graph->chunk_bloom_indexes = NULL;
>> +		graph->chunk_bloom_data = NULL;
>> +		graph->bloom_filter_settings = NULL;
>> +	}
>> +
>> +	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data)
>> +		load_bloom_filters();
> 
> Wouldn't it be simpler to rely on the fact that both Bloom chunks must
> exists for it to matter, and write it like this:
> 
>   +	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
>   +		load_bloom_filters();
>   +	} else {
>   +		graph->chunk_bloom_indexes = NULL;
>   +		graph->chunk_bloom_data = NULL;
>   +		graph->bloom_filter_settings = NULL;
>   +	}
> 

:) Yes. Fixed in v3. 

>> +
>>  static int oid_compare(const void *_a, const void *_b)
>>  {
>>  	const struct object_id *a = (const struct object_id *)_a;
>> @@ -1198,8 +1290,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>>  	load_bloom_filters();
>>  
>>  	if (ctx->report_progress)
>> -		progress = start_progress(
>> -			_("Computing commit diff Bloom filters"),
>> +		progress = start_delayed_progress(
>> +			_("Computing changed paths Bloom filters"),
>>  			ctx->commits.nr);
>>
> 
> Ooops.  This look like a fixup which should be made to the original
> earlier commit instead, isn't it?


Yes. Should have been in a previous commit. Fixed in v3. 


>>  };
>>  
>>  struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
>> @@ -77,7 +82,7 @@ enum commit_graph_write_flags {
>>  	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
>>  	/* Make sure that each OID in the input is a valid commit OID. */
>>  	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
>> -	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
>> +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
> 
> This looks like accidental change; if we want to use trailing comma in
> enum, this change should be in my opinion done in the commit that added
> COMMIT_GRAPH_WRITE_BLOOM_FILTERS (as I have written in a comment there).
> 

Yes, I noticed the lack of the comma later and forgot to move it to the right
commit. Fixed in v3. 

> 
> Thank you for your work on this series.
> 
> Best,
> 
