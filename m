Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9058C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 14:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C245B20732
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjE7KIP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgFVOq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVOq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 10:46:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15EC061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 07:46:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so3840532qko.7
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uST09V6u+rdcqIigrj+tuLkTqRJAdrgWsDDGt7rOQX4=;
        b=cjE7KIP6Xmh1SNPqYrJhEnsLBU/3fa3bCdLmYjVA0E6NvDj47aINO4og/y/Ajh/jLD
         ryW0Ho4XNoQzbsEKTCjpYftXKPI8oG4pqEWjx31vxWE6ollFRddRr9tAVMkWFOQjSHOh
         aQhpYyFGHu5K8Vg9go6wY8njTwsANPc+0pguczCYkTUg85pHgMPsA++uu/uCfp81mZoo
         XFxx9YAz9hAqWyTapdcpX+IfIuqNbGjY8XdymWAaz+v4SJvQJl/7no57DKNODwHE+m2n
         fciM1/55TXciWApwd8Ejb8a9cdcjPvu/fQ8YLSCx/zDJAW+Sj6SXjp51VjuQQ6Q2hRXA
         uA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uST09V6u+rdcqIigrj+tuLkTqRJAdrgWsDDGt7rOQX4=;
        b=KWMZ97+NxOM9ZADyakxl7geC0DdXdZp3W4h51LZQI+RfOGAz51h3gN73VEQ12WLTFL
         oGTtj/zEDn938yogQRH8BN1+7cLzk1VzjTL1HuJjwHhf0KCvNv52w2z7jaWVRB3JYzKq
         al1LbekKCUEiudTKQRd+wdAv3Drly3siJKcoNJbKlfuyGrfInd9kgH/3X3frZhKqByEn
         3n4yluHebhaGlnFJ+ErRTi4u/4O90HhQ/K0RroICxKQDpri6XubQUg9JV/ioivzClKs4
         MlDaJ4haikZ4h4LQYBr8owh/ziyU+cDymqOzofA/K57pmrzHsbJZmYsK7UsN/PcXGt+t
         kVwQ==
X-Gm-Message-State: AOAM5315nerO1hsjtO+dKdxosXTD3IxiAb3FDcpWMqD8VtLxrUhNyGwz
        JOG0PI1A+jDm05cLIwn5CTLXh4XssPA=
X-Google-Smtp-Source: ABdhPJwG7XbTQFYMgbP7lxh85w5yqsIZRQapmnC2QrHoVrX9Y4iz0wBhDQu1/OcmpHHGCPJXqR+aLg==
X-Received: by 2002:a37:c401:: with SMTP id d1mr4439518qki.19.1592837188228;
        Mon, 22 Jun 2020 07:46:28 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h3sm1226233qkk.10.2020.06.22.07.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:46:27 -0700 (PDT)
Subject: Re: [RFC] Metadata vs Generation Data Chunk
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com
References: <20200622093451.GA1719@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7bd59f07-39e7-82c4-51c4-0ceba9f45999@gmail.com>
Date:   Mon, 22 Jun 2020 10:46:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200622093451.GA1719@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2020 5:34 AM, Abhishek Kumar wrote:
> One of the remaining pre-requisites for implementing generation number
> v2 was distinguishing between corrected commit dates with monotonically
> increasing offsets and topological level without incrementing generation
> number version.
> 
> Two approaches were proposed [1]:
> 1. New chunk for commit data (generation data chunk, "GDAT")
> 2. Metadata/versioning chunk
> 
> Since both approaches have their advantages and disadvantages, I wrote
> up a prototype [2] to investigate their performance.
> 
> [1]: https://lore.kernel.org/git/86mu87qj92.fsf@gmail.com/ 
> [2]: https://github.com/abhishekkumar2718/git/pull/1
> 
> TL;DR: I recommend we should use generation data chunk approach.
> 
> Generation Data Chunk
> =====================
> 
> We could move the generation number v2 into a separate chunk, storing
> topological levels in CDAT and the corrected commit date into a new,
> "GDAT" chunk.  Thus, old Git would use generation number v1, and
> new Git would use corrected commit dates from GDAT.
> 
> Using generation data chunk has the advantage that we would no longer
> be restricted to using 30 bits for generation number.

It will be important to detect these 30-bit overflow and replace the
value with GENERATION_NUMBER_MAX and treat those commits as having
GENERATION_NUMBER_INFINITY(_V2) when parsing them.

