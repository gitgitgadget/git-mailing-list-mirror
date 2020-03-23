Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F6C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4F20714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7y/lqxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCWPyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:54:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46842 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgCWPyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:54:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so7381106oia.13
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fpz/1/vSTiJy4dp6tf5cHZhaoJffmvHMcMinG4nHU9g=;
        b=J7y/lqxdWyZMMVN/xpmAeiJDjqMbvc6qh/vwevyNK/ZhyPbNxF48DvOQPz/oqk+RPV
         AX4OyLX7AVFK7UUs8lLV54q6c9Os62GvZ2S9218I5Tra8Bq1Pqjko10AmVxHY0RiikxP
         00rLFtxokiUS5jIa3Wh+x7z2r7ysDvOfQuSvTgJYUD4K6pskkgUy1p4G1De/ZxEFskvY
         9GKgmlmcpiURfzl3rAUKu3Ks8eR60y27AW9I9JGlZ1hBgPo/hBDzjbtGfeSvLZgjOWAY
         kpnwwROJzrZ8nXIwgNReGzr2ptMby+fA2LmlMNp7+/jV37E9TuZJ9Fn9txeQAmTMtUn7
         gaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpz/1/vSTiJy4dp6tf5cHZhaoJffmvHMcMinG4nHU9g=;
        b=Xq26/bLyGaX6LkfBJIzB0BSJjbl2+5gcjS7EuoPM9K5wx86IoVG1wRsF+NTLzJTzjb
         7R5AD9i8BISdMC0GtXF3HZjDl4b+UXcv0ysJi2dtGbAqWsLJl76kNzIY26ra04hIsc+G
         VtN2wNZLV1eg6f7ucSPn4J6LZqr2TKssZaJK7C5KerK9fTAfRO3wxINN6CnvEg+M8kSP
         i6MvschZTqenKsgCi5NIDY4A4ZWIlr6XKM71DFpGLpNrLnraiB76InqmYQ1s3KwubRTP
         VJ+wG/fr4SRQ6ZtrHNGxYxpb/kWpBl2pp/nbjTw9unGytsVN6inKfpZ40TauXKgZeuPl
         2ACg==
X-Gm-Message-State: ANhLgQ0Rixjr4YKknLwAkxrLcTfj1ZHblxbsZPXfcH6UpoqWEjs+Qf7W
        h2iPTsRt2LZZzLI/KR2MqRk=
X-Google-Smtp-Source: ADFU+vva/TZOQm3DiAXGqyaltsKeW5JhbGZNB7p8MfzmawKNC4wtO0QoWmn1DnrjDxCy573VASzbVg==
X-Received: by 2002:aca:cc81:: with SMTP id c123mr1111oig.74.1584978849144;
        Mon, 23 Mar 2020 08:54:09 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e64sm5338639oif.10.2020.03.23.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 08:54:08 -0700 (PDT)
Subject: Re: [RFC][GSoC] Implement Generation Number v2
To:     Jakub Narebski <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
 <20200323042517.GA1258@Abhishek-Arch>
 <xmqq369z7i1b.fsf@gitster.c.googlers.com> <86mu87qj92.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <13995fbd-d645-56aa-b647-e9a51d00554e@gmail.com>
Date:   Mon, 23 Mar 2020 11:54:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <86mu87qj92.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2020 9:43 AM, Jakub Narebski wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>> Jakub Narębski <jnareb@gmail.com> writes:
> [...]
>>>> Unfortunately for the time being we cannot use commit-graph format
>>>> version; the idea that was proposed on the mailing list (when we found
>>>> about the bug in handling commit-graph versioning, during incremental
>>>> commit-graph implementation), was to create and use metadata chunk or
>>>> versioning chunk (the final version of incremental format do not use
>>>> this mechanism).  This could be used by gen2 compatibile Git to
>>>> distinguish between situation where old commit-graph file to be updated
>>>> uses generation number v1, and when it uses v2.
>>>>
>>>> If you have a better idea, please say so.
>>>
>>> We could also use a flag file. Here's how it works:
>>>
>>> If the file `.git/info/generation-number-v2` exists, use gen2.
>>> Otherwise use gen1.
>>
>> If the file is lost then we will try to read the other file that has
>> the commit-graph data as if it were in old format?  And if such a
>> file was created (say, with "touch .git/info/generation-number-v2"),
>> a file in the original format will be read as if it is in new
>> format?  If that is the case, it is likely that we'd see a segfault;
>> sounds too brittle to me.
>>
>> It appears that the format of "CDAT", and the fact that generation
>> is represented as higher 30-bit of a be32 integer, is very much
>> hardcoded in the design and is hard to change, but your new version
>> of graph file can be designed not to use "CDAT" chunk at all, and
>> instead have the commit data with new version of generation numbers
>> stored in a different chunk (say "CDA2") to force older version of
>> Git not to use the new graph file---would that work?
> 
> It looks like there are a few possible ways of handling introduction of
> generation numbers v2.  Let's consider them one by one.
> 
> The problem we need to solve is co-existence of old Git (that does not
> understand v2, and that hard fails on commit-graph format version bump),
> and new Git (that understands and writes v2, and that I assume soft
> fails that is it simply doesn't use commit-graph if it of unknown
> version).
> 
> 
> If the commit-graph file was written by new Git, and includes generation
> numbers v2, we want old Git to at least do not crash, possibly do not
> use commit-graph, best if it can use commit-graph in suboptimal way.  We
> also need to handle old Git trying to update (in incremental or
> non-incremental way) the commit-graph file.
> 
> If the commit-graph file was written by old Git, and includes generation
> nmbers v1 (topological levels), we want new Git to recognize this and at
> best use those old generation numbers in a correct way.  We want new Git
> to be able to update commit-graph file (in incremental or
> non-incremental way).
> 
> Did I miss anything?
> 
> 
> Proposed solutions are:
>  - metadata / versioning chunk,
>  - flag file: `.git/info/generation-number-v2`,
>  - new chunk for commit data: "CDA2".
> 
> I would like to propose yet another solution: putting generation number
> v2 data in a separate chunk (and possibly keeping generation number v1
> in CDAT commit data chunk).  In this case we could even use ordinary
> corrected commit date as generation number v2 (storing offsets as 32-bit
> unsigned values), instead of backward-compatibile corrected commit date
> with monotonic offsets.

