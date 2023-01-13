Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE9DC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjAMQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjAMQwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:52:54 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5002D6E0C2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:49:56 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id 186so17508770vsz.13
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsPbjW9pFoguIa0tQlWIDr3b/dmdC3nrtYBag6zrUZM=;
        b=deq+r9YJ5cqWGvw2teUjrHw5AJtZpz7ORTiX2qFK3VxvKJ8soJsgt6w+AVEILACl6j
         iYpWDzNBufQeGFLrruzXmoigxK+G9CaJDRdp1dtvIruNJ4qILiKm0M5BfqB0jSpv0MGW
         zHw0qCFOoK37qz+gy+LMO//5tzNWqHiz+Pqlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsPbjW9pFoguIa0tQlWIDr3b/dmdC3nrtYBag6zrUZM=;
        b=1F57YJ2PxtIfRUjDxetII+8oLOZqY8FcUFhY4HLIV8uCFVrzWs3YQJ40R/hHWL0OpM
         QGOjkg23k5EPSI35+GqGCsLfhcy9//LA6I0cQlQBisOfk28uLjlzJ1f0ySCR2yqmzaGV
         2W/C3RVNEhrHF2uYfTzV/Xv/3hwtu8z8+uWyFBY+/cZMA6G35faf5Rvqh+lJiz8rpDsA
         n1Jzd2/sQUaMO2fjco0iGBpW4QWC2MONn5tx+cbCVIGPS8cjJ6wVqcMc+UBChezxIUK5
         Mb0D4mfhmvmR3L/3sif9+u6i2GT4W1XF9/5dWHSaDSUZDsVldqQp9mr17sc7J8OgWVG6
         kjDQ==
X-Gm-Message-State: AFqh2kp/rN6V4xthhVgGidy0jiosHb8NqiOkPZtB0PNR0oGKuvTJEjtb
        zRJi70VSQEQFLu9Fff6Bfl3r/d10qFnIE9DZ
X-Google-Smtp-Source: AMrXdXv7HPGK2nqLyVU+5GgjA390iyOaowjDrV9rx/Q8w2g+81fNyr8L8idxV7ZZ9LwbO4e6aqht1A==
X-Received: by 2002:a05:6102:b01:b0:3b5:2fe2:aadd with SMTP id b1-20020a0561020b0100b003b52fe2aaddmr43504586vst.32.1673628595383;
        Fri, 13 Jan 2023 08:49:55 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id d3-20020ae9ef03000000b00705e0ad29cdsm4807484qkg.77.2023.01.13.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:49:55 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:49:53 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113164953.o63hu5pgetci4sbb@meerkat.local>
References: <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
 <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
 <20230113163619.4ab5oyqyjrthxrwv@meerkat.local>
 <7a51b925-cb0a-4b48-fc14-171006f73298@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a51b925-cb0a-4b48-fc14-171006f73298@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 05:44:03PM +0100, Hans Petter Selasky wrote:
> By using a cryptographic hash algorithm, the goal is to avoid tampering you
> say, like tampering on the internet, ISP, cache node and so on. To me that's
> clearly a zero-trust thought. You don't trust the guy(s) that put down the
> infrastructure, neither those that provide that local cache for the GIT
> repository, only the master repository. SHA-1 gives a certain confidence,
> that if you checkout XXXXXXX, then you get a likely expected result with
> reduced possibility of tampering.
> 
> Anyone could intercept a CRC protected blob and re-compute the hash and send
> it on. But not a SHA-1 one.
> 
> I on the other hand trust the guys that put down the internet and are
> providing the cache nodes for GIT.

I admit, I never trust the "guys who put down the internet," so that's a very
scary scenario to me (and I would say to pretty much everyone else on this
list).

> It's two different world views.

Indeed, werenotalike.gif :)

-K
