Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3DFC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1A206DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqyE68cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGILlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgGILlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:41:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8BC061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:41:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so755553qvb.11
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+vz1kaeFytmuyah6Yrj0fg4ff/5RbiucwmgCDNiM9Fg=;
        b=iqyE68cpSb4TNO5bXHWGXmoZDgQY/HmSne6b83n8GJGoYcYlVZzGGCKVCH4Ps15i3R
         4DgEsS0Gq3MARZzoESgxsBBXL+xI1wMIPLtn+5Ir8AN15eV8VGULeY1UFQJhZ1saDoVA
         7SbNoOEpVFU6Pzn4/v/fx5Om7TUJuF0BffTnkFU3bFc2Vb7J13U5ADLDTWt2Z9Cgbg/4
         Xbq+E/FhW0TE+jQMdEPqQPkG0zhFOp7yFuc5FgW6bxiImjMAgABnTmzrIpBCjnq92FV9
         INsGtHii8iZ64Bxmta1IohplTNXFwQoqIR0IeGiZ2jOdx9ATHG9zmrNZ2/Zh0kArpva2
         nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vz1kaeFytmuyah6Yrj0fg4ff/5RbiucwmgCDNiM9Fg=;
        b=oFQWuVZZXBLGXiAd7pKjKU5VUK1OGGHpfRgRuvdHiAkWkK7vHwiC8X4yDwy0hWoVxW
         6RtEiEvJcZNzN8T9Nw/SDvp02BPFmXolsedjVxHKd4Lh4pqTv0Dp1ZKK4t9y83mhHE01
         KYkovuZXM3fx/rQ9q/zvghEnlE4lmUnxfibUPS5cgk9HaTsnO5+i+lQQTPmrI7Afsx3o
         FbO+eUQ3x0B6Raiac8gUo/CcUnxmnZwtRq1MmdJ0p8oV83BbpNIxgk+/kdzQudcjv6Ep
         T1tByj6UNtrYKV1wnL+3ZuPwIFzvz6peoQiQUACY3NIDnXus9x46IFsKsOACDI5e0O31
         xSoA==
X-Gm-Message-State: AOAM532XjUTJzUpxGEptRmWxeukLwnO1Wy6++ZNgQ0ctLcuXiL/O8Kb0
        On3w2BWbCLU388PzJyuqsWe4l+FmIrU=
X-Google-Smtp-Source: ABdhPJzjgJzs+HJR6e9UCFPlxy+uKpdgt9pocu7Un0Sjgt2NaytayVonCiGPwryu5AsTbvEN2V5TXg==
X-Received: by 2002:ad4:424a:: with SMTP id l10mr16414795qvq.29.1594294890936;
        Thu, 09 Jul 2020 04:41:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r2sm3176610qtn.27.2020.07.09.04.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:41:30 -0700 (PDT)
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <882592a4-ffb7-924c-b52a-3287b11318b8@gmail.com>
Date:   Thu, 9 Jul 2020 07:41:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 10:10 PM, Matheus Tavares wrote:
> In 11179eb311 ("entry.c: check if file exists after checkout",
> 2017-10-05) we started checking the result of the lstat() call done
> after writing a file, to avoid writing garbage to the corresponding
> cache entry. However, the code skips calling lstat() if it's possible
> to use fstat() when it still has the file descriptor open. And when
> calling fstat() we don't do the same error checking. To fix that, let
> the callers of fstat_output() know when fstat() fails. In this case,
> write_entry() will try to use lstat() and properly report an error if
> that fails as well.

Looking at this for the first time, I was confused because 11179eb311
doesn't touch these lines. But that's the point: it should have.

Thanks for finding this! I wonder if there is a way to expose this
behavior in a test... it definitely seems like this is only something
that happens if there is a failure in the filesystem, so I'm not sure
such a thing is possible.

It would just be nice to know the ramifications of this change in
behavior, keeping in mind that this behavior started way back in
e4c7292353 (write_entry(): use fstat() instead of lstat() when file is
open, 2009-02-09), over 11 years ago!

Thanks,
-Stolee

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  entry.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 00b4903366..449bd32dee 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -113,8 +113,7 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
>  	/* use fstat() only when path == ce->name */
>  	if (fstat_is_reliable() &&
>  	    state->refresh_cache && !state->base_dir_len) {
> -		fstat(fd, st);
> -		return 1;
> +		return !fstat(fd, st);
>  	}
>  	return 0;
>  }
> 

