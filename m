Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0011C433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C227720775
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMu6gMdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgF3Uqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgF3Uqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 16:46:51 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32667C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:46:49 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id z23so589713ood.8
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IolTvhlVpr5fw3qDWhSdry+KCLfmlQ1tdzYI/g3bex0=;
        b=IMu6gMdYckkd4cXL1rXr4ffTNzobYYnDq9Mw+WX1x7lpLoWIIyTcWYoZM0JSFHUv6a
         vj65lM8sHEoRxDgiHDxg3P8yZJStrpuYf+/1JvErdHYlONncWd0ezYtkT/8Ve2ICbdoh
         QO641QXi4hXgSUeJTDjCzibDuAFtBGraed5JcQmiD+U99j2AnJ8FPTZ3RB5FPMSC9LQK
         PHRumudF3kUjifVb4cTCqNri817Asf27+u+qTnI5RQSyh8zeXPFxEsjdIsRuwVJvOJqO
         faVSryF0YH/EXo8UsoH7orsqlfSV8H48Fn/p40Le0edQ7OWnX5U/iVO+XeCuN7vVqVT7
         6QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IolTvhlVpr5fw3qDWhSdry+KCLfmlQ1tdzYI/g3bex0=;
        b=B3bF8G+a4hOATahPMKo0yhH/qLLH051X8yJuZn7NEWsqjKHeK6ISh759f19c6hrnJJ
         Qk+qIa87UGV04Yo9NXGWfra8piOtxv9hKogrHddEs/iP6dpP53QMLLV/1NQHs/1ZIIQF
         QQrt6Ew5oygaRMeQgX4vZ5ssjacAmElcfoasN2f1LmHLVzC2GV5C2GOdnN2fBpvizKkj
         KjVge9RZim+3A/se0jceakl5gx3JyUwoazYumptg4sgGmb+EMO+Gfk48M4koMirXedHE
         7XZ/ZSEysvYmj96/jCEneciH3xh3omSCk5/DlJ0dQ4Ew7GqVtl7WpJzjmJgrJBjY4rBh
         16/A==
X-Gm-Message-State: AOAM533wZESMkUyEkDYgYUEvgur3boHs9i1Kjo5S6Ev8LddKnhYvrQ+N
        d38esTv35hv4Hx52nF49Tg4bnHH5YpE=
X-Google-Smtp-Source: ABdhPJwZZskef506/FHMlUqfA1lWotiGqBK5ds66O1xrW6syrD7xzKqvpTWIwAaFQgjs6Ch2RhEhcQ==
X-Received: by 2002:a4a:c43:: with SMTP id n3mr7643609ooe.66.1593550007330;
        Tue, 30 Jun 2020 13:46:47 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l24sm986245otf.79.2020.06.30.13.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 13:46:46 -0700 (PDT)
Subject: Re: [RFC] Metadata vs Generation Data Chunk
To:     20200622093451.GA1719@abhishek-arch, abhishekkumar8222@gmail.com
Cc:     jnareb@gmail.com, git@vger.kernel.org
References: <20200630150056.GA4111@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cf230320-b661-cc15-ce46-9cdc0250ee1c@gmail.com>
Date:   Tue, 30 Jun 2020 16:46:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200630150056.GA4111@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2020 11:00 AM, Abhishek Kumar wrote:
> Hello everyone,
> 
> I have finished all tests that I can think of and instead of throwing
> performance numbers at you, I am going to try and tell you a story.
> 
> WRITING COMMIT GRAPH
> ====================
> 
> The run time of writing a commit-graph is affected by time taken to
> compute generation number(s) and write them to the file.

As you continue, you use V0, V3, and V5 without (re)introducing
them. Please ensure these are defined well. This message has "Re:"
in the title, but was removed from the thread somehow in my
inbox. I don't see a definition of these terms in the thread [1],
either.

[1] https://lore.kernel.org/git/20200630150056.GA4111@Abhishek-Arch/T/#u

IIRC, we have these modes:

V0: The current generation number gen(C) defined as one more than the
    maximum gen(P) among parents P of C.

V3: The corrected commit-date given by ccd_3(C) = offset_3(C) + date(C)
    where offset_3(C) is the minimum non-negative integer such that
    offset_3(C) + date(C) > offset_3(P) + date(P) for all parents P of C.

V5: The backwards-compatible corrected commit-date is given by
    ccd_5(C) = offset_5(C) + date(C) where the inequality
    offset_5(C) + date(C) > offset_5(P) + date(P) holds, but also
    offset_5(C) > offset_(P) for all parents P of C.

Please correct me if I am wrong about these definitions.

> We had the following possible ideas for writing commit-graph:

The options here seem to be a little bit of overkill. Here are the
ones that I would seriously consider:
 
> MO: Calculate generation number V5 and write the offset into CDAT
>     (along with a metadata chunk).
>
> G3TO: Calculate generation number V3 and generation number V0, write
>     topological levels into CDAT and the offset into Generation Data
>     chunk.
> 
> G3TD: Calculate generation number V3 and generation number V0, write
>     topological levels into CDAT and the offset into Generation Data
>     chunk.

I think this last option you meant s/the offset/the corrected date/.
This means you are storing the date+offset in the file instead of just
the offset.

