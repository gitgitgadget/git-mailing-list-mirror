Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6902C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 02:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLGCgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 21:36:10 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE954748
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 18:36:09 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 3so4753947iou.12
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0ndYzScjyCOJ+yyRF9Z0ojJkKEBHT0AlBGpugKbXys=;
        b=vwjpgoPZ8DOfFcH8lz12hcaFFsuUukuS93p+n70K8Va9wOeTWqLaAjkri+Maq+dd/v
         klaqzptptEdijJ4VSSfoFiJgCaUbgC02RZSboVZq+sJh5z4bz+qeZ/LK/a5kTvic/Uet
         ebO19saUpvtDY5xxviGftY24ysl/+KTMFPH2/xP/0NRsV5S81w0QZm99LT+88+X3Ufk4
         ry1g+YJr9h6AM2w+grEO1vWErZowvinZhIVXzaZzHhdMc75p6Pe79okBxHT+2fTjX8M5
         WqNiXCw4nN23Rz7lcLkg5bb0iy4gdccSfIBvmltUSjh/JxH29I+oVmiaWwMcMqatd6UX
         3Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0ndYzScjyCOJ+yyRF9Z0ojJkKEBHT0AlBGpugKbXys=;
        b=5pIgFE3QeLy4Z8fzLi6ujpkHbEHmGNuyj7KKt++ftAHiwYG/1p6LxmSpbRu+YKvSuP
         jXJxWpurJjs+yHDL+H5qJ1qUd1c+UoplCXKeWutOdG5qG7UAcfWnOEbQLSqPyPMT86SX
         Vo09KJGLQLzWh/4CWfh4i/JizcNqRR4s2+hqDrSXeR2erAMMN7tXanxbjTf6+NJwZVF8
         v4ndabsJ3y4DDzPn4RsqoRO/TAF5c4stzw4zo+uzhc1hGTMZUbeXkAi2wadbLk55ttFy
         Kwj4f8wlvhY8lenqlMQAE9VOV4I3uPLZDGZreRi+3W/UTF34mofIgLsDsFN8BXVmbjAA
         3g0A==
X-Gm-Message-State: ANoB5pnVN2jwMzIHyI5DET8jv9AYnekhBwkSFzIZUolxV16pQDBBUfcU
        35hAOFoNOao5iXjIH1CVLUgNvA==
X-Google-Smtp-Source: AA0mqf63IHpXA9e+dLu9oh3GUZ3GDf36fxBqe8+Z8ylyu+foS91CokRTeB/CWaPPoYFn/NlhgdSG6A==
X-Received: by 2002:a02:298b:0:b0:35b:4296:ce78 with SMTP id p133-20020a02298b000000b0035b4296ce78mr35651756jap.317.1670380568605;
        Tue, 06 Dec 2022 18:36:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k17-20020a0566022d9100b006a129b10229sm7618450iow.31.2022.12.06.18.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:36:08 -0800 (PST)
Date:   Tue, 6 Dec 2022 21:36:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y4/8FzWiYasWemSW@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
 <Y46fHhD3xionHgPE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y46fHhD3xionHgPE@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 08:47:10PM -0500, Jeff King wrote:
> On Tue, Dec 06, 2022 at 12:12:32AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> > But if we *are* doing that then surely we should provide the full set of
> > functions. I.e. ALLOC() and ALLOC_ARRAY(), CALLOC() and CALLOC_ARRAY(),
> > and REALLOC() and REALLOC_ARRAY()?
>
> FWIW, I would be happy to see all of those (minus REALLOC(), as there is
> not really any point in growing or shrinking something with a fixed
> size).

Same.

> The biggest argument against them that I can see is that:
>
>   struct foo *x = malloc(sizeof(*x));
>
> is idiomatic C that newcomers to the project will easily understand,
> and:
>
>   struct foo *x;
>   ALLOC(x);
>
> is not. But it feels like we already crossed that bridge with
> ALLOC_ARRAY(), etc.

Yeah, I agree that it might be off-putting to have that convention
pervade throughout the tree. On the other hand, though, we can clearly
document that in CodingGuidelines, and make Coccinelle rules that
indicate our preferences.

And indeed, ALLOC_ARRAY() and friends is a useful test-case for gauging
how something like this might go. I don't think we necessarily need to
do all of that in the same set of patches (though I'm not opposed to
doing so, either), but I wouldn't mind getting there in the end, one way
or another.

Thanks,
Taylor
