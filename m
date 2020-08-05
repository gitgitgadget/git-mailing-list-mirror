Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBAC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E736021D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="a+36upc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHEVBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEVBI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:01:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420EC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:01:07 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so28877008qtq.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=djecj8kj93PRaImX8/zJoRYaCVHm92YxQWiQOi9rkU0=;
        b=a+36upc8PW965BR/aHXeEBXKHj8bCBbHg0n8fRVx6fJt9kXFhgpo8yqmcv9r7cMQVp
         WDNqEKyf+rmESDifJamfX8QFe1gtEcJBsMfwZY3dSCgpQ6AgddPGarvDJpYDOoUSAp0k
         gks77FfbwaSmGPfhh9UZmBjVtS/Zabzk4atRTUTAUCl3D0UMvbYFQYFHm+wZsIPl8d+k
         P2R34/rZQ+++fkyZzquyRxMXDkKac4ikez5I+Fk/O/8bTAMvdSagN4BiF01OkpNN6xxX
         pI3TwRMsUYY8Gzqi2yh0Ss1yV12HkeqvcA2Vn3Q+9SI1ydcmfDS/E1VXOL+l3cxJD81z
         vcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djecj8kj93PRaImX8/zJoRYaCVHm92YxQWiQOi9rkU0=;
        b=ZRxd9kEtcCNnWeZAfIGLDaW7NQrO8qN5xbRjfQaJh9cWP4lxUBegYN+d4GlQMy1qzn
         yM215lRD7G/OiQc6pWBRvcDJ+oO4jIWA1cKri7BT7XkGNSwO8+O2AA2hC1NcOf1z1xSF
         46yO7C7Ol2t8FPlB9+YqALpy5+ECr+JDXeg77kGADED6kVm2EWIGHi/Fl7hqEcD/8dth
         TkiVg7fzB7v7FEHjHfs6oAXaxSbuHqO1VteT/t0XBnVeawfWmxrhqalugzqXijiIiZyA
         apTuNgz1LuA9LNkjISkJKtkrO+4NocidUDSWln4dgv8ctugeOtGRMOELMkyGwwT8P3d1
         I7Jw==
X-Gm-Message-State: AOAM530VtrYh+t4tskn/fwKX09pPyI6YozTs4oN6BAkVv+HD/ZB0SfsP
        F0YPb6F/dnIOxZ5WIGnouEHfqQ==
X-Google-Smtp-Source: ABdhPJxJCa1mrch1OkglUb7vJIms3/yMBhr0RSJnAgGJvo/V1FZLRLQkHasM1PCOrUK1aDD9BN4ZDA==
X-Received: by 2002:ac8:7205:: with SMTP id a5mr5428355qtp.235.1596661266493;
        Wed, 05 Aug 2020 14:01:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id j15sm2342735qkl.63.2020.08.05.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:01:05 -0700 (PDT)
Date:   Wed, 5 Aug 2020 17:01:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
Message-ID: <20200805210104.GH9546@syl.lan>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-4-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805174921.16000-4-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 11:19:20PM +0530, Shourya Shukla wrote:
> The '--for-status' test got its expected output from stdin. This is
> inconsistent with the other tests in the test script which get their
> expected output from a file named 'expected'.
>
> So, change the syntax of the '--for-status' test for uniformity.

... serves me right for not reading the whole thread before responding
to the previous patch ;).

On a technical note, I don't think this is different enough from the
previous patch that they couldn't be combined. (A good indicator of this
is that I expected this change to be included in 2/4 and was surprised
that it was a separate step afterwords).

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 18fefdb0ba..145914cd5a 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -285,13 +285,14 @@ EOF
>
>  test_expect_success '--for-status' "
>  	git submodule summary --for-status HEAD^ >actual &&
> -	test_i18ncmp actual - <<EOF
> +	cat >expected <<-EOF &&
>  * sm1 $head6...0000000:
>
>  * sm2 0000000...$head7 (2):
>    > Add foo9
>
>  EOF
> +	test_i18ncmp expected actual
>  "

I think that this is on the right track, but you can use a '<<-\EOF'
here instead of '<<-EOF' to make the tabulation a little more flexible.

>
>  test_expect_success 'fail when using --files together with --cached' "
> --
> 2.27.0

Thanks,
Taylor
