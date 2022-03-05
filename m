Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18771C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiCEISr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 03:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCEISq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 03:18:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB813E0E
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 00:17:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y11so12984471eda.12
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GirgiguzgbNVInCymHcWyXChQ1f/QoqEancjX4plNAc=;
        b=dSvaMrEbZYGEi3S6Wc2xhZAzKK03FZkZIp0l+6DEc6PDPL7tuzSJaQaBNhK649ZrlT
         oGe5XsU8i7M8lnKTGkmd26W7LN5hsmZWt10RejjhkFYDle8trdhg6fZUKYCRmk3+WN2C
         JeQsNvB4ytTOqxV8rBx1pXf86w42WJodLMxk1tQSDDzZPvrWmSoiJ44ZwTMMaO1+g/Tj
         e8O0/TVr38KVOPg/VCzx709HXqwTJ6PdaWMV970zpcpqMeLlCrh4iAsoRMzFxr3B9OcY
         V8OZcYdkNq6oQR+q/KB73NI9fah0N2dlc9ZVJ6mkjWoKPHg5L5le8Cw334AA4iGXpUVv
         K8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GirgiguzgbNVInCymHcWyXChQ1f/QoqEancjX4plNAc=;
        b=sDSK9B01sPtIU1hfy3pxLBglsTvhqurWQ0OjdDhoBy249rSg0H9oNhEdxLhVWvZ687
         vAz7VvKMG+La4VA6WIui4ezMSzIK1Gp7nfTRGWKlPN9kHj0te1Q+B6FDAZ3lWDLmcbcc
         AbiDL1TxN0+1BpfrsB8OuG3bw+7w+dHcbUD3GzI7psfNbTi3aLaxcFlPSjQ5rsYW1Qjy
         6wHIzmNCyNSNQBqpZWFtq5QLW9/VUs6F9yfqBhXdJodziEKdet1KTBXgN0xiVNyoOnzu
         4Dh+t0z0MUQJmcChO9uI1PtyxldE1oyFlo9GQGxQXKRrvY5RNbf16+Nv32NXGBQZ6rn2
         BoRA==
X-Gm-Message-State: AOAM530l92oN0jlIRi4NMrukRZxn2z7eywH7vMt3X8nH2LoC9k5LEU6w
        rpvJi4tfqI+66rz0nLeQrOaZNT2NwJs=
X-Google-Smtp-Source: ABdhPJxZNjGX63IsssEKtUpMZRVhRpy+I6+VRkiY/FmRLWQi/GFoZh7YvdLbmXueh/AbsqGF7xxyrA==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id d25-20020a50fb19000000b00404eb5262cbmr2063854edq.363.1646468273739;
        Sat, 05 Mar 2022 00:17:53 -0800 (PST)
Received: from szeder.dev (62-165-236-91.pool.digikabel.hu. [62.165.236.91])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm2636728ejz.57.2022.03.05.00.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 00:17:52 -0800 (PST)
Date:   Sat, 5 Mar 2022 09:17:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 23/25] CI: stop over-setting the $CC variable
Message-ID: <20220305081746.GA1655@szeder.dev>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <patch-23.25-8a8b7ecf16b-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-23.25-8a8b7ecf16b-20220221T143936Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 03:46:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
> 2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
> to setting it in the environment was due to Travis CI clobbering $CC
> in the environment.

This is not what 2c8921db2b8 detailed; in fact 2c8921db2b8 detailed
the exact opposite.  Travis CI did not clobber $CC, it set $CC to what
we asked it to.  We started using $CC in $MAKEFLAGS as opposed to
setting it in the environment, because our Makefile _ignores_ $CC in
the environment.