This 30-bit overflow _is_ more likely in the approach we've considered
because the commit-date offsets will accumulate through the history.
Please test a check for this against repos with particularly nasty
commit-date problems like the Linux kernel repo. Perhaps it would be
worthwhile to output the maximum stored offset in the trace2 API so
we can see how close we are to overflowing, even if we do not.

In order to fully commit to this plan, we need to know how problematic
this overflow is. Generation number v1 required hundreds of millions
of commits in a row to overflow, but here we could overflow with a few
appropriate commit date problems. How common are they in the wild?

> It also works
> well for commit-graph chains with a mix of v1 and v2 generation numbers.

We do not want to mix commit-graph chains with v1 and v2 numbers,
because we want the comparison between two commits to be independent
of which commit-graph layer they came from. This will require us to
squash the layers if we are asked to write one version and the existing
chain does not match that version.
 
> However, it increases the time required for I/O as commit data and
> generation numbers are no longer contiguous.

I'm glad you were able to measure this, which makes the locality of
the data chunk a valuable feature.

> Note: While it also increases disk space required for storing
> commit-graph files by 8 bytes per commit, I don't consider it relevant,
> especially on modern systems. A repo of the size of Linux repo would be
> larger by a mere 7.2 Mb.

...relative to what? What's the percentage increase? It still is not
going to be too bad. I'm _guessing_ ~10-15%.

> Metadata / Versioning Chunk
> ===========================
> 
> We could also introduce an optional metadata chunk to store generation
> number version and store corrected date offsets in CDAT. Since the
> offsets are backward compatible, Old Git would still yield correct
> results by assuming the offsets to be topological levels. New Git would
> correctly use the offsets to create corrected commit dates.
> 
> It works just as well as generation number v1 in parsing and writing
> commit-graph files.
> 
> However, the generation numbers are still restricted to 30 bits in CDAT
> chunk and it does not work well with commit-graph chains with a mix of
> v1 and v2 generation numbers.
> 
> Performance
> ===========
> 
> | Command                        | Master | Metadata | Generation Data |
> |--------------------------------|--------|----------|-----------------|
> | git commit-graph write         | 14.45s | 14.28s   | 14.63s          |
> | git log --topo-order -10000    | 0.211s | 0.206s   | 0.208s          |
> | git log --topo-order -100 A..B | 0.019s | 0.015s   | 0.015s          |
> | git merge-base A..B            | 0.137s | 0.137s   | 0.137s          |
> 
> - Metadata and generation data chunks perform better than master on
>   using commit-graph files since they use corrected commit dates.
> 
> - The increased I/O time for parsing GDAT does not affect performance as
>   much as expected.
> 
> - Generation data commit-graph takes longer to write since more
>   information is written into the file.
>> As using the commit-graph is much more frequent than writing, we can
> consider both approaches to perform equally well.
> 
> I prefer generation data chunk approach as it also removes 30-bit length
> restriction on generation numbers.

Thanks for testing these approaches.

The other thing to keep in mind with the new data chunk is that we will
probably still want a 32-bit value, but it no longer needs to be
backwards compatible! We would keep generation number v1 in the data
chunk, but could place _any_ definition in the v2 chunk.

This means that the "offset" from the commit-date does not need to be
strictly increasing! This could help with the overflow issue if someone
decided to do a nasty commit-date order issue (say, a commit with
Unix epoch "0" pointing to a recent commit with "real" date).

Recall that a commit C has a commit-date (date(C)) given by the
commit date, and we are storing an additional offset (off(C)) with
the following requirement for all parents P:

	date(C) + off(C) > date(P) + off(P)

The backwards-compatible requirement is this:

		off(C) > off(P)

but we can drop that if we are using the new chunk. That allows
off(C) to be zero if we already have date(C) > date(P) + off(P),
which will naturally happen as time passes (barring malicious
users).

Since you have an initial prototype of these two approaches,
could you extend your Generation Data prototype to use this
non-backwards-compatible model and report the performance data?

I found that using different pairs of tags in the Linux kernel
repo to be particularly fruitful for A..B performance tests.
In particular, "git merge-base v4.8 v4.9" demonstrated the problems
with generation number v1 [1]. Please also update the
paint_down_to_common() method to use generation numbers so
we can see the benefit or drawback there. Perhaps use config or
an environment variable to change this:
 
	if (!min_generation)
		queue.compare = compare_commits_by_commit_date;

to this:

	if (!min_genertion && !git_env(...))
		queue.compare = compare_commits_by_commit_date;

Without comparing commit-date heuristics against your generation
number values, we will not be sure that we are moving in the
right direction here.

[1] https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/

Thanks,
-Stolee
