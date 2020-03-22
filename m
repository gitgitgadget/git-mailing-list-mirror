Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B934C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ECC20719
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bdfxFnOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVQpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:45:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36410 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 12:45:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so4910875pjb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRVQrouiE1XNGKp5zdWoH3u2AXuYihlSvuEWdH4Gn9g=;
        b=bdfxFnOVA8V5Gv3loIUAnPk2I6Vwfs4Vx1a4NtbO8TZAm76rrXiVr68/vPy9IkqqzM
         sVK1frnsaPGZXC8ae7PLtRmOeoXHjopPe6jG/paBJVfHZfBRQu/PcrYrOfmkjUuoT4OX
         owzKmN5xwN8C93f6KcjlQgkNdC5RAG7HsSatA0pAB+Sx+SeDEsGPcNh3goO96ypF9FQF
         nSahmYRVYOrn4LtP8radGqaloPJxpmLpuqZADVs7tiPV0MyUvW0y7SY25zwksnwnhEQf
         avPWR85Wl4jCX1eiWhejkDQQOhPXXj1JJGX7h+YcqaJzDaD70MMphBD7IpKhodg7oZae
         JBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRVQrouiE1XNGKp5zdWoH3u2AXuYihlSvuEWdH4Gn9g=;
        b=OwRPm41y3vNng7VY5ak07oNMOJoc+Wg4ZkMtQcfGdIYvXFrb262MWJs5hgoqZ936Vg
         Z9nQL7PEbflEH2CGj23m0zKWKIJSK36TqY8ZMpmxlmvNW7BWQmEnWkZY0NYa7s07VC0a
         20vOXJsJJ8yrnD38ubkCIuWSTO/fL6zpRPwFl5Lm9tccos8OiuCtykov6f+eW2v3xZaa
         Gx5Cly1palrArMtRb7n+Akd7K2s35sIi9ARPRdbUSSKrDyrqgmtgKXHQqbtkhkA7ZDAE
         3XNLepr4yveSpikt/Dvig8OaptFI3QOtXDp/Vc0gVaKdWf9bOPvSaQrBF3uOHoT5s3wY
         6Yrw==
X-Gm-Message-State: ANhLgQ1fdgxThV9udD8km3E87rdQYx9vpbLawNFDfdD8IlTXw/jelEgJ
        cbDAZvluqL/FMgLQZ4iC+brGzw==
X-Google-Smtp-Source: ADFU+vvvkfzdnZ9JH7roBBavUobCltjQvSpnnmV5TSsIcq3nARuZ4fm2Ruuk9/VvLK/25MXtHMqHKg==
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr21190466pjo.108.1584895534025;
        Sun, 22 Mar 2020 09:45:34 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b16sm3216365pfb.71.2020.03.22.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:45:33 -0700 (PDT)
