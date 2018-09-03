Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0481F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeIDEFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 00:05:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36834 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeIDEFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 00:05:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id 93-v6so1285911qks.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 16:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ia6sfuMx+PvHg32Se4jDYYpTmItqQx8mGfOfGYukao=;
        b=jXCuUncB+jFYdcpee6bQHx1wt5bfoaTcbiQ2kOGY8d0M0WwBlobP8Z3Rd+hALf5SZE
         mbEwTJr/egJ5Q0UF/J1YfBAx9CP8aqgmmmTs0+x9kubDG18t+RO+oG1kBzYr8HB7JvPt
         7yuaA+WcN5M4MaTX+s0LoaOz2PJlTAkFoMW56nTIMh/SoiMCVlKsovLuU3OmdQRPzMzY
         STrVPq+qNIMgYDbjcoxSCDlsfqpoC/YdgaW4rWTaE21dvtgc8DYEn2znowTXbAYHV9Nt
         YADG0RXoFSM5zVpuNFYKfIC/FQO8O7F0qbNMlKGLJlgCv7kyU7Yna7g4g3aBZTICI2vS
         pXxA==
X-Gm-Message-State: APzg51Bg4nKpwlF9Ez/yApufuKNM/pXurNDIfM4Ot0L+HmQJwmwArO+x
        HcRjgnbUEYQTYM+l4IsdNnB+lpU8zWoKaCh1e5Y=
X-Google-Smtp-Source: ANB0VdYM5L8auaEQd36U5QC6yKjLun7cPeULSp0NhVxbBoNKTKfqZtdKJsmgYqRQ32PjrfdQ0r64xMCF1BhFUSp5Wsg=
X-Received: by 2002:a37:49cf:: with SMTP id w198-v6mr16152006qka.307.1536018207160;
 Mon, 03 Sep 2018 16:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Sep 2018 19:43:15 -0400
Message-ID: <CAPig+cTYwnEt3_EoMZq7U265nEDRJc5uCtJbuVeBNTxqvWSPww@mail.gmail.com>
Subject: Re: [PATCH 2/9] ci/lib.sh: encapsulate Travis-specific things
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The upcoming patches will allow building git.git via VSTS CI, where
> variable names and URLs look a bit different than in Travis CI.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> @@ -28,7 +28,8 @@ osx-clang|osx-gcc)
>         # Uncomment this if you want to run perf tests:
>         # brew install gnu-time
> -       brew install git-lfs gettext
> +       test -z "$BREW_INSTALL_PACKAGES" ||
> +       eval brew install $BREW_INSTALL_PACKAGES

This 'eval' is unnecessary, isn't it?

    brew install $BREW_INSTALL_PACKAGES

should give the same result.

>         brew link --force gettext
>         brew install caskroom/cask/perforce
> diff --git a/ci/lib.sh b/ci/lib.sh
> @@ -1,5 +1,26 @@
> +       BREW_INSTALL_PACKAGES="git-lfs gettext"
