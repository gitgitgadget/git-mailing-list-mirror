Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB1C74A5B
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 03:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjC3DQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjC3DP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 23:15:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D359E8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 20:15:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o11so16871383ple.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680146149;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JvVneyypMLTSv8l4MoNyPcLO0WLpaZsdPau/lHBOAQ0=;
        b=Dqhea4rEz1YySmokvC4oHFRkQsSVK3hNGQzhazfvIkDrgh5y3Fp35PeD1oll9Kb+jO
         TJUrjHxxZE6qw8sP4cLwp06CstRRmwzUfsq844GzUTviKKRd3dTaUGEPw1l13udIpM4d
         WcHMe5BEfzbR3ZGqFMMdf095WK1sDlvdlWMdmsDXNU89HHd38UQBON0kBk65ZRIEhAcF
         hKerQl4UISX+AJ1+LU1v5Y+nRluDT1JND8DAbwpc7kCUITYMFQN7eqsB5nTn/aS8Iwui
         0usRVn2GVatJ2vauQfZAabkVCcfxaHlSIlZkCGKZGqdmWjs/aQiZnSnXA8RZ7FeE/p4h
         Y7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680146149;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvVneyypMLTSv8l4MoNyPcLO0WLpaZsdPau/lHBOAQ0=;
        b=rm9PsGaEdUtbA+u0uUUpZGQYlKzehzV+6/M0tVLZYEGWTGpOIHuMu0tM3Rp+R2YIRx
         XPi2aP2MrEVQf6l8/Ig1iIMnDljbsEwMB5dYfp3R3hMGI9LvpQpP2fjHrcnwluOUoQYd
         cmrS95Gdt9XBldRbFBdddfwNqzT0UXw+BMi01dM7Yx/sDLaUNfowjmdnjF1cd92YA7kF
         90wGXYdR0fnJ37dwLbf09Ohhavvs1Twv6Vgrxgnd8PHqJZIqnsQ0qGziR7oCZMgB4ic+
         xXNVXGbRc2uT8HrpC2yWNUR0Qh4Ku9LL4W2JYF+pHwA67WOp4FfWPGO7ZZ97vqKh6+/R
         HO9w==
X-Gm-Message-State: AAQBX9cg5+g2WmhkJRD43zIy/S6zazhE2gz9GXEDLlFLzkzC+SdgM9vw
        bC4oP+TvCUdFTDUy45lJyms=
X-Google-Smtp-Source: AKy350bCb0aKnB8lhq5pq5wqX4StBqhU85PXutSbGZbJAg/u27CIAqZRM/JUbNbqt02diLmUiQSzJg==
X-Received: by 2002:a17:903:2347:b0:1a0:50bd:31c0 with SMTP id c7-20020a170903234700b001a050bd31c0mr27204467plh.24.1680146148726;
        Wed, 29 Mar 2023 20:15:48 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902848c00b00198f256a192sm23642624plo.171.2023.03.29.20.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:15:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
        <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
        <xmqqh6u3d119.fsf@gitster.g>
        <ZCS4SXlkqnvjxidA@tapette.crustytoothpaste.net>
Date:   Wed, 29 Mar 2023 20:15:48 -0700
Message-ID: <xmqqjzyz3p5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> While these patches may make it "work" with zsh in its native mode,
>> because zsh that is running in its native mode is sufficiently
>> distant from the more POSIXy portable variants of Bourne shells like
>> dash and bash, I find it hard to justify the cost of maintaining the
>> resulting codebase to "work" that way.
>
> I think that's a fine position to take.  We have found some fun bugs in
> our testsuite via zsh's sh mode, and zsh (in sh mode) is a valid shell
> according to Debian's /bin/sh rules, so I think it's fair to address
> shell fixes for it in sh mode where we can, even though it sounds like
> we'd prefer to skip the zsh mode.

Yeah, as long as the sh mode is sufficiently compatible, I would be
happy to see the shell supported as one of the /bin/sh we can use,
and I agree that it is fair to address shell portability fixes for
zsh running in the sh compatible mode.

If the native mode didn't impose too much burden on our developers'
to maintain, it would have been nicer, but judging from the contents
of these patches, I am afraid that it falls on the other side of the
line.

Thanks.
