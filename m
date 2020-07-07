Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CCC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB620674
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPytngPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGGQAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGQAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:00:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB4AC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 09:00:14 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id q10so4702773ooo.11
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYygiyKQZ6APeAW5vptxBXrmt9BYWyvN89JyiqbcdR4=;
        b=hPytngPKiMYoud6bnrJKF7HpkbH3hCiiGBBOm67sdJODczf2F2DyXWUcGX3jQxYFcg
         wayqjWMRLh8FgAYFFzDxCvyN7INeXIskzcjZnxbmT85PmjF8sSsTyCp6ZGZJZ17Oyd3z
         AZpZsiHaBABz+CoMjiQI6QBwy1QFBAU0Ia7k4QlTwj/R8os0YuonBR0sDW+MgAqnJ9JF
         1Bi+D6KfNJzpJZU1uavyYuz/P7SzWkv0mp8pTB78GmSFzCRTWXqb1IRG8HCUBWXyA4jf
         G393le2MB6n5korL3OzE61PolcDNqC2uh3tVCRY1+WXKu5riqTih96NjhL83wp7aZq/m
         xLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYygiyKQZ6APeAW5vptxBXrmt9BYWyvN89JyiqbcdR4=;
        b=T2FuRchfmmR3gsbWWZJ0n4n+nGtF8c3Jj66p1EHLZwMKkZWHno1jIAPPhnSfJ/41g3
         odJHWtU/Z7/f3XcYgnCd5aLBaEbCG6m5NZrhyyP8qIP66PLPAUSEZnUzhAOCp0jEgjvv
         EogZbMZ2GAnM3ujX5h4YhVnIv6sgXEGiJh1gbZo+9n6b1KwX3Z35XmrWuKqiepsHLlb2
         tWduDhMZx/nvVxz24uRqXNrhqABxx8LrxkPXrymy1d4XFxBJevNZLS+sncuuttRO2+aS
         /4fqD+M42gTDtVoVOylilVc8yQslt28iG8+Nwz1dO6I+fpbTMwmAIm6HnqcwsfNLn6aP
         yNAQ==
X-Gm-Message-State: AOAM5322+1GVAF6jaQHeFnK9FiffYVD7zNSjfY03HaylI7aolmRgk7qb
        SWj4oxGrDFmZtPJjw9BVmvlFWBwx8cU=
X-Google-Smtp-Source: ABdhPJzC6waHDUlOMMJieHrpouomXKTqBnGEWSPCnKteybYYzP/jUEOwwyOD4bee3MSU53Inum5yTw==
X-Received: by 2002:a4a:b284:: with SMTP id k4mr8897696ooo.49.1594137612823;
        Tue, 07 Jul 2020 09:00:12 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m13sm5806880otf.43.2020.07.07.09.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 09:00:12 -0700 (PDT)
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul
 2020, #01; Mon, 6))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
 <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
 <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
Date:   Tue, 7 Jul 2020 12:00:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/7/2020 11:12 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/7/2020 1:57 AM, Junio C Hamano wrote:
>>> * ds/commit-graph-bloom-updates (2020-07-01) 10 commits
>>>   (merged to 'next' on 2020-07-06 at 177e6b362e)
>>>  + commit-graph: check all leading directories in changed path Bloom filters
>>>  + revision: empty pathspecs should not use Bloom filters
>>>  + revision.c: fix whitespace
>>>  + commit-graph: check chunk sizes after writing
>>>  + commit-graph: simplify chunk writes into loop
>>>  + commit-graph: unify the signatures of all write_graph_chunk_*() functions
>>>  + commit-graph: persist existence of changed-paths
>>>  + bloom: fix logic in get_bloom_filter()
>>>  + commit-graph: change test to die on parse, not load
>>>  + commit-graph: place bloom_settings in context
>>>  (this branch uses sg/commit-graph-cleanups.)
>>>
>>>  Updates to the changed-paths bloom filter.
>>>
>>>  Will merge to 'master'.
>>>
>>> * sg/commit-graph-cleanups (2020-06-08) 10 commits
>>>  + commit-graph: simplify write_commit_graph_file() #2
>>>  + commit-graph: simplify write_commit_graph_file() #1
>>>  + commit-graph: simplify parse_commit_graph() #2
>>>  + commit-graph: simplify parse_commit_graph() #1
>>>  + commit-graph: clean up #includes
>>>  + diff.h: drop diff_tree_oid() & friends' return value
>>>  + commit-slab: add a function to deep free entries on the slab
>>>  + commit-graph-format.txt: all multi-byte numbers are in network byte order
>>>  + commit-graph: fix parsing the Chunk Lookup table
>>>  + tree-walk.c: don't match submodule entries for 'submod/anything'
>>>  (this branch is used by ds/commit-graph-bloom-updates.)
>>>
>>>  The changed-path Bloom filter is improved using ideas from an
>>>  independent implementation.
>>>
>>>  Under review.
>>>  cf. <20200627155610.GN2898@szeder.dev>
>>>  cf. <20200627163335.GO2898@szeder.dev>
>>>  cf. <20200627155348.GM2898@szeder.dev>
>>
>> I see these are both in 'next' (thanks!).
>>
>> Perhaps the "Under review" status for sg/commit-graph-cleanups
>> should be modified to match ds/commit-graph-bloom-updates?
> 
> Oops, I am not sure what happened here.  There I thought were issues
> pointed out at least on the latter series but was I hallucinating?

I believe I have resolved all the open comments in both series.

Looking back, I suppose I never responded on the feedback to
"commit-slab: add a function to deep free entries on the slab" that
the deep free is never called. The intention is to add a free
eventually, but at the current point it is not appropriate.

> For now, as -rc0 is so close, I'm tempted to mark both of them to be
> cooked in 'next' during the rc period.

This is completely acceptable. No need to rush this into the RC. I'm
happy to let this cook and do more small improvements on top in the
2.29 cycle, if necessary.

Thanks,
-Stolee
