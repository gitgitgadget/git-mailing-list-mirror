Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE6C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiKJCm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiKJCmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:42:25 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5011573B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:42:25 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n191so299422iod.13
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Q3Hq5BaxRz6m9zME/G0Gc8BVSuaaqptmhmXXhwvWY=;
        b=P9PZanI1+GjEPbQC8E/bvQwKoZetdX4LRTNoTIJzcviaFMslkI2ydJeyBSCuKIoZnB
         xhXhIXtzMN14a+t7nPjVLTmMI59KsNKYPzvR+j3Gbt3z2NqDLPBJh+WrcQiMa8HVgUwM
         BHSHE8MD0vQf3bDjbdRl76QOn6CG30ubJ0tDI2VIjjVT17Dr/0tDNUmAsO3bqsYhYjmh
         ML2DbpNu00W3zoTtBa7fS/w5yEDKQiK5RVkxVa+7knSviFb/aCOXeN0n8y9JWjHJTpZD
         uSaapEpFblIqnNtXTDz8NXBkqmNk01CaFoa9kmY9rCzqeOjGaLFP1PQk0kESqGHraToL
         ZC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Q3Hq5BaxRz6m9zME/G0Gc8BVSuaaqptmhmXXhwvWY=;
        b=A8+td7In/tzd585DxSNrqKrh0bH+Eu/rgdym5rr5lNIGErmwpB3P8SjV7lcFBUr3Ul
         QCkmGjza1nppDuom+ckDYhV3UuKpdlUpEbO3UT1/jV4wPoaAKoql9+XaOEvwvFqTGu9O
         tZgO1UwEUulaO6ohRYhongN9kgiUgG+Ro+MV6+OkCJUb6HTD3AE7ElObtdhtWzPpUdNE
         fPP8ArfJb9LHqVvsihxxS0gi2+utvJMVPafgVdbGoUXHQErZil8gxi8wMlZJVrkgEK3g
         m882sMAqBtGYOHllNZXkKUccmDFRC1L5XfSsC5P2qeWpmTrom+k6CzLijursamDyWT20
         mcjA==
X-Gm-Message-State: ACrzQf1H8Y5dlrMCZ+75TMULKkffI4SrY7yOEwZc2VGZDW0GcE3xwf4I
        fmDqcS/g5PcL827QrklwYinmZw==
X-Google-Smtp-Source: AMsMyM5fd7FOUiR8cDf3obFabVGBm3GcVhh0cSNQ/qKeZQcUNy52wOrHYEIrG4EWk3afTmFpkQZOag==
X-Received: by 2002:a05:6602:2357:b0:6ca:31f8:b792 with SMTP id r23-20020a056602235700b006ca31f8b792mr2366966iot.1.1668048144435;
        Wed, 09 Nov 2022 18:42:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e3-20020a056602158300b006ccc36c963fsm6157554iow.43.2022.11.09.18.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:42:23 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:42:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
Message-ID: <Y2xlDvmXR4UJgofB@nand.local>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
 <Y2q78ofF8fsAX8XU@nand.local>
 <Y2unEeio8cgmBWCX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2unEeio8cgmBWCX@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 08:11:45AM -0500, Jeff King wrote:
> So it all seems like a step forward to me.

Thanks, all. Let's start merging this topic down :-).


Thanks,
Taylor
