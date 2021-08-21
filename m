Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08947C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73F860E9B
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhHUKgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUKgG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 06:36:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F5C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 03:35:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i21so10901498pfd.8
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3LPQ18ZHHw+dz9sLLeoy08Zkjcbv71ZcY1TJ1wIv/Bg=;
        b=Mp1oPsQqeTk75Vy3Y3JwQiE6sKqXYpkoVANM0Cwe4XAZ3QO/Qd0NoL43JNcKFJ4RdL
         m1tTkIawIP7bUKwdtecDmKNPIGzqY+cfZb600XZUXxrawlonndlF6sAU+r2cd54o22yZ
         aDrTklwZWHQETlVDIHC8rAAmqOZ5ctdlENDBrFJ5PDPqcQ76Kbb0t3GM+id+fwP8SafZ
         lpPbEz7W6dih4ufYibQ0kw6MHAnT8Q6oju09H9pXnGfVDoN+ijxiNh4PPeCIO2kpsQh3
         Srw3z1h1nHRwR96RBUxW+krRPpufDv2/HMByB5t7ef0gdbXiHS5gRnT36GfmJglJ5Qa5
         LQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3LPQ18ZHHw+dz9sLLeoy08Zkjcbv71ZcY1TJ1wIv/Bg=;
        b=YitYNRWVDdRlODuGffMuqvfDfw9vuN4n9NXRU+lPz7QaSuwBQzMj89sbhQLQ6K0e+7
         4MhBMwyR9wvybYJNzFdNYsiCMEiABqsRxH/46isgcrSSU9QqaRq+OdS3eXjsWK6Ep1G7
         zJZsB+PH0hRyg2O+M5j8WjkTvNuzWNw/OJDivx5isSNndRZe3ULA606D5+yNgCf7zyJl
         xgyj6yztXXLgzH2U78LO7eUvbT1tzZqrCH5FlssBPILscmwj/9As0pVVm9ZFgpGZWbak
         xPeg9Mkp9GwRPmTb7jPqsJB6ZE+4787XxMnx5ck/AtE1h6zyTozm11qOhH9S9uo9yrZD
         /O9g==
X-Gm-Message-State: AOAM532EINDgvYMse2D4FrDt7GrgBvpIuIsgdR6kpSkHSBQFft5fRGm/
        cISNJFoNFN1ct+JnSeXp2Ys=
X-Google-Smtp-Source: ABdhPJzNrwHB47ZUeb1+Sbsn3T+f646t0Q3AxIzZ9w+8K3v9OB9pfhuypedYN9aORw6XIw7dirw72w==
X-Received: by 2002:aa7:8d0c:0:b029:3e0:2e32:3148 with SMTP id j12-20020aa78d0c0000b02903e02e323148mr24168746pfe.23.1629542126687;
        Sat, 21 Aug 2021 03:35:26 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id t20sm11458927pgb.16.2021.08.21.03.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 03:35:26 -0700 (PDT)
Date:   Sat, 21 Aug 2021 17:35:24 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
Message-ID: <YSDW3nsG2iWPGakF@danh.dev>
References: <20210820105052.30631-1-bagasdotme@gmail.com>
 <YR+Tp2AGeeKyRKoC@danh.dev>
 <70e609f5-bf40-658a-a021-ab7a0ad4baa1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70e609f5-bf40-658a-a021-ab7a0ad4baa1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-21 15:24:22+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 20/08/21 18.36, Đoàn Trần Công Danh wrote:
> > I believe it's better to write like this:
> > 
> > ----- 8< ------
> > ifdef INSTALL_STRIP
> > install: strip
> > endif
> > 
> > install: all
> > 	....
> > ---- >8-------
> > 
> > IOW, install depends on strip, not install invoke strip.
> 
> Oh, I missed that.
> 
> > I think it would work better for:
> > 
> > 	make install strip
> > 
> 
> Wouldn't it install unstripped binaries to the prefix then stripping them in
> the build directory?

No, with:

	install: strip

strip is one of install's dependencies, then strip will be executed
before install.

-- 
Danh
