Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A5C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiANTjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiANTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:39:16 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E8CC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:39:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v1so13555021ioj.10
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yGNZhJQp/4MES/W/IEHOTaLtiDV0+pqz3KDhl0iTsBU=;
        b=TUwbpBwlujNnHOVk80yN4Rq3bS0D5GLWiKgXCTz5xQTN5lxQtZ3pgCzRhhtb/YFFyc
         E8SzY608Tq02lS/yiEZR26pLeL5zx0R7hkrvSbtoVhdR/Nli/a7AUpyIRGxpgMFvRlgf
         5zl5iIahQaNnfOszHebfc6i8+Pk6DNANA+eIoURlzFgTMx6aUTHQdyp83UO4LRZxfRRi
         5SdNnwd06bqp1sEjCGl+AqTGgNiFwnPdC/G1inAipHaK4MBbkkhJNVRbeWe/9zmyR6C2
         2so2mEhgE/FU9EDbl1joIpx8OlHPQUoFyXlhG0Xk1cyw/oEhbQ33P0Ykj795QERRPwq7
         sb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGNZhJQp/4MES/W/IEHOTaLtiDV0+pqz3KDhl0iTsBU=;
        b=YDU184YoMZwXdhNfiTwwX9UICHcVCiumFf57dHoEkL0RSydQKYg0Ofy9ZyAC180H7z
         OzeAaXpUA8TOvmIG2OAYicaNTwdaRMoMFIcag4U6cFmZG3s4HSwJudRjJ0cqRflKVcOB
         a9SyY+NUY4O4Jaik3sl6FtVwlkGBhExN/OnXoAeTVs8idB7sW7F7uyT1DaQcd7dK74jk
         Xp6zYfKr6Sna7T6Oc4vTukKbxYGvIwwgwBsYtSp9IYhvs1X8ge1KXL0mE/3GZ845hKRl
         cg80fjiS2ce+z689ti/s8Vtch3SjMVZZkIq3p2hf7Smw4j5B4SrjzcoY2xonteKGWKjJ
         YO+g==
X-Gm-Message-State: AOAM530Q1XB7vw6Ds/oZrOtGOGOdkyi0efBuwE/cy6a47ZqRvJpnTGdR
        ud/wC8rRyY+S6hh2B/BB+tUoHhLHmwwD+w==
X-Google-Smtp-Source: ABdhPJxa4nZLNsaWHlEfMcv7T8gB0CVRuM4WXuzo32OvAkRAsE2sPz9PTe0IH2kFyaHteDdZmgBMbQ==
X-Received: by 2002:a02:a18c:: with SMTP id n12mr4733614jah.196.1642189155631;
        Fri, 14 Jan 2022 11:39:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm5286412iow.7.2022.01.14.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:39:15 -0800 (PST)
Date:   Fri, 14 Jan 2022 14:39:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: tb/midx-bitmap-corruption-fix (was: Re: What's cooking in git.git
 (Jan 2022, #03; Thu, 13))
Message-ID: <YeHRYkl2RaQbrtmx@nand.local>
References: <xmqq35lrf8g4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35lrf8g4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 04:48:59PM -0800, Junio C Hamano wrote:
> * tb/midx-bitmap-corruption-fix (2022-01-04) 9 commits
>  - pack-bitmap.c: gracefully fallback after opening pack/MIDX
>  - midx: read `RIDX` chunk when present
>  - t/lib-bitmap.sh: parameterize tests over reverse index source
>  - t5326: move tests to t/lib-bitmap.sh
>  - t5326: extract `test_rev_exists`
>  - t5326: drop unnecessary setup
>  - pack-revindex.c: instrument loading on-disk reverse index
>  - midx.c: make changing the preferred pack safe
>  - t5326: demonstrate bitmap corruption after permutation
>
>  A bug that made multi-pack bitmap and the object order out-of-sync
>  (hence the .midx data gets corrupted) has been fixed.
>
>  Waiting for a hopefully final review.
>  cf. <Ydceeo33Yt4N%2FbrN@nand.local>
>  source: <cover.1641320129.git.me@ttaylorr.com>

I would really like to get this into 2.35 since it's fixing an important
source of repository corruption, but I think it should have a careful
round of review before merging. And it is pretty late into the cycle
anyway, so we may be too late to merge the whole thing.

But the first two patches:

  - midx.c: make changing the preferred pack safe
  - t5326: demonstrate bitmap corruption after permutation

could be applied as-is and the rest of the series left for later, which
should be a safer approach (and would be sufficient to resolve the bug
at the expense of some redundant bytes on disk[1]).

I think Stolee is probably the most familiar with this topic, but he is
off currently and I'm not sure whether or not he'll be back with enough
time to get this merged before 2.35.

On the other hand, the bug is pretty difficult to trigger, is affecting
a very new feature, shouldn't ever cause permanent damage, and can be
recovered from fairly easily (by dropping existing bitmaps). So perhaps
it's OK to let it sit out for another release like this...

Thanks,
Taylor

[1]: More or less storing the contents of the multi-pack-index-$HASH.rev
     file twice: once in the .rev file itself, and again as an optional
     write-only chunk in the MIDX.
