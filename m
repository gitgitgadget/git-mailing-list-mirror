Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE2C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A470361260
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhKRWwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKRWwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:52:50 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6393C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:49:49 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 14so10238517ioe.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C0JzIWN9QUiE43UN+7OrbTNTJ9ypQ7de0RobVn9WfLo=;
        b=zv5KjLh7QkCB/i+yayRXyOZmGiERZPMjOo0Y/s2vTf4dT+5jxbbzvW11qIEg1Nemor
         TY+bEAS7A66XSeU8YiyHP9YcMeYCMuyOLB0vRHtU4lRKHHfglhmbvJABxYdh/bw9uMGq
         /nK3l8pQ6cFtPf+bAF6I1ThD1VU52rUH7cOEzL9dBq3nxY091miOFgWmL00SamZ3C1RX
         ++2pasn3etOIPEtKNe2/sVvd0wL0cfgMHm9HZ/ggMVEPmp0Oope8NYRyS/0XiOPOieQA
         5WyRmpbCnNU2lbAx4MKrhmTkN+NX5TQREj6qzkALPnF6T6uYK6knpdHEWjpxnAQRZ5UW
         GqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C0JzIWN9QUiE43UN+7OrbTNTJ9ypQ7de0RobVn9WfLo=;
        b=omtfip0mzfwWASYbdiQAKwo+x+f9RqNB9TyeYiEEXeBOFOTaUO0x1N/G1zizq0+bjn
         HCA5cwreMW73DO/9gv3+bysYhq7igPH0okF+Po82isFiXgZKkRO8vo7mMpx/ivAyAZW0
         n6UfzpxrF2u0meZ6zj4P3YznaFkYS4G9J6KKP0EunqdAf7ViDNwttEr+qqD9lleC7150
         jEPXvqGeVacZlZh5f2Xf0+ep53/JOFXGwpZNv2R78Qnsd8p7qJnes7j3xvIUwG3FAS02
         zVkn9dVXIlpBvlD2QQrE5mxpHD/p5TyGL8tcXkkB79+FyJxhqBTksRNG7bJ7OVTenSg2
         +gsg==
X-Gm-Message-State: AOAM530xCsbO3/DTeA2rOPOJgLXQYFHSEHpSgEQ4wFGRDVXrSyyP6sMq
        IaB4tErVx/c8wBLSwECwmBxoxT+8m778ibhz
X-Google-Smtp-Source: ABdhPJzXo9cmjk7o6lVMucubAZ9GOJdrCcPbTGYhIdIiXdngZAE5vf9WSLR/eBAsFgr2ASj6mTmyDQ==
X-Received: by 2002:a05:6638:339b:: with SMTP id h27mr23350373jav.4.1637275789160;
        Thu, 18 Nov 2021 14:49:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y3sm766369ilv.5.2021.11.18.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:49:48 -0800 (PST)
Date:   Thu, 18 Nov 2021 17:49:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jan Kara <jack@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Stochastic bisection support
Message-ID: <YZbYjFpA1bpeebx+@nand.local>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 05:49:13PM +0100, Jan Kara wrote:

> The first part of the series improves some tests so that they accept
> other valid decisions for bisection points. This is needed because to
> make it easier to share some logic between normal and stochastic
> bisection, I needed to slightly change some bits for normal bisection
> and then since commit weights will be computed in a somewhat different
> order, also chosen bisection points are sometimes different.

I have only looked through a couple of the first half of your patches,
but I'm not sure I understand why non-stochastic bisection needs to
change at all in order to support stochastic bisection.

In other words, if we're tweaking all of these tests to allow picking
equivalent bisection points, why can't we simply leave them alone? It
would be nice if normal bisection didn't change as a result of adding a
new feature on top.

Thanks,
Taylor
