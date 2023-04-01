Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677F7C761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjDAABC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjDAAAy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:00:54 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C81991
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:00:53 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5456249756bso444556097b3.5
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680307253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+KK62M3nR5DwXd9cHBI7Jm9JWXnyT5A4Ghk1t791wE=;
        b=JLKngwgh7epzUd0Sp7epL6Fm74/kR6LXUtGDyfDHpHxmodA5SwLJjfKfP9kJdeUGWF
         PO80Z+FiaOcYsCdaWj+NbY4yVEyqw8OMskUdbHkP1qZNOTrCx7iXIuK5eOUAw0di9EMI
         2UwxB/VR8yUFkxQRIvml9CcrCF+cBN+xKIY5nPN6D5RUfzeJHtOWEQr6C+Xll5Q/ThR8
         cI/Cd3oBc3Q2Nz0Z6PZ/aRpFWNWKNwppQOFvPF3iabWTqgNpHvmB/2kHJd9PjdvSW2/h
         54pHeM3Cmj5DK/TYuM+hvunRotPmN8eI+sZpGU8WhS2TR+eN7oR+nNvXWNNjg+jqlyiE
         SVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680307253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+KK62M3nR5DwXd9cHBI7Jm9JWXnyT5A4Ghk1t791wE=;
        b=hbecJKBy6sDmk3KULqITH+RSx9059A5CvhbZDwKC53MXUG9rEUHEwvVOrNRzB7zHrI
         AVvswWAZMbvuqnLFO85NWmhQwk3SocPOuAOVa4QTX2r/aRcJ4R2ztVVOhmqGPRuFoiik
         d/HJbwa+QST4dDn0g6CqH88U4JZ3khflmxvcIBT1c5hJ1IplZixGh9vvVE1hEwar147w
         Mkf+Hhl+lf+516mZy68Rrk6UInTTMIkKMcpudTbbuyUscwakymmiMPLp9vXM1D8PARrG
         txS7dMzqLImmB1xo3cPjtpYhm/yEiOzBq8Efb8sg1fiTK2Ux4MSDPo4tZ3nrSnUjly6W
         jjXg==
X-Gm-Message-State: AAQBX9fidKeniZEEq0mE/f7EzXgvO4FabjgOGw5hOuF/v5FT4ky3kSmT
        QRtxSMP0HAwIqN2EmcOWHPNXqw==
X-Google-Smtp-Source: AKy350Z89I11ZEu032sdp0tihPioz/cmDYEsRRQvsD3kOGwkwl/c4JLqzSArQYHN+kmFiRYGtM/LlQ==
X-Received: by 2002:a0d:d242:0:b0:533:9c8d:81d1 with SMTP id u63-20020a0dd242000000b005339c8d81d1mr24544055ywd.3.1680307253101;
        Fri, 31 Mar 2023 17:00:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y135-20020a81a18d000000b00545a08184f0sm836357ywg.128.2023.03.31.17.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 17:00:52 -0700 (PDT)
Date:   Fri, 31 Mar 2023 20:00:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
Message-ID: <ZCd0MyieHOZDQeVM@nand.local>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
 <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
 <xmqqa5zu4ka3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5zu4ka3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 03:15:48AM -0700, Junio C Hamano wrote:
> > In truth all the patches regarding shell portability have been along
> > the lines of: "this code makes $x shell work, doesn't break other
> > shells, and isn't against POSIX". In some cases even when the Austin
> > group disagreed on what POSIX actually said, we did whatever worked in
> > most shells.
>
> One aspect that is missing in the above is the extra burden on our
> developers.

Well said.

Having to remember that we need to write "$ARGZERO" instead of "$0" is
yet another burden to place on developers who want to make changes to
the test suite.

Is that a big deal? Probably not. But it's a slippery slope, and a weird
gotcha to remember when dealing with our otherwise POSIX-y test suite.

So I'm not convinced that it's a worthwhile price to pay for zsh support
in our test suite.

Thanks,
Taylor
