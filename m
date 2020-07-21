Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC56C433E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3737E206E9
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 13:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeaE/8TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGUN3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGUN3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 09:29:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177EC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 06:29:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u5so10732706pfn.7
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XoZVrHah5+cu78lhav5mJWeBaMOSxAu9KSpkvVT0LFg=;
        b=OeaE/8TJ6rMkxQJn2q9xw6r4B6y89Lyh+aXDatWV2N7e7EwyDqhsZJx4ITKdeTyfQj
         LsFEqhdiEbaNUjhpNxecYLabJsrqTf7sd000UHnm89Vk9GUXxmxr+6ovwChdZkPST1Ai
         KUnBux/9SDz5a198cbSS5hhXs/cc/wb4WJY6nxygY5hDZge35zF01mG/K0wChrGFyIj3
         nzyFT7rmtQuRm0z35ue3utDfP9Ft552ozSFv+NeIZHVpDmy+y2uVIvyi0OhN3QtxP2Cd
         24Afk0eernI/559RBbLq+HJ3jHrGmAkXYVU0ula3U+uTdOIIVMheVi6Qj54aFsdPoJnb
         prHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XoZVrHah5+cu78lhav5mJWeBaMOSxAu9KSpkvVT0LFg=;
        b=B9yypzPYpXuJ9y4FF74hLMioaV0tL+2w09lEn38lv1O2WQdKnqv9UNwNSuJcCpw8TO
         sWsaXV4qFQY95KA54wziUvNlgJ6qfndqM4SJL5MvVGSKIgNYPSi/KwNBewEEMz8i1Wlr
         WeM/tvIPUhWpZljqx/5IOx8NASnyE/BY9YjfxD7Y5jZvdCVJvSwEhSPjowpcmam2HB/H
         1rrKv57+NwaQjrjlWR31KD8a+mOAk9lx9JMhXKPjAErtE8eGD1RX6aAd+XFdMe7Qywy3
         VifBZYuRndWdyppvGJcSSpuDukLuIZYyT0bUf8jsePYzlxBj2yNsrEdSeNtbC+fQ3dFC
         zvhg==
X-Gm-Message-State: AOAM530antgoaodXGfeY8RxX1L24rALKn+Ief05Jv2+0kuzByfbMI5PK
        Nwwwc6UknHIFbUQkpUwcr1CdCw2AK4E=
X-Google-Smtp-Source: ABdhPJz2u5kp9s2HqF3bSSgv62i1XHpvVgbJHfMa3Mh4NAYUOpUp7DnKbbf9MSgRHjbDh4WLmaHVGA==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr22080894pgn.127.1595338145116;
        Tue, 21 Jul 2020 06:29:05 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:4e15:5d57:88bc:ced0:b9c5:4254])
        by smtp.gmail.com with ESMTPSA id d14sm3439280pjc.20.2020.07.21.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:29:04 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:57:04 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [GSOC] Blog about week 6
Message-ID: <20200721132704.GA29663@Abhishek-Arch>
Reply-To: 85k0z1pxjs.fsf@gmail.com
References: <20200714063236.GB10242@Abhishek-Arch>
 <85k0z1pxjs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85k0z1pxjs.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 12:49:11AM +0200, Jakub Narębski wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> > Hello everyone!
> >
> > Over the last week, I started implementing generation number v2. Based
> > on the performance numbers and subsequent discussion, we have decided to
> > use generation data chunk approach, storing topological levels into CDAT
> > and corrected commit date offsets into GDAT chunk. Do note that we are
> > maintaining backward compatibility using topological level, not with
> > monotonic offsets.
> >
> > I also found a performance regression with `commit-graph write
> > --reachable --changed_path` that sneaked in along with the patch on
> > moving generation and graph positions into commit-slab.
> >
> > https://github.com/gitgitgadget/git/pull/676
> >
> > Yes, I pushed without signing off or a cover letter. It's still a work
> > in progress.
> 
> All right.  Did you send this series of patches to git mailing list for
> a review already, or is it only a working version?
> 

It's a working version so far.

> >
> > https://abhishekkumar2718.github.io/gsoc/2020/07/12/gsoc-week-6.html
> 
> Reply to the blog contents follows:
> 
> ----------------------------------------------------------------------
> 
> > GSoC - Weeks 6
> > ==============
> 
> Very minor nitpick / correction - I think you meant "Week" not "Weeks"
> here in the title of this blog.
> 

Thanks! Will fix it.

