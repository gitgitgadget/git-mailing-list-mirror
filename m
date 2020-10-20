Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E02C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA432225C
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MzPEOmRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410337AbgJTWGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410333AbgJTWGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:06:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C8C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:06:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w9so64665qvj.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VHG3v8nZgVf7w0HEb9X9r8TFEUjgDSQ5fGOUQ+bT820=;
        b=MzPEOmRB1XLDYtUUgTJtW31thQF6WsZ4b0JrIMguYpq64/4+TN6YE1YEiYx4WMyza/
         bLNgukiWvp7o7qerkjGWE9aj7JZPYbVwnHB/W0gxwK4qyS9S1lRsx4xpGd1Z+u+uvx9D
         q8E1/KVa/97Y1H/ccfh5W6603R9vZy1a8UUlGb1zGpUSh0tToAEVfcmoAG6X7yMOmbqf
         3t48XP8cfGNF6Zvp5wrLGqqZ2MVgVPECpBh7IHlvPPc14lLyaOgLkyXgLIV3uzP/FcvD
         IxthjC5BzkXHvTTjmjpZE9w9kFZiplHMShKjaUwK8g93sRKzu34eEfsO2Ptx8ZwuBR0c
         arNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHG3v8nZgVf7w0HEb9X9r8TFEUjgDSQ5fGOUQ+bT820=;
        b=om/RctMbfRLq6hRSBwaezWVy+954PtbTvKTTn1EIpfkaADkGmXtHdRl959mD5lwJ8m
         bVT8tbLDu7WmL9U+0hyRyVdBzaDPxRc/SmuwLHNmkePFnzjsFqI0fwAFo0pIVgrOVu2H
         ouWJBR7W4UMh1gj+bmoDDN6XU5C1BBZwW1SU3Qa/wJDYDS9iMv+6qUMQZzJiY/P7AvKd
         w8bxRsiULjBSjcK5u3XRmrRV7TDXsI1FBEVxPP9pOnb5aKy9kRKOHtIXJoNo3+UVpAXW
         b65LyeJZYg2zigSvrs4nGAhWTSX4OlTmcLEtJSvT4XjOVAEftTLsMtpWWZfclB9VTPjh
         HUwQ==
X-Gm-Message-State: AOAM532OfxjWqhrRkz7LC5K/N/WfEb9fEORaDjVTNQs4/YMipoKIfzlj
        tYIjO6pqAzKNcz2LF/n4acp6sg==
X-Google-Smtp-Source: ABdhPJxPSS2QSPezNDs/MfEKfsBhk2pPNLfdP95BmImzYZ+zmD1mNyH0N6Wb6KBCmSGQ8ezQnLG5Kg==
X-Received: by 2002:ad4:4249:: with SMTP id l9mr5637930qvq.52.1603231592275;
        Tue, 20 Oct 2020 15:06:32 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id w6sm191158qkb.6.2020.10.20.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:06:31 -0700 (PDT)
Date:   Tue, 20 Oct 2020 18:06:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 5/7] perf lint: add make test-lint to perf tests
Message-ID: <20201020220629.GF75186@nand.local>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
 <b534cd137a833de802d6d95c1affb8d2d8f7de85.1603201265.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b534cd137a833de802d6d95c1affb8d2d8f7de85.1603201265.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 01:41:02PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> diff --git a/t/perf/Makefile b/t/perf/Makefile
> index 8c47155a7c..fcb0e8865e 100644
> --- a/t/perf/Makefile
> +++ b/t/perf/Makefile
> @@ -1,7 +1,7 @@
>  -include ../../config.mak
>  export GIT_TEST_OPTIONS
>
> -all: perf
> +all: test-lint perf
>
>  perf: pre-clean
>  	./run
> @@ -12,4 +12,7 @@ pre-clean:
>  clean:
>  	rm -rf build "trash directory".* test-results
>
> +test-lint:
> +	$(MAKE) -C .. test-lint
> +

Great; it sounds like adding a complete definition here was too much
effort to be worth it, but that adding a '$(MAKE) -C ..' is just right.
We can still run 'make test-lint' from within 't/perf', but there isn't
a bunch of clutter in this series to make that happen. Thanks.

>  .PHONY: all perf pre-clean clean
> diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
> index d202aaed06..7a0bb29448 100755
> --- a/t/perf/p3400-rebase.sh
> +++ b/t/perf/p3400-rebase.sh
> @@ -9,16 +9,16 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
>  	git checkout -f -B base &&
>  	git checkout -B to-rebase &&
>  	git checkout -B upstream &&
> -	for i in $(seq 100)
> +	for i in $(test_seq 100)
>  	do
>  		# simulate huge diffs
>  		echo change$i >unrelated-file$i &&
> -		seq 1000 >>unrelated-file$i &&
> +		test_seq 1000 >>unrelated-file$i &&
>  		git add unrelated-file$i &&
>  		test_tick &&
>  		git commit -m commit$i unrelated-file$i &&
>  		echo change$i >unrelated-file$i &&
> -		seq 1000 | tac >>unrelated-file$i &&
> +		test_seq 1000 | tac >>unrelated-file$i &&

The rest of this all looks good, but I think adding 'tac' here is still
wrong; this isn't available everywhere, so we would want to find an
alternative before going further. Is there a reason that you couldn't
use a different 'N' in 'test_seq N' here?

Thanks,
Taylor
