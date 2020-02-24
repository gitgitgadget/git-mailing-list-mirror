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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F8C38BFA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6A220CC7
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BATBcOyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBXVvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:51:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33715 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:51:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so10155092qkm.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 13:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DklSjgHVwhgRcDb70O2qZC+oA6+ppuEFGq/NuFWrheE=;
        b=BATBcOyCo7/eMUqHZWkG0D9WvFC83GeuWn3j+XV6l+5gNgM6S6zEsWS36mpNEKv9E8
         ZY4bQ2pIWpmEGiiLuM5m2UoP2bRiNOlbgc+hzAXjtpOk/AfsKpgMIq1UOGACevkP5qAi
         jSDSw9hGfbXqPFoXjY0hxbNg+Zlr0erUxcwyUvzQE0fTDpXScxUhJoYBJvcm/i/gkTiw
         QHCahYUu9GLh13uOf3epcShprzHzf4NwO9r1SW/ZtgMbAseOHJ+0IwFrdUZV4ApDD2cY
         eKL5ETNGG3iIzpK/+6fi+ijKaN6m+EPnhWeCRTLr9uPbNOEFUi94/TnjBbJsW8qqujVb
         gAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DklSjgHVwhgRcDb70O2qZC+oA6+ppuEFGq/NuFWrheE=;
        b=f631oH13XbCus9EJhbmJlw3N/wA9x3H//9gbKG3kymdHx5AngaqrNH6FmDq22kQKRn
         EvjgQyf3/XGSoQDdlFiF/50sFiHFtad66HQGN+0gqWQT7acZNFkghmdTs8Kh+LeXi4fk
         H9yBknj434bXGkp2Bj41A0KN9RTf4wXFbTBB+JJO2tsbD9MfawDxtl2kUMbLt+nZtgwP
         s0EDtg5cqeUBvHmArywa+GR6C1yhdkbs+cXu+AA65eI5PmIyvtNdJLYETV9IjpDuzLDO
         4bLMmOz2Fi7nl3NdqAR6IEzH/JidnqVmi13basVlmZhj0Dh6GCc/CcmUXFdk/hfXei8h
         kADA==
X-Gm-Message-State: APjAAAUUz19ruPlSajVU12Q4UiwjSwii39ATS8BWtV85eNiwztSH2qM4
        Y9+Ko/QsETp9MN17xF0R+Rs=
X-Google-Smtp-Source: APXvYqxQo1ZvdqMRq//+zYCMuNFxf50eIJyIKccIFhQeyse6nQ+qFM5L8MLN/Q/wTd3SUpIxIY40Ew==
X-Received: by 2002:a37:6e06:: with SMTP id j6mr15757673qkc.171.1582581112253;
        Mon, 24 Feb 2020 13:51:52 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1010:1a08:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id h12sm6609770qtn.56.2020.02.24.13.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:51:51 -0800 (PST)
Subject: Re: [PATCH v2 09/11] commit-graph: add --changed-paths option to
 write subcommand
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
 <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
 <86y2sxdmw9.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <56150788-c477-5526-2d6d-e9325ccb4da6@gmail.com>
Date:   Mon, 24 Feb 2020 16:51:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86y2sxdmw9.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/20/2020 3:28 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Add --changed-paths option to git commit-graph write. This option will
>> allow users to compute information about the paths that have changed
>> between a commit and its first parent, and write it into the commit graph
>> file. If the option is passed to the write subcommand we set the
>> COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
>> commit-graph logic.
> 
> In the manpage you write that this operation (computing Bloom filters)
> can take a while on large repositories.  Could you perhaps provide some
> numbers: how much longer does it take to write commit-graph file with
> and without '--changed-paths' for example for Linux kernel, or some
> other large repository?  Thanks in advance.
> 

Yes. Will include numbers as appropriate in v3. 

>>
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  Documentation/git-commit-graph.txt | 5 +++++
>>  builtin/commit-graph.c             | 9 +++++++--
>>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> What is missing is some sanity tests: that bloom index and bloom data
> chunks are not present without '--changed-paths', and that they are
> added with '--changed-paths'.
> 
> If possible, maybe also check in a separate test that the size of
> bloom_index chunk agrees with the number of commits in the commit graph.
> 
> 
> Also, we can now add those tests I have wrote about in my review of
> previous patch, that is:
> 
> 1. If you write commit-graph with --changed-paths, and either add some
>    commits later or exclude some commits from the commit graph, then:
> 
>    a.) commit(s) in commit-graph have Bloom filter
>    b.) commit(s) not in commit-graph do not have Bloom filter
> 
> 2. If you write commit-graph without --changed-paths as base layer,
>    and then write next layer with --changed-paths and --split, then:
> 
>    a.) commit(s) in top layer have Bloom filter(s)
>    b.) commit(s) in bottom layer don't have Bloom filter(s)
> 

I will see what more can be done here. 

>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index bcd85c1976..907d703b30 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>>  With the `--append` option, include all commits that are present in the
>>  existing commit-graph file.
>>  +
>> +With the `--changed-paths` option, compute and write information about the
>> +paths changed between a commit and it's first parent. This operation can
>> +take a while on large repositories. It provides significant performance gains
>> +for getting history of a directory or a file with `git log -- <path>`.
>> ++
> 
> Should we write about limitation that the topmost layer in the split
> commit graph needs to be written with '--changed-paths' for Git to use
> this information?  Or perhaps we should try (in the future) to remove
> this limitation??
> 

Given that this information is going to be used best effort, it would be 
superfluous to describe every case and conditional that decides whether 
this information is being used.
>> @@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
>>  		flags |= COMMIT_GRAPH_WRITE_SPLIT;
>>  	if (opts.progress)
>>  		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>> +	if (opts.enable_changed_paths)
>> +		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>>  
>>  	read_replace_refs = 0;
> 
> All right.  This actually turns on calculation Bloom filters for changed
> paths, thanks to
> 
>  	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
> 
> that was added by the "[PATCH v2 04/11] commit-graph: compute Bloom
> filters for changed paths" patch.
> 
> Though... should this enabling be split into two separate patches like
> this?
> 

The idea is that in 4/11 We compute only if the flag is set. 
And between that patch and this one: we prepare the foundational code 
that is now ready for that flag to be set via an opt-in by the user. 

> 
> Best,
> 
