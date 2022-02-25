Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8BC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 22:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiBYWpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiBYWpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 17:45:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BB2118E6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:44:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c6so9319069edk.12
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nTq6UGfp4IFbLags7IVo+BYeQvqW0C6JDqViqnl1raI=;
        b=TWQiBF+FbzbZHzpuoXBGqdi6assgdgRkrGCnJZaDRDNE6On+FdiJbj2ZjymUerbkBC
         WzbX6xvOli6uLkgaj7KPhXQxWZYkrxew1eLO/v85RRKchBX8lZ9GN5AteG3giwSqRlhF
         P19wz3X8bUC28gLUJ8c51PESjTC/6oBgjAMfIL/jiuSyZjeHqf0/s9nh0uJtbHrb2YXt
         hfxyl2gfKny3dYtRGXBbSNpK6vs7bvx9PPoSwdkjkcSQs/m5LLHYq5SgsUQu7O+lkDg9
         /hk/eJFXMfrtsLoVr432qIbvmwHzN5m0fb7eUN6Vm27xMYFPTsqFfxbDhEOuIiaeBtwz
         cucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nTq6UGfp4IFbLags7IVo+BYeQvqW0C6JDqViqnl1raI=;
        b=2Atcot2Hqwq2O7UuZ2qcnicWgmSVNE2SMqgZ1bzG1UhDvh5nFs1/nNWANFB0OX4GoW
         YXRX3LRHSR1JekDJ+YpQdyO/5qwkvqZdXVcrsTKADFKj7LZfxkJDgYBbPyMbp00iQXWJ
         lJKmzancrW3uIx/C6+7mevZqizpSmvMCzRGuVLDqUjnXnruLmgpyXJ39CG+TNj4orNEh
         /1WOY8xzbGOIHm71+DdC1rAErwGMaSulBP+x336WMEaEuVrHi6KTf+bEZKs7yvHfCWe1
         pxzw+XX+uzG2YWMnvFPA6NJCj07CgGz+lx8+0wwfKSv2kgDLFznYhQQV6mrUq8vf8kpN
         0waQ==
X-Gm-Message-State: AOAM531VugSqWooa6D8FEZ6omKvYgqrwxsIvD3WtZhV47Lh0eW+0hN+Y
        PhcGIRTTm0kMTCJUCBVq/Cjxvr5kVAR4Kg==
X-Google-Smtp-Source: ABdhPJx1muDgZEyy58Mr4J0G2V3e2G9z0bPTsyMyeNOHU4TY02sE4ZADn7GyYdm12A9/AmyksnLDhw==
X-Received: by 2002:a05:6402:26cf:b0:413:1741:eeab with SMTP id x15-20020a05640226cf00b004131741eeabmr9002386edd.442.1645829068034;
        Fri, 25 Feb 2022 14:44:28 -0800 (PST)
Received: from gmgdl ([109.36.128.147])
        by smtp.gmail.com with ESMTPSA id e11-20020aa7d7cb000000b00412a96ba630sm1908702eds.25.2022.02.25.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:44:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNjK6-000jBB-ON;
        Fri, 25 Feb 2022 23:44:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Date:   Fri, 25 Feb 2022 23:31:59 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
Message-ID: <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Derrick Stolee via GitGitGadget wrote:

> The corrected commit date was first documented in 5a3b130ca (doc: add
> corrected commit date info, 2021-01-16) and it used an optional chunk to
> augment the commit-graph format without modifying the file format
> version.
>
> One major benefit to this approach is that corrected commit dates could
> be written without causing a backwards compatibility issue with Git
> versions that do not understand them. The topological level was still
> available in the CDAT chunk as it was before.
>
> However, this causes a different issue: more data needs to be loaded
> from disk when parsing commits from the commit-graph. In cases where
> there is no significant algorithmic gain from using corrected commit
> dates, commit walks take up to 20% longer because of this extra data.
>
> Create a new file format version for the commit-graph format that
> differs only in the CDAT chunk: it now stores corrected commit date
> offsets. This brings our data back to normal and will demonstrate
> performance gains in almost all cases.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  .../technical/commit-graph-format.txt         | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 87971c27dd7..2cb48993314 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -36,7 +36,7 @@ HEADER:
>        The signature is: {'C', 'G', 'P', 'H'}
>  
>    1-byte version number:
> -      Currently, the only valid version is 1.
> +      This version number can be 1 or 2.
>  
>    1-byte Hash Version
>        We infer the hash length (H) from this value:
> @@ -85,13 +85,22 @@ CHUNK DATA:
>        position. If there are more than two parents, the second value
>        has its most-significant bit on and the other bits store an array
>        position into the Extra Edge List chunk.
> -    * The next 8 bytes store the topological level (generation number v1)
> -      of the commit and
> -      the commit time in seconds since EPOCH. The generation number
> -      uses the higher 30 bits of the first 4 bytes, while the commit
> +    * The next 8 bytes store the generation number information of the
> +      commit and the commit time in seconds since EPOCH. The generation
> +      number uses the higher 30 bits of the first 4 bytes, while the commit
>        time uses the 32 bits of the second 4 bytes, along with the lowest
>        2 bits of the lowest byte, storing the 33rd and 34th bit of the
>        commit time.
> +      - If the commit-graph file format is version 1, then the higher 30
> +	bits contain the topological level (generation number v1) for the
> +	commit.
> +      - If the commit-graph file format is version 2, then the higher 30
> +	bits contain the corrected commit date offset (generation number
> +	v2) for the commit, except if the offset cannot be stored within
> +	29 bits. If the offset is too large for 29 bits, then the value
> +	stored here has its most-significant bit on and the other bits
> +	store the position of the corrected commit date in the Generation
> +	Date Overflow chunk.
>  
>    Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
>      * This list of 4-byte values store corrected commit date offsets for the
> @@ -103,6 +112,9 @@ CHUNK DATA:
>      * Generation Data chunk is present only when commit-graph file is written
>        by compatible versions of Git and in case of split commit-graph chains,
>        the topmost layer also has Generation Data chunk.
> +    * This chunk does not exist if the commit-graph file format version is 2,
> +      because the corrected commit date offset data is stored in the Commit
> +      Data chunk.
>  
>    Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
>      * This list of 8-byte values stores the corrected commit date offsets

We talked a while ago now about how we do commit-graph format changes
and this is partially echoing those earlier questions[1] from 2019.

I fully understand why we're writing this amended CDAT chunk in a
different layout. By not having the GDAT side-chunk to look up in the
data is more local, that part of the file is more compact etc.

What I don't understand is why getting those performance improvements
requires the breaking version change & the writing of the incompatible
version number.

I.e. couldn't the differently formatted CDAT chunk be written instead to a new
chunk name (say "2DAT") instead? Per [1] we'd pay a small fixed cost for
a possibly empty chunk (I didn't re-do those numbers), but surely the
performance improvements will be about the same for that miniscule
overhead.

It will give you something you can't have here, which is optional
compatibility with older clients by writing both versions. That'll be a
~2x as large file on disk, but with the page cache & each client version
skipping to the data it needs caching characteristics & data locality
should work out to about the same thing.

Or maybe they won't. I just found it surprising when reviewing this to
not find an answer to why that approach wasn't
considered.

E.g. 76ffbca71a9 (commit-graph: write Bloom filters to commit graph
file, 2020-04-06) is a commit adding such new optional and
backwards-compatible data.

1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/