Date:   Sun, 22 Mar 2020 10:45:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322164531.GA55067@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322053635.GA578498@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 01:36:35AM -0400, Jeff King wrote:
> On Sat, Mar 21, 2020 at 11:27:16AM -0600, Taylor Blau wrote:
>
> > > I'm not sure how to do that, though. Saying "--input=none" still puts
> > > all of those existing graphed objects into the list of oids to include.
> > > I think you'd need a case where you were legitimately only adding a few
> > > commits, but the merge rules say we need to create one big commit-graph
> > > file.
> >
> > You have to be careful, since we're taking the reachability closure over
> > any commits that you do give. So, one thing you could do to ensure that
> > you have an actually small graph is to take something from the output of
> > 'git rev-list --max-parents=0 HEAD'.
>
> I don't think you need to be that careful, though. In split-mode,
> close_reachable() will stop traversing when it finds a graphed commit.
> That's why using the tip of HEAD in my previous example worked.
>
> > To try and reproduce your results, I used '1da177e4c3', which is the
> > kernel's first commit in Git. If my interpretation of your setup is
> > faithful, it goes something like:
> >
> >   $ graphdir=.git/objects/info/commit-graphs
> >   $ git rev-parse 1da177e4c3 |
> >     git commit-graph write --split=no-merge --stdin-commits
> >   $ cp -r "$graphdir{,.bak}"
> >
> >   $ best-of-five -p "rm -rf $graphdir && cp -r $graphdir{.bak,}" \
> >     'git commit-graph write --split=merge-all'
>
> My case is the opposite, isn't it? Here it looks like you've made a very
> _tiny_ commit-graph file (with one commit), and then you're going to end
> up adding in all of the new objects. I don't think it would be improved
> much by this patch (which makes me very confused by the numbers you got
> below).
>
> I also don't think it's that interesting a real-world case.
>
> The more interesting one is where you do already have a big
> commit-graph, and want to add just a bit more to it. In the real world,
> that might look something like this:
>
>   # create a fake server repo
>   git clone --bare . dst.git
>
>   # imagine the server already has everything in a graph file
>   git -C dst.git commit-graph write --split=no-merge --reachable
>
>   # and now do a small push
>   git commit --allow-empty -m foo
>   git push dst.git
>
>   # the server might do an incremental immediately to cover the new
>   # objects; here we'll use --stdin-commits with the new data, but a
>   # real server might feed the new packfile. We'd probably just use
>   # regular --split here in practice, but let's imagine that we're
>   # starting to have a lot of graph files, and that triggers a desire to
>   # merge. We'll force that state with --split=merge-all.
>   git rev-list HEAD^..HEAD |
>   git -C dst.git commit-graph write --split=merge-all --stdin-commits
>
> Without your patch, that takes ~11s for me. With it, it takes ~2s.
>
> Another equally interesting case is if the per-push generation _doesn't_
> merge anything, and just creates a new, tiny graph file. And then later
> we want to do a real maintenance, merging them all done. I think that
> would be something like:
>
>   git -C dst.git commit-graph write --input=none --split=merge-all
>
> But that _isn't_ improved by your patch. For the simple reason that all
> of the commits will already have been parsed. The "--input=none" option
> isn't "no input"; it's actually "take all existing graphed objects as
> input" (i.e., it implies --append). So each of those objects will
> already have been examined in an earlier stage.
>
> > Where the last step is taking all commits listed in any pack, which is
> > cheap to iterate.
>
> I'm not sure it's all that cheap. It has to find the type of every
> object in every pack. And finding types involves walking delta chains.
> That's something like 7s on my machine for linux.git (compared to the 2s
> in which I can just merge down the existing graph files).
>
> > In the above setup, I get something like:
> >
> >   git version 2.26.0.rc2.221.ge327a58236
> >   Attempt 1: 16.933
> >   Attempt 2: 18.101
> >   Attempt 3: 17.603
> >   Attempt 4: 20.404
> >   Attempt 5: 18.871
> >
> >   real	0m16.933s
> >   user	0m16.440s
> >   sys	0m0.472s
> >
> > versus:
> >
> >   git version 2.26.0.rc2.222.g295e7905ee
> >   Attempt 1: 5.34
> >   Attempt 2: 4.623
> >   Attempt 3: 5.263
> >   Attempt 4: 5.268
> >   Attempt 5: 5.606
> >
> >   real	0m4.623s
> >   user	0m4.428s
> >   sys	0m0.176s
> >
> > which is a best-case savings of ~72.7%, and a savings of ~71.5%. That
> > seems much better.
>
> I'm still puzzled by this. In the setup you showed, hardly anything is
> graphed. But the change is only in the graph-merge code.

