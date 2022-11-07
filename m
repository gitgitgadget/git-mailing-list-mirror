Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14716C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 22:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKGWpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKGWpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 17:45:40 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55105CEF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 14:45:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 63so10130738iov.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 14:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+cxXrNCdd/Z88CIfCHimgr2wanCZkPvP+3w3PFPJ+uY=;
        b=tPKw2QiiNwfRibe6oThUKJqKv/YpS9ka5pjTKPxAupnIgfPnCo6S/DgAv7ydUZasH1
         cLjs/MZ5Nd/fjhXCcg/63cBPoPgY3/Qg68pABlEESnTsBcfdo5Xm+n4LuhoydEXKhNSd
         hs+33GYovIT/c7eRNkvmFexE0pV4rAf7jd2aEiwLpkh/FN1Jwi8huqvkksMVPdU+AK9s
         mOM4bZwwOMjQRQqGzCx+L/xj/A0OdTk29Org/tGKCdpwo1g5AwB2lpRBhyPhftABE6/R
         6F6kPx/J+3fNrGy0j0TPtm/WFhc7BOxHEFpxQ5x++EPgrnQKKH2NRtOnmvXj1iuT5NF4
         crhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cxXrNCdd/Z88CIfCHimgr2wanCZkPvP+3w3PFPJ+uY=;
        b=2qf2wOdDORjBBUSJ6lLNhz+uTbWVEKS9EKhsSVZmKcrB6IPiP8QnCnn1kITi/a6ETS
         uOKGvH0fge3L5//BCMzBsDGOlCUUUlFPS4H5JUO7jBbdDz476b6BgVyO3YLawEx5j2Sw
         iqSQnMRBUG/KykpM7Khyb9bC4GabdnleMrNDkKsGyzkctxaUGm085uWI3j4Ctf8bbYUE
         1eChBB0oIO9abxL0tDOpnRTHz+19P/rCxK0WN7cs3kb8eMBqR2CAO6EPyBuw7WxId5PG
         VxuLdsXtRrIHJB4wNUo/n/Ih9Kz4w9ogXbKqpNHwdBge4+QJwZFIb3T/9kXXFslxDNfB
         Do3g==
X-Gm-Message-State: ACrzQf0xw1r6RIg5TsvsmeqUs7at6G7OU/9dHsmzPiivWuI4fC6ItzVt
        MV2UOGxcNjhX5yEax8vWnE6wHg==
X-Google-Smtp-Source: AMsMyM5FjKBERT/sGXOqSQmOFGicE0ldFOD1fmlAvPJ/RhMNXVlQAvKi6BmJaDEdS4Mb3Fw8O6nB5g==
X-Received: by 2002:a02:a883:0:b0:347:c2ed:9ff with SMTP id l3-20020a02a883000000b00347c2ed09ffmr29917701jam.217.1667861137746;
        Mon, 07 Nov 2022 14:45:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d5-20020a0566022d4500b006bb57cfcb88sm3598782iow.44.2022.11.07.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 14:45:37 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:45:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/3] notes.c: fixed tip when target and append note
 are both empty
Message-ID: <Y2mKjwpRME3EnQGn@nand.local>
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
 <221107.86cz9yx1wh.gmgdl@evledraar.gmail.com>
 <Y2l9yfOhiT7r2+H6@nand.local>
 <221107.86bkpitmw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86bkpitmw6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 11:33:33PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > I don't mind seeing the cleanup here, but I don't see why we need to
> > keep that portion of the hunk at all for this series.
> >
> > IOW, your "...and only need to keep this one" does not make sense to me.
>
> I was still on my initial read-through, and was assuming that it was a
> prep change for the 3/3 adding a new field, before I saw the 3/3...

Gotcha, makes sense. Thanks.

Thanks,
Taylor
