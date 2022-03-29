Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286FAC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 01:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiC2BXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiC2BXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 21:23:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF92DAB4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:22:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e22so19272154ioe.11
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3GiPFFSkkTvJ7lCep3asEiS8jUY5EA951LNyfcRoU6s=;
        b=K9h7zkmKJcRf2/rjOyfpR2YyvJipHqUBaTCljPhnrMY+sLmoKsQx80HFQaj4FJ8Abo
         0vSdipIzqu7yaoMVufX7WYJjKJv0YyZsv/RKW/Cuj86llzLq81F3OCR5ZdRFghELgTsZ
         j1M/XBbwbBAMz7E5kkztXKcUK/bSjLoJN7eh9zin/8/yGpJJsPXVxGF1VJuFiY0vZwDQ
         SldorBiK9Bs49M/NvFMFrP0Pb0DqvWiXtIz6VuOKzfIWI4Tt+zAeXy9ZYK95BaSpagAs
         fhNuKFwF/xNEkkA6JGHropghzqbVH/4V/jiNGX31cMrLcYQmRD14agkp33CUHiKzCfpK
         DT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GiPFFSkkTvJ7lCep3asEiS8jUY5EA951LNyfcRoU6s=;
        b=1mAXD06dz73nlJdfIY/i7pbObUMs4TFck52yOs63xM+3TKRWZ/msuR2jA9J5siwLdd
         pwL9hkslDw+bG3qVa3zz175w4ZOt+Jk1v8hyguzzamnhCoHWNZCz49No2TK1kQHeMnZ/
         15sgKzboHOFu8bj44BKIMFoWbRotN/Jm1d7X0LBO2UkZz37RcLkOgtrx1qe1wtb9Mzbs
         t1T40sMJF+JfavbCzAuyYnDGHQxYtQVcfJe2Yef7ER11Sj+BGqwSLk56cIhsyK2IpGWB
         6+CrxCiE5+APPi4lLP+ORvG7m4uoZRk1oC6/TPDjBMfbitk+bn9OAQmDn1RxNKIT1qd3
         Cy9g==
X-Gm-Message-State: AOAM533WuMyqPd0cvtcu308/eWjRIWRv631h5HwL7A8UjTPjfWYQ7Btp
        1Yi21v499A2XhUWJZg/j36PRig==
X-Google-Smtp-Source: ABdhPJxT3jGtcBNcX4n+NkztrYQJElgc3Zbgk2M4hpGEBbgCoiPgidIHootn+K0jpN79elZpZc5msg==
X-Received: by 2002:a02:7157:0:b0:31a:fc9:a808 with SMTP id n23-20020a027157000000b0031a0fc9a808mr13769459jaf.262.1648516919820;
        Mon, 28 Mar 2022 18:21:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d9ec2000000b00645ab33390dsm9090281ioe.9.2022.03.28.18.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:21:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:21:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkJfNtcXiKWQOtQA@nand.local>
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <YkIJacCaaqFk1MDa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkIJacCaaqFk1MDa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 12:15:53PM -0700, Josh Steadmon wrote:
> > Looking around, I think I probably inadvertently broke this in
> > ab14d0676c (commit-graph: pass a 'struct repository *' in more places,
> > 2020-09-09). But prior to ab14d0676c, neither of those settings existed,
> > so parsing the commit graph was a pure function of the commit graph's
> > contents alone, and didn't rely on the existence of a repository.
>
> Yeah, I have not done a great job keeping the fuzzers up to date with
> commit-graph changes :(.

I think that puts you and I in the same boat, since the original
breakage from ab14d0676c blames back to me. I'm sorry that I didn't
notice that my change had broken the fuzzing code at the time, and I
appreciate you working on fixing it!

> > We could pretend as if `commitGraph.generationVersion` is always "2" and
> > `commitGraph.readChangedPaths` is always "true", and I think that would
> > still give us good-enough coverage.
>
> It might also be worthwhile for the fuzzer to test each interesting
> combination of settings, using the same arbitrary input.

Definitely. I don't think it hurts to just focus on getting the common
case ("2", "true") working again. And if libFuzzer makes it easy-ish to
test more of the possible input space, I'm all for it.

Thanks,
Taylor