> > Over the last week, I worked on implementing corrected commit date
> > with generation data chunk and boy, was it painful!
> >
> > While working on the prototype, I used the space allocated for graph
> > position to store topological level before writing it into CDAT chunk.
> 
> First, I assume that if we choose to not compute topological levels and
> simply store GENERATION_NUMBER_MAX in the 30-bits in CDAT set for
> generation number v1 we would not have this problem, isn't it?
> 
> Second, isn't `graph_pos` nowadays on the commit slab? Why reuse it,
> which can lead to problems if other parts of code assume things about
> its syntax, rather than making use of _new_ uint32_t `topo_level` commit
> slab?  We have many different ad-hoc entries stored on the slab, what's
> one more...
> 
> > However, while computing bloom filters, we call `get_bloom_filter()`.
> 
> Ah, I guess this happens when `git commit-graph write` is called with
> the `--changed-paths` option, so we compute both generation numbers v1
> and v2, and Bloom filters for changed paths.
> 
> > This function checks if the commit belongs to the commit-graph. If it
> > does, load the bloom filters (avoiding a lot of computation).
> > Otherwise, compute the filters and return it. Since I am storing
> > topological levels in graph position, Git mistakenly thinks that we
> > are reading a graph and tries to load bloom filter, segfaulting right
> > away.
> 
> So don't do that; don't store topological level in graph position.
> 
> > Faced with the problem, I could think of three ideas:
> >
> 
> > 1. Extend generation to be 64-bits (which we were planning on anyway)
> >    and store topological levels within higher 32 bits and corrected date
> >    offsets within lower 32 bits. Code for calculating corrected date
> >    offsets, topological levels would be littered with bit shifts and
> >    ANDs, but code for parsing and using generation numbers would be
> >    clean.
> 
> If I remember it correctly, extending `generation` to 64-bits in
> `struct commit_graph_data` (stored on slab) is there to store and
> operate on the corrected commit(ter) date, instead of storing and
> fiddling with offsets?
> 

Well, yes. We could ask for a new slab for topo_levels while writing the
graph. But since we are writing offsets (to minimize space used by the
graph), I store offsets through out `compute_generation_number`. Since
the offsets fit into 32-bits, I thought of reusing the higher 32-bits to
store topological levels.

> >
> > 2. Use two 32-bits variables, level and odate, and use the contiguous
> >    64 bits to store generation (while reading commit-graph): Code for
> >    writing commit-graph is clean, but reading generation is much trickier
> >    as we try to coerce value stored in (graph_data + 4) into a timestamp.
> 
> I don't quite get this idea.  For backward compatibility we have to
> store topological levels in appropriate 30-bit wide field in CDAT chunk.
> Storing topological levels in higher 32-bits of 64-bit GDAT chunk would
> not provide it.

Here, I am talking not about the how data is stored on chunks but rather
how it's stored in the commit-slab while writing commit-graph.

> 
> > 3. Split get_bloom_filters() into two functions - First checks if the
> >    commit is from the graph and tries to load whereas the other computes
> >    bloom filter. Then we could directly call the second function when
> >    writing a commit-graph. I was not sure if this would have worked, but
> >    I wanted not to change things unless required.
> 
> 4. Store topological level data in a separate commit slab entry.
>    This way any code that examines `commit_graph_data.position`,
>    like `get_bloom_filter()`, wouldn't be mislead.
> 
> About the 4th possibility: does Git use both graph position and
> generation number in the same process?  Because if it is not, then
> perhaps putting graph_position and graph_generation_number in a
> composite type `struct commit_graph_data` on slab might have been a
> mistake.  Due to how modern CPUs work (with data prefetching and
> pipelining) it might be more advantageous wrt performance to have
> subsequent data for graph position or for generation number to be packed
> and not strides, as it is now -- at least when accessing commits in the
> commit.index order.
>

I suppose so. Graph positions would be used to efficiently look up
generation number in the commit-graph, so Git uses both graph position
and generation number in the same process.

Although, since we store generation number in the anyway, we have no
further use for the graph position.

But I think Dr. Stolee would be the right person to answer this.

> > I felt the first two approaches were too unreadable.
> >
> 
> I think the 3rd approach is worth doing on its own, as it makes the code
> bit clearer... but I have not actually examined the commits in the pull
> request.
> 

Alright, will add this as well.

> > In the end, I compromised by using a 64-bit generation and a 32-bit
> > level in the initial commit and will restrict the ugly conversion to
> > reuse 64-bits in a focused patch later in the series.
> 
> I would have to examine the patch in question in more detail, but I am
> waiting for the series to be posted to Git mailing list (though I can be
> persuaded to do pre-review on GitHub pull request, as pre-release step).
> 
> > Regression when computing bloom filters
> > =======================================
> >
> > While wrestling with the problem above, I noticed that
> > `commit_gen_cmp()` lies in “commit-graph write” path but uses the
> > helpers. But the helper would always return `GENERATION_NUMBER_MAX`
> > as we found while moving generation number into a slab.
> >
> > Digging through git logs, I found [the patch][1], which introduced
> > `commit_gen_cmp()`. Sorting commits make the computing bloom filters
> > much, much faster. The helper returns the same value every time, which
> > makes sorting pointless and nullifies the performance boost. Fixing
> > this was easy, bypass the helper and access generation number.
> >
> > [1]: https://github.com/git/git/commit/3d11275505694ce4e5256516de1c5dd90e749303
> 
> Good catch!
> 
> Best,
> --
> Jakub Narębski
