Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94CDC35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D22072D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ods2Gyx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgBYP6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:58:55 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34852 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgBYP6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 10:58:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so5911108qvi.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 07:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wgutafk+h2SltWoiyyB+KMS56CSgeAEINqjymEws28g=;
        b=ods2Gyx5f87ClOkumcCbG8ffE892V2HF+1//cIGjJPGLJI+nchdWIgP3EO02bIZfHO
         9/+MoohR8jmQ8ez+mTNl4iwn6faE0bYfT1lH42B0BDh/67wL34PY+LKdwaadUNF+UfMi
         E+Kd6HxvJJ+ydga0QpDqHyRuFEFNI7rml/8Sb8MZMx4VTVpweDlByACzmDvbXQ2/tF/h
         08P212+YH6taW+DO4RWAxHyCN2URt7TVYqMRNGOhsxsAbqgdRjYbsC09BX+AsUfpf2jT
         E3XlyWODG96cJlUcl7v3EBKZ96LGktBC7j0fXkYTFEBAJJ0ybgwJ4tzCJ9xtOmuHkkCV
         CBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgutafk+h2SltWoiyyB+KMS56CSgeAEINqjymEws28g=;
        b=Gvy13CeYdK6LkbDKcP3YXaa54cky2c8f1huWP7yLWaF+JP3gARG1Xz2c4YYzMBlvsd
         GVvtOAgEnvu8EG+N0BmgsvNuHbq4HplWf5U/acgmYW6bqQ2Q+9bFD7/92pM5B+fyGXLy
         XkoY8J6Y6OgUipTOOhCA7bi4AHpdas7w32hcGcCcsGi7dnSU4IXBvxx3ir41gcBmUqn/
         YHS9/o2/MKUTskSNfv87oVtZfLBljGrVWQnsCK6k+Nl1v2kgM2+lR5LWrssY+W9KZV3i
         v34f3zV6ALZWSvyvdDL01KEO8S0holaYfAub64vnJQ/fCtWZmbUhwdFjWATuUWl1Ks4r
         sF2g==
X-Gm-Message-State: APjAAAWaweHmjbNqEGHMu49ZoZWHjjXD6SP9uSSzMuDnqpwisqWXJip8
        C20ApA+Y4NdXeJ0eTzioZLQ=
X-Google-Smtp-Source: APXvYqwIt3HY1/ON1onIsgaQ9qdklm+XQtGRl2//NlV9LJrFZWJZeibbhqcMBdBe5HkxaiXCOrq9/A==
X-Received: by 2002:a05:6214:3d0:: with SMTP id ce16mr50665041qvb.72.1582646332738;
        Tue, 25 Feb 2020 07:58:52 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:71c7:b899:72c7:7a30? ([2001:4898:a800:1010:22fe:b899:72c7:7a30])
        by smtp.gmail.com with ESMTPSA id g9sm7543565qkl.11.2020.02.25.07.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:58:52 -0800 (PST)
Subject: Re: [PATCH v2 07/11] commit-graph: write Bloom filters to commit
 graph file
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
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
 <86pneahaop.fsf@gmail.com> <de3f1f7e-0f2f-6c5d-6290-3ba5d37a0ea5@gmail.com>
 <86sgiyc2ta.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <65c3bce0-40b5-6c25-fd4a-11429c7f2196@gmail.com>
Date:   Tue, 25 Feb 2020 10:58:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86sgiyc2ta.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/25/2020 6:40 AM, Jakub Narebski wrote:
> Garima Singh <garimasigit@gmail.com> writes:
>> On 2/19/2020 10:13 AM, Jakub Narebski wrote:
>>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> [...]
>>>> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
>>>> index a4f17441ae..22e511643d 100644
>>>> --- a/Documentation/technical/commit-graph-format.txt
>>>> +++ b/Documentation/technical/commit-graph-format.txt
>>>> @@ -17,6 +17,9 @@ metadata, including:
>>>>  - The parents of the commit, stored using positional references within
>>>>    the graph file.
>>>>  
>>>> +- The Bloom filter of the commit carrying the paths that were changed between
>>>> +  the commit and its first parent.
>>>> +
>>>
>>> All right.
>>>
>>> Should we also state that it is optional (meta)data?  This would be
>>> first optional piece of data stored in commit-graph, I think.
>>>
>>
>> However the entire commit graph file is non critical metadata since git commands
>> work just fine without it, just slower. The same applies to the changed path
>> bloom filters. 
>>
>> Based on the definition of optional you are suggesting, edge data is optional
>> because not every commit-graph has octopus merges. 
> 
> Well, edge data (EDGE chunk) is optional in different way from Bloom
> filter data.  The former depends on the repository (whether there are
> octopus merges used), the latter is opt-in user choice (whether to run
> `git commit-graph write` with the `--changed-paths` option, or in the
> future equivalent config option).
> 
> To provide some advise that can be acted upon: perhaps it would be
> better to start with "It can store", or end with "if requested" or
> "optionally".  For example the change could look like the following
> suggestion:
> 
> 
>  The Git commit graph stores a list of commit OIDs and some associated
>  metadata, including:
> [...]
> +- The Bloom filter of the commit carrying the paths that were changed between
> +  the commit and its first parent, if requested.
> +
> 
> Best,
> 

Sure. That makes sense. Will incorporate in v3. 

Cheers!
Garima Singh
