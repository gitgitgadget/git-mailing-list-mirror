Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECAC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A11610E5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhJ2KTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2KTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 06:19:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022CDC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:16:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 5so36188255edw.7
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5Tu/geYh4cY6BWXuTQ+WiDKP8FRfTcXyFxV6DiWCft8=;
        b=Ke43CBTX+pY14AkNjLZQk+0Hv/3kW6LQSvDtF4aDSw1r9CXzjGrcFkZiSEgv4lS6ls
         VgShK5gG0fhMnEcWJvQsZWtbzwqiy4a9KujnMoz91aEd5AY8xSKYXwtOqwW9TEJTNJ5J
         9mIZXd71VofH6xtvBAdcPWAMCo5ppAhHzT5abnjv6ehOpbcT95LmRZaVsCMjFBC0Kh19
         kUfnIHYaALJOSlTrhUVbyXe+TKdTZnUvmqNIiuTv2IUD60IAG5LB0DmXB8lnyLElQtg9
         310+M9NN4Te3dukDx7gBokcP3+hpvqWgro+1jRpVP2KPWk5cyVrwJ7+9gx70vW7H0iX4
         H3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5Tu/geYh4cY6BWXuTQ+WiDKP8FRfTcXyFxV6DiWCft8=;
        b=hbJVkl/DOtShZ+MmEzmpoqpIzOTfsbBjXg02SIA02kGuOnN9W3PT5FQbuiKPe4SsFz
         DPlCNAoXPPLvUGkSO5my07j2Ir+yoJg0kiqgaGCQkatOJhmpbtELouzewjbGltpvk6Dn
         QUaFRJk1427fMlFXoeI7lQT/h9US/JkLFLCDPZa1sEQlrvhCUiQ19+it4sSWgH/gvVDB
         xU5QNwUrnPqzLb0nbY065OAUhHM131aNWdKU6XrGEwuMBV8Be2N473HIDJ3uftV6LJN5
         BVF7GC2smpEjfSfWxOn4tEh7YhvAht8reHbvV7tR2RmJPyllUPPQubeQaqziMcsojvlx
         hyKA==
X-Gm-Message-State: AOAM530EW4ppfY5t51bKd+KNzgOQXYCg8JdSFnBXPOldGqLVP9XWw9HM
        S4whgPdsf1/w/ITAl6zv3MrvzwwpDZKi/g==
X-Google-Smtp-Source: ABdhPJz+XHBRqC4veFcCm1ZbXtVBMr9vww4jW5H+te+RJsL8UtJW0l8WJIyznYfkmSXcoHZt4mn7pA==
X-Received: by 2002:a17:906:26ce:: with SMTP id u14mr12863295ejc.559.1635502599417;
        Fri, 29 Oct 2021 03:16:39 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p25sm3186305edt.23.2021.10.29.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 03:16:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgOwA-0024Zy-N4;
        Fri, 29 Oct 2021 12:16:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5310: drop lib-bundle.sh include
Date:   Fri, 29 Oct 2021 12:16:14 +0200
References: <YXr3+yqtXYGgaxnX@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXr3+yqtXYGgaxnX@coredump.intra.peff.net>
Message-ID: <211029.86fsskw2yh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 28 2021, Jeff King wrote:

> Commit ddfe900612 (test-lib-functions: move function to lib-bitmap.sh,
> 2021-02-09) meant to include lib-bitmap.sh in t5310, but also includes
> lib-bundle.sh. Yet we don't use any of its functions, nor have anything
> to do with bundles. This is probably just a typo/copy-paste error, as
> lib-bundle.sh was added (correctly) to other scripts in the same series.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not really hurting anything, just confusing.
>
>  t/t5310-pack-bitmaps.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 673baa5c3c..dcf03d324a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> -. "$TEST_DIRECTORY"/lib-bundle.sh
>  . "$TEST_DIRECTORY"/lib-bitmap.sh
>  
>  # t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in

Thanks for cleaning that up, yes that wasn't intentional, but just some
copy/paste programming or something that managed to escape me & the
list. Thanks!
