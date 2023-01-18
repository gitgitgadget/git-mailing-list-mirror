Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C8C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjARVYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjARVY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:24:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B7604A0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:24:28 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id u8so186077ilq.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs54h+oEh5nSMlOTgpCJ/t1+9oIDlB7fZpEoatdwcZE=;
        b=TKrKu6MdsZUGiWmE9s+amx+Q3ARuKwWKftSKD1IHv3nHC6Bghi+t4HGjIXZvUh9X9n
         qIS0e3KCHCN4aWkJzvnkk72F+L0CaThYM/5nLRgP0jqMGCvHM9RAcJPH7Mumcw5jT6LF
         vK/2xD1bGry6+XUsxFmksjJh7eyuOGqfdvdcRQyquAjgRO9X+J1a4DJsKU22LMqXfjFo
         GwidvMkEp89tnUDiaJupAImAplk4H9W/T6t4t5jKLCWw6rLPNHd4rQO2cT35DjIbZcW6
         57DU5TO+rZnKAbPkaB9yemUryMP6oRIEJ4xeJkQKsD69l+e4Z/vkVxx9C7l0X46k8nBC
         v1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs54h+oEh5nSMlOTgpCJ/t1+9oIDlB7fZpEoatdwcZE=;
        b=dP3wgahgV82FRuJAjxb9do5KQ2HlUFk4GhZX7i9Oc6kDf4Gf6EZidqFZRusmw2D704
         5k/pNsz+kuNBlpT6w3Na4WDxthFPNfwPrBYPX++XBUu1T1gj8pHW6eG85wv5BlK/LcP6
         gRxuKfnKT9BkpiJFfRS/8pUrkbvcapS+3IAvkjg2dvZ/oR/v0WbAXstQVFA/EvHooe3U
         ntqSI5p6gQQXcMik4LtQCRZSh7HbJzTgP9KypPszwpXcYMnEXxziDEHwgVnVjS85XyeI
         M7RIR59k66pTMQb6nbYEqufb4TXh4KUy8asBnSp60XaJGeFo8fYtu7IfswmBQfIkJKg1
         eW2w==
X-Gm-Message-State: AFqh2krdi0pqtvWFSh5Enz1io36qeeryfVjKAWFubOM1ZlA04gWgpDYA
        0FOwS3uc6uU6kt8ldQWd/j9o9g==
X-Google-Smtp-Source: AMrXdXuL6cEgv6BP872FlArGS3piYUE4mL08iaawgJuv+tt1K9hsKiWIjxq70UnujHF0xn4HqyT+cg==
X-Received: by 2002:a05:6e02:d50:b0:30e:ce10:b90f with SMTP id h16-20020a056e020d5000b0030ece10b90fmr5580841ilj.14.1674077067366;
        Wed, 18 Jan 2023 13:24:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v8-20020a927a08000000b0030005ae9241sm10197931ilc.43.2023.01.18.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:24:26 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:24:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/6] fsck: provide a function to fsck buffer without
 object struct
Message-ID: <Y8hjiWUAIuiWfJoD@nand.local>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haCbAQIV9s/95l@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8haCbAQIV9s/95l@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:43:53PM -0500, Jeff King wrote:
> However, the only external interface that fsck.c provides is
> fsck_object(), which requires an object struct, then promptly discards
> everything except its oid and type. Let's factor out the post-discard
> part of that function as fsck_buffer(), leaving fsck_object() as a thin
> wrapper around it. That will provide more flexibility for callers which
> may not have a struct.

It's really nice that the only thing we care about having an object
struct around for is basically just knowing its type. IOW it seems to
have made the refactoring here pretty straightforward, which is nice
;-).

Thanks,
Taylor
