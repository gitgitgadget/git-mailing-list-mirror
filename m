Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A0AC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CB320EDD
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZprIkLxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgFZNqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNqO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 09:46:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD2C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 06:46:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so4651337pfa.12
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=B7aVInvoZ43nlQoxAcv371815jrtIDec3x/tq9QwBwg=;
        b=ZprIkLxjl4M//KAkDAu7ks9x/QvuwNMmH01RCp9KVIKoBad6BWuyo/KateIqvnwh3w
         tNjsJRM6enlpf0CT8JvGTRSGi55yykfUyvA0FZ4x/CbD9NYVHk6fJuByx2tEcsB9m/n3
         oRnO/o+jeOeFXmos4+7x3fGfsvOLh/+QxcoXqA4GGaJYQWiXHxhUz4y2CAMXrNCnf0/F
         zh8OPmBRpOQWktyVp1sEUG5NMcI58nTzT/5FnHRis4yKZLLKZ6IkO4IpLzp9XrNrNMgp
         JPZ/DbavcLIWzb+R0ySzh3tAEzDBiNd5yKUice6E85qJeqC5gJOkoPC5RJJt2T40Rm23
         r3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:content-transfer-encoding;
        bh=B7aVInvoZ43nlQoxAcv371815jrtIDec3x/tq9QwBwg=;
        b=BTwpGugeDfYXmYdI4OkhffHDVKpVOqnVGufSAtboXMBdCP7qExwswD6jjKTd8w3k+H
         lwji5ZLmXcp7Aed5Az8BzThbeUJNQakuar1tR7rTm5vS68WLsmasHjnXn1jsAQ/A+wAm
         eRyKc81CYYNzreGeWNP0rzzPKq8Ap8H6vAt4s42Jgs92ZZ9B0idM7e9xl6qYaV2f9pQu
         FFCEa9xYj2BauKuA8rlI0KK3Gh7QazIEB3151wC4STG5ZHNXD7sDficuoGtAchA7rcKq
         sN8KkVr9unbWGXHYbD9aD6EkPckZ3fdWhlfJ5k/sFZsPZ9ihqZJR0pSQDar8BC9pt+6R
         TA0Q==
X-Gm-Message-State: AOAM530B3NjbEq8zzaW+v7oFTbxLFI+XMsz+P9nCS9sTXVmsyuf2AOpA
        PX4akTvXwZZSCO7fL2Qd4FM=
X-Google-Smtp-Source: ABdhPJyW7oxHouXLgMYlOCmnUz2KqLE9sz6nF6+eeBbSaFh4uOgVq0bTw9Qgj36OqLQC1fqf4VE/gA==
X-Received: by 2002:a62:8096:: with SMTP id j144mr2963947pfd.78.1593179174211;
        Fri, 26 Jun 2020 06:46:14 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:240c:f780:27e9:de1c:b7c0:2e6b])
        by smtp.gmail.com with ESMTPSA id y7sm11914950pjy.21.2020.06.26.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:46:13 -0700 (PDT)
Date:   Fri, 26 Jun 2020 19:14:22 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     jnareb@gmail.com
Cc:     stolee@gmail.com, git@vger.kernel.org
Subject: Re: [RFC] Metadata vs Generation Data Chunk
Message-ID: <20200626134422.GA17537@Abhishek-Arch>
Reply-To: 10d99e37-8870-6401-d9aa-21a359b30835@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.06.2020 at 13:40, Jakub Narębski wrote:
> On 22.06.2020 at 11:34, Abhishek Kumar wrote:
> 
> > One of the remaining pre-requisites for implementing generation number
> > v2 was distinguishing between corrected commit dates with monotonically
> > increasing offsets and topological level without incrementing generation
> > number version.
> > 
> > Two approaches were proposed [1]:
> > 1. New chunk for commit data (generation data chunk, "GDAT")
> > 2. Metadata/versioning chunk
> 
> Actually in [1] there was also proposed another distinct approach,
> namely to 'rename' the "CDAT" chunk to something else, like "CDA2"
> (or proposed here "GDAT").
> 
> If I read the code correctly, with old Git if one of required chunks
> is missing then Git would continue work as if commit-graph was not
> present -- as opposed to current handling of unknown commit-graph
> file format version number, where Git would stop working with an
> error message.
> 

Actually, v2.21.0 (and possibly others) segfault when they encounter a
commit-graph without CDAT chunk.

Here's what I did:
- Create a commit-graph, renaming "CDAT" to "CDA2" and otherwise
  identical.
- Call `git log`.
- Git segfaults after calling fill_commit_graph_info().

Diff for the hexdump of commit-graph files:

3c3
< 0000020 4443 3241 0000 0000 0000 a807 0000 0000
---
> 0000020 4443 5441 0000 0000 0000 a807 0000 0000
209,210c209,210
< 0000dd0 0000 0c00 cd5c d1f7 a34d d713 70d3 114e
< 0000de0 7b92 131c f605 3b92 856a 2318          
---
> 0000dd0 0000 0c00 cd5c d1f7 b474 d280 6b17 2eb2
> 0000de0 a660 9ed6 04f0 7bed 8cb0 3712          

(They also differ in the hash checksum, but I don't suppose that would
explain the segfault.)

With this, I presume "CDAT Chunk Replaced With Another Chunk" is no
longer feasible?

The commit-graph files:
"CDA2" - https://github.com/abhishekkumar2718/GSoC20/blob/master/commit-graph-cda2
"CDAT" - https://github.com/abhishekkumar2718/GSoC20/blob/master/commit-graph-cdat

