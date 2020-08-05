Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE80C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B971221D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GmWm6fzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgHEU6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEU6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:58:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028FC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 13:58:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so38925663qkf.10
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0X2iByGIkePPBeQfydIB58TrnX+lUZ9tpYyauum1qH4=;
        b=GmWm6fzLSBeEzV7vv6RKA76aawY+sMHeWhkWvAkLOcFCul3BDJfy1A/PkEsok4uWzu
         MFkAqayNALqHZX6/mY8sCt5Dw/6sjd83pHFYeG/F45Bz6K64xDPJ2TEOjjMfMcidIC8E
         DWsTz2MSPU52G3IQFF/0XsLpGayUpBwR1FS9JDIoQsi3ka+6iSsNPpTHIhQlsR9fDPlT
         1LfN7r2kaXtSSn0/wJvpOkcZ6H74RTLThH3eIrhApJYys0dRt1RbJOcANLXs1n8X5r0C
         iQuqQkkvzgZ1abayrAXJ5iucmCjD4izmefgC0z+BoDOKf9ZacljKD2I2VrZ8LhfuzBHY
         Tc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0X2iByGIkePPBeQfydIB58TrnX+lUZ9tpYyauum1qH4=;
        b=PlJnV7SnycPICbHwD4soQZSyF7lO6LFc5yCgXJwAfJyhFjpa7pYkAjGisbkxPIhRbw
         U9pnRIUaPJwp8PFZIW156RJFIXyBq6J+G8NbKyV1Hr20cGuGsloGxkRaWG2S78e165FR
         rYTVt5bWhx4SsWGVS8l7EVK4CpiaL8AyeY/Y0wUkKfnYhior8PjmqB75140ylHJsykMf
         1ASIjwmlFgD5SMExWj+oc7iNvyfk69n0UqSa1sBhF3048zrzsa3mApWVffFRak85TquM
         bhQ8S8n8AXQFV2m5622gPskr4MQ1fZIFrZnOLQz2f/mgzvMcfXwL3LDdcYrb7VZ5TjYy
         fvOA==
X-Gm-Message-State: AOAM533EHZRmPgyuN5Z/KK8UQte9BfURkWGEO/+7Sj1MJPWaVOceUMly
        naDm39xeJs8LqsdeBx2xujPX8Q==
X-Google-Smtp-Source: ABdhPJyA4ZdV2Znv0N/0KW0eDKh9dDUqZfU7XMfHTUAxgwDJBBlm2zFKSZifG2AV8TqvzHr4nNLcbQ==
X-Received: by 2002:a37:a64a:: with SMTP id p71mr5450534qke.296.1596661118383;
        Wed, 05 Aug 2020 13:58:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id x28sm2620013qki.55.2020.08.05.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 13:58:37 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:58:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] t7401: change test_i18ncmp syntax for clarity
Message-ID: <20200805205836.GG9546@syl.lan>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-3-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805174921.16000-3-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 11:19:19PM +0530, Shourya Shukla wrote:
> Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
> 'test_i18ncmp expected actual' to align it with the convention followed
> by other tests in the test script.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 4439fb7c17..18fefdb0ba 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -183,7 +183,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
>    < Add foo5
>
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>
>  test_expect_success 'typechanged submodule(submodule->blob), --files' "
> @@ -193,7 +193,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
>    > Add foo5
>
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>
>  rm -rf sm1 &&
> @@ -204,7 +204,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
>  * sm1 $head4(submodule)->$head5(blob):
>
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>
>  rm -f sm1 &&
> @@ -217,7 +217,7 @@ test_expect_success 'nonexistent commit' "
>    Warn: sm1 doesn't contain commit $head4_full
>
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>
>  commit_file
> --
> 2.27.0

This all looks good, and matches a long-standing convention of having
the expected value as the first argument and the comparison value as the
latter argument.

There's one spot you missed, which could be addressed by folding in this
diff on top:

--- >8 ---

Subject: [PATCH] fixup! t7401: change test_i18ncmp syntax for clarity

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7401-submodule-summary.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 18fefdb0ba..bd8fc8511a 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -285,12 +285,14 @@ EOF

 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
-* sm1 $head6...0000000:
+	cat >expected <<-\EOF &&
+	* sm1 $head6...0000000:

-* sm2 0000000...$head7 (2):
-  > Add foo9
+	* sm2 0000000...$head7 (2):
+	  > Add foo9

+	EOF
+	test_i18ncmp expected actual
 EOF
 "

--
2.28.0.rc1.13.ge78abce653
