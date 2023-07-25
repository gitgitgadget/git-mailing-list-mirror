Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DFDEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGYXIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGYXIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:08:00 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75301DB
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:07:59 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5700b15c12fso72192527b3.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690326478; x=1690931278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBhFWXlZ4qHuyGdkRC6Mz9L8PysCFczELzP4usJs5tw=;
        b=eFtJuVlccf6exzDs5y/vSmWFEnBpB7RlGAW2PR7qKUXdO3azxhhr7fn24K27vbczT5
         9CuHrCMUqcotbJwEK8aCR4xka1kVTbDXCgpq6rebU11Ncb4ho55DdosNYZt8T+Sm7GGq
         3AizmygxiA0/bDku5qHhSQd2uDkWwf1VCqlKQEAveXGIrsH7eHe81t4kEQEkVlyPCiS0
         0/AIF8C/SmSch1K/jt8Xudc1+6lxdbvwpI6YR4ARojzHYlADIdwBs4W4wwc4un/NtzGV
         Jqlx8lqK51rscFzcr9ktBEluSIYKDvfOpbEUZe876HgQcLYcp4qaudtvdYV2LWdFYvIk
         i5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326478; x=1690931278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBhFWXlZ4qHuyGdkRC6Mz9L8PysCFczELzP4usJs5tw=;
        b=O9p0wWNvJOa89amsKXrVxj57V3mPTmlr9kvfHO7WIv5cZhy/lVHFeqgceF/RJHPuOm
         4h4QK3kQttyLeGA5sbjU5sme+ptvCHLXyZGcl1Cc+d0FiwdrmCISWvEAhVCoBLLeQGNg
         oXwGd4u6lShZ656dllOnCHAMBzan5QXsCpPmBAowxNNMHvVlZWQbHLlW2LGMHqMBh18s
         TXzfrqdCeUFgqjxyvtdPS9OkzxUF4/nNPc0PRu3TPW3WMBqeks2OeFcTwBsVKlOlG0ev
         Pj96BdBrezOX4D2aCVzE5ZPGktFlw1cp9t1i8jdH5vQ8/itgnyUXNHDKdLmMjajkNzRt
         ZDrQ==
X-Gm-Message-State: ABy/qLaBUKQRXAXhSumPvKFgoaSdkwRq0Xcbn7Sd/h7xi9VtStjC1MIT
        8ijWae76OT1r0O7KCdXzhA3UbA==
X-Google-Smtp-Source: APBJJlGWzG+7z6Wns8J2MKf9vgQlb8QXrg+E3xgoO85x+esq2rlDGb/wq3nnEh1s7Xyjb/iGwJWoIA==
X-Received: by 2002:a0d:d455:0:b0:57a:4719:859e with SMTP id w82-20020a0dd455000000b0057a4719859emr461672ywd.50.1690326478588;
        Tue, 25 Jul 2023 16:07:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x76-20020a0dd54f000000b00583fdbfa001sm1455507ywd.98.2023.07.25.16.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:07:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:07:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 6/8] gc: add `gc.repackFilter` config option
Message-ID: <ZMBVzWoFQCUCSTwE@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-7-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-7-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:07AM +0200, Christian Couder wrote:
> A previous commit has implemented `git repack --filter=<filter-spec>` to
> allow users to filter out some objects from the main pack and move them
> into a new different pack.
>
> Users might want to perform such a cleanup regularly at the same time as
> they perform other repacks and cleanups, so as part of `git gc`.
>
> Let's allow them to configure a <filter-spec> for that purpose using a
> new gc.repackFilter config option.

Makes sense.

> Now when `git gc` will perform a repack with a <filter-spec> configured
> through this option and not empty, the repack process will be passed a
> corresponding `--filter=<filter-spec>` argument.

I may be missing something, but what happens if the user has configured
gc.repackFilter, but passes additional filters over the command-line
arguments? I'm not sure whether these should be AND'd with the existing
filters in config, or if they should reset them to zero, or something
else.

Regardless, I think it would be beneficial to users if we spelled this
out in git-gc(1) instead of just this patch message here.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 69509d0c11..5b89faf505 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -202,6 +202,18 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
>  	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
>  '
>
> +test_expect_success 'gc.repackFilter launches repack with a filter' '
> +	test_when_finished "rm -rf bare.git" &&
> +	git clone --no-local --bare . bare.git &&
> +
> +	git -C bare.git -c gc.cruftPacks=false gc &&
> +	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
> +
> +	GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none -c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&

Nit: can we wrap this across multiple lines?

> +	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
> +	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
> +'

I think the `test_subcommand` helper might work here, and it would allow
you to avoid writing a long grep invocation.

Thanks,
Taylor