> 
> > Since both approaches have their advantages and disadvantages, I wrote
> > up a prototype [2] to investigate their performance.
> > 
> > [1]: https://lore.kernel.org/git/86mu87qj92.fsf@gmail.com/
> > [2]: https://github.com/abhishekkumar2718/git/pull/1
> 
> That's very nice.  Thanks for investigating that.
> 
> > 
> > TL;DR: I recommend we should use generation data chunk approach.
> > 
> > Generation Data Chunk
> > =====================
> > 
> > We could move the generation number v2 into a separate chunk, storing
> > topological levels in CDAT and the corrected commit date into a new,
> > "GDAT" chunk.  Thus, old Git would use generation number v1, and
> > new Git would use corrected commit dates from GDAT.
> > 
> > Using generation data chunk has the advantage that we would no longer
> > be restricted to using 30 bits for generation number. It also works
> > well for commit-graph chains with a mix of v1 and v2 generation numbers.
> > 
> > However, it increases the time required for I/O as commit data and
> > generation numbers are no longer contiguous.
> > 
> > Note: While it also increases disk space required for storing
> > commit-graph files by 8 bytes per commit, I don't consider it relevant,
> > especially on modern systems. A repo of the size of Linux repo would be
> > larger by a mere 7.2 Mb.
> 
> All right.
> 
> Another advantage: we don't have to store the corrected committer date
> _offset_, we can store the date (as epoch) directly.  This saves some
> calculation, though a minuscule amount.
> 
> Yet another advantage: we don't need backward-compatibility for
> generation number v2, i.e. corrected commit date.
> 

That's actually a great point. This might save us some calculation as we
don't need to calculate the "correction offsets". 

> Another disadvantage: we need to compute both topological levels and
> corrected commit date when creating a commit-graph file or a chunk of
> it.  This means that `git commit-graph write` could be slightly more
> expensive.
> 
> > 
> > Metadata / Versioning Chunk
> > ===========================
> > 
> > We could also introduce an optional metadata chunk to store generation
> > number version and store corrected date offsets in CDAT. Since the
> > offsets are backward compatible, Old Git would still yield correct
> > results by assuming the offsets to be topological levels. New Git would
> > correctly use the offsets to create corrected commit dates.
> 
> This also means that we need to use backward-compatible generation
> number v2, that is corrected commit date with strictly monotonic
> offsets.  Which may lead to more cases where 30 bits for label is not
> enough, and thus worse performance (no detailed reachability
> information for newest commits).
> 

Yes, that's definitely possible. Dr. Stolee raised the same point too,
and I am working on using trace2 API to find the largest offset and the
number of commits for the tests.

> > 
> > It works just as well as generation number v1 in parsing and writing
> > commit-graph files.
> > 
> > However, the generation numbers are still restricted to 30 bits in CDAT
> > chunk and it does not work well with commit-graph chains with a mix of
> > v1 and v2 generation numbers.
> 
> 
> CDAT chunk replaced with another chunk
> ======================================
> 
> In this approach the "CDAT" chunk is missing from the commit-graph file.
> We can craft the replacement ("CDA2") however we like, but it can also
> look like the "CDAT" chunk, only with the offsets for corrected commit
> date rather than topological level for generation number part (30 bits).
> 
> If we choose to follow the "CDAT" format (modified), then the file
> size would not change, and neither would change the amount of I/O
> needed -- there would be the same access structure as in current
> version.
> 
> There should be no confusion with a mix of v1 and v2 generation numbers.
> 
> The disadvantage is of course that older version of Git would no longer
> be able to make use of serialized commit-graph if the file was written
> by newer version of Git.
> 

Another disadvantage is that the CDA2 chunk yet again limits the size of
generation number. Future generation numbers will be restricted to 64
bits by the design of CDA2.

> > 
> > Performance
> > ===========
> 
> What is the repository where those benchmarks took place?

It's based on the linux repository.

> 
> > | Command                        | Master | Metadata | Generation Data |
> > |--------------------------------|--------|----------|-----------------|
> > | git commit-graph write         | 14.45s | 14.28s   | 14.63s          |
> > | git log --topo-order -10000    | 0.211s | 0.206s   | 0.208s          |
> > | git log --topo-order -100 A..B | 0.019s | 0.015s   | 0.015s          |
> > | git merge-base A..B            | 0.137s | 0.137s   | 0.137s          |
> 
> Nice.
> 
> How those two (or three) approaches work on gen-test [3] test cases,
> both in terms of commits walked (extracted via trace2 mechanism) and
> actual wall-time clock, like in the result above?

Sure, will do.

> 
> [3]: https://github.com/derrickstolee/gen-test
> 
> > - Metadata and generation data chunks perform better than master on
> >    using commit-graph files since they use corrected commit dates.
> > 
> > - The increased I/O time for parsing GDAT does not affect performance as
> >    much as expected.
> > 
> > - Generation data commit-graph takes longer to write since more
> >    information is written into the file.
> > 
> > As using the commit-graph is much more frequent than writing, we can
> > consider both approaches to perform equally well.
> > 
> > I prefer generation data chunk approach as it also removes 30-bit length
> > restriction on generation numbers.
> 
> Thank you for your work.
> 
> Best,
> 
> P.S. I hope I haven't sent it twice...
> -- 
> Jakub Narębski

Thanks
- Abhishek

----------

Mutt has been acting weirdly for replies sent using "mail" option. This
mail is in reply to the following post:

https://lore.kernel.org/git/10d99e37-8870-6401-d9aa-21a359b30835@gmail.com/
