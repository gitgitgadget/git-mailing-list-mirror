Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90FC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BD460F4C
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhHBROo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBROm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:14:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6EC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:14:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b7so25499691edu.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6fvO3zgKVPeLyZ8tX07ZrBxGVhllHwYiZntwZXOyZCM=;
        b=lRZdEdOChn/XLyqyaKf0Aip60PRrp5RKrRuVCPQDABdfzcnh8S1ZgqmNtsX0NPh2UD
         4jiB1/4QOZc/nQyMpEzkH5eWunbKrP8OGXEj07vXRkB6Wj7rmEnakViNsjgdGBFWatQ9
         CfQyh9araO08s81UoAnYlQDTaEi0pguBP0KctLWtsjI1yEv0bO0mqvWaBTwBrD7ik9ld
         iZ2omhAahm4htTY6mskhra42aWfkjzkGo0h/wy9deCAvYVTvM5S5bmAZmg/iE0K8oJTP
         OQZlkCJs0FlYiXtIAdz2kEM1PnZgFAftUJjv8e81EpRHaFTjIpy7xOcTPDs6Pp7klpfx
         3dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6fvO3zgKVPeLyZ8tX07ZrBxGVhllHwYiZntwZXOyZCM=;
        b=fxPly2x0f+atZeo3apFyuNIdqNHB/S/4stNd58PyWY955ZxN4bq8f34sT+y28KAiAI
         CgoqcLXnNi9NPMqlNFqlU/58ud7pOzX/uBmhXTZnE4LyqzjZ3Dg7/1Ierxkm2P3eF7aA
         gtvX+RLW2PmrT/Y2Shc1uNl59lFPgPhYcv5qUHYWd8xULy14Ja6nikMvQL8fIcUZcGWL
         rR2y9sCVMeqSbJtXhvpYg3vyVqbyi+9Lu/af89jyITDzAOVWLsJI8bHbCa7MDVbqCQTz
         loAxuaY8nb7frcSVP+7HvA4W3pZKgTlM+CBCysgZU9elLvLyGOEwpfcGsdW8qhkxIYhl
         hO7w==
X-Gm-Message-State: AOAM531nbMlefoxsBxtNK3mMnlY+GEKOfBoyIN+jeUB0rDNWCvzPGcWK
        2mkTtsXBr92z7jsxfe30fAHchuyOyA4=
X-Google-Smtp-Source: ABdhPJxdlLHsn7cPY03kfXDYnCbJ3LIHzNSaZ2+iTGntN3BOsdrJXXEUlOp/OJtJi6yk6fOhigRi8g==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr20485788eds.156.1627924470738;
        Mon, 02 Aug 2021 10:14:30 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id dg20sm6356363edb.13.2021.08.02.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:14:30 -0700 (PDT)
Date:   Mon, 2 Aug 2021 19:14:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH v2 2/3] test-lib-functions.sh: add a test_with_columns
 function
Message-ID: <20210802171429.GC23408@szeder.dev>
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
 <patch-v2-2.3-36c57178c55-20210802T134610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.3-36c57178c55-20210802T134610Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 03:46:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Add a helper function to wrap patterns of "COLUMNS=N <command>" as
> "test_with_columns N <command>". This will be used and extended in the
> next commit.


> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 37da7d9a99a..536339faaa2 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1718,3 +1718,11 @@ test_region () {
>  test_readlink () {
>  	perl -le 'print readlink($_) for @ARGV' "$@"
>  }
> +
> +# Test a with a given number of COLUMNS in the environment.
> +test_with_columns () {
> +	local columns=$1
> +	shift
> +
> +	COLUMNS=$columns "$@"
> +}

This function needs some redirections to separate the tested command's
standard error from the function's '-x' trace, see a5bf824f3b (t:
prevent '-x' tracing from interfering with test helpers' stderr,
2018-02-25).

