Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF29C6146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhCDAWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842979AbhCCKXR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E02C08EB2C
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 01:43:29 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so13703187plg.13
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XQhdNg50NxBFQq5AQ3pQwGZ1Iv0mNJ2HKVuoZZBtVwA=;
        b=guh/k9pksp8+FOse2msqWV4krCRoJxsBjWPk/p9sBza0H87ebAk3QP2/zQMos8WDrh
         sJL57w6bn871YaYRPB41KogoOtvbbyycOtG/p7fBEia3n40K9GAH70quDoPg3lNRoNsI
         VaV1VRfSCHBpiQH1lJzBUPJsSHYCBogqZcONn2Y1zavcBDqALO8GWaRjrQ+rtVXTkdFw
         /jESYJdiH9Y3gW9YcBx6WQTIN6vUI9GcF8R69CdhSKd8SajWzm9R4Mnh29mmVDLztrj3
         fvx1EunZwyJ0QUNYwH4TlYX7O1ilTU7FUYWtBoa0TLftOpmAKbora3JBFZ04Zp1YNpKp
         nU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XQhdNg50NxBFQq5AQ3pQwGZ1Iv0mNJ2HKVuoZZBtVwA=;
        b=rlenC9f6sLZqEx2Ig2a042Bm8NJktQ4UvdmcjFVX+gVmZV8zT66/gZvPvLlNg0ExhJ
         g/0ph6pEpSGe8fKi+MqWBvzj4MoPbZpT6/mGKANnqjh399YahouD5Bkx5puk38qX/Tzs
         GpA/OeTSJOsSSWneE+sDjAs+UrTPj4NUQsksRoJY4VmhOYO6HT6gCw1r+xbb67yHH7Tk
         CsYPOIOb4mLZdFZpYzpF7SIbFsbPSfjX6DHE4d5mifN+xxashaLuO7cWD6tF6+V6ikkM
         yDrvwiEr1eImR2hZZBWofkYrRG7A1yDj/vKnMAAJ6HmsN+fY6RNOqCzzuKHDptVli4SM
         78Yw==
X-Gm-Message-State: AOAM533nAZj7HhHV6AcB6UbAFoXwHHvE3pfSoesL4cN4iHaOm8QjRL/n
        6k/85HC7VAChRVlkim6IrAA=
X-Google-Smtp-Source: ABdhPJzES7uuK+28Y9rqmFQ8WF/KQvYBqizDUzWDaIFNQQIRNlX7QlBbRx1CopnP2mFRtVwciknNlQ==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr8512693pjf.41.1614764608743;
        Wed, 03 Mar 2021 01:43:28 -0800 (PST)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a15sm6337387pju.34.2021.03.03.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:43:28 -0800 (PST)
Date:   Wed, 3 Mar 2021 01:43:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
Message-ID: <YD9aPW0LOZrySK4E@generichostname>
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Mar 02, 2021 at 09:51:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I've often wondered why "make coccicheck" takes so long. This change
> speeds it up by ~2x and makes it use much less memory. Or a reduction
> of a max of around ~2GB per-process (under the old
> SPATCH_BATCH_SIZE=0) to around ~200MB.
> 
> Running the full "make coccicheck" now takes ~50 seconds with -j8 on
> my machine, v.s. ~2x of that before. I've got 64GB of memory on that
> machine, or it would be much slower.
> 
> Why has it been so slow? Because I think we've always been running it
> in entirely the wrong mode for what we wanted, and much of the
> previous fixing of this target has involved re-arranging the deck
> chairs on that particular Titanic.
> 
> What we really want to do with coccicheck is to do search/replacements
> in all our *.c and *.h files. This is now what we do, and we'll
> process a default of 64 files at a time.
> 
> What we were doing before was processing all our *.c files, and for
> each of those *.c files we'd recursively look around for includes and
> see if we needed to search/replace in those too.
> 
> That we did that dates back to [1] when we were only processing *.c
> files, and it was always very redundant. We'd e.g. visit the likes of
> strbuf.h lots of times since it's widely used as an include.
> 
> Then in the most recent attempt to optimize coccicheck in [2] this
> anti-pattern finally turned into a bug.
> 
> Namely: before this change, if your coccicheck rule applied to
> e.g. making a change in strbuf.h itself we'd get *lots* of duplicate
> hunks applying the exact same change, as concurrent spatch processes
> invoked by xargs raced one another. In one instance I ended up with 27
> copies of the same hunk in a strbuf.patch.
> 
> Setting SPATCH_BATCH_SIZE=0 and processing all the files in one giant
> batch mitigated this. I suspect the author of [2] either mostly ran in
> that mode, or didn't test on changes that impacted widely used header
> files.
> 
> So since we're going to want to process all our *.c and *.h let's just
> do that, and drop --all-includes for --no-includes. It's not spatch's
> job to find our sources, we're doing that. If someone is manually
> tweaking COCCI_SOURCES they can just tweak SPATCH_FLAGS too.

This is a very clean and well-done analysis.

I've also timed my runs and the effects are really obvious:

Before:

	$ time make -j7 coccicheck
	    SPATCH contrib/coccinelle/array.cocci
	    SPATCH contrib/coccinelle/commit.cocci
	    SPATCH contrib/coccinelle/free.cocci
	    SPATCH contrib/coccinelle/hashmap.cocci
	    SPATCH contrib/coccinelle/object_id.cocci
	    SPATCH contrib/coccinelle/preincr.cocci
	    SPATCH contrib/coccinelle/strbuf.cocci
	    SPATCH contrib/coccinelle/swap.cocci
	    SPATCH contrib/coccinelle/xstrdup_or_null.cocci

	real    3m15.215s
	user    17m36.779s
	sys     1m4.262s

After:

	$ time make -j7 coccicheck
	GIT_VERSION = 2.31.0.rc1.1.gd8c3638591
	    SPATCH contrib/coccinelle/array.cocci
	    SPATCH contrib/coccinelle/commit.cocci
	    SPATCH contrib/coccinelle/flex_alloc.cocci
	    SPATCH contrib/coccinelle/free.cocci
	    SPATCH contrib/coccinelle/hashmap.cocci
	    SPATCH contrib/coccinelle/object_id.cocci
	    SPATCH contrib/coccinelle/preincr.cocci
	    SPATCH contrib/coccinelle/qsort.cocci
	    SPATCH contrib/coccinelle/strbuf.cocci
	    SPATCH contrib/coccinelle/swap.cocci
	    SPATCH contrib/coccinelle/xstrdup_or_null.cocci

	real    1m14.070s
	user    7m40.644s
	sys     0m13.689s

so this gets my

	Tested-by: Denton Liu <liu.denton@gmail.com>
 
> I'm entirely removing SPATCH_BATCH_SIZE. If you want to tweak it you
> can tweak SPATCH_XARGS_FLAGS to e.g. "-n 256", or "-P 4 -n 128". But
> in my testing it isn't worth it to tweak SPATCH_XARGS_FLAGS for a full
> "make coccicheck".
> 
> I'm also the whole "cat $@.log" introduced in [3]. Since we don't call

I'm also... what? :)

> this in a loop anymore (and xargs will early-exit) we can just rely on
> standard V=1 for debugging issues.
> 
> 1. a9a884aea5 (coccicheck: use --all-includes by default, 2016-09-30)
> 2. 960154b9c1 (coccicheck: optionally batch spatch invocations,
>    2019-05-06)
> 3. f5c2bc2b96 (Makefile: detect errors in running spatch, 2017-03-10)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
