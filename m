Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A95FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKABeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKABeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:34:11 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956412620
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:34:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d123so6501602iof.7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N69K5ZWHoz8HhIKRkNhBDeKAtjpNa0iQODZ0/cWpqLY=;
        b=FUkVhO48+bIQudSP4ZBAZNA+TJaArHwf1sJri8fxNPx0YD2/ASLaeOVU9I0jI4OA+B
         84ERMag2ghKSEvX4sDavFL5iW1kzH+QtpaqHXFGY3JjYo08QHcOz/0Ql5CiGTPZGAYMm
         35smIC0XcKy2R/4PgVU9c9gqR/KV1pDYwS3xtFJpxELbAgItk7LWvSHPxo5NvU1EI3pt
         laOkbGYqM6ATTbY/hTi+HaUxDcVLJ/tDfrmumHYyvPEbn4wehnQ5XT53ZwUmi1C4pio8
         TL1+I3+YFhv2CQDftLGKxDjDinlS8LMWsw6Rdw6tyuTQwCCvLFSPnCujXbH22eEqaV+Q
         JiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N69K5ZWHoz8HhIKRkNhBDeKAtjpNa0iQODZ0/cWpqLY=;
        b=Exj8KY1g4sW5r4FukMh2OHd5lINgaX6Mj73ogPqrYhDv/jDh3QI+sZpiXmeL9XmS8p
         9U27rcr2cCI3mORYhfAHqlSbvW6LloXo2RhMveOOE1Nx6T7f+SuvYQn46iQgO9zt3qtZ
         Z5qH2pND92ZR6wliQ3BsyWO8wF5/1Zwl1OcN9Dn7LVhGEfgv+BMjmkEbLY5pe10dCQrZ
         2TbzQyNS9zeZmqy6f2eBQ+SvT2TUOQbywmtbAmbP9lGtx2N46HMJ70WxYiLawrwV/bnB
         6uOQdBelLy+r5CSIkRl65OHjaqKkj1V7Ujrg8ExknhqMWywMogSxx78gTAcjLk/nQQRm
         92Qw==
X-Gm-Message-State: ACrzQf0ZoDsNH3KdXFPPEZPGCLcYaRSMegkrIRPuUhEp639U9+rSvD1c
        HV9seq+NtsPjFN7v06R6bt/cZA==
X-Google-Smtp-Source: AMsMyM6ZNlcm72E67wVr6XZw3qhLv8N5lawuyevzAgFKLQUas2B9O5+rjLMeX3Cwz4kaRILg5vXCJQ==
X-Received: by 2002:a5d:9902:0:b0:6a2:f72d:4b21 with SMTP id x2-20020a5d9902000000b006a2f72d4b21mr9422722iol.113.1667266449050;
        Mon, 31 Oct 2022 18:34:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g9-20020a025b09000000b00363dfbb145asm3272231jab.30.2022.10.31.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:34:08 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:34:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
Message-ID: <Y2B3j3sFcd/mJoHx@nand.local>
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 04:11:52AM +0000, ZheNing Hu via GitGitGadget wrote:
>  t/t4070-diff-sparse-checkout-scope.sh | 469 ++++++++++++++++++++++++++

It looks like this test is non-executable, leading to the following
error:

    ~/s/git [nand] (zh/diff--scope) $ make test
        SUBDIR templates
    make -C t/ all
    make[1]: Entering directory '/home/ttaylorr/src/git/t'
    rm -f -r 'test-results'
    non-executable tests: t4070-diff-sparse-checkout-scope.sh
    make[1]: *** [Makefile:120: test-lint-executable] Error 1
    make[1]: *** Waiting for unfinished jobs....
    make[1]: Leaving directory '/home/ttaylorr/src/git/t'
    make: *** [Makefile:3083: test] Error 2

Thanks,
Taylor
