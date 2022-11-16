Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC85C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiKPVW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiKPVW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 16:22:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539B6069A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:22:26 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id bp12so9831786ilb.9
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSCIZcWF2DW+O1TUrXp2aW8bBiQGx76B1zgVpUm4cVY=;
        b=kYw/0PTyjJ8yE71RPJcqLmEwr659dD0TgbGtEKmCAIJDh51x7DpKAnUavw3QP1/CWX
         wE7yJeP6/zBnAjF95Z3vIW8zkgmLsfaFUJBmxnZ2mRWhze/1U9q7JtL/vqkz8HZ1ihrN
         vQnuVGSIJN8iOToMzGCXDB0Hoo0aLWFXiLy9NAyBL6mCPuAeyoh0ydr2IZK0h4kp8IqL
         UUw6aZeIU61pL6yGssYSSqdhAYIr4j798dqBa89ptEjxoJIUlJHEm8Qxa7ek/0Nv4znn
         CABJ7VvM0CAxL4PUb6H0QJVT4sRDW9WZHyIwGkW2TgOzUTAmW3IPxbLqDlVgJeiAiiNO
         t7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSCIZcWF2DW+O1TUrXp2aW8bBiQGx76B1zgVpUm4cVY=;
        b=5b+kvECSLyv1gbNXWt0LoqAFuBupDadeEMDtLRD0hJj6ghOvmR1Z5vxG7Po3NE44bd
         fjnH1zHcZFG/iiSLmmOaMjvsgoxvStkR/MsdAtHhN8XF/bnxYR+iW+kO5zOKQxsZGQrL
         ShVCIcbUpgguUsc5fXw1so2zcEIDhVEgijDLym5fxfWpmQXvJuDNjXxM8Ke8V/W26DYV
         hTgOUnVeMaMv5G+06b3xlkyIjmNhsDnC0NMP7VoanSGHrcHff/EGm777pA1axgJLuN4E
         YShipi95PSJRv1gwRo5cPZ1+PT1YFATAIqAl0cVhEthrlMJPnGZhIdfxnX5kg9xRB6VH
         g/uA==
X-Gm-Message-State: ANoB5pmulZxHOzUNFlKqbOReR0kB4DyK8cuhVfcDdRCVD7HCeJLD+fYD
        aAOtKxLfnAQkmCDT8Fcfc9jPCw==
X-Google-Smtp-Source: AA0mqf5mhkqQq9BR1UjZA5ectAS2iZqrT3xhkrwzix/EQZsjK6pRqUDFEyW3BIaTtqOJgPv0fk+Srw==
X-Received: by 2002:a05:6e02:11ae:b0:300:a20b:1895 with SMTP id 14-20020a056e0211ae00b00300a20b1895mr11300358ilj.167.1668633746045;
        Wed, 16 Nov 2022 13:22:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b14-20020a05660214ce00b006bb57cfcb88sm7008769iow.44.2022.11.16.13.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:22:25 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:22:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3VUkKoKd8j7IW6T@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
 <Y27KL0Yg7nzdQ+HC@nand.local>
 <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 12:26:25PM -0500, Jeff King wrote:
> On Fri, Nov 11, 2022 at 05:18:23PM -0500, Taylor Blau wrote:
>
> > On Fri, Nov 11, 2022 at 07:49:49AM +0100, Patrick Steinhardt wrote:
> > > Patrick Steinhardt (7):
> > >   refs: fix memory leak when parsing hideRefs config
> > >   refs: get rid of global list of hidden refs
> > >   revision: move together exclusion-related functions
> > >   revision: introduce struct to handle exclusions
> > >   revision: add new parameter to exclude hidden refs
> > >   rev-parse: add `--exclude-hidden=` option
> > >   receive-pack: only use visible refs for connectivity check
> >
> > The new version is looking pretty good to my eyes, though I would like
> > to hear from Peff, too, since he caught a few things that I missed in
> > the previous rounds.
>
> This looks good to me, too. There's a typo (s/seciton/section/) in the
> commit message of patch 6, but definitely not worth a re-roll. :)

Hmm. It looks like this is broken in CI when the default initial branch
name is something other than "master":

    $ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main ./t6021-rev-list-exclude-hidden.sh -i --verbose-only=12 -x
    [...]
    expecting success of 6021.12 'receive: excluded hidden refs can be used with multiple pseudo-refs':
        git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=$section --all --exclude-hidden=$section --all >out &&
        test_must_be_empty out

    + git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=receive --all --exclude-hidden=receive --all
    + test_must_be_empty out
    + test 1 -ne 1
    + test_path_is_file out
    + test 1 -ne 1
    + test -f out
    + test -s out
    + echo 'out' is not empty, it contains:
    'out' is not empty, it contains:
    + cat out
    d2e88f5a45c63e4ec7e1fd303542944487abe89a
    + return 1
    error: last command exited with $?=1
    not ok 12 - receive: excluded hidden refs can be used with multiple pseudo-refs
    #
    #			git -c transfer.hideRefs=refs/ rev-list --exclude-hidden=$section --all --exclude-hidden=$section --all >out &&
    #			test_must_be_empty out
    #
    1..12

I haven't looked too deeply at what is going on here, but let's make
sure to resolve this before graduating the topic down (which I would
otherwise like to do in the next push-out, probably tomorrow or the next
day).

Thanks,
Taylor
