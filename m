Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B1C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiI1XVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiI1XU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:20:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BC3F314
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:20:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s14so22070933wro.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=bmjPws3zZsnDiROshna/GQgwJz3/nmZRjqCYp0sEnOs=;
        b=o6sIA+D2epHLLEMtM1tiK5gUlD1GauzwLD98KP5rhzkWwnV9BYQBZNur/wD6iH3t+c
         0OfK6gWiNkatCBoX7Gk7JQRGNcA88QYO1hgjN6rLcvBDfOjKKHFH5gh63vaBeud4za9+
         mE60iGzTqvcg43QDIR3CgKeuSdRuj1quBNEX/mZLu6SkbXQ+etbG6FUVDe8GRZO7Pkno
         1PCGDjRajMdvVx1h8HfGQ+MCBIn4KFDrgUB26IQprM+JDb8GXP4VcL3IZ1Jnv9ZLG+y4
         3epGP3c19xYQBl7gcBJZXzyFcTg6xHktvgl8zvdiMkocwK6eYMl9XYKdUDT0NeInXGaD
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bmjPws3zZsnDiROshna/GQgwJz3/nmZRjqCYp0sEnOs=;
        b=bLwpcFgHy9nhj7Cf/4BJy9+RChdntNQrqeIMvPvzTcEosypwbB7WampS8zSgICmsK1
         hlVbgf76EQfsi75nRK77iWcQPYcbE7EhJEzEhGZ+2BtN+SUy1lMIXymsJqLP+4wTXHVS
         luwEmhUqxuchGcpoCJlIoLswvs+QDW264jaHyylnFabatimig+DSecHWPmzUD+J2VRPU
         zDTMvaesgQ3TXU55W+9KHS0/q98QoDlsuSddxsANT94U66vQAY26q3hJS4T9IsguG2AI
         gsPX9NRpFw8w4k6nEkHR+tNiDAoAXG/3ybZ7IRHKMxAGyzT6og1cHJXhvK+8V1pf2PqN
         hAyA==
X-Gm-Message-State: ACrzQf3D7Q5YtMQhjmRUt5axMANV/Bi+nCr1xATiaO2goIwl4deJQdSd
        VxPdYr5hrfTbc497dx7NRrA=
X-Google-Smtp-Source: AMsMyM6FXuS/YAXcKXIl3+FdDHk+6gawVl/Naia6UiCP5moA6FnQ3QmiDsf+C/2Po6CZAxalTBxzvg==
X-Received: by 2002:a5d:6609:0:b0:22a:3965:d5ad with SMTP id n9-20020a5d6609000000b0022a3965d5admr152409wru.62.1664407243308;
        Wed, 28 Sep 2022 16:20:43 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id m67-20020a1c2646000000b003a342933727sm2903742wmm.3.2022.09.28.16.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:20:42 -0700 (PDT)
Subject: Re: [PATCH] test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <7730c25c-5f10-b1a8-f1c3-cdeaa712ef05@gmail.com>
Date:   Thu, 29 Sep 2022 01:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-e31681731b7-20220928T095041Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/9/22 12:01, Ævar Arnfjörð Bjarmason wrote:
> Since 131b94a10a7 (test-lib.sh: Use GLIBC_TUNABLES instead of
> MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04) compiling with
> SANITIZE=leak has missed reporting some leaks. The old MALLOC_CHECK
> method used before glibc 2.34 seems to have been (mostly?) compatible
> with it, but after 131b94a10a7 e.g. running:
> 
> 	TEST_NO_MALLOC_CHECK=1 make SANITIZE=leak test T=t6437-submodule-merge.sh
> 
> Would report a leak in builtin/commit.c, but this would not:
> 
> 	TEST_NO_MALLOC_CHECK= make SANITIZE=leak test T=t6437-submodule-merge.sh
> 
> Since the interaction is clearly breaking the SANITIZE=leak mode,
> let's mark them as explicitly incompatible.
> 
> A related regression for SANITIZE=address was fixed in
> 067109a5e7d (tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK,
> 2022-04-09).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Junio: I think this is worth considering for v2.38.0. We've had this
> check since v2.36.0
> 
> But 2.34 just recently got migrated to Debian testing (just a few days
> ago), I suspect other distros are either upgrading to it now, or will
> soon: https://tracker.debian.org/pkg/glibc;
> 
> When I upgraded to it I discovered that all of our tests pass with
> SANITIZE=leak, i.e. unless TEST_NO_MALLOC_CHECK=1 is provided we
> completely disable the LeakSanitizer in favor of glibc.
> 
>  t/test-lib.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a65df2fd220..02f438d47ec 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -563,8 +563,10 @@ case $GIT_TEST_FSYNC in
>  esac
>  
>  # Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
> -# the test with valgrind and have not compiled with SANITIZE=address.
> +# the test with valgrind and have not compiled with conflict SANITIZE
> +# options.
>  if test -n "$valgrind" ||
> +   test -n "$SANITIZE_LEAK" ||
>     test -n "$SANITIZE_ADDRESS" ||
>     test -n "$TEST_NO_MALLOC_CHECK"
>  then
> 

Thank you! A quick test with this on master shows clearly the leak in ref-filter.c
we discussed recently.  No need to dig with valgrind.  I also found that other case
you pointed out, from checkout. I'll reroll with that if you don't mind.

It is nice to have this working.

Thanks.

Un saludo.
