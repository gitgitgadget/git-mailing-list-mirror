Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A55C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1101A610A1
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhEFQJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhEFQJH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:09:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BDAC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:08:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m124so5002999pgm.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MAB8exAAJ1Gb/cb2KtcSN6Hhsenfjno/y9vUnbG2iQI=;
        b=oXdNJzRrrksPE9xXI5dWcMgEADDCjL7VYh0qNv9U+n8RUxxJrB/UqZcSO5kQPpqvRw
         usK5NU8f4weh9Q2Wr4H3PzsfVaEclq4iKTRNP7J7KcNxlQRgLqe6TvU/os8Wj7IVMNgb
         TjsqHOxIWq35drUurl7rbXgSBeIShbn3XnYQ/LmLSr1NnH11NTiTcX8BUNZOw70hPFlY
         UqBmHkKZEptDBs3bezIVDq/wb/81Zw5X9bTqwlTnhWxIyQqL66ml7HCbGmaETuGkMk3A
         wZpSMZsqKNDQmf+DH8bfGZHfG1ia2tmjlwIFbYp6bV6Y4rPvm2BrSW772domvxk4rLy6
         phlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MAB8exAAJ1Gb/cb2KtcSN6Hhsenfjno/y9vUnbG2iQI=;
        b=X5Reg8LwoLWXWVaJlxJwXWM1CkrEUyiVxA+IvyyIUVmDmyxVutIPldFA4zBn27j3xq
         6U8tEfZhDb1JBoR7QW4aCmnVvUJRnC4HIQwGbcOsKOvBRAdvv7ODqfy+4IPcIzpTOSZB
         z4n4tuyvx0p/5rBYuxXHLCjV7mOrdmEMqbykrTyh/lkXbiOrm3dQtmBga15tC6hTrxev
         PLOOtxr9h7w2Vz+80t2SNa6VMUy+bcyXDw3SxPC+sY96HFu/3YKob2MqaURYb5omlDEZ
         IbFcuzpFNy3PoqW6UbKfArGALwDICG+NrPl9bJ7n6wpzUy9bq1Cdgt3QWDVsE5QmLIWO
         9puA==
X-Gm-Message-State: AOAM531K8mHSsOqkzrfKMhP9hC5mlDXTJv7gQQ002oF0Pa4TOa8sJPYE
        RhmfRrBH1ayvvws7e6lsEOg=
X-Google-Smtp-Source: ABdhPJy8eWTL/2TBg7zfkZrhMh1Oyz3OMKf/W+miYLNLKVz4rlT6qLVNGk+GGaB3FU1ul7bNEG1EWA==
X-Received: by 2002:a62:31c4:0:b029:28d:1ad0:340c with SMTP id x187-20020a6231c40000b029028d1ad0340cmr5357857pfx.35.1620317287739;
        Thu, 06 May 2021 09:08:07 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id s21sm2357069pjn.29.2021.05.06.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:08:07 -0700 (PDT)
Date:   Thu, 6 May 2021 23:08:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 07/11] test-lib functions: add --printf option to
 test_commit
Message-ID: <YJQUZfbJXuWm+7Yf@danh.dev>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <patch-07.11-a0fe0640148-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-07.11-a0fe0640148-20210423T072006Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-23 09:21:11+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 827c8502b10..701518f5fd3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -173,6 +173,10 @@ debug () {
>  #	Do not call test_tick before making a commit
>  #   --append
>  #	Use ">>" instead of ">" when writing "<contents>" to "<file>"
> +#   --printf
> +#       Use "printf" instead of "echo" when writing "<contents>" to
> +#       "<file>". You will need to provide your own trailing "\n". You
> +#       can only supply the FORMAT for the printf(1), not its ARGUMENT(s).

This is the second appearance of "You" in this file, and it's the
first in the usage of test_commit
Perhaps:

	Trailing "\n" won't be added automatically. This option
	supports nothing but the FORMAT of printf(1),
	not even its ARGUMENT(s).

Or something along the line.

>  #   --signoff
>  #	Invoke "git commit" with --signoff
>  #   --author <author>

-- 
Danh
