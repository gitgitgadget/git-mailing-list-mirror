Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476BCEE49A3
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHWNWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjHWNWD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 09:22:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813910D3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 06:21:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3082c771so2660350b3a.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796829; x=1693401629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Dmr7q8i+DYNUciGJcAmrFD08v0wbjTYBeSHQK8+sQ=;
        b=FbpfxLD5GQfLzPFzrCEcE+t4QifxThou4AwLyBmpRhGNtlcqOYjPnT8fzyN3ChHozx
         NGHxKLpIYcjO4qF7BxSUUX4SV946SxI3kxFqjGHW1Vuek9Asr0UELzqD8s86lG+5NBRQ
         tdamP/ND7RTzSjXS5xL4rvsykhvHxWd6oH0v91HFzHxFFfHfISCvjr/Dy9ESjgjX9KvV
         hK3SFL6OiI3/h8wQyQXHRBXxJvmfFLwm+cBckH2T6H5/VIbKmJG1Ht2zDD9o4qpTZnJW
         Hd9Vxe5SpQywYvlejQsJfHvw4WdIWjnEF2otracnEjUszqLsvFHWNKDQHUJUPbs6zgvk
         PZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796829; x=1693401629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Dmr7q8i+DYNUciGJcAmrFD08v0wbjTYBeSHQK8+sQ=;
        b=Hkm6Hh3z+0L+tFN/mhMsWFoOF0CWisChVQhOMCJ7kyZ2lpaXRSlyAfeayXZ+ILgCKb
         tnvcEpeP4i86+8/eWYiA4q5EPsS/pIJj0tQaBHnqnWXz+A82lILr1wlIm2eHQ2lMh+RG
         y8W0qitPxMAENJbLOYOMFtIw0MR6G8aGutsiqTwkeR4RM00uSQF8bvB3jK/e/bl/NM/i
         h7cbr7cQS4Xit7mmhNQdw3PboU1FzKAg6E28CUWpCLtU+yPNygzOm2JYEQuJVxwGyMYH
         6dbKzCuKAgc4D5bVAKHnA/yYyW6ig+iiavofqHkmIjEqRDc6aCbeIHovoXcX/zO002VO
         nd+g==
X-Gm-Message-State: AOJu0Yzi8EkFvuZpOs5n517JGQGn+/0QGmFuyAnoaTSgiZDhBZwLHyJf
        LNPSf+UmkyjzX2BBnj0c0nA=
X-Google-Smtp-Source: AGHT+IHW7PiemnHO9B6941FwQl4F7rTechyQrpneAqXook+qrZdiSW51HdyDzs5kWL+/CISMfszQZA==
X-Received: by 2002:a05:6a20:3d0d:b0:13f:de94:fb97 with SMTP id y13-20020a056a203d0d00b0013fde94fb97mr18231526pzi.27.1692796829160;
        Wed, 23 Aug 2023 06:20:29 -0700 (PDT)
Received: from five231003 ([49.37.156.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a63ae0f000000b00563ff7d9c4bsm9849632pgf.73.2023.08.23.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:20:28 -0700 (PDT)
Date:   Wed, 23 Aug 2023 18:50:15 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH v2 2/2] t/t6300: drop magic filtering
Message-ID: <ZOYHjwOFdFGjFm1W@five231003>
References: <CAPig+cTFrroZGo=KOXu0aCxeJvNz7eaHAK++HXELZ0ZheJhw9w@mail.gmail.com>
 <20230823065300.21961-1-list@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823065300.21961-1-list@eworm.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 08:52:17AM +0200, Christian Hesse wrote:
> From: Christian Hesse <mail@eworm.de>
> 
> Now that we ran a trustdb check forcibly it does no longer pollute the
> output. Filtering is no longer required...

s/forcibly/forcibly, 

s/it does no longer pollute/it no longer pollutes

Also, maybe instead of "... the output.",

	"...the output when we encounter a signature check and hence filtering is no
	longer required."

or along similar lines.

> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  t/t6300-for-each-ref.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 5b434ab451..aa3c7c03c4 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1763,10 +1763,7 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
>  '
>  
>  test_expect_success GPG2 'bare signature atom' '
> -	git verify-commit first-signed 2>out.raw &&
> -	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
> -	head -3 out >expect &&
> -	tail -1 out >>expect &&
> +	git verify-commit first-signed 2>expect &&
>  	echo  >>expect &&
>  	git for-each-ref refs/tags/first-signed \
>  		--format="%(signature)" >actual &&
> -- 
> 2.42.0

The code looks really clean now, wow. Although I'm curious why both the changes
weren't in a single commit. Is it because 1/2 is applicable generally and not
only to this specific test?

Thanks
