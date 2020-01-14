Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3538C33CB1
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67282467D
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jErK1+l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgANPOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:14:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34522 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANPOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 10:14:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so12432354qkk.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fcyAQuNvwtq4e9Ii918XVqE6s3fGZJXAak848qrzdnk=;
        b=jErK1+l13nyrNKN63A4J6XgNVAZzIuGLLwDYbMBBRq192rh3S3qaSQ/EOGnJvKu9+Q
         R73LUV428/Q1zlBVHGIp6TrhNxxLs629CHlw5/EUSN3HjxRrbXA0LpsQLmR/nLnKAyzg
         ZCgJMLyXfD99D5oyibnH3IH3/NblPN9QwC8weG6J3KQtDR2XCGJPqqEk+Vw0m0aaNnaX
         GYNzMXDFjw3lt+d0MfE0w9RW7Rxg9NqAgdfk2Z/wEXC01ha/hqzo1HbJarAOrtmjgsJg
         wVN2Cj+UfUA9X0fFESaHlJnmvNN4Nww3iFb/pefo0z4w0MR65H2F43tEFYkeC0iBMG05
         7EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fcyAQuNvwtq4e9Ii918XVqE6s3fGZJXAak848qrzdnk=;
        b=CV2VT3YshT/FtA76Jx5sXpEqOHkW+esGUwuGdg7+4KkLk1BztDTPk6LovEeB+JKVEC
         qApEDUcxAVGdqL2C997qIODm9glDAe3/+vkfTh4G+HYcmINPdh10JMHpECd+ZTsOlmD9
         C51v8XHDVw+SylX3SJ6NMcaXtD7EhWzdwDyNaAvRwvPgNLZiR/sOMIR0+UQUqINnFq9p
         ebFY5Jz3xO0/jTsiRoFPEVB625ayONe8n/nRlsnFKyXawaKc67wWqHN1iAKRWbB8GaPr
         aFeo0JLzhSYHR5mxx804qiKdpKWVNXyHUyxbWPpC9zcZrOx/HyS5IAFdHsJnM+nZZ8s2
         5XtQ==
X-Gm-Message-State: APjAAAWjRV3Gp4rvjIfoQjUZ9XDPk1Mkur/cJrb6oPPqI5U5XNg1vdRT
        xVY8znIwqqHcmdOGFMDgeV4=
X-Google-Smtp-Source: APXvYqy9vM1+0Ach6uUHZRds88KrTGHJ2Meh6SjXDKqcrN1Aw59L0RpQltGZr+FkeFODyd9BxoHjtg==
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr22635465qkj.475.1579014871586;
        Tue, 14 Jan 2020 07:14:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:14fc:be65:9350:cf67? ([2001:4898:a800:1012:c630:be65:9350:cf67])
        by smtp.gmail.com with ESMTPSA id c24sm7744673qtk.40.2020.01.14.07.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 07:14:31 -0800 (PST)
Subject: Re: [PATCH 5/9] commit-graph: write changed path bloom filters to
 commit-graph file.
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <7648021072ca11153ac65c90f0ebed5973f20e1a.1576879520.git.gitgitgadget@gmail.com>
 <867e23xnkh.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <3b7d77a1-aed9-d202-8646-4b964cb965db@gmail.com>
Date:   Tue, 14 Jan 2020 10:14:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <867e23xnkh.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/7/2020 11:01 AM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +
>> +				if (hash_version != 1)
>> +					break;
> 
> What does it mean for Git?  Behave as if there were no Bloom filter
> data?
>

Yes. We choose to use Bloom filters best effort, and in such cases, we will 
just fall back to the original code path. 

>>  	if (ctx->num_commit_graphs_after > 1 &&
>>  	    write_graph_chunk_base(f, ctx)) {
>>  		return -1;
>> diff --git a/commit-graph.h b/commit-graph.h
>> index 952a4b83be..2202ad91ae 100644
>> --- a/commit-graph.h
>> +++ b/commit-graph.h
>> @@ -10,6 +10,7 @@
>>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
>>  
>>  struct commit;
>> +struct bloom_filter_settings;
>>  
>>  char *get_commit_graph_filename(const char *obj_dir);
>>  int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
>> @@ -58,6 +59,10 @@ struct commit_graph {
>>  	const unsigned char *chunk_commit_data;
>>  	const unsigned char *chunk_extra_edges;
>>  	const unsigned char *chunk_base_graphs;
>> +	const unsigned char *chunk_bloom_indexes;
>> +	const unsigned char *chunk_bloom_data;
>> +
>> +	struct bloom_filter_settings *settings;
> 
> Should this be part of `struct commit_graph`?  Shouldn't we free() this
> data, or is it a pointer into xmmap-ped file... no it isn't -- we
> xalloc() it, so we should free() it.
> 
> I think it should be done in 'cleanup:' section of write_commit_graph(),
> but I am not entirely sure.
> 

Thanks for calling this out! This is definitely a bug in how commit-graph.c
frees up the graph. The right way to free the graph would be to call
free_commit_graph() instead of free(graph) like many places in that file. 

Cleaning up this entire pattern would be orthogonal to this series, so 
I will follow up with a separate series that cleans it up overall. 

For now, I will free up `bloom_filter_settings` in free_commit_graph(). 

Cheers! 
Garima Singh
