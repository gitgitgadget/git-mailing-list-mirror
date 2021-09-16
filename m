Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859AFC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1860F38
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 13:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhIPNpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbhIPNpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 09:45:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D16BC0613D5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 06:44:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so5906902pfa.7
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hr1nuto5NQUgUCdHcIn53+ejy2Ug1i0woHKZ6iAQiPY=;
        b=RSfDv7doUIgrCSS2kehDyqFryONpSOg2Ps6oCmtc/zns7TnOnsQBwSEdnOBP1yw4C1
         kVVA41xzvNyJ6wYRfaoqpb492JJpRt+L4m2IRW11mVVLPi5D+9P2kz+trQelooyVBDv9
         q9G3ILoj8UFjkRf2vMGuythkAzkTvWiN7/Vl4Ljh2qn/jGfFBeXWnTtK95dHAtja3IFW
         qNlt7StOhry0s+tshdrPtMJ/oVz8Ptta9y7kJAxz/XYJA1F+WiyZ3iJwQ7b26k41FbwL
         6I1UeaOMhAUQg0YO/eSjPr09RRMKNgNKqpKGE+Fmilllc3Aa6pdAyLs7EpJBtPLNHKmP
         CL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hr1nuto5NQUgUCdHcIn53+ejy2Ug1i0woHKZ6iAQiPY=;
        b=SdLH+h3zIfYy26I5FlC9zJcSSPxfMmLdjPEkJ7XUaGnrtX91MCKIecB4ZqUZnKUiBf
         XWIgw6O3fguJdhL/yyNvhYw/9+Lq9vO7ACNWsFDIT6Z05V3X7rG2d8FWFPWKGlWhYvO2
         zkyvjVsqLnxeMZH780OqnISYRTk61FtGNQx3lapxpSTQ17C8hiSdCH9MN3sTuVhXzNC4
         OpMrq4BZhi5w/zsoruaLWXlprUoDO46NG3PxB7gCedbBL2Rb/xemaL2iYOhRHH+OtXTr
         GvvcT5dmZ0sD4mtqB39iY85b1/xOwMSkUZkJQ6BLw+Yd/soQ2QuHFUlKhEAezIGspqGy
         IaHQ==
X-Gm-Message-State: AOAM53289itMHcHtFtSUXeROdNPwmkIwIxgwldELI4Z2iuDZfmd/3i99
        NsewWVBlIbi9z6rtatdJ6F4=
X-Google-Smtp-Source: ABdhPJwmaB7VgCpEzp/NelX/u4FLxVovsPWUCX4WZWFBPlB/EqnlysilDL/20Kvs8C04DDM7v2OlsA==
X-Received: by 2002:a63:b50d:: with SMTP id y13mr5053775pge.286.1631799861397;
        Thu, 16 Sep 2021 06:44:21 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a175:897f:beb8:2ff7:699a])
        by smtp.gmail.com with ESMTPSA id gk3sm8023137pjb.37.2021.09.16.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:44:21 -0700 (PDT)
Date:   Thu, 16 Sep 2021 20:44:18 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ryan Anderson <ryan@michonline.com>, vmiklos@frugalware.org,
        bedhanger@gmx.de
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
Message-ID: <YUNKIj44AlW0tkXk@danh.dev>
References: <20210916113516.76445-1-bagasdotme@gmail.com>
 <20210916113516.76445-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916113516.76445-3-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beside the problems pointed out by Ævar:

On 2021-09-16 18:35:17+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Mark user-faced strings as translatable (including PR message output).

I would argue request-pull message shouldn't be translated.

The person who creates the request may prefer to use a different
language, let's say French, for day-to-day work.

However, the recipients may not understand French, and prefer to
receive English message.

And this change break their workflow badly.

> @@ -138,19 +138,22 @@ fi
>  
>  url=$(git ls-remote --get-url "$url")
>  
> -git show -s --format='The following changes since commit %H:
> +git show -s --format="
> +$(gettext 'The following changes since commit %H:
>  
>    %s (%ci)
>  
>  are available in the Git repository at:
> -' $merge_base &&
> +')

Hence, I think this message shouldn't be translated.

> +" $merge_base &&
>  echo "  $url $pretty_remote" &&
> -git show -s --format='
> +git show -s --format="
> +$(gettext '
>  for you to fetch changes up to %H:
>  
>    %s (%ci)

And neither should this message.

>  
> -----------------------------------------------------------------' $headrev &&
> +----------------------------------------------------------------')" $headrev &&
>  
>  if test $(git cat-file -t "$head") = tag
>  then
> @@ -162,7 +165,7 @@ fi &&
>  
>  if test -n "$branch_name"
>  then
> -	echo "(from the branch description for $branch_name local branch)"
> +	echo "$(eval_gettext "(from the branch description for \$branch_name local branch)")"
>  	echo
>  	git config "branch.$branch_name.description"
>  	echo "----------------------------------------------------------------"

Ditto.

-- 
Danh
