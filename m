Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE089C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5687623D6B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390511AbgLJS43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390494AbgLJObh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:31:37 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F395C0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:30:56 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id l200so5888134oig.9
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8jHOWONzhXX/mmzEgRGV5URDjTuSxzLhrF6Z8i5TnY=;
        b=qP7s1v82CpZ++ojCgWvTJjNgoC/aUtvA061oQRqtiXrPFgiAwi+DvM8HKS3KZeKCVP
         3KoOAZpHyFvxFOISksv4+6O4ypX0B1oRkhlCXbICF/Lz0x0LUL613aoUCtC1eetW/u95
         Z3V89BgGT9XqHp5IQsuIjFgQL7INJZg6q3Dyi9b8tevzVU5d0rGSxDa48rf4zZWVA3o/
         kioeMFBvyacU07hag82OdjMoqsZ6E6QfkBS83nlQ27dCozwX2FtIAW+et6tyswrXq1LP
         QIUdiJtVhxR4+dP6hwvgfqKg6TySBgdgle+bKbFDG/iXkFKvuzd6kk5Dgb77OGO+ruh/
         2FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8jHOWONzhXX/mmzEgRGV5URDjTuSxzLhrF6Z8i5TnY=;
        b=JIvIrxAxaR/AF7NRbsMJbIMdlGgzQjmgHwV2WsWBct3495PP/u6TA3hKQun+Kpwa5B
         h1A5LyYzRGhAIxBfn0ysOcc/4ma5XA1m9XUVh/ulvrt5s8jBpUif6Csu/KgfBH3h+lk2
         toCTjjTYN+mu/1KY6RGiM4wWtuUB8iP/4kevVeA13fbuU+X3WFQz2xELtnT/MOOw28eK
         jUDwfGbkkONuMJ3D6O845ILIqdWulxcpkbw1ASYh/6vj4IKWr/y6BqQ1M01ufr+qcgJ/
         a4XwRlcsgjatky5GsLWxuMNpqxzapv+EBLSRvs4ggkb0/VDrHMmMHneBzPZkLxuBlpJx
         74hg==
X-Gm-Message-State: AOAM531ZxqwQ8HVXN7jGmd2KjNYwlf4sTsfronguMJIR8sX0XG3U4cK8
        uFmvbp7T9ps54hLqH8WLXHo=
X-Google-Smtp-Source: ABdhPJwEj538yWjoqH5rSqLU3Hp/khofpBGjvgdbILi1HenDHNzDgEwko2Vo8ktPycife6CCOsu8RQ==
X-Received: by 2002:aca:ab8b:: with SMTP id u133mr5655183oie.18.1607610655851;
        Thu, 10 Dec 2020 06:30:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id f10sm1107165oti.11.2020.12.10.06.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:30:54 -0800 (PST)
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de> <X8/K1dUgUmwp8ZOv@nand.local>
 <4696bd93-9406-0abd-25ec-a739665a24d5@web.de> <X9Fw0Pzn5wsy3wt0@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6691b5ab-6975-9aa3-3b72-11299d0889de@gmail.com>
Date:   Thu, 10 Dec 2020 09:30:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X9Fw0Pzn5wsy3wt0@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 7:50 PM, Taylor Blau wrote:
> On Wed, Dec 09, 2020 at 06:13:18PM +0100, René Scharfe wrote:
>> I'm not too familiar with the chunk producers and consumers, so I can
>> only offer some high-level observations.  And I don't have to use the
>> API, so go wild! ;)  I was just triggered by the appearance of two
>> working pieces of code being replaced by two slightly different pieces
>> of code plus a third one on top.
> 
> :-).
> 
>>> With regards to the "YAGNI" comment... I do have thoughts about
>>> extending the reachability bitmap format to use chunks (of course, this
>>> would break compatibility with JGit, and it isn't something that I plan
>>> to do in the short-term, or even necessarily in the future).
>>>
>>> In any event, I'm sure that this won't be these two won't be the last
>>> chunk-based formats that we have in Git.
>>
>> OK, so perhaps we can do better before this scheme is copied.  The write
>> side is complicated by the fact that the table of contents (TOC) is
>> written first, followed by the actual chunks.  That requires two passes
>> over the data.
> 
> "Two passes" meaning that we have to both compute the size of and then
> write the data? This is relatively cheap to do, at least so I think.
> 
> For e.g., the OIDLOOKUP commit-graph chunk is just the_hash_algo->hashsz
> * commits->nr bytes wide, so that can be done in constant time. A more
> heavyweight case might be for e.g., the Bloom data section, where Bloom
> filters have to first be computed, their lengths accounted for, and
> _then_ written when we eventually get to writing that chunk.
> 
> This happens in compute_bloom_filters(); and write_chunk_bloom_indexes()
> + write_chunk_bloom_data(), respectively. Those Bloom filters are all
> stored in a commit slab until they are written, so these "two passes"
> are just paid for in memory.

The current design of the format (TOC first) does require that we can
predict the chunk sizes before we start writing the file. But also this
has _some_ desirable properties for the writer. Specifically, we keep
the file write handle for a smaller amount of time. How valuable is that?
:shrug:

>> The ZIP format solved a similar issue by placing the TOC at the end,
>> which allows for one-pass streaming.  Another way to achieve that would
>> be to put the TOC in a separate file, like we do for .pack and .idx
>> files.  This way you could have a single write function for chunks, and
>> writers would just be a single sequence of calls for the different
>> types.
> 
> Interesting. I'm not opposed to changing any of these formats (and maybe
> there is some compelling argument for doing so, I am not sure) but I
> think that unifying the implementation for reading / writing the chunk
> format _before_ changing it is a postive step.

Changing the TOC location would require a version increment in the file
formats, which is a bit painful.

I understand why the ZIP format does this, it is trying to stream data
through a compression algorithm and cannot store the result in memory
before writing. Perhaps we would want to consider that as a way to
reduce the memory load for things like changed-path Bloom filters, but
let's wait for that to be an actually noticeable problem before making
the change.

The TOC location is definitely optimized for readers, who are already
reading the initial header to discover some info about the file.

>> But seeing that the read side just loads all of the chunks anyway
>> (skipping unknown IDs) I wonder why we need a TOC at all.  That would
>> only be useful if callers were trying to read just some small subset
>> of the whole file.  A collection of chunks for easy dumping and loading
>> could be serialized by writing just a small header for each chunk
>> containing its type and size followed by its payload.
> 
> AFAIK, we do use the table of contents to locate where the chunks are so
> that we can for e.g., set up the commit_graph structure's pointers to
> point at each chunk appropriately.

The chunk-based format is really optimized for _structured data_ where
these sizes are mostly predictable. The chunk sizes that are not
predictable are things like the "extra edges" or changed-path Bloom
filter data, but that data is indexed by a structured chunk.

A natural fit for the chunk-based format is the reachability bitmap
format, since the current format requires a scan to discover which
commits have bitmaps. If we used chunks, then we could quickly
search a lookup table for the commits that have bitmaps, then navigate
to the binary data chunk for the bitmap itself.

Thanks,
-Stolee