I agree with your reasoning. I tried to recreate these timings this
morning, and was unable to do so. Here's my setup (where 'git' is built
on the tip of 'next'):

  $ graphdir=".git/objects/info/commit-graphs"
  $ pack="pack-b10a98360eacb1f5a5ff67cb8d8113d8b3d0b39f.idx"
  $ rm -rf "$graphdir"
  $ git rev-list --max-parents=0 HEAD | tail -1 |
    git commit-graph write --input=stdin-commits --split=no-merge
  $ cp -r "$graphdir" "$graphdir.bak"

  $ git version
  git version 2.26.0.rc2.221.ge327a58236

  # repeat the below twice to ensure a warm cache
  $ rm -rf "$graphdir" && cp -r "$graphdir.bak" "$graphdir" &&
    echo "$pack" |
    sudo perf record -F 997 ~ttaylorr/bin/git commit-graph write \
      --split=merge-all --input=stdin-packs
  $ mv perf.data{,.base}

  $ git version
  git version 2.26.0.rc2.222.g1931b73955

  # do the above again, and mv perf.data{,.patch}

  $ sudo perf diff perf.data.base perf.data.patch
  # Event 'cpu-clock'
  #
  # Baseline    Delta  Shared Object       Symbol
  # ........  .......  ..................  ..........................................
  #
      18.42%   +0.34%  libc-2.24.so        [.] __memcmp_sse4_1
      15.50%   -0.45%  libz.so.1.2.8       [.] 0x00000000000083c9
       8.42%   -0.01%  libz.so.1.2.8       [.] inflate
       6.33%   +0.30%  libc-2.24.so        [.] __memmove_avx_unaligned_erms
       4.67%   -0.36%  git                 [.] lookup_object
       3.62%   -0.28%  git                 [.] unpack_object_header_buffer
       2.64%   +0.20%  git                 [.] commit_to_sha1
       2.41%   -0.03%  git                 [.] get_delta_base
       2.05%   -0.17%  git                 [.] sha1_compression_states
       2.00%   +0.06%  git                 [.] use_pack
       1.66%   +0.14%  git                 [.] nth_packed_object_offset
       1.63%   +0.11%  git                 [.] write_graph_chunk_extra_edges
       1.44%   +0.21%  libz.so.1.2.8       [.] adler32
       1.42%   -0.03%  git                 [.] sort_revindex
       1.42%   -0.06%  git                 [.] parse_commit_date
       1.41%   -0.15%  git                 [.] oidhash
       1.37%   +0.07%  git                 [.] commit_list_count
       1.11%   -0.02%  git                 [.] in_window
       1.08%   -0.05%  git                 [.] packed_to_object_type
       0.90%   -0.18%  git                 [.] ubc_check
       0.82%   -0.23%  git                 [.] hex2chr
       0.75%   -0.02%  git                 [.] hashcmp
       0.71%   +0.17%  libc-2.24.so        [.] msort_with_tmp.part.0
       0.70%   +0.25%  git                 [.] sha1_pos
       0.70%   +0.12%  git                 [.] repo_parse_commit_internal
       0.66%   -0.06%  git                 [.] bsearch_hash
       0.65%   -0.11%  git                 [.] compute_generation_numbers
       0.64%   +0.03%  git                 [.] unpack_object_header
       0.60%   -0.06%  git                 [.] find_entry_ptr
       0.59%   +0.09%  libc-2.24.so        [.] _int_malloc
       0.55%   -0.01%  git                 [.] hexval
       0.51%   +0.07%  git                 [.] entry_equals
       0.44%   +0.12%  git                 [.] get_sha1_hex
       0.41%   -0.13%  git                 [.] packed_object_info

...and many other functions that have a delta that can be attributed to
noise, all comfortably less than 1%.

So, I'm not sure what was going on with my original measurements, other
than that I took them around midnight, so the chance for error was
probably high. I'll go with your measurements, since they are both
closer to what we'd see in the real world, and actually representative
of the change here.

I'll wait for some of the discussion in the sub-thread about
'OBJECT_INFO_SKIP_FETCH' to settle, and then send v2 in the next couple
of days or so.

> -Peff

Thanks,
Taylor
