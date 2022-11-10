Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3334C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKJCRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiKJCR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:17:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EB1CFE1
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:17:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p184so277270iof.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGLVq0PhQEIxBo5M4gWfk8TNcdj3Iiy+ZTvGUE0zj6I=;
        b=IeCtBjUJNS467GXT5jVE28sHLjQPZCi72FvM7yzFpNPCjH+9JEL7qd9U49vDxx2dnv
         wdhtjKpwn8otWA506R0xuXGoAipHYNKwG/USl6XGUlwSxxTYJFwijQvQSxxL7o9BN/X0
         cR+s9ZajCxTMYoU509vTvS2oSH27b+ToOOFgjzTBalIopAGgjYJRvVSnWKpOu8RwyXQc
         t4AZK5fyJV8pwEL/2o/DwBl+IbTYdK04Z01uGosRovYbmz1eYj6jUme54NbcBxUAePFS
         aLNlOcHSfnPEOvBE+BNTMnvLelknr7RRAVGsrIfG3Sv/hwciDyGZuKMouvsAlxVX9vOE
         UsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGLVq0PhQEIxBo5M4gWfk8TNcdj3Iiy+ZTvGUE0zj6I=;
        b=YMzEQOLy3GeJbHJ8ntt0zfNOHJdXMJJCqZT4lK2W1C1koX3jnD/4pg7VYaL1SO8q8P
         KncbwLDU246THpSzEXlXcMUzbObczZqCngEDkAX8iuutrrOsYpyjCvd+3rLFJO8ZiHlv
         mX6YyOg0lu66RrMSiQBZmifGFTwnrbEK0/uIM9pc/QmLY7dGBIkVEo4exeKRL/Kvu5eH
         FO/50f2FS/UeT7bj3d1SmmlzG4UOs6zwJ9ua8wwsGZ1u/qT3dHS5CkdN9D5D1RUIkBxA
         /I4JxqFWcmeEjqBN8H83SiNNsCVD3SGMn+pskri+tO4V0eKp7uIkffmHRe6c07bTBavx
         FvGA==
X-Gm-Message-State: ACrzQf3LAg0soOZX9h4zPitS7YT3gR+Qvi1W6/Nx0BLvFvh4OvL+glZ2
        RXJhBX+oWWYpDLgF/vvloCkGBg==
X-Google-Smtp-Source: AMsMyM7DhuiIERgkYacucv9k2cOx6QGwRDOe80mSVCYqzqoyqTUFyrRqVL7FuTiTiuIj5ZHiW8wkCg==
X-Received: by 2002:a02:a394:0:b0:375:41a7:531 with SMTP id y20-20020a02a394000000b0037541a70531mr34659192jak.224.1668046646522;
        Wed, 09 Nov 2022 18:17:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n22-20020a02a196000000b0035a40af60fcsm5320420jah.86.2022.11.09.18.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:17:26 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:17:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7610: fix flaky timeout issue, don't clone from
 example.com
Message-ID: <Y2xfNcCfkij6k4Uk@nand.local>
References: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
 <Y2wuEDGMRg99Ifef@nand.local>
 <221110.864jv7ptbq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221110.864jv7ptbq.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 12:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:
> But we generally just fail some or all of 3..9 pretty fast, and don't
> start taking 20 minutes to run the test, when it took 10s before (or
> whatever).

OK. I still think that in principle this is indistinguishable from not
running a setup test to completion.

*But*: I'm willing to treat them differently since instead of
manifesting in an immediate failure later on in the suite, we hang for a
substantial period of time.

So I'm content to merge this down, but I don't think it's worth
searching out for more of these in the future.

Thanks,
Taylor