> | Version | time Taken      |
> |---------|-----------------|
> | master  | 14.200s         |
> | MO      | 14.094s         |
> | G3TO    | 14.331s         |
> | G3TD    | 14.419s         |

I don't consider write _time_ to be a huge issue, especially not with
these relative values. The SPACE taken by the commit-graph is more
important, and is probably a higher relative change than this time.
 
> Observations:
> 
> - Writing offset (i.e., 32-bits) is faster than writing corrected date 
>   (which are 64-bit long). However, we would have to deal with overflow
>   issues.

Please keep in mind that the CDAT chunk has a 64-bit "column" that
is split between commit date (34 bits) and generation number (30 bits).
So having 32-bit offsets in a new chunk adds some extra flexibility.

>   The largest offset value observed was of the order 2 ** 29. Assuming
>   no further "skips" in offset, we can store around ~635 million
>   commits without overflows. This, however, might not be true for other
>   repositories.

Was this the largest required offset for a single commit->parent skew,
or the cumulative effect of many offsets needing to grow, along with
the natural generation number growth? I'm guessing this is just the
largest offset that you computed in your write.

Since V3 doesn't require offset_3(C) > offset_3(P), the offsets should
naturally "fix" themselves over time by decreasing as time moves ahead.
So in that sense, I'm rather surprised to see that a 2^29 offset is
necessary.

This does make it seem like V5 should be abandoned because the CDAT
is running out of room for these offsets, so repos that grow enough
to overflow will lose any performance benefits from this approach.

>   A repository with a commit with Unix epoch '0' will overflow.
>   If we choose some sane default like commit date must be higher than
>   the release date of git, we can store around 110 million commits even
>   with '0' epoch.

This really depends on a commit with date '0' having a parent with a
~30-bit timestamp, OR having many of these kinds of shifts with more
reasonable dates.

> - Calculating topological levels with generation number V3 takes nearly
>   the same time as calculating generation number V5.
> 
> - The commit-graph file is larger by 4 Mb (+8%) and 8 Mb (+16%) when
>   storing offsets and dates.

8-16% is noticeable, but also not too bad. Thanks for reporting
these stats!

> Number of commits walked for different commands:
> 
> | Command                         | Master |   V3   |   V5   |
> |---------------------------------|--------|--------|--------|
> | log --topo-order -10000         |  48011 |  49954 |  49933 |
> | log --topo-order -100 v5.4 v5.5 |   3794 |   3314 |   3312 |
> | log --topo-order -100 v4.8 v4.9 |   5736 |   3887 |   3625 |
> | merge-base v5.4 v5.5            |  55053 |  57097 |  55109 |
> | merge-base v4.8 v4.9            | 635579 | 167468 | 506577 |

This last data point is extremely valuable. I think the fact
that V5 is closer to V0 here speaks to the negative effect
of requiring offset_3(C) > offset_3(P).
 
> - For log --topo-order, V3, and V5 walk 35% fewer commits than
>   the topological level when comparing v4.8 and v4.9.
> 
> - V3 walks far fewer commits than V5 when comparing by generation
>   numbers and then date for paint_down_to_common(). This is unusual
>   and is probably due to my implementation. Based on log --topo-order,
>   we might expect V5 to perform better than V3.

The v4.8 to v4.9 case is particularly nasty in a way that
doesn't cause issues with topo-order walks. This is the
big reason we are pursuing this at all!

> - V3 walks the same number of commits when compared using commit
>   date for merge-base.
> 
> The time taken for each command rough corresponds to the number of
> commits walked, with no difference between Metadata chunk and Generation
> Data chunk approaches.
> 
> | Command                         | Master  |    V3   |   V5   |
> |---------------------------------|---------|---------|--------|
> | log --topo-order -10000         |  0.210s |  0.209s | 0.207s |
> | log --topo-order -100 v5.4 v5.5 |  0.013s |  0.013s | 0.013s |
> | log --topo-order -100 v4.8 v4.9 |  0.015s |  0.013s | 0.013s |
> | merge-base v5.4 v5.5            |  0.048s |  0.047s | 0.047s |
> | merge-base v4.8 v4.9            |  0.135s |  0.133s | 0.134s |

Are you sure these timings are correct for the last row? It
seems that the times would be more significantly different
for the number of commits that were walked. Keep in mind that
we should be reporting these merge-base timings when
paint_down_to_common() has its priority queue set to pull
the maximum generation number (V0, V3, or V5) in order to
really compare. It seems like that was done correctly in
the commit count, but this data seems to imply something
else.

> - If overflows are unlikely to happen and not accounted for, implement
>   generation number V5 using metadata chunk. It has the lowest write
>   time and walks just as few commits as V3.

(For the "merge-base v4.8 v4.9" case, this is untrue.)
 
> - If overflows are a concern, implement generation number V5 with
>   generation data chunk, storing offsets in generation data chunk.

Here is an excellent time to be REALLY clear about what you mean
about V3 and V5.

Do you have these prototypes available somewhere so others can
test? That would also help in verifying these results. It
would be enough to push the code to a public Git hosting service
so we can fetch your commits, build, and test. These don't need
to be submission-ready patches.

Thanks for doing all this work! We are getting closer and closer
to a final direction.

-Stolee
