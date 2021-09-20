Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC1C43217
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CAB61242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbhIUCWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbhIUBvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A26DC07E5F7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:25:39 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b6so20567762ilv.0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uos0IMuf1qRArcR1m3OaqJ9DJlOLr29rCoXT5IpygYI=;
        b=q169mdKPomEIR9vJNz3I7nkSSmqkyc/VHHfsr8UL2ntTAn6HoHGqWIstn4cB0/kpxd
         hEVrH1vKXYPZyRJbA2FRNp2qIwzFvzJGwiWL5pY1PoTLFT0pdsTlWQCYTtI9cvQafn2G
         qenlRmvRfI9jvD06/Wsbi33NLsqwVkzARBRW5cSlyO5l0UgljltFaboGt+9EAP1mzMAA
         2DhEPNb958AyZnMQcnN5cZswuOibp40Q8885M/fsRQBDS59TVCBPVksTG204LQFyrZoe
         RQvzakMd048jBTNL2gOV3K5xz3OrDMQbK04ykEbxIrvOcQF+7ieHNxxTIHASlScTwSmV
         dyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uos0IMuf1qRArcR1m3OaqJ9DJlOLr29rCoXT5IpygYI=;
        b=pudtscY/6U44LztyDVHQ2NSWo79lYhCB/wu1d0v+zb6he8ETHV9xWntrGPOpeWKH+m
         CkvO1a4J+njVufwHeLM9aMSaod6h1NB5auBe3nOEOoffaeFfYTHhFkAKXf/Mq4E03toK
         nR1pVG8B5DLIOLy1iygJAcPdpZfZUWq6jpohRj4y9tnyuE4mKFI7E44hfPoaSK+uERY7
         uebTn2N2/8xymwO3BveerskC/YSPei8qZx/jtNAh/Y0p+CFUwmbvg8QU1lpxpynR91QX
         bhDGDiO9CYVShoiMSlBAcAj3A29M3tOghInE5R3TgGmwZ0dCjpQsjnqF07XRK3kXCgRG
         H85w==
X-Gm-Message-State: AOAM533RpfnzTnyH2tgFEt9zMmGGEPoK+OLVZlrMUOdCMmBVo4tQvgw4
        UN6pygHOBKAg2kWEOLm2xqmyQQ==
X-Google-Smtp-Source: ABdhPJwsbiGffqPcaOq7BYLsJ24V7HxkBWbRc44ZqHcZvi5m08Fgqlyi40SdiDAaIIcB0ynKu2c2Ig==
X-Received: by 2002:a92:dc85:: with SMTP id c5mr18937485iln.104.1632176739006;
        Mon, 20 Sep 2021 15:25:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a10sm1944012ilt.69.2021.09.20.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:25:38 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:25:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/5] repository.h: don't use a mix of int and bitfields
Message-ID: <YUkKYWEc9vXFUsDu@nand.local>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-5.5-3cc033b8864-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-5.5-3cc033b8864-20210919T084703Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 10:47:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
> There's no corresponding config for "command_requires_full_index", but
> let's change it too for consistency and to prevent future bugs
> creeping in due to one of these being "unsigned".

This was the only thing that I thought of while reading through the
diff, so I appreciate that you explicitly called out why
command_requires_full_index was changed in this patch.

This looks good to me.

Thanks,
Taylor
