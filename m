Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45AC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A2C60FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhH3VQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhH3VQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:16:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED15C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:15:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z4so24320667wrr.6
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rji5lEShrzsOOMeBq2TLKgTVmvszofUAtr4u48KHYhA=;
        b=N0kBYWRcmNrT6n3VmmG2aH5NvEDHmcy7dWvrBoUXzsD2uDSMT2Kqhfty5xtxG2lMfO
         Gmvf7GO/z3w0sQmZXKoEOozjDTkNzFpboyQGsjKSIa/1M8hsiqFZ4uft9VD+kUzJRf7z
         icgCGFJ5LGfxAEbsMieCEo+fuKLJs5GLyUqyimHz4COf0jigDaRJM37x1hhXGma5Gami
         aoQJ1xXr1Owm/OVgYpchL9sHYG2JW68ynOb1xG1SRLJ/FTdmUA7irMD1RR1t5tGBZwhD
         sOaVUMAFtKxwUAKXZzN08XmECnE5n2rZ/r3SM5I1v0pimyRd/6Qk2Tj5OmJ6fNQrKKwX
         qWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rji5lEShrzsOOMeBq2TLKgTVmvszofUAtr4u48KHYhA=;
        b=CCjT+r58mrv7KTyC5Mjih5xULKQlEjgZgV93aP9tZRayhhiSt85MDDsgL7rii7IlM+
         390gOevTR08TdYf9bCexc/7s0InOfVcKFtWb/EuGpInKp9+ZPK2F47ktyWg9hqI9GMhm
         DBuQcgTfeW1kC8EZSvpnm3AOvbtpW4R57NzCRm/FAENK+rS66d7HQOAPb+awMdMIS5LD
         IZB7Gitl5JfloNBok3rQENpe/z4L+EI3qoLvdras8gBJJQrVHVYekApwzKlGEHKLY8rh
         DGdHmQ5P3wD4Brt8OCQy9VbjvhC1plyLwPmqNFJv6Z2gc1ekEaL1vyhURYSk0Gu9v2M9
         +CUw==
X-Gm-Message-State: AOAM532VvdrOTSRuWiDLbc8tutvxTUpFMKCE3GA5jueoQDC3TQOmb9Ex
        FBKnqzImvhP8ZgGot2ESa7BHpSbj/Fg=
X-Google-Smtp-Source: ABdhPJxRoKu5FO1b+BRWjVV3II0P8EVIbrHFP7VWhgteY4rdpHuHml4YQHbEVtMqs5dDRJd+xHCRmg==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr27824747wrw.366.1630358130558;
        Mon, 30 Aug 2021 14:15:30 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id n4sm19506118wro.81.2021.08.30.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:15:30 -0700 (PDT)
Date:   Mon, 30 Aug 2021 23:15:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/7] progress: catch nested/overlapping progresses with
 GIT_TEST_CHECK_PROGRESS
Message-ID: <20210830211528.GK23408@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-3-szeder.dev@gmail.com>
 <YNIJB8uYp7gzLC6v@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNIJB8uYp7gzLC6v@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 12:00:07PM -0400, Taylor Blau wrote:
> On Sun, Jun 20, 2021 at 10:02:58PM +0200, SZEDER Gábor wrote:
> > Note that this will trigger even in cases where the output is not
> > visibly wrong, e.g. consider this simplified sequence of calls:
> >
> >   progress1 = start_delayed_progress();
> >   progress2 = start_delayed_progress();
> >   for (i = 0; ...)
> >       display_progress(progress2, i + 1);
> >   stop_progres(&progress2);
> >   for (j = 0; ...)
> >       display_progress(progress1, j + 1);
> >   stop_progres(&progress1);
> 
> s/stop_progres/&s, but no big deal. Everything else here looks good.

Well, at least I was consistent :)

> > diff --git a/progress.c b/progress.c
> > index 255995406f..549e8d1fe7 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -48,6 +48,8 @@ struct progress {
> >  static volatile sig_atomic_t progress_update;
> >
> >  static int test_check_progress;
> > +/* Used to catch nested/overlapping progresses with GIT_TEST_CHECK_PROGRESS. */
> > +static struct progress *current_progress = NULL;
> >
> >  /*
> >   * These are only intended for testing the progress output, i.e. exclusively
> > @@ -258,8 +260,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
> >  	struct progress *progress;
> >
> >  	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
> > +	if (test_check_progress && current_progress)
> > +		BUG("progress \"%s\" is still active when starting new progress \"%s\"",
> > +		    current_progress->title, title);
> >
> >  	progress = xmalloc(sizeof(*progress));
> 
> Ah. This is why you moved the allocation down further, since we don't
> have to free anything up when calling BUG() if it wasn't allocated in
> the first place (and we had no such conditional that would cause us to
> abort early before).
> 
> For what it's worth, I probably would have preferred to see that change
> from the previous patch included in this one rather than in the first of
> the series, since it's much clearer here than it is in the first patch.

Yeah.  It must have been a rebase mishap.  (I started working on this
after I reported yet another commit-graph related progress bug around
v2.31.0-rc0, and I had the first two checks on the same evening.  But
then some time later Peff came along and found a backwards counting
progress line, so I decided to add a check for that as well, which
necessitated a bit of refactoring in the other two checks, and then a
hunk somehow ended up in the wrong patch.)

