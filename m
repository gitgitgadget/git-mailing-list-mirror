Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C270C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263B26101E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGMQ6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMQ6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 12:58:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31458C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:55:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x16so10531383plg.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rCNIRkSlVHe6fqJE9Q3yFgldbDZSq7TmxDakvkdKE0Q=;
        b=XaDSuzulwb7epQgjA4rlQrE8XTQ7wo6MdOrQjgiXkwKacosotxEpVC4LUQ5htGmJEt
         90hxAntLy+1X/SSkQxOnyhMy/JvsZ3GNcwVujUFIVBsyOVK4lVBKfjGAgT9Bh8uJ4lIz
         dRhATbSmbIrN6RNUvHDixkZFQxbparx/UD+qUChQMa1V+K5hleRJv/EBydbkBDR96CDS
         uC2sC+iqj39dWrdXdNiMH8KPyxQX3mTvCL3UH5zfg8O1+BeaUPYtyQAuLGn9uFuKKfNe
         ltb9g4XHVgkLpfwPVVFYL4s+Sp+lk+Y/19/OH91gmDSuj9Shoj81AQhLJjZq6NSuc1UL
         m6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rCNIRkSlVHe6fqJE9Q3yFgldbDZSq7TmxDakvkdKE0Q=;
        b=lDjURz1PYBSYJzxFa4jLAF55rCqS97SAcX7Jxw37nh2XAohJZiTy82xGwynFod87xn
         YmdHctFVlAVctzEEytUwXu8/9NBJqLetI/UVCqGU4RE4mHfcFXvxmhinY2GperEsgifC
         +7HqNNGDPxnBGiw+8pTLE9c4a1F7VXThWNdNWZjDPfeQAxYjw+PPQECiDOoIu00ofmUV
         O7aLukUt+XZOB+QYwVwAN7YJVVI5YV2oGnzBx+A3T1976LwCVJyzvz8PiorR33ROpJZO
         UMufkrdqMkm+nwvNuxDTp2daZBFmzGZdJZ6Cez4VoVCCEdeAqNuQC1EF8jDDhSFDKYI6
         wmbw==
X-Gm-Message-State: AOAM5309lvSHYFpS9U807SlLPj3a0xZO+g8/Wv0RZXOvXNIrJPqjqQCo
        +QFUqUYQ+JotP5WxjHawBsU=
X-Google-Smtp-Source: ABdhPJwgakydkzCaq8ToVWPvr6e5SlDSSk3ay4TlqbT3bIz5l8L6GG5O1zVq0VZRXl5d8+txh20lBQ==
X-Received: by 2002:a17:902:aa49:b029:10d:22fa:13d4 with SMTP id c9-20020a170902aa49b029010d22fa13d4mr4128868plr.78.1626195324687;
        Tue, 13 Jul 2021 09:55:24 -0700 (PDT)
Received: from localhost ([2402:800:63b8:f6f9:3a91:18b:7264:dbcb])
        by smtp.gmail.com with ESMTPSA id gd20sm2829808pjb.33.2021.07.13.09.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:55:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 23:55:22 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
Message-ID: <YO3FelB47QrZwSa6@danh.dev>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-13 11:51:26+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Occasionally we receive reviews after patches were integrated, where
> `sparse` identified problems such as file-local variables or functions
> being declared as global.
> 
> By running `sparse` as part of our Continuous Integration, we can catch
> such things much earlier. Even better: developers who activated GitHub
> Actions on their forks can catch such issues before even sending their
> patches to the Git mailing list.
> 
> This addresses https://github.com/gitgitgadget/git/issues/345
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for doing this change.

Some minor nits below.

> diff --git a/.github/workflows/run-sparse.yml b/.github/workflows/run-sparse.yml
> new file mode 100644
> index 00000000000..25f6a6efb40
> --- /dev/null
> +++ b/.github/workflows/run-sparse.yml
> @@ -0,0 +1,22 @@
> +name: Run `sparse`

Markdown doesn't work with Workflow's name.
Please remove those backticks.

> +on: [push, pull_request]
> +
> +jobs:
> +  sparse:
> +    runs-on: ubuntu-20.04
> +    steps:
> +    - name: Download the `sparse` package
> +      uses: git-for-windows/get-azure-pipelines-artifact@v0
> +      with:
> +        repository: git/git
> +        definitionId: 10
> +        artifact: sparse-20.04
> +    - name: Install the `sparse` package
> +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
> +    - name: Install a couple of dependencies
> +      run: |
> +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
> +    - uses: actions/checkout@v2
> +    - name: make sparse
> +      run: make sparse
> \ No newline at end of file

The last step's name and run is the same. We can just drop name, it'll
use run as name. Anyway, remember the newline

Otherwise, look good to me.

-- 
Danh
