Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36212C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C9D64E6C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhBXEvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBXEvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:51:07 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10DC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:50:27 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id dr7so497245qvb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gf1t+VxJZoEfKaB79VP4gx+9tL1B3a5OUBdUKYFGh64=;
        b=0etfFyrD47WEJs/wLtRgZgcTv1kt18AYQSifHaPBQv2fP8b+iOgvDj3lTSFPSZL9oT
         EmMaxOHfz5cgxnxjNzoen4sefGMBCd7rl66SGH6Iy0CdpZDl7d0Vg9OKB79mX6Hh0iJH
         /tXlh7FeUwFwpCQfWJ1i5vSNIZsnq+g1cDzjLJTanOe6ABSe74bQJjUtCKJKQusMTRmE
         Q3K4ji/6lxg0iccwRcSQaQ/eBx/iqGFeQ/OEJfDh/8cXKcS0JUnpnY8VHJgJYKqDj5DK
         wA45UWQjr+wPWfsk9WpZzcI3HpQKO1snzVYhvXV43Mi4k0Fg8t1y23dBzgRdN7V8Zi7Q
         zxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gf1t+VxJZoEfKaB79VP4gx+9tL1B3a5OUBdUKYFGh64=;
        b=kFOh/XgdcpAhuOtkCvJgn95Vo2ExF4pyvojaMgSaduFiN05tSIeUPNiXPEhl0I+JTO
         oUlE6m5ikKs/ljQ+N5WLDptzwMuFHNDybKA4Wewubzx9LibmCMwofxbE1/ZUntxW+LD+
         pxhGZTJQIPauHcsZm08amWJ+f/RN+SQbH03607HRlTf8Jk/pS7XuQrFgvIJN1HWU6unb
         BVtyoGwN1HF9Q/MzC0uJETX7uMERpStrlNkRGa00S5x6mTJMvG5EsV9/kGjLW2FyisWr
         SmyTPmszD4povQg0D6zId1rvKaDRf/swDCnGUgRx39+zfHq0RTAPblXj8YECt7xlCWhF
         tFtQ==
X-Gm-Message-State: AOAM530r4wNo11QEPobwv18jd9nPCir9IxEy6zAftd7w9qAW7pUHav9B
        7M2LVf48gR1En6UCcMH2bFRBhybTmxtKz1hD
X-Google-Smtp-Source: ABdhPJw/JRJ0LalpQgi3aa6qIGodLu7R8oczxYDM3zge5TfrPiTSK/JgIl+vkZ43TTFT6LM3RC2i0A==
X-Received: by 2002:a05:6214:1907:: with SMTP id er7mr28153389qvb.27.1614142226620;
        Tue, 23 Feb 2021 20:50:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id x3sm749842qkd.94.2021.02.23.20.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:50:25 -0800 (PST)
Date:   Tue, 23 Feb 2021 23:50:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDXbDwOwNDJUZa7b@nand.local>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 11:43:15PM -0500, Jeff King wrote:
> The workaround here is enabled all the time, without a Makefile knob,
> since it's a complete noop if open() never returns EINTR. I did push it
> into its own compat/ source file, though, since it has to #undef our
> macro redirection. Putting it in a file with other code risks confusion
> if more code is added after that #undef.

Hmm. The patch below defines it in wrapper.c. Intentional?

> I do still think the OS is doing the wrong thing here. But even if I'm
> right, it's probably prudent to work around it.

Regardless of the above, I agree that if your explanation is true (and I
have no reason to believe that it isn't) that the OS is indeed doing the
wrong thing here.

That patch below looks quite reasonable, thanks.


Thanks,
Taylor
