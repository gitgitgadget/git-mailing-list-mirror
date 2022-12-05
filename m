Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F95C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 22:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiLEWge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLEWgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 17:36:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D61C11C
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 14:36:27 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y2so3964333ily.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 14:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YD5USKK6abuTOTQsfVcJQubXgyxM5U3V5WWSjEZzOW8=;
        b=C7zXjLsrAojfRzr06eupVs5Wn3Mc1SmfUZ7EJ12f2DT7c7nvSFat8FDgFclaLTBXhj
         L5Jg7OTEgPoEldwM9x8xKUO1yeJjVbCttq+QoqjBb1l8NTRQm9NerOME7CPw2ePgJaUZ
         pSn8nvItlpy090HwBlDUV8beSCluhNcxkV6vZRSTRntwJwwIaVKk94qfYLJaOlsYwg9Z
         fAM/j1foaN7CtUhpJpEjJABWZCTB2aeiu1XudVhhdqI7vANJ6sCBXonC0ex27bxYwNnH
         2f3M7QhsSbFVHjMAoPMVov616jPXek2rhMqo5JMt7R55Gif9m1iBGKZxObsLDZJbAGHq
         m4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YD5USKK6abuTOTQsfVcJQubXgyxM5U3V5WWSjEZzOW8=;
        b=5DE4ZNQ/27xxLuXOcAWyO3SvqgrCjDKGnAGUC4SSHvH0RLshs2uXf2vw6BPGqFYMHu
         tAteHqx6DKF7cWQP6MrvCDtZTvv6scm+RC/bpKweok1RxyvJHO8Si08MkPqqIOVsWxL+
         XYil0zCdWUEdu4Hgn7XJH4hRb4IQ6NTn3Qp+oFbVVb3l/JlEARL6TFy3rYoK+17ntXEO
         /rfApXZIlbjx07uHDJlDW2yCXwRurWb6dGYUeN2FyjxiOR4Q23PPJhNGs06rQNUaSlYZ
         wiw0llWPn4hj28cj2PatijJwUQCTZNkQtPlZcQvLPJ0/NDo9/bMqmH9v2Zmmv8PdvJAC
         oDVw==
X-Gm-Message-State: ANoB5pnODyjSwuiHzzLUnKiLpr18vehzRfuR29AV+AHZzp8+w1tLNDbK
        fpd+l5qGcyyowR0VeYdt6VD46A==
X-Google-Smtp-Source: AA0mqf7Pw3wvZhy7C5D1xYO5hAFjSw5bAjAh5v9FfpgvDQjec5+eLIk4/FNMc6qRm1R2D+EYcuXxAQ==
X-Received: by 2002:a92:360a:0:b0:303:5d8e:5bca with SMTP id d10-20020a92360a000000b003035d8e5bcamr3040383ila.121.1670279787201;
        Mon, 05 Dec 2022 14:36:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ci7-20020a0566383d8700b00389e690d09esm5926543jab.74.2022.12.05.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:36:26 -0800 (PST)
Date:   Mon, 5 Dec 2022 17:36:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y45yaYV3xFB/xR2G@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 10:01:11PM +0100, René Scharfe wrote:
> This rule would turn this code:
>
> 	struct foo *bar = xcalloc(1, sizeof(*bar));
> 	int i;
>
> ... into:
>
> 	struct foo *bar;
> 	CALLOC(bar);
> 	int i;
>
> ... which violates the coding guideline to not mix declarations and
> statements (-Wdeclaration-after-statement).

Yeah, I was wondering about this myself when I wrote this part of the
Coccinelle patch.

Is there an intelligent way to tell it to put the first statement after
all declarations? I couldn't find anything after a quick scan of the
documentation nor our own patches.

Thanks,
Taylor
