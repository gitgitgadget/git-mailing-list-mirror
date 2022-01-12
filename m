Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6BC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbiALTHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbiALTHH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:07:07 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A744C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:07:07 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 19so5089151ioz.4
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XwAAjHJPhGz0blRHCt0sDHcZpmeW5LJXM5CHoyEhGZo=;
        b=1G116EE+1ymi4jn+/xaE+Hrg5SfaaATrDWCSSKd2nmOxNN92Hm6vur16BwGH6hjyIh
         YgR1a4Be0zPtBDPJVAskzC6difYexwsk4pjdnc1QR7C2XFPJHQzLI96Cn0GBXs0Z+EE0
         6nCUbNO57zX+LV18WFSTc6x+vedou+2bt5zXRsX1r06uYiwRKkrveDSiaNVPbmYJyG0a
         t4guJH1Jr9ASkbtepuqQRezvWsvqNB7CENwf/41lxto1fjVT7+XyXZEW1KdAoE5hEk+s
         J9srGbaGXdrTNlZEvRNpeUN0ioeHjcLRRkONEElQQ7qvj7W9ZwzizwxOU8WLc13CszvC
         qijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XwAAjHJPhGz0blRHCt0sDHcZpmeW5LJXM5CHoyEhGZo=;
        b=WRDAPkCPDv3w64HIdyPY+hn2VF0QJb3rxNZ3RUQUd5oH6VmeLYCa1PQUQke/I2eViu
         q/OJgCR+0UkdRkNuZ8jvNsGhu8adeZe+NW4UnI+m5nQgPnLyehiC75gDAxj56dvCB+01
         uPwtRkMkJh2dagmVyYYEop9fsuI2n9q1DtOtZX/qggsBhRV/+Ph0t+c+2kCVMKQTvzZu
         tR+KSt4KNXMcI6BBVcilF4zPoQQDeav3yHV8qAPn2SgyAkB6GAqFkJo8t9Mxfnp+LanT
         OpFX62WWAIDsJ+DsaVHwO8L9t10gUvds2V3M4jXGFMSypp4bOn+U+2Uf5wBO88paURMW
         UpyA==
X-Gm-Message-State: AOAM533TTD4VwPJ200JOqdJ622ssENP3E+6QFCB8sFDIHqhY7k12tk3u
        kbPvT0QzQOA47YfsZiabjlDOtg==
X-Google-Smtp-Source: ABdhPJy5+WDEbM7annMMbkUnEpYAt9lmR5Lmrye3t6b/rQ+3Xp8K3XzlAhG7xSB5CTG/EVpfBpiQiw==
X-Received: by 2002:a05:6638:c:: with SMTP id z12mr526416jao.123.1642014426871;
        Wed, 12 Jan 2022 11:07:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g1sm410331ila.26.2022.01.12.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:07:06 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:07:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Message-ID: <Yd8m2YeDZrgSiFzJ@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
 <Yd3dao5Qh5yl/cBs@nand.local>
 <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
 <Yd3mCVLyxkVTNcS9@nand.local>
 <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
 <xmqqh7a8vkuq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7a8vkuq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 11:02:05AM -0800, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 11.01.22 um 21:18 schrieb Taylor Blau:
> >> On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
> >>> Am 11.01.22 um 20:41 schrieb Taylor Blau:
> >>>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
> >>>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> >>>>>> In any case, you're only setting the lower half of `min` high. Maybe:
> >>>>>>
> >>>>>>     uint64_t min = ~0ul;
> >>>>>
> >>>>> yeah, that works.
> >>>>
> >>>> I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
> >>>> somebody more confident than I in this area would be welcome :).
> >>>
> >>> It does not work on Windows: unsigned long is 32 bits wide. You have to
> >>> make it
> >>>
> >>>    uint64_t min = ~(uint64_t)0;
> >>
> >> Perfect; this is exactly what I was looking for. Thanks!
>
> That sounds perfect.
>
> > Actually, on second thought, UINT64_MAX would be even better.
>
> I wouldn't introduce use of UINT64_MAX, which "git grep" does not
> produce any hits for.

> Unless it is very early in a development cycle, that is, in which
> case we have enough time to help platforms that are not quite POSIX.

Yep, I agree that avoiding introducing the first instance of UINT64_MAX
in our tree is worth doing (probably in general, but certainly now that
we're past even -rc0).

Either `~(uint64_t)0` or `UINTMAX_MAX` would be fine with me.

Thanks,
Taylor
