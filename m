Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D77FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJaUg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJaUg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:36:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187E12D21
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:36:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q142so4700361iod.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvyQCwcvPgB9n15hEnvqNLkhRboL2UtNXN9eHf/v17A=;
        b=SD/pMNGyOWEqH6o422GRb4byZPx+2R9/8oaN5ONmu+YNF4f8Qabv9Nhp8ajB/1DQuD
         ajYXHWgzEJXKG6hWvrpJIFx5ZhqlfOlDt6rzgEcK0SE83rgPMICDd8eajQAmMGcVBBM2
         47zsBJqXLrTA0L5GUQH/SpeVdjbUfmwiuLyx8HmJYU5ysFTnprAN5udJ9w2To6Ia9KQx
         u1h3dHTEjprrfrHTk8X2OGySQ/mxPQEoXGRUsXeKPDeycGBMlHDiU7P8hF8r2m01dyZ3
         0k/G4T02HyphUYfdGcQfFn+92e5vKoN30rirMmvcJdbqMbbQFetC88uT/PFDlUQNdJqs
         nuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvyQCwcvPgB9n15hEnvqNLkhRboL2UtNXN9eHf/v17A=;
        b=Eo4usyW6HWHNvbj3sB+bbD7sgelRcuURa3EBDKt93uoEKTa3ZFbr2HSUawVENvJ7s7
         SYGFfNGNFlSGCZuPYcmv0MblYOgFppjWttxeQENpCt8IaXg8lIlO9vJUx96fiBilZ34i
         J3CJx4kUiWq0YVYVy6qLR4vnhupgxHIrWD7yLynzM4bvC/Dk4v0ewZqAUvHtYyXZ1xrL
         Lg/QeyV/gBvw3Ho3ZRA4KxC87aVIa5TgEu1n1l3msHDCCuzfF+ywJp7lCRPnEhH2M4YN
         DZBQ88jUv95IKoPLQnKn8+tanlA6A1FkCevTZp9xraNOu3Z3QQo402WqSh9WucgA4wIG
         6JlQ==
X-Gm-Message-State: ACrzQf0QK2/FJtkj6UnfPGp/UZEKD5wkg1UbM/g+3iPu1msxbYiA0lCh
        c+wMYu+IgmODPR30NYQ6AUtFqw==
X-Google-Smtp-Source: AMsMyM6yHbM+HS8MhUZgY7JbxtS6KzxKB0wIfVeg+zOdIm4KVMNNtyjhMc0x6lo0/JpxXdzBys4EXg==
X-Received: by 2002:a05:6638:3e16:b0:364:1a1:6fe1 with SMTP id co22-20020a0566383e1600b0036401a16fe1mr8540034jab.64.1667248615656;
        Mon, 31 Oct 2022 13:36:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u3-20020a022303000000b00363b8ef4bc5sm3020707jau.71.2022.10.31.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:36:55 -0700 (PDT)
Date:   Mon, 31 Oct 2022 16:36:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Mark Hills <mark@xwax.org>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
Message-ID: <Y2Ax5XOgSOOcgo8J@nand.local>
References: <2210311614160.25661@stax.localdomain>
 <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 09:21:20PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I think you're almost certainly running into the parallel checkout,
> which is new in that revision range. Try tweaking checkout.workers and
> checkout.thresholdForParallelism (see "man git-config").
>
> I can't say without looking at the code/Makefile (and even then, I don't
> have time to dig here:), but if I had to bet I'd say that your
> dependencies have probably always been broken with these checked-in
> files, but they happend to work out if they were checked out in sorted
> order.
>
> And now with the parallel checkout they're not guaranteed to do that, as
> some workers will "race ahead" and finish in an unpredictable order.

Doesn't checkout.thresholdForParallelism only matter when
checkout.workers != 1?

So what you wrote seems like a reasonable explanation, but only if the
original reporter set checkout.workers to imply the non-sequential
behavior in the first place.

That said...

  - I also don't know off-hand of a place where we've defined the order
    where Git will checkout files in the working copy. So depending on
    that behavior isn't a safe thing to do.

  - Committing build artifacts into your repository is generally
    discouraged.

So while I'd guess that setting `checkout.workers` back to "1" (if it
wasn't already) will probably restore the existing behavior, counting
on that behavior in the first place is wrong.

Thanks,
Taylor
