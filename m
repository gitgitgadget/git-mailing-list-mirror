Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C8C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiLFAbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:31:40 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4D1D0C9
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:31:39 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q190so3644824iod.10
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5eMM8Iy2KGRIo8gj7D3wa77T400/wZ3lOJy20ymK7I=;
        b=Ok4UK2IVJ4vd6ADW1WE9+AnZppio6/hcQKDwHTEBsDmbPPH7JfhXB4nn0pGVDVsEmr
         78iWlS5/6Z/SBnxpWs4aGw+KWg0t5W7YFjs7CSsJnK3vchg8DhMoa4nAWZTj9fxlidsO
         pZy2/3mSGjTKBIUtkevV9+KJ4qHWzNnfdrb31QbQ0ekG4ahKGwR9aLx3HNJWQ4adyE4y
         LeU8bT/9xNaFm7t2A49Egyh/9UnlNco1E78Ds3IETXuXxcYqdZfAP02CblOTTVLGYsuq
         Fgjg3he2+wwF4ZZ0y6zlij+l94RTpOGlpvQYHg1mTSaC9+h3m7TN9apgbionRbqpwKsI
         ZMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5eMM8Iy2KGRIo8gj7D3wa77T400/wZ3lOJy20ymK7I=;
        b=bi7FM6OEWdqInWxFug5BxioIRLpl3uPAY7xX1JA90F3jKQbVIVW6YnzVnYik77opGi
         5W56bGSauPW4KpFFjwgIxxHF1wplmGRQieLL5Sw57cn2vw0AwXYKG0yad1eDGr+ejs+9
         n7NpENoyPVJPh0ry5ceWQ0bJddiUgAvAkD/VhMFzZ1jUN+u9BjDNaMa0T1WZPJTyCHu0
         81FgkUNjecHmZstu+K5uLc6dwm5MgxcKDD4P+q+64hZiynf3uCjl4msTq/7BtTKKt3vp
         oh5+pwKp13o5FM5I4VPLTTZYv+4PIhCg5heQ3/XLiL9z4GBEocqjaKMHqvsGzkuYguUi
         cxrg==
X-Gm-Message-State: ANoB5pkERUJfBiowyDFKd/OtlEPS1RPud4SfPL9qKULsreSilk8rgtB+
        OR4AWHzcA/nKXSWhqezg72CWjA==
X-Google-Smtp-Source: AA0mqf4YGhVp5kwdjfmvRJc4an2Q+ZUgkTqVSEqpvi6kHzG7E47wDxfydictMoPV1QjOCbfiFPpteA==
X-Received: by 2002:a6b:fa05:0:b0:6d0:5632:1bff with SMTP id p5-20020a6bfa05000000b006d056321bffmr30668256ioh.141.1670286698804;
        Mon, 05 Dec 2022 16:31:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n12-20020a92d9cc000000b002f966e3900bsm5590342ilq.80.2022.12.05.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:31:38 -0800 (PST)
Date:   Mon, 5 Dec 2022 19:31:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
Message-ID: <Y46NaUjc+eqzSExR@nand.local>
References: <20221205190019.52829-1-cgzones@googlemail.com>
 <Y453yiYAifv/oV5n@nand.local>
 <xmqq7cz5pf1w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cz5pf1w.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 09:10:51AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > So it appears that the old version is ever-so-slightly faster than the
> > new one. But it's so noisy, and the regression is so small that it's
> > hard to notice it at all.
> >
> > So I wouldn't strongly oppose the patch based on those numbers, but in
> > principle it seems flawed.
>
> Thanks for writing and reviewing.
>
> As long as we were touching the function, I suspect that
> the logic should become more like
>
>     if (fd #0 is not open)
> 	open /dev/null read-only and give it to fd #0
>     if (fd #1 is not open)
> 	open /dev/null write-only and give it to fd #1
>     if (fd #2 is not open)
> 	open /dev/null write-only and give it to fd #2
>
> with opening of /dev/null optimized not to happen when not needed.

Yeah, that would work, and it has the added benefit of not opening fd #0
with O_RDWR (though I kind of doubt that such a thing matters in
practice).

But it's still no better than the patch here in the happy case, since we
still have to perform three fcntl() checks to figure out that all three
descriptors are initialized as-expected (versus just one open() and
close()).

So I think your version is a slight improvement on Christian's, but I
would just as soon stick with what we have.

Thanks,
Taylor
