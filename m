Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E2C2BBD1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78B321D24
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="2KB1Pnpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgIQQxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgIQQx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 12:53:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C019C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 09:53:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t138so2969726qka.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kLxgYjx0b0ellkVajpe498uEKO8dH7pHqb21l//y+4I=;
        b=2KB1Pnpj4kECEhJNLBV+cmhB+j0GdIbz/7mhuspo2IlY/2b/GLu35tLDXyz7phmssU
         smlK3FFpjh5DRm/yHF9hT1Yy+Fqa1IQMSCrV+lj5ZD76k6w4zN3qttcxSQtaL+eWBXXD
         2Xr67/46VUItJqZA7wb+8gx579ghONXFY1eTSvaeXbyRGeZh2fgnXbom5lQKXdmqsr3c
         UkNzQay3CBYV7D65lQtVMyVMLq8ubIi3TpFxS0kxr7ywXrfsYpxTC2k/gniTNKrERAJ8
         qOlryHiHTqRhpVFU1jKvJiu0/7a/+XHrNPg97Fr6KlTHyq1u1mpqtakhbzwXsf3zHAc3
         B+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLxgYjx0b0ellkVajpe498uEKO8dH7pHqb21l//y+4I=;
        b=to4rjdPLsACuD/20QpsWyEp8CfWbwOROVKY4B37SGsDkaljmp1T4+ieZLRQpE3DMAP
         /5dWDKHrLvV4JKpQ0lW3L0XirQkGhZDpZMqhrpA/zayyfe+IdrI0cuwxi5lD7iMSI4zK
         +Kp/JHNRgjwo7Squo5e5IkrI8+LGqmAr4I8P4nkmZPfCJjt3/gjVc8J+qiSse+3J41QC
         mPAuFvVqRPVB4x1vgvDcuWFdLFMaA7VyQfdEr15INeyNbOAwfys97xlKvoxLlcjnYOT4
         683NTYpTusKNOii3V3EYqeGVLqVNxknysuvXUxh32TbUBSZgwxAPpx+RB9mtam0twhEs
         kJSw==
X-Gm-Message-State: AOAM5334a+4o9/rTe7WjXaDsz11ug9TPCBP93JKOyCClbKCUrtapg/5f
        4JDfUyIltZ78zy50xm7U4vokOA==
X-Google-Smtp-Source: ABdhPJwbJhxDWP1C8f1EqDTSD11bx+DpgzmQGyzMeOspJka3ZtLEhweVrgaycH4fevPdIM7MQ6Xokw==
X-Received: by 2002:a37:b2c3:: with SMTP id b186mr6420708qkf.90.1600361601650;
        Thu, 17 Sep 2020 09:53:21 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:819f:6bba:e7ac:1ed8])
        by smtp.gmail.com with ESMTPSA id n203sm219052qke.66.2020.09.17.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:53:04 -0700 (PDT)
Date:   Thu, 17 Sep 2020 12:53:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] packfile: actually set approximate_object_count_valid
Message-ID: <20200917165300.GA15187@nand.local>
References: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
 <20200917125333.GA3024501@coredump.intra.peff.net>
 <20200917164743.GA3731633@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917164743.GA3731633@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 12:47:43PM -0400, Jeff King wrote:
> So here it is wrapped up as a patch. I think it's worth fixing (as
> opposed to dropping the unused flag code). Thanks for finding it.

Yup, after reading the patch and performance timings below, I agree that
this is worth fixing and keeping instead of dropping.

> It doesn't help at all when we have 1 pack (5303.4), but we get a 10%
> speedup when there are 1000 packs (5303.12). That's a modest speedup for
> a case that's already slow and we'd hope to avoid in general (note how
> slow it is even after, because we have to look in each of those packs
> for abbreviations). But it's a one-line change that clearly matches the
> original intent, so it seems worth doing.

Excellent.

> The included perf test may also be useful for keeping an eye on any
> regressions in the overall abbreviation code.
>
> Reported-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  packfile.c                 | 1 +
>  t/perf/p5303-many-packs.sh | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/packfile.c b/packfile.c
> index 9ef27508f2..e69012e7f2 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -923,6 +923,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
>  			count += p->num_objects;
>  		}
>  		r->objects->approximate_object_count = count;
> +		r->objects->approximate_object_count_valid = 1;
>  	}
>  	return r->objects->approximate_object_count;
>  }
> diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> index 7ee791669a..f4c2ab0584 100755
> --- a/t/perf/p5303-many-packs.sh
> +++ b/t/perf/p5303-many-packs.sh
> @@ -73,6 +73,10 @@ do
>  		git rev-list --objects --all >/dev/null
>  	'
>
> +	test_perf "abbrev-commit ($nr_packs)" '
> +		git rev-list --abbrev-commit HEAD >/dev/null
> +	'
> +
>  	# This simulates the interesting part of the repack, which is the
>  	# actual pack generation, without smudging the on-disk setup
>  	# between trials.
> --
> 2.28.0.982.gdd163d6eb1

Looks all very good to me. Thanks.

Thanks,
Taylor
