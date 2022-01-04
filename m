Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE87C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiADRc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiADRc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:32:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3054C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:32:56 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l11so35508298qke.11
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekvNYjCBqND5QcdTgUVTVkLpu1IbaIIG2Fv0Ua6L0/4=;
        b=2gsrXD0sAUD8BIFO6B7Mk/A11sEr53fPwBc120QVHrMiE/PCBbHGIG3vm0F41yqT5q
         UCyPtxi3Qh1s8M+hbJbMBhT0g4WUiqNfmrpAGl9UT6hhGBJ7mI8katlCsBinx4+QBdQA
         FB3Sp21qb2eSxhM4qXWp/J/s6n0j8MpUZL4sUoB5vwhYaj4ykBKB2IkmJjGyH/1d7yxV
         kumvWP7T6CfstOcu3WM9v5WSIkhXGlPOswc/Jz+C6nJbuzUez5hWIMoL78fsZFJqjKMm
         mUtlaAp19ofWXjyH3FZq/ek1sOLWlq6HYJSvC3oF18QksM2iqA+QB/kosPEfzghWdMww
         TXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekvNYjCBqND5QcdTgUVTVkLpu1IbaIIG2Fv0Ua6L0/4=;
        b=MZexi5g0WBfLX5NfUZ60xQ1+XHLfDPPdZWEidrnkZ67WaanYwpaJ4glapncX4BTOTK
         o/+OabEYVNZx29vcIYopUp33SaTcZRTrzRSjlyuiYo7pamJAxRC1UO9SiMJI5c6j1euE
         ltDp6MVpv0CXsjtZRBu8lJ1OtYYTvnJ9DJNRXJ+/haBVYNtehuKWAAHjzsz2yU0gKCM4
         odgjRiY2X+7h49G/8inzICnc0daAnGRGfQZqDwQB3Ilj+vG4SWKElkH2keXpNx+RQg1d
         Ph/51Mlc++vREBZ3pSlBHrfpkOlYYJdOs2UZTdd9JJTSNhFY+1WADo2s9fsB7hW1Q1/Y
         a8hA==
X-Gm-Message-State: AOAM530hMxUy77wcnrzXFvg/iia/PQuJ9IdwwEIoygC462OeqMndmWsc
        F0MiUbQ4qfKMD4vzu8GSk8t8Eytn+tAYLpIn
X-Google-Smtp-Source: ABdhPJzIFkBx/FdYCB0tXK19peyj0fATyPyLqtIksfWj7uBqIAGZ8rD4GSZT5oo5aDNcJG+UFX7oNw==
X-Received: by 2002:a37:b5c3:: with SMTP id e186mr36566718qkf.747.1641317575962;
        Tue, 04 Jan 2022 09:32:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f18sm31712178qko.34.2022.01.04.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:32:55 -0800 (PST)
Date:   Tue, 4 Jan 2022 12:32:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/midx-bitmap-corruption-fix (was: What's cooking in git.git (Jan
 2022, #01; Mon, 3))
Message-ID: <YdSExm8fIiRePHI4@nand.local>
References: <xmqqsfu4duxl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfu4duxl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 03, 2022 at 07:46:46PM -0800, Junio C Hamano wrote:
> * tb/midx-bitmap-corruption-fix (2021-12-23) 9 commits
>  - midx: read `RIDX` chunk when present
>  - t/lib-bitmap.sh: parameterize tests over reverse index source
>  - t5326: move tests to t/lib-bitmap.sh
>  - t5326: extract `test_rev_exists`
>  - t5326: drop unnecessary setup
>  - pack-revindex.c: instrument loading on-disk reverse index
>  - midx.c: make changing the preferred pack safe
>  - t5326: demonstrate bitmap corruption after permutation
>  - Merge branch 'tb/cruft-packs' into tb/midx-bitmap-corruption-fix
>  (this branch uses tb/cruft-packs.)
>
>  A bug that made multi-pack bitmap and the object order out-of-sync
>  (hence the .midx data gets corrupted) has been fixed.
>
>  What's the status of this thing?
>  source: <cover.1639446906.git.me@ttaylorr.com>

I have a small reroll that I'll send shortly which contains a minor
fixup and one new patch on top.

I'm assuming that the "uses tb/cruft-packs" is related to the two topics
both squatting on t5327's real estate? If so, feel free to eject the
cruft packs topic for this cycle, and we can look at it again after
2.35.

Otherwise, the version I am going to send is based off of dcc0cd074f
(The sixth batch, 2022-01-03) in your tree, so it should apply cleanly
onto master without the other topic.

Thanks,
Taylor
