Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03404CCA473
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbiFOVcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiFOVcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:32:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D880562FB
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:32:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 68so9721386qkk.9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZSlhuw4aCWryHwEk3eBsHug/pCEerLNBhTeCQHGNWBA=;
        b=1y1vs6Wb15eCGx/OxvAM9SeTyfF5IHN5kuGuuEDy2iymmlGt1vEg5aG9rY4FEZFNsH
         ss4ZVrn5esS3Cb8G/SU+PQUqtmj2kvljXhbT9GQoZXzW1tRDPjHAj4hxbBgHGgSjLjtK
         SkLpjOqdti4kT+nhudQPhri5XHd5XyrijzQa+k98cZTEcr7NoZkagS2qfGP/B2+Jqj7i
         UXCxvphsXyMz2BSDii5MhMawP0t65lL4wsGssPklnrbDie/WEinG7QwZ3kIVx6G0StbJ
         fz3B0MprsaPXCjPJcfdB1JImYIzghwZZww/AKVQmoZ16eRUuurJksYUjNOED372M7pt+
         oIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZSlhuw4aCWryHwEk3eBsHug/pCEerLNBhTeCQHGNWBA=;
        b=NmKbWUXQwK4rLts/hTQVnYoF1y1vd5SBfzS3FNSpXG88Y+nGWFJwAEx8q5K/gZ4iuy
         lp0xBKQ0/p+x2Tx31+WoLP9b31rktmW2/qLHtWF82FWvSs21fOqeAX88I533vx+k2vmC
         bjAkyS00i/+YMY45P0zKIkw5aI/nswYL8xm1OGXonYKZ9UpKK5vFkyAyGrXzuNr3I4z8
         Yy4R6+MWHO3bcW/mF/gPo6qHCLJrfS+9rnHj55pPto749NrkqAZ5NJW1uE6GbbNpooRW
         9IZ2XFOx3hARhTYeFnBNyUuihmCm1+KEjbnFGokP1pgRKOKOXI9l4/jSQbGAK3hbjaQZ
         w/jQ==
X-Gm-Message-State: AJIora8UePmISxqTOIiMVNYQQMckLN3p+zDFOsOT8dJ3+bZ+cLUF6RtE
        j0B6WIBSVswgGJTARrHATrbDBQ==
X-Google-Smtp-Source: AGRyM1sx0ULpDnlz9L6GEnsx2EIvvEHQkkahoEQDD28ftL+b2wO848iDXsVDNiXqKDeawrSgVShORg==
X-Received: by 2002:a05:620a:29c2:b0:6a7:609f:54dd with SMTP id s2-20020a05620a29c200b006a7609f54ddmr1373705qkp.545.1655328723251;
        Wed, 15 Jun 2022 14:32:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a37a407000000b006a66f3d3708sm12056432qke.129.2022.06.15.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:32:02 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:32:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH] send-pack.c: add config push.useBitmaps
Message-ID: <YqpP0b2zt0sWZD0B@nand.local>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <220615.86edzpy9m6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220615.86edzpy9m6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 09:47:58PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Refresh my memory, we always use them if we find them now, correct?
> I.e. if repack.writebitmaps=true

Kind of. `rev-list` has an opt-in `--use-bitmap-index` option, and
`pack-objects` has `pack.useBitmaps` which controls whether or not
bitmaps are read.

So `git rev-list --objects HEAD` won't use any bitmaps, even if they
exist, but `git rev-list --objects --use-bitmap-index HEAD` will. There
there's a good reason not to use bitmaps by default, which is that they
(effectively) randomize the ordering of your output.

`pack-objects` behaves slightly differently, cf. its
`use_bitmap_index{,default}` variables to see how that works.

> This doesn't make it clear: Are we now going to ignore them for "push"
> by default, even if they exist? I.e. a change in the current default.
>
> I think I recall from the previous discussions that it was a bit of hit
> & miss, maybe we're confident that they're almost (or always?) bad for
> "push", but I think there *are* cases where they help.

Yeah. In theory they should help most of the time as long as the bitmaps
are kept reasonably up-to-date. There's a tradeoff between using bitmaps
and how much walking between bitmap and ref-tips is required. Since
every object we encounter between the most recent bitmap and the thing
we're trying to generate a bitmap for has to incur extra overhead in
order to find and mark its position in the bitmap being generated,
there's a certain point at which it would have been faster to just walk
down to the roots and avoid bitmaps altogether.

But I suspect that in this case the bitmaps are just simply stale, and
that a "git repack -adb" or more aggressive background maintenance would
make things quite a bit faster.

Thanks,
Taylor
