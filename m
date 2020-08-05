Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A2C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F11B21D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MOb95tfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHEVEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEVEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:04:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72030C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:04:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so43033251qke.13
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+NcigDR/Zflwai08JCdxPRyvgKvbLDrXaA4pKOkkFM=;
        b=MOb95tfBQnysUzIU2ysamZ2lgXn5cvzTud4jqIk/TFPPHGSx1VW/sPBU0/QH5NUXEb
         mhsZtaI6mmWW+8shKjjNjeZrg2YbGYEYif992X2SrOb/cFs6L6M1ArgabN8XKG4xRp3A
         KFovX8p8vZMYb7OaG6/CN5BF5EMQWZPXtS7vNpTm92DQfkeSKl3lBIeeI9UENIIOSPBl
         /NzsiXGldoJHBXKJaWNIbIN/snSi9KKws0mBUk3c6h9N4V5M+T2hdy3WwealRpFve405
         /wT1kT8gSKlRF8SDVdcOJQILyAyZCCqrf8djJPHts7l0pUmG93GX6acv7WXNtmbOWNs6
         N57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+NcigDR/Zflwai08JCdxPRyvgKvbLDrXaA4pKOkkFM=;
        b=SU9kwrQQRG/0+bayYO+WW8dX55GU9E4QeQRoem02cFvE+MS7wRUlroVkq/76n+oUgH
         KycgQ1uaJyFd5oUvOfAxhZub1cqOnZUQIvGMh/fXusYY9lIEUotquieUgIHBwO3HEEOR
         kxwikVYRQRTppBjbq5oQ1JLJfEuriuU7LvPIEx+O3iWPpFaYgFLRv3CnZh4zmhAJHpx7
         in0enhnHY/cwzOkUAWTEA5Mls/ja4KDLsz2g9rH0s4GzCaZrKD2Rr6EG1yIEO/IZCPmc
         enNd128G3M59chRrtr+nWW8mfnjFXTlcigaI/9hJRoM+64oLFUgjD43XM7ppgV/mTEtT
         x+gA==
X-Gm-Message-State: AOAM532gr3whg3WrULXFYB7ZB9jcpa19ejXWe2I+IkDrVi9zsc/LYkco
        HJCzp9oKgL9IsjhGRXo53DblaQ==
X-Google-Smtp-Source: ABdhPJxZJTM90gb8K2Df8YQckOv6XzyqEdcuXmgxF9V2HMPpMxvtqMSdkSosA/ba4CLVE03HPF888Q==
X-Received: by 2002:ae9:e507:: with SMTP id w7mr5211261qkf.264.1596661450529;
        Wed, 05 Aug 2020 14:04:10 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id n4sm2986291qtr.73.2020.08.05.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:04:09 -0700 (PDT)
Date:   Wed, 5 Aug 2020 17:04:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
Message-ID: <20200805210408.GI9546@syl.lan>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-5-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805174921.16000-5-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 11:19:21PM +0530, Shourya Shukla wrote:
> Add a WARNING regarding the usage of 'git add' instead of 'git
> submodule add' to add submodules to the superproject. Also add a
> NEEDSWORK regarding the outdated syntax and working of the test, which
> may need to be improved to obtain better and desired results.
>
> While at it, change the word 'test' to 'test script' in the test
> description to avoid ambiguity.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 145914cd5a..2db4cf5cbf 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -5,8 +5,13 @@
>
>  test_description='Summary support for submodules
>
> -This test tries to verify the sanity of summary subcommand of git submodule.
> +This test script tries to verify the sanity of summary subcommand of git submodule.
>  '
> +# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
> +# submodules to the superproject. Some submodule subcommands such as init and
> +# deinit might not work as expected in this script.
> +
> +# NEEDSWORK: This test script is old fashioned and may need a big cleanup.

It would be worth saying why, especially if you're re-rolling anyway.
Even something as simple as: "there are lots of commands taking place
outside of a 'test_expect_{success,failure}' block, which is no longer
in good-style".

I also wouldn't be upset to see some of those fixed up in this series,
but I realize that may be a bigger endeavor than you are willing to take
on for now.

>
>  . ./test-lib.sh
>
> --
> 2.27.0

Thanks,
Taylor
