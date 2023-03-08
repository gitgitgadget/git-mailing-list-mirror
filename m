Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D72EC74A44
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 15:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCHPuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjCHPt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 10:49:58 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277B13DCF
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 07:49:56 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id l2so10652964ilg.7
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678290596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwd5+dtphuC1kkZpxlcpYDWOWQk/WytvhiUjgQ7HD3M=;
        b=WRHYJGaFJhw1/LfKKl6LX+uH1CArIjWKHd5DPiges+3Mz0FnA/xqOOUU1M54xChWw7
         2haHD97pskOO/o0wo8pDky9HIHxNfLlumI6FCZVjKk2MB01YQfaShgDgJiLgZq+2f2g3
         oF/Hx+62V7K4Y+A2tQ0vUR0Cd6weWYtu6VI//2PjsAk/CeamAcvt6GgUhqSSjIiTEr6z
         Qk1Mzpq5sWMm91jZPWUhelJaSv/TJ8l30O6iHE2jQulSil8Nxs8F127n7OpU447etyjN
         dhIURPrRcST+tzWhdGE1TYdtJbBkdGm9FOD/wmn6ibU3Guio1qbAh0HP9Z6l+Jxa4vay
         k4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwd5+dtphuC1kkZpxlcpYDWOWQk/WytvhiUjgQ7HD3M=;
        b=7793iqpId+mkmq8NTfJyjRBtEADpUOR3nRUbg9Urzd48f99ixmFwQAiSWMR4rVqgGw
         L2w2a9foIBeLGq3qXbT2chwBfrOWxv+4l31m1w877aBzAf1vuTG/l6NowFtcWo8RPlLv
         57AdIlPHxKupkpSv3aEEb0qLf7zui1tV4Q8s34IB7gFNVZrSazn+HehVC0+9WWSnCUaa
         V+Qjaik3vMclgt7oDws4wyAMK6um8q1sG/aPrwqPS34+9KO8zC5WWAN3ecLrssKaD++w
         goFCXbXxsiHxIX4Ap322HmfR+je50Lt86xSE82CBDtoGbnKQ8ATdUU4BR7D8G/GN+VkX
         x+5A==
X-Gm-Message-State: AO0yUKUMOIPceFPuO+7zzK+hdt2QdL2QLoa/M7Tfp7up85PNAF23HB0c
        9QpHnrWwe95vC+wMhTCPatfFFA==
X-Google-Smtp-Source: AK7set/t4XxPXWwat57SvUlbyoIvk74oWoA44wp+lPqLUpb0obhoXr92N7ThYD/lSh1qwxK1yU0B7Q==
X-Received: by 2002:a05:6e02:13ee:b0:319:2bf:54ad with SMTP id w14-20020a056e0213ee00b0031902bf54admr10683883ilj.14.1678290596139;
        Wed, 08 Mar 2023 07:49:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p21-20020a02c815000000b003c4e1bfbab8sm5101997jao.44.2023.03.08.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:49:55 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:49:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame-tree: add library and tests via "test-tool
 blame-tree"
Message-ID: <ZAiuojxNifGo3n97@nand.local>
References: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
 <4ab0b2b0-b045-2346-ccc1-19f9b23d0a02@github.com>
 <230307.86o7p4zm4s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230307.86o7p4zm4s.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2023 at 02:56:29PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I hear your concern about leaving this open for optimization, and in
> general I'd vehemently agree with it, except for needing to eventually
> feed a command-line to setup_revisions().
>
> Ideally the revision API would make what you're describing easy, but the
> way it's currently implemented (and changing it would be a much larger
> project) someone who'd like to pass structured options in the way you'd
> describe will end up having to re-implement bug-for-bug compatible
> versions of some subset of the option parsing in revision.c.

I get what you are both saying here, but I think I find myself tending
to agree with Ævar a little bit more here.

In an ideal world, sure, having the blame-tree API take a single struct
called 'blame_tree_options' would be very clean. But the crux is that we
have to pass some arguments to setup_revisions(), and that our problems
here stem from the leakiness of *that* API, not this one.

I ran into a similar problem when looking at rewriting the bitmap
traversal code a year or so ago (which is sadly still on my to-do list).

Without getting into the details, part of that work involved calling
limit_list() as a function of setup_revisions() to discover the
traversal boundary. And if the caller happened to put --topo-order in
their command-line arguments, we wouldn't end up calling limit_list() at
all, since (as Stolee well knows ;-)) those two code paths are quite
different.

I can't recall if I either detected if '--topo-order' was passed (by
looking to see if `revs.topo_order` was set), or grafted an extra
`--no-topo-order` argument onto the end of the list. Either way, I think
those two problems are more or less equivalent in this context, and that
it seemed like a much more expedient solution to work around the
fundamental leakiness of the setup_revision() API rather than refactor
it.

> Isn't a way to get the best of both worlds to have a small snippet of
> code that inspects the "struct rev_info" before & after
> setup_revisions(), and which would only implement certain optimizations
> if certain known options are provided, but not if any unknown ones are?

Yeah, I think this is basically the same as my "let's check if the caller
passed `--topo-order` by checking the `revs.topo_order` bit" above.

> I think those are all good ways forward here, and I'd much prefer those
> to having to re-implement or pull out subsets of the current option
> parsing logic in revision.c. What do you think?

Same :-).

Thanks,
Taylor
