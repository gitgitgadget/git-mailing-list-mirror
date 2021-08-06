Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4996C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B123961186
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbhHFNnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHFNnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 09:43:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEFDC06179C
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 06:42:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso17770355pjf.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=BG87wtEzkJpt9sRVV3LuAt5gOsngVPyJgBr7j/fJKfo=;
        b=fENn8BH9He3clIQzJa6UeLmtceG2wlzakGV976sziZxRjw35kYVv4XktkOlgCPKUE4
         lf9drYAk+B1wH9mw+/LwepXuW/jTqpyXKoeL0kyMBaXt8JpKnw6ge4oFKGl1tbCcbzBE
         D67cm5LX/9vx4/gpMZUvQ7rP32g6TesEVUhagTRbU6fd466KJnuYJh2qxNrRVyymU4rQ
         PLcAbEk3EHX/TdCRjMd6A63At9KgeEciMVt9BYPR/rea+xBLcn0BV7VlzdeJ+O/SecGQ
         U1kb5h+MsfRxeWZgCM5q6ZZkbwQWaeCn/KoQej5AwPS82sl4iUJtLd0c1IRctfeF5Ijy
         panw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=BG87wtEzkJpt9sRVV3LuAt5gOsngVPyJgBr7j/fJKfo=;
        b=qdbq5jDbE+mv+g3nLu0UKfguByFGGZCQ12Ifiog/Mf30bZqhBuD8nVWPohhioicMwz
         QH5toe3eMF/b7TWR+1Io+Vcf0/spdmDQyo/S34uSBOKA2Y4Ykfrr49t3rpx4jptUntA8
         ZG1vfrv+BPzrfyx8DXVfec1qpBvyiTgHBby/RAPHYxZTt0gqwbAqJ1TmKk47KsT1FpRT
         QxjvpzS5MMJIfIHosFJK8sSxxMPM5AmMopjHWkld9aMOVfUY+PISNxMaaQ/JLhEKe6b4
         yuStXnFQ7FiwxinSqWK+Rng2R20gicCbGJdpLD/faLGwzJEqUiJyTww4M1CEHQZgFC0m
         ab6g==
X-Gm-Message-State: AOAM531fL9GgvXoqYAEO2NXCCPwlxViFYAWWBTXy2KxKhW//pvpv+mkT
        +pHozBPxdIJelmVjvzlDbiA=
X-Google-Smtp-Source: ABdhPJzkU/aGTIZUKwg8wcOCwIqXzEMT6MIIMckkUS+l72g2XeeWXpm7z+AS/7IZEAWOwGIkWh3FUw==
X-Received: by 2002:a62:e211:0:b029:3c7:ed35:7463 with SMTP id a17-20020a62e2110000b02903c7ed357463mr3632179pfi.14.1628257368299;
        Fri, 06 Aug 2021 06:42:48 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id y6sm9251091pjr.48.2021.08.06.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 06:42:47 -0700 (PDT)
References: <20210806080634.11869-1-carenas@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
In-reply-to: <20210806080634.11869-1-carenas@gmail.com>
Message-ID: <m2sfzmu1t7.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 19:12:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> 1da1580e4c (Makefile: detect compiler and enable more warnings in
> DEVELOPER=3D1, 2018-04-14) uses the output of the compiler banner to
> detect the compiler family.
>
> Apple had since changed the wording used to refer to its compiler
> as clang instead of LLVM as shown by:
>
>   $ cc --version
>   Apple clang version 12.0.5 (clang-1205.0.22.9)
>   Target: x86_64-apple-darwin20.6.0
>   Thread model: posix
>   InstalledDir: /Library/Developer/CommandLineTools/usr/bin
>
> so update the script to match, and allow DEVELOPER=3D1 to work as
> expected again in macOS.

Thanks for submitting this enhancement!

For those of us using Homebrew and using the LLVM installation from
there, we get:

$ cc --version
Homebrew clang version 12.0.1
Target: arm64-apple-darwin20.5.0
Thread model: posix
InstalledDir: /opt/homebrew/opt/llvm/bin

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  detect-compiler | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/detect-compiler b/detect-compiler
> index 70b754481c..c85be83c64 100755
> --- a/detect-compiler
> +++ b/detect-compiler
> @@ -44,7 +44,7 @@ clang)
>  "FreeBSD clang")
>  	print_flags clang
>  	;;
> -"Apple LLVM")
> +"Apple LLVM"|"Apple clang")
>  	print_flags clang
>  	;;
>  *)

So maybe we could add another case for "Homebrew clang"?

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
