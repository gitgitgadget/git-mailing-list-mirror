Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECBC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiKCAmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKCAmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:42:14 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660F2AEB
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:42:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e189so207967iof.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpsBlh+OOurqOKotMclxfMo6bRb5EQL/He6/v06KzeY=;
        b=655tEvlaEK6wTGP71+KJ5Cj2Al4kDNb8p6Uboy5QQjqp+hKFGWEANVuE75GjmQjhqV
         skOTA96/Ed+BjYaXF63osLNwLIWKmPAz6wkMYFcNCtEmsExtpOzlzFb8X7+18pl25ObN
         +JpsG1OS50Fo8DziKWuuXHEcTmXiQdeZGqj9ycqhM5flMGL1OtNz15EYjhrqIA14yJch
         Vu0t3cyd5mK63KKDH8rR/skr+KK/rkEOaYA32P4TF7Li+O0Vtj0dbuqYl0/cCVrx4ds6
         GkmNQB2xt3NCl78X80OURQ4eJk2SuIhWJmjlVtJxnrRTGis488ssT7ZF4wrcTUDHMDx9
         XTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpsBlh+OOurqOKotMclxfMo6bRb5EQL/He6/v06KzeY=;
        b=sNr/vpJaeMV+K1c1zN6IbrM68TIF/WI5vj7pUfdKqOr1TtB6NkJkDMtuxvU89RUhgr
         YtiWwx7rN30PVUPW2bp6CkVIjgljPEzm8ShnqOoXAtFDr0oC56oflxvLSonZedYYQ/xp
         NcohdpeeAeXcq4+FI2R1+topjd+FhtEcBnj/h/LOkG/E3IgtihimIlGjSEHm+X9TZmJy
         TXniDJRFCgdBTUESpuc8lJYAsuFoXBuk5b/W+NPd+tigGQPm6VVyvIP12MzgmyTlZrYa
         y5z7M1rmbPzGSVn881wm2txd+97n/u5zh0VERwt4JDtXmwM/Kq8blRX63CLE1H+gArZc
         Lclg==
X-Gm-Message-State: ACrzQf2F1KsCKPdWLoofJpvfWsXG9+sSq9SjZYd1wMVR+wRzS66o97f0
        Y8wxfTSTMCGS4MwMiCHVEpYssA==
X-Google-Smtp-Source: AMsMyM5sfDZPYAk48z60AQVgbi5opYchVHes5zMII63dkr01IxyLej3pkj9HiPBYSQwLpUls8JugRQ==
X-Received: by 2002:a02:c90a:0:b0:363:2b87:887c with SMTP id t10-20020a02c90a000000b003632b87887cmr17710774jao.72.1667436131740;
        Wed, 02 Nov 2022 17:42:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a056638216a00b00374d6db7566sm5220641jak.117.2022.11.02.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:42:10 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:42:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: Re: Git Bug Report: out of memory using git tag
Message-ID: <Y2MOYfalWOB9YlP2@nand.local>
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 03:39:20AM -0400, Jeff King wrote:
> After sleeping on it, I think I fully understand what's going on. There
> are actually _two_ bugs, but they are closely related. ;)
>
> Here are patches which fix them both. I may be setting a new record for
> the ratio of commit message lines to changed code. But it took me a
> while to figure out what was going on, so I wanted to explain it fully.
>
>   [1/2]: ref-filter: fix parsing of signatures without blank lines
>   [2/2]: ref-filter: fix parsing of signatures with CRLF and no body

Indeed. I agree with others below in the thread that this is very well
explained, and the fix(es) both look sensible to me.

Will queue, thanks.


Thanks,
Taylor
