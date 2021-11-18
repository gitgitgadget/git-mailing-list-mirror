Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD8FC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7761B73
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbhKRKVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244918AbhKRKU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:20:59 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070AC061224
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:16:00 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id r15so12502604uao.3
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w83kNrHT7NzVCN3FqN8B0dBbi0Yxa2YVD0JzahYHHYo=;
        b=qRxZSPko8zZr+6/L5t9Kwr5YjMqzlrblkljrwVNNKJV4fe4T3cnkiwvQwFHikVT2ek
         nDrm3e3mzvrvNzyjZh632sQuM1FtOi3SgGi1POu8MKdcBMvILIDg/nAm5TI8duu2MiwU
         LNBfylcLZWvRJbp+6IwwP72XOdcqVOtTRA5Jjb8P1s5LMl/5f3rgWQqkwWsY/tGEj95y
         qkg6qg0ABCKS3Lc5TdWeK7lDS7GUmlKaF/JczY5JVHNoy6jRvtAWOLYxHZyycBJbC8DP
         wn1Vaw+gXR4qWTnr67DXVllnLj0PBNn2+P1qPd9O02WAxxfga3W/Q/U9Ujg3QfP6JB2M
         ZQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w83kNrHT7NzVCN3FqN8B0dBbi0Yxa2YVD0JzahYHHYo=;
        b=rue9SIcJ5Kbi1H3nhgPfT+WA2XyPBqWatSWEWMKgst2Fg35YkDZGn5+36AB6DehNGi
         eE0TPpNIV8ahMdo83DDRaaOE+qqZIC5dItaO+BsHOk0cjGso72f4C35R3pVav7dM5Man
         C7GZu6YL2klmxPo/pB1ALwik3EoPrOjP/D1L7t9r+0eMwyyzMYjsxzrKGyO5/000ljFw
         racI2wV8b9W85xWh9G2+LJ+y3avdE61lofiTFfDoJoTmMXcSXyiqZPn1hd9+KiW2a2VM
         ym3VX/HxwTHFBMAp5GJt9l400qFw6NwRuTeZ8745OONNW20PvS9r9NyQutEO8mM3EVdb
         b6xg==
X-Gm-Message-State: AOAM5303ygtpFGb7n4zdj8x9CajcMTX/uk2CtgdWhmqmlVfhRiGtitmr
        u2SdPviPWK7nWdy6D0P35KhxoecSe0Gbdm0TfOc=
X-Google-Smtp-Source: ABdhPJwrNmaIKyTmi8wPv9MaQ1aYsH7MavmMCO1Xe4vowfJ0Dmxtw8SU6XxMLSSk4HYg5TLZI6hCoFlPPb90sP3sKuw=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr80320447vsb.14.1637230560215;
 Thu, 18 Nov 2021 02:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20211116110035.22140-1-carenas@gmail.com> <20211117102329.95456-1-carenas@gmail.com>
 <xmqqpmqxyla3.fsf@gitster.g>
In-Reply-To: <xmqqpmqxyla3.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 18 Nov 2021 02:15:49 -0800
Message-ID: <CAPUEsphbA0Qrnt-MdxyYT2OMrnXnbi0tN5_YNqLypCqDqZyeWg@mail.gmail.com>
Subject: Re: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, someguy@effective-light.com,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 11:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So, is this the final verrsion everybody is happy with, instead of
> just reverting the whole "paint hits in log --grep" topic, or did I
> miss more discussion in the original thread?

This will likely need at least some ACKs.

Apologies for the noise.

Carlo