I agree that if we are creating a new (optional) chunk, then that gets
around our versioning issues and could store just the offsets to get
the "corrected commit date" option instead of the backwards-compatible one.
By including yet another version number at the beginning of that chunk,
we could present a way to update this "second reachability index chunk"
with things like your interval mechanism with very little cost.

> Each solution has its advantages and disadvantages.
> 
> 
> With the flag file, the problem is (as Junio noticed) that if file gets
> accidentally deleted, new Git would think incorrectly that commit-graph
> uses generation number v1... which while suboptimal should not be bad
> thanks to backward compatibility.  But I think the flag file should have
> some kind of checksum as its contents (perhaps simply a copy of
> commit-graph file checksum, or one checksum per file in chain with
> incremental commit-graph), so that it old Git rewrites commit-graph file
> leaving flag file present, new Git would notice this.

I'm not a fan of the flag file idea. Optional chunks are a good way forward.
That _could_ mean the metadata chunk, whose length can grow in the future
if/when we add more fixed-width metadata values.

> Metadata or versioning chunk cannot be deleted by mistake; if old Git
> copies unknown chunks to new updated commit-graph file instead of
> skipping them we would need to add some kind of checksum (similarly to
> the case for flag file).  The problem to be solved is what to do if some
> files in the chain of commit-graph files have v2 (and this chunk), and> some have v1 generation number (and do not have this chunk).

The incremental commit-graph format is newer than our previous tests
for generation number v2, which will be a big reason why that old code
cannot be immediately adapted here.

The simplest thing to do is usually right: if we try to write a
generation number version that doesn't match the current commit-graph,
then we need to flatten the entire chain into one layer and recompute
the values from scratch. While it is _technically_ possible to mix
the backwards-compatible corrected commit date with generation number
v1, it requires taking the "lowest version" when doing comparisons and
that may behave very strangely. Better to avoid that complication.

> About moving commit data with generation number v2 to "CDA2" chunk: if
> "CDAT" chunk is missing then (I think) old Git would simply not use
> commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
> chunk has zero length... I don't know what would happen then, possibly
> also old Git would simply not use commit-graph data at all.

CDAT is required as it contains more than just generation numbers. It
has the commit date, parent int-ids, and root tree oid. The generation
numbers _could_ be left as all zeroes, which is a special case for the
format before generation numbers were introduced, but it would be better
to have values there.

> Putting generation number v2 into separate chunk (which might be called
> "GEN2" or "OFFS"/"DOFF") has the disadvantage of increasing the on disk
> size of the commit graph, and possibly also increasing memory
> consumption (the latter depends on how it would be handled), but has the
> advantage of being fullly backward compatibile.  Old Git would simply
> use generation numbers v1 in "CDAT", new Git would use generation
> numbers v2 in "OFFS" -- combining commit creation date from "CDAT" and
> offset from "OFFS"), and there should be no problems with updating
> commit-graph file (either rewriting, or adding new commit-graph to the
> chain).

I share these concerns but also the locality of the data within the file.
As we parse commits, we need the parent and commit date information out
of the CDAT chunk anyway, so it is not difficult to grab the nearby
generation number. If we put that data further away in a separate chunk,
then it can be more expensive to flip between the CDAT chunk and the
GEN2 chunk.

In terms of your prototyping for performance checks, it may be good to
have a number of "GEN<X>" chunks so you can compute one commit-graph
that stores all of the candidate reachability indexes, then use one
of the chunks based on a config value or environment variable. I think
that would only be appropriate for testing if you are evaluating which
to build, so if you are focusing entirely on backwards-compatible
corrected commit date, this is not worth spending time on.

Thanks,
-Stolee
