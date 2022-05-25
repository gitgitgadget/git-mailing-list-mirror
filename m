Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803DC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiEYXAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 19:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiEYW7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 18:59:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8336899E
        for <git@vger.kernel.org>; Wed, 25 May 2022 15:59:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d21so457643qtj.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=86fx9JUviOLnOIIvq9Ns4mtXK/znDAF3CXA9CZUOSzg=;
        b=tgDNe4marcrF/DnkZB+Xq6DbOjcxkAFOL8Vfp/+iPgg2L7JlEFCIV1Fc94NVuierDf
         c31Kq8DyKvcvupOvxYdyySEwQtUW92ZDrmZapbxmpW//ChG0S3+OBab+Nvakfz+8+vT4
         QCFXn/HhaUuXIzavNd4QyIUdv3s4INXjFPPAdJl+jlzpUWzadkMZiacPUmrCmN8ZjmGs
         82T3Asc+DoH0+z+DAncVvy7ljHxbuKjUnJfxjHBlJxDdKmFlmrKsG3NQkWLqMz85IcZN
         7F2FnemtOJmHVo/AXTuV8iuSYiIDlPtZMcR0OZ6oPQya5Ki55oejWxye93xHqptso0b2
         QYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86fx9JUviOLnOIIvq9Ns4mtXK/znDAF3CXA9CZUOSzg=;
        b=z0b0D2Z01FzHQYGXe9zSJKPiGUc1zex7HN4xCrNuPuZLqnxzn3TIG/yqsOXZgGXmf2
         zKEZyHOshLAySyj6uu6S9I6FrAUQ04VfHFxe3tAaOxZPYqal1oiz22AqmOtWRdQTV9fQ
         WRj5o6hOFB9dX/T64JMxg76EU7CCZRXIfXmYoB9E+VwJdYITNDae77sJPiqsW5QSPgSv
         /nlkbu288vyqSruZTIPEcgmx+3CwIHI/Jjjtz1ylZA+Mvy34dXicp+pJsYMo5N/9yXNr
         NA4USnUQOqF3rbOgpN27tATr8l6FniWU7qUSt67V17NriApNQ0pDRC1ppIpCBSyD7EF0
         8g6g==
X-Gm-Message-State: AOAM533osKXX5/wx/NFYqfkDixZ6oJqMYy7VnK5DaKqBnc1GxVZC4lDy
        P8hX+AYcCNicGvjEeK81qHXuSw==
X-Google-Smtp-Source: ABdhPJzVPNzaQABQS/EHfu/XneTOUmhptHwXGJzPiT0pKfjGw5pC5GWcf5g93+P0J1XuSmDxp8GBLQ==
X-Received: by 2002:ac8:5b53:0:b0:2f3:f26b:3d25 with SMTP id n19-20020ac85b53000000b002f3f26b3d25mr26676694qtw.357.1653519592713;
        Wed, 25 May 2022 15:59:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t26-20020ac8739a000000b002f39b99f692sm2130725qtp.44.2022.05.25.15.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:59:51 -0700 (PDT)
Date:   Wed, 25 May 2022 18:59:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Jonathan Nieder' <jrnieder@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo605oy4gfQmJ+VE@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <Yo1aaLDmPKJ5/rh5@nand.local>
 <Yo3fZkpkCLPbAC8B@google.com>
 <Yo6hcOjIlYglqdxs@nand.local>
 <01df01d87082$a0757020$e1605060$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01df01d87082$a0757020$e1605060$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 05:58:49PM -0400, rsbecker@nexbridge.com wrote:
> >> > `data` is definitely uint32_t aligned, but this is a tradeoff, since
> >> > if we wrote:
> >> >
> >> >     uint32_t *data = xmmap(...);
> >> >
> >> > then I think we would have to change the case where ret is non-zero to be:
> >> >
> >> >     if (data)
> >> >         munmap((void*)data, ...);
> >> >
> >> > and likewise, data_p is const.
> >>
> >> Doing it that way sounds great to me.  That way, the type contains the
> >> information we need up-front and the safety of the cast is obvious in
> >> the place where the cast is needed.
> >>
> >> (Although my understanding is also that in C it's fine to pass a
> >> uint32_t* to a function expecting a void*, so the second cast would
> >> also not be needed.)
>
> I do not think c99 allows this in 100% of cases - specifically if
> there a const void * involved. gcc does not care. I do not think c89
> cares either. I will watch out for it when this is merged.

Thanks for the heads up. I looked through the results of "git grep '=
xmmap'" to see if we had contemporary examples of either assigning to a
non-'void *', or passing a non-'void *' variable to munmap.

Luckily, we have both, so this shouldn't cause a problem. fixup! patch
incoming shortly...

Thanks,
Taylor
