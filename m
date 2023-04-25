Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C3C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjDYVAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjDYVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:00:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBB14F5F
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:00:14 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5562c93f140so35152477b3.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682456414; x=1685048414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9u5Dly3vtsHuqctBPPU6mWlpMfy++Qx48qbCQm6jvw=;
        b=FsWsOolx2SWLuXBcjI4VKAUN05VpnOJ7VFo4iDkDNgdXWGJrsn6qSIgJ2gd88afXpi
         BoEa1IrIeJ75LJgGTNMNgqAs+aEaTAEBmBgTEYnAWLXBK1ceUpuYQCOW2JhbKJrH1+KJ
         FzQ0tb14ylXqU5JW2MGdTDAn/vDG7qVdFmRsThuuGUTBywaaaFVmuI4u7vEkIzFDIQfS
         r2YAaY86DoTqk8upUyRKH3GFQRfraAUWZfJhRlUYNXzTiYxgSTaDJIl43+d9G3fZucDO
         qMnD+XYH7PTzHC8f/OHnJ43FTbkbMSsmGjTfgE5WAff+9J72I1V1Sr5cd7HFXP+vnHDN
         bCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456414; x=1685048414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9u5Dly3vtsHuqctBPPU6mWlpMfy++Qx48qbCQm6jvw=;
        b=Ht8qXIRPMP5g5709NKwpbvluI33xdG2t1g0Xc/Kw5+VDppU1zEoQJ+/udHxweSw4rr
         W+ulOkqBP/XlUSQFZQceLGUfEQJ9DDrT5tAVHMIDeioIN7cLqLRs2iq7h6UGBIrVAiY5
         1ZICe8LHSWedJwpny1A6j+z1LoBz+ipmNNumAbml939PnS67398sgTXbA67mDEA0IJ4x
         afcC9hjx49iSJK7GNqI9nYhFus3cogXb3XNRujS9eJ6j82jWOXNKttclZL0E7DiZnV2I
         Xzrif2Nqvza4J3LepBLRQjEFOxCbLTS5M2tMgEUWroASXnVY7Oe8A0J6FCJg3yWX9cnI
         qxQg==
X-Gm-Message-State: AAQBX9eLyD25qXEQnevuhggDibXrk6vNBGZNq0BTqlZy5xzNoPaiOalZ
        XSAh/twNKTlW5WRVlEB2vQxgaQ==
X-Google-Smtp-Source: AKy350a6O6OflGSY9jpoLTtRbJ6UgGx/FRSWoAZgwJYRN0j4C/4lqHb6YWAsUkPRH1OqSezrIUkyWA==
X-Received: by 2002:a0d:d541:0:b0:54f:cbaf:36d with SMTP id x62-20020a0dd541000000b0054fcbaf036dmr10390824ywd.35.1682456414024;
        Tue, 25 Apr 2023 14:00:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a81a50b000000b0054f3e4bf623sm3780411ywg.132.2023.04.25.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:00:13 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:00:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/6] string-list: introduce `string_list_setlen()`
Message-ID: <ZEg/XPbtaAx0tPzK@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <ae8d0ce1f25f26da09f2e3f5bc68f85cc162ce64.1682374789.git.me@ttaylorr.com>
 <20230425062107.GA4061254@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425062107.GA4061254@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:21:07AM -0400, Jeff King wrote:
> I think we _could_ do something like:
>
>   for (i = nr; i < list->nr; i++) {
> 	if (list->items[i].util)
> 		BUG("truncated string list item has non-NULL util field");
>   }
>
> though that is technically tighter than we need to be (it could be an
> unowned util field, after all; we don't know what it means here). So I'm
> inclined to leave your patch as-is.

I think there are two ways to do it, either:

  - something like what you wrote above, perhaps with an additional
    `free_util` bit on the string_list itself (which might make it
    convenient to drop all of the `free_util` parameters that permeate
    its API)

  - have string_list_setlen() take a `free_util` argument itself, in
    which case your code would change to:

    if (free_util) {
      for (i = nr; i < list->nr; i++)
        free(list->items[i].util)
    }

> This would all be easier if the string_list had a field for "we own the
> util fields, too" just like it has strdup_strings. Or even a free-ing
> function. But instead we have ad-hoc solutions like "free_util" and
> string_list_clear_func(). But that's really outside the scope of your
> series. </rant> :)

;-).

Thanks,
Taylor
