Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3476C5517A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9028C222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 21:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MooYAzno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418771AbgJYU6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418768AbgJYU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 16:58:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA01C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 13:58:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h12so295251qtc.9
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jEPM7hN9KBVrLp0CJal/v3IZF2iM/zRJcg11v7dUrKo=;
        b=MooYAznoAU0W5xkeZzIqb2HOoHgGZhzrLAQFOR+9mHs3z+RihijGsAUwqLe531Zs9j
         Wrz+oxcuNpiexEB3oGTEng1oD/1iEPHOERCrnMyAbY/uDq9j4dv2n0iTnGm64xRpG0EO
         6CrI64MaxBtSVNzGpl3dZkNy5SNc0Se6tN3MmOTt2fp2vwbTy49N4nOVNri9kJl8Oug6
         2ROR9EMxSlrb/h6xCiYf3t3FXmxvMX7Q/ZfhCilh4gSdWSIfifoSdecMrsc2UVG1uBu6
         Ixj2C1n+3MSas6F9Ta3GSfBY8rxx/WanrL9LGoLE2E7w/UUx884jZui6ZWbXiMPhP7S3
         +pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jEPM7hN9KBVrLp0CJal/v3IZF2iM/zRJcg11v7dUrKo=;
        b=SxlntUuo2H/4XRTEM+6XPhVuAztOfKobaLuWYT46EDajoSeoyxAG3886BgL0Gui2cJ
         vx9OyMPCPsMEHpZdNjW5WYTFK2ZhtVwzMWou3duSH3Mk+98METgl4+uKlDDh5uVibQXu
         ZBydaeeNi7kradXe1nVXGnKyqsNzrNEVONDtfON7oGaZf0FCeCo1HocnI1kqEhukYZXb
         qoG14UwtUu/5aN68Bt853VG5sctNFKZtgKX9N+BT1Ox1NqOUXyif4NIUIwgzmzpdUEcO
         SvSh0y5Moa+TndAVm3eANPFjSRdEv+tGJOZQjd39Rk6Yb1q1FFcvwuQHCQp4Uy779PXe
         kroQ==
X-Gm-Message-State: AOAM533Sn6hVfTMW9EFGbPY8z94Odwr5oNMDLcA4mw4t8hV5YhGMy7lS
        Vv363RmifToTEvDjXrwtpaRCmg==
X-Google-Smtp-Source: ABdhPJwGCS5DQierLCadTlyxDzRx3baeoiZI46RAwNWpEpd1rvlWIn6i1cJzF8jr+yarcOfocFwM+Q==
X-Received: by 2002:ac8:4246:: with SMTP id r6mr13956537qtm.129.1603659497011;
        Sun, 25 Oct 2020 13:58:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:ddfd:5961:bab:6894])
        by smtp.gmail.com with ESMTPSA id l125sm5413983qke.23.2020.10.25.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 13:58:16 -0700 (PDT)
Date:   Sun, 25 Oct 2020 16:58:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 01/10] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <X5Xm5nlFK39o0rkJ@nand.local>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <fae81b534b14c8227454ff94e385fb16faee0e99.1602079785.git.gitgitgadget@gmail.com>
 <85wnzf43kv.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85wnzf43kv.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 01:16:48AM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > While measuring performance with `git commit-graph write --reachable
> > --changed-paths` on the linux repository led to around 1m40s for both
> > HEAD and master (and could be due to fault in my measurements), it is
> > still the "right" thing to do.
>
> I had to read the above paragraph several times to understand it,
> possibly because I have expected here to be a fix for a performance
> regression.  The commit message for 3d112755 (commit-graph: examine
> commits by generation number) describes reduction of computation time
> from 3m00s to 1m37s.  So I would expect performance with HEAD (i.e.
> before those changes) to be around 3m, not the same before and after
> changes being around 1m40s.
>
> Can anyone recheck this before-and-after benchmark, please?

My hunch is that our heuristic to fall back to the commits 'date'
value is saving us here. commit_gen_cmp() first compares the generation
numbers, breaking ties by 'date' as a heuristic. But since all
generation number queries return GENERATION_NUMBER_INFINITY during
writing, we're relying on our heuristic entirely.

I haven't looked much further than that, other than to see that I could
get about a ~4sec speed-up with this patch as compared to v2.29.1 in the
computing Bloom filters region on the kernel.

> Anyway, it might be more clear to write it as the following:
>
>   On the Linux kernel repository, this patch didn't reduce the
>   computation time for 'git commit-graph write --reachable
>   --changed-paths', which is around 1m40s both before and after this
>   change.  This could be a fault in my measurements; it is still the
>   "right" thing to do.
>
> Or something like that.

Assuming that we are in fact being saved by the "date" heuristic, I'd
probably write the following commit message instead:

  Before computing Bloom filters, the commit-graph machinery uses
  commit_gen_cmp to sort commits by generation order for improved diff
  performance. 3d11275505 (commit-graph: examine commits by generation
  number, 2020-03-30) claims that this sort can reduce the time spent to
  compute Bloom filters by nearly half.

  But since c49c82aa4c (commit: move members graph_pos, generation to a
  slab, 2020-06-17), this optimization is broken, since asking for
  'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
  while writing.

  Not all hope is lost, though: 'commit_graph_generation()' falls
  back to comparing commits by their date when they have equal generation
  number, and so since c49c82aa4c is purely a date comparison function.
  This heuristic is good enough that we don't seem to loose appreciable
  performance while computing Bloom filters. [Benchmark that we loose
  about ~4sec before/after c49c82aa4c9...]

  So, avoid the uesless 'commit_graph_generation()' while writing by
  instead accessing the slab directly. This returns the newly-computed
  generation numbers, and allows us to avoid the heuristic by directly
  comparing generation numbers.

Thanks,
Taylor
