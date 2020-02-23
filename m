Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C3AC35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CC9208C3
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 09:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/G/f+L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBWJBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:01:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 04:01:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so3396956pgl.4
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 01:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hxRAFn/K/3x1KEFH4yG7/ozanT6qjgmzFnfNAQKCMv4=;
        b=N/G/f+L8LkDRvNgKBoOk+oo6hMezOGTnFhefehDuZFykDmESEkhPTERnXjZELsaTJ1
         rW61RrQlViYgSpqFYNwF8kEDCqud+e4Ya2wauXEitYYdwfG2UDmiVhU20yRy2WbVSoeG
         UKe8U+OzL/EHHaWgJK/M63t1e1bqlnl2ddV656eefhypmgmnuWaAV3TDc9YlwE0zMBjd
         73bmDfnNWOUXH4n6QYLYZKfnNrVySOKUNgKc9xWYEMPsTmCi3HZoAp5JRGUelVijJQJL
         ci9rlZ3FWOjDD3TCcSNttPRLxDOSwnkTaIzbnJjqM4Mc4riMLZ2U7Id7nzow2HbafviL
         qBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hxRAFn/K/3x1KEFH4yG7/ozanT6qjgmzFnfNAQKCMv4=;
        b=Nl4N4PG931kz+1/7fI0chX8BS3vN6AXx7v4hWgettT5hCkJ5mk4QZ4JhX0x09/8Srg
         kQYcJ+ffbJH2BZQBT2UUP/Nz1NIeXgyn/V3xcjcQxmw2t9WcFCZYMjqmSnhxodeU3VoB
         SNutmrxodWPwvqO/8ecZQ8AmbRjuWW306Q95Cw3MP+TTafwwAXzEr/dGYPusfQDjIpvX
         4V9q9kmuEzExLfOpYlGXgfbJgA15vJh28n7LUDFB1i0XKgG5bc1lG7H/IolpfHgklur2
         sI6P/r0ARhKbyrUBUHdMzv6iw5Hwykn3GcSFnfHvq2On3ljprYM8BnDJVq1vGBFGFkYJ
         qVGQ==
X-Gm-Message-State: APjAAAVDtutCWf5xQa8u/5FIN0dau3lo06xtUqkoKpmlGe7jLIlVi89q
        /vixPy//N+S+fZeBVVsQpoSvuzXlL8fKywtNCBw=
X-Google-Smtp-Source: APXvYqzZNwA4mErX7fn2XL7PQmtIVH2lEG83be8FCEmwlVM76nxQrKZnW6BuSe+zhIMQDthkE4V8liSfIpFANhuY9t8=
X-Received: by 2002:aa7:86c2:: with SMTP id h2mr46133225pfo.45.1582448501397;
 Sun, 23 Feb 2020 01:01:41 -0800 (PST)
MIME-Version: 1.0
References: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
In-Reply-To: <4140dade-d999-a74a-1f8e-06eedb84ed20@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 23 Feb 2020 10:01:29 +0100
Message-ID: <CAN0heSpwNg0MKN7SCRi9b2CnxwQdCwxpc4LEkeVV4f9mxtYkLA@mail.gmail.com>
Subject: Re: [PATCH] use strpbrk(3) to search for characters from a given set
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 22 Feb 2020 at 19:53, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> We can check if certain characters are present in a string by calling
> strchr(3) on each of them, or we can pass them all to a single
> strpbrk(3) call.  The latter is shorter, less repetitive and slightly
> more efficient, so let's do that instead.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/show-branch.c              | 2 +-
>  compat/mingw.c                     | 2 +-
>  mailinfo.c                         | 3 +--
>  t/helper/test-windows-named-pipe.c | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)

I failed to identify any other spots, except for some hits in test data
(in t/t4256/1/) which are probably better left alone.

> -       if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
> +       if (strpbrk(av, "*?[")) {

Indeed, the `strchr()` calls use the same haystack `av`, as opposed to
`av`/`aw` or `av++`/`av++` or so. All conversions in this patch look
good to me.

Martin
