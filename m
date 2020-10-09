Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B63C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696C82224A
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm0cZPnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgJIBpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgJIBpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 21:45:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E54C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 18:45:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so5840182pgf.12
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1cpuBwRAvn7LRmHFDrokgH97OeR/5DcVgMlqyNiX4E=;
        b=pm0cZPnkUHh96mUwa+ieJSQPEWAhdxpTJVOUdySuSuvlyOVoWwDEEdsq32fTSRy6sO
         WJg5WKlOnYBeG/evwSLlg4uT0J6TA+k7wknHSfH46UKYWUoeUw5KqFH6hiJfaChw521X
         zQR+lnNC/HnSu3MkZMWoInDz9ibpza2Mw6LhD7YBzfeO2W9N9I2qzVQKx63V3jiO6030
         V6nwF7bQ6IodyHvSfPcgHntRXu1tV/R73MLRlEM+deNPq1zjg+kICWlsVq6DOYLS9y+z
         EG26PGlcqfFhoPIYEbl/8JSOmztpPGwIIr0YnVDmHVAB+g2Oa3byvFonw0Rk4301Onvc
         SxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1cpuBwRAvn7LRmHFDrokgH97OeR/5DcVgMlqyNiX4E=;
        b=oXL9KTCdaaCso24DsYlo7IdWIM9HsYg43W15nkrymPpt0yGL6HiRR0jgfmD5N9vvLV
         fkHE2Sm4OLdQfhcXZrm0m9iNkLe6a4f+imdgadagLNDyeRWV9pJRQ3y/cNd5oSTmaLPE
         ms55yJhK2t4bsSS6p2EUhtztPsUZKX7vtKoq/FJK55FsUVvGz+xoRq/uRMzOXEm95hC/
         IZSEuYKmTfNvQy93N6mieE1i0SL5ua+/3sW+bEx4UQ3Mj5rGBBxluDQcImoFgkdi+gWe
         mTn5WhmJQtBQdR+ZI7PpvMlbVx4XyWAsX1F7ytl46/Q+hWlvkImAMKcvwgJ8lJV2aGef
         m+9Q==
X-Gm-Message-State: AOAM530V5oMHKXJdPS2yzFcQz7bodKvGg2+aXt755ugZ7jnw/hNSZ93p
        cAB594hzcPPxMtz0G8BJpqc=
X-Google-Smtp-Source: ABdhPJybqD4YKZ56LoYCt1O2OLc32fEAU/WvhvvTDUtZPU1mZCooeCR3k0ZIEiqo5FyE06ZRK66CvQ==
X-Received: by 2002:aa7:95bb:0:b029:152:b32d:6935 with SMTP id a27-20020aa795bb0000b0290152b32d6935mr10250808pfk.54.1602207932094;
        Thu, 08 Oct 2020 18:45:32 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id 137sm8890640pfu.149.2020.10.08.18.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 18:45:31 -0700 (PDT)
Date:   Thu, 8 Oct 2020 18:45:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
Message-ID: <20201009014528.GA1314@generichostname>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Oct 08, 2020 at 12:06:47PM +0200, Johannes Schindelin wrote:
> Also, this strikes me as yet another task that is so automatable that we
> should really avoid bothering humans with it.

Yep, I found these changes via a similar-looking Python script. I like
the Perl version, though, since it gives a path for inclusion so that we
can automate this task.

> I gave it a quick whirl, and
> this Perl script seems to do the job for me:
> 
> 	$key = '';
> 	@to_sort = ();
> 
> 	sub flush_sorted {
> 		if ($#to_sort >= 0) {
> 			print join('', sort @to_sort);
> 			@to_sort = ();
> 		}
> 	}
> 
> 	while (<>) {
> 		if (/^(\S+) \+=/) {
> 			if ($key ne $1) {
> 				flush_sorted;
> 				$key = $1;
> 			}
> 			push @to_sort, $_;
> 		} else {
> 			flush_sorted;
> 			print $_;
> 		}
> 	}
> 	flush_sorted;
> 
> It is not the most elegant Perl script I ever wrote, but it does the job
> for me. And we could probably adapt and use it for other instances where
> we want to keep things sorted (think `commands[]` in `git.c` and the
> `cmd_*()` declarations in `builtin.h`, for example) and hook it up in
> `ci/run-static-analysis.sh` for added benefit.
> 
> My little script also finds this:
> 
> -- snip --
> @@ -1231,8 +1231,8 @@ space := $(empty) $(empty)
> 
>  ifdef SANITIZE
>  SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
> -BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  BASIC_CFLAGS += -fno-omit-frame-pointer
> +BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>  ifneq ($(filter undefined,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>  endif
> -- snap --

I opted to exclude this hunk because it didn't seem like a list that
should be sorted. Perhaps if we include this in the static-analysis
script, we could define a whitelist of lists that we want to keep
sorted?

Thanks,
Denton
