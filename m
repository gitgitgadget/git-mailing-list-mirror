Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE0C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 05:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF3A2227F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 05:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8ytKLWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCFjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 00:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCFjU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 00:39:20 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB67C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 21:39:20 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id a200so13199880pfa.10
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xr05zqgYs4Ju2D/IGy3NYoRBjVBSPVmWcGExEOYGZDM=;
        b=m8ytKLWcYW6nxV2l6VN6xInanirj5kNutR58EyOvln+bG4Yja2bsBoMJLpq49MWitn
         ISr8vX3Zz+IQIjBns9YgLg6HpWyOqerC5vitK3dxknXeXPFBROB7u4sEcqHa32hI3Beb
         j+CGhhVVaV4umOviFVb4mLGgJSdEhjbDJ+Zd6+yi231VJqwdHas7bsU5rAUknYUvYP7J
         5oAefJ38h9vigPsJol8qUxONWUY4GTl7Kzbx3u0ssPbrl4xTjQJp6Na0XcYql9s6aRFn
         GrZsICHqYAQKpQTU8IByrUs3iLvjWpoZ7LoF3BEKcVaV+pRL4iOJVHugWPl6MYEoAp1e
         cJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Xr05zqgYs4Ju2D/IGy3NYoRBjVBSPVmWcGExEOYGZDM=;
        b=KBkti+qvEssFU/nMsdZUpoagvZoaBLVphC8GI0pMlYdhG30ULMC0r/bmXHavL19YRW
         m92VOJUVpe0lcEfOQ3PPH3t4Uxon3pdjos0V716/76IN8X7n0sf7tvYW591MdrCCVOcq
         585rpeq1jq38AGrGXjvKMGtpQ5a594uQOwLdzbZzzfi3WpKtzxjXG9zhTQ/OyM92cU+i
         4+ZXVvwe/nPHYw5rV6EMIDHCN26Sey97Lr7qt6NPTV2wSygFe/R7G3n62v8XVc6r8kWd
         eXKApi9i7SIVbtRCO7OyGAILV0sq+FB8tAVIjXd4Me+oldXcbrt32+1JNwUre+nw6lxI
         ZNtw==
X-Gm-Message-State: AOAM533zEyuHvvO/Oz44OMyv1jj0H7KTcdmhf5ORA8syeYtTfJZbH+4E
        ml3+rCv4SBJifzsh9mfQDHw=
X-Google-Smtp-Source: ABdhPJxspe4UvbR/Jm2INzuksTMBk+cChRIE52/aoPBhC9sjElTLpA4GTizClwQ5AkztVhDQ0EG6jA==
X-Received: by 2002:a65:6856:: with SMTP id q22mr15688661pgt.408.1604381960144;
        Mon, 02 Nov 2020 21:39:20 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:883:e6fa:e766:1820:6007:cfb3])
        by smtp.gmail.com with ESMTPSA id m12sm13083075pgl.90.2020.11.02.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 21:39:19 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:06:29 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, jnareb@gmail.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH v4 01/10] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <20201103053629.GA13228@Abhishek-Arch>
Reply-To: X5Xm5nlFK39o0rkJ@nand.local
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <fae81b534b14c8227454ff94e385fb16faee0e99.1602079785.git.gitgitgadget@gmail.com>
 <85wnzf43kv.fsf@gmail.com>
 <X5Xm5nlFK39o0rkJ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X5Xm5nlFK39o0rkJ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 04:58:14PM -0400, Taylor Blau wrote:
> On Sun, Oct 25, 2020 at 01:16:48AM +0200, Jakub Narębski wrote:
> > "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > While measuring performance with `git commit-graph write --reachable
> > > --changed-paths` on the linux repository led to around 1m40s for both
> > > HEAD and master (and could be due to fault in my measurements), it is
> > > still the "right" thing to do.
> >
> > I had to read the above paragraph several times to understand it,
> > possibly because I have expected here to be a fix for a performance
> > regression.  The commit message for 3d112755 (commit-graph: examine
> > commits by generation number) describes reduction of computation time
> > from 3m00s to 1m37s.  So I would expect performance with HEAD (i.e.
> > before those changes) to be around 3m, not the same before and after
> > changes being around 1m40s.
> >
> > Can anyone recheck this before-and-after benchmark, please?
> 
> My hunch is that our heuristic to fall back to the commits 'date'
> value is saving us here. commit_gen_cmp() first compares the generation
> numbers, breaking ties by 'date' as a heuristic. But since all
> generation number queries return GENERATION_NUMBER_INFINITY during
> writing, we're relying on our heuristic entirely.
> 
> I haven't looked much further than that, other than to see that I could
> get about a ~4sec speed-up with this patch as compared to v2.29.1 in the
> computing Bloom filters region on the kernel.
> 

Thanks for benchmarking it. I wasn't sure if I am testing it correctly
or the patch made no difference.

> > Anyway, it might be more clear to write it as the following:
> >
> >   On the Linux kernel repository, this patch didn't reduce the
> >   computation time for 'git commit-graph write --reachable
> >   --changed-paths', which is around 1m40s both before and after this
> >   change.  This could be a fault in my measurements; it is still the
> >   "right" thing to do.
> >
> > Or something like that.
> 
> Assuming that we are in fact being saved by the "date" heuristic, I'd
> probably write the following commit message instead:
> 
>   Before computing Bloom filters, the commit-graph machinery uses
>   commit_gen_cmp to sort commits by generation order for improved diff
>   performance. 3d11275505 (commit-graph: examine commits by generation
>   number, 2020-03-30) claims that this sort can reduce the time spent to
>   compute Bloom filters by nearly half.
> 
>   But since c49c82aa4c (commit: move members graph_pos, generation to a
>   slab, 2020-06-17), this optimization is broken, since asking for
>   'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
>   while writing.
> 
>   Not all hope is lost, though: 'commit_graph_generation()' falls
>   back to comparing commits by their date when they have equal generation
>   number, and so since c49c82aa4c is purely a date comparison function.
>   This heuristic is good enough that we don't seem to loose appreciable
>   performance while computing Bloom filters. [Benchmark that we loose
>   about ~4sec before/after c49c82aa4c9...]
> 
>   So, avoid the uesless 'commit_graph_generation()' while writing by
>   instead accessing the slab directly. This returns the newly-computed
>   generation numbers, and allows us to avoid the heuristic by directly
>   comparing generation numbers.
> 

That's a lot better, will change.

> Thanks,
> Taylor
