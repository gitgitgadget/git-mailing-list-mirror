Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F8FECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ3SFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3SF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:05:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A45E1
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:05:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e15so8299955iof.2
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5Coz+6ReaXrb9lJ4L4SPQbA2UPlORQr0oRbJ7StdFk=;
        b=UjxoIm+2A+YIHg5YAAey5iKhp+EvbKx92zD03ZU6ndrxyRdzOWEJmw7YseitXXnbzW
         FfLaSW7fAGZpkYcs1CePn37pijaOjdJM5odY0cDULBANKrPuQ/DmJMl23PXy7JHmICbz
         dpfgpaNHqDTdD56zJAR4wBYfAqXiKN4otJynlVHIlV39+ge6+pZgHOtOBNBzx2UMss+i
         B08W4oPkvdiQ6KKzU5ry9O5wN4kiygwX8vZ5O33rE4/B62+KzHwrPTjWy5fgyFW+GRjI
         6Z9IPl9FSZD/0oYWQV5fol+BcdVRmz4WiXEhQkuyvT/ery/FdSOaIGoLhUwN1Z8azrOQ
         uTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Coz+6ReaXrb9lJ4L4SPQbA2UPlORQr0oRbJ7StdFk=;
        b=D1awfP7zBoVrjLHXoBTylK/eVHfGwMPFltQ32mZFw8m7ytHeikAzEeUQB9hIXcUDSj
         h7EEPb17KbqRa1YnvXf7fkY/SbARdul+y4UgahLb5TIYEVOrPb/1typwoASAXzw1nnki
         Z2NawDLcxwlVu9SdK7fyBAEApBaK5+UwFA8lA7jRANTBJt6CFFhz80RddWQuRZti1LkI
         M/SymeOV7jn5NHx+Q6YX5MLShHYXCB8wPKjJgRFMDcYa7000VCfoLfUp1hmos/EGsLUN
         MV91C9kNWG+Cr6N9EVchdcLfJqR9fTRc+V/i1IgRJsTrZBwALzl4j6mAcW8Lawy0VVz5
         UaQA==
X-Gm-Message-State: ACrzQf1tmv0tX9IbfKMAbw24Tvv7kGOxxZMF0EUSr1vc0Y7CZvU18PFa
        sH46k5ya+VXZvwjq/Ea08MQ5tw==
X-Google-Smtp-Source: AMsMyM7FyxEfMq5y+AiJ25Gb4xol510K54DUGLqmTF4RF8lPfhBiqqXPvMGaA1MgeUwYZ5RqRZ8oXQ==
X-Received: by 2002:a05:6602:2e0b:b0:6bc:d134:4791 with SMTP id o11-20020a0566022e0b00b006bcd1344791mr5019073iow.45.1667153128497;
        Sun, 30 Oct 2022 11:05:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19-20020a027313000000b0035a10a7e3ecsm1825849jab.74.2022.10.30.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:05:27 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:05:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/12] run-command: remove run_command_v_*()
Message-ID: <Y1685tnqts37KHnm@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
 <c14503ea-0b76-464a-02d5-0b001a462083@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c14503ea-0b76-464a-02d5-0b001a462083@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 12:58:13PM +0100, René Scharfe wrote:
> > Changes since v1:
> > - Do the return value fix earlier; it was only an afterthought before.
> >   Keep the colon (no "while at it, ...").
> > - Break out the xstrdup(), oid_to_hex_r() and C99 cleanups.
> > - Convert tricky string arrays before strvecs because Ævar didn't like
> >   the opposite order.
> > - Extend the example code in tmp-objdir.h so it still only requires
> >   "cmd".
>
> Forgot one:
> - Fix grammar error in run-command.h added by the series in a comment
>   that goes away at the end.
>
> René

Thanks, replaced. This round is looking good to me, though let's hear
from ÆVar before we start merging this down.

Thanks,
Taylor
