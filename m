Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C830AC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 02:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358213AbiATCoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 21:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiATCoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 21:44:09 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F7C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:44:09 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id w5so2761223vke.12
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=brqRmCNxMj9qoK8DCLn8ItmmwZ1JbdDwzY8/x1HoKjU=;
        b=eX2/ttyDqrVTCMfs3/8NyFZfQ+/XUkg5pPTviTMI+0TO1OXiqiPNywkd3p9pt6yrMQ
         ZMHmLxnY1KOIhiGyYcPGOAvjsPHyC737h2IY4rUbtQKZIjXaTYJCP6kj3+NW+tIJfXXi
         egOGpmME6A8PmJ7kuaN6szd6t4vsCLpUf9FwvSy1jZNY5NkY0jV529dLHqmzq99mszam
         CICHC+vKWUMjY8esjCUTecB0wwFnwj+SMfAwQwhstDfT6TS16eSGTyA5Z8RX9ZgDa0tF
         5BQHItN7JTJ7+nuuU73Gnvta69IIkqI4l8QERhSBrTaUWVXO0kCR4LF9Ty0E2GubHW4a
         4lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=brqRmCNxMj9qoK8DCLn8ItmmwZ1JbdDwzY8/x1HoKjU=;
        b=ya8ckHbeKoCjBI0JQVpJ0x3H7xYguyjcbhU5OZgIY03uEfsjUeSZTBXcvbIIXDIzJQ
         WEj8JHKyb/iY8R/H5V6Bc+uiWpAYnrxwk6jpXtb6p4Siz5ltFhQjO1zb1gbXB++FnyMp
         z9QUW1OsWKUQwdct0dCbl5aQXt8N5oGqruDdiHj2BBsptCOes0H6Dd0koS1uDaYlXeNv
         f9zj8kXff6yDOxIQ5NWvidmJsMP9UalM1RqzN7yjdvKpx2HgaFk0ghdiEf0gH/jZKKGo
         rr06LaaLx11qdYeTKhObklNgcfxu+adlU1DFF9avYdBX68rTODJZoUfnf/cfkzz213se
         CEgQ==
X-Gm-Message-State: AOAM532NDbJR/pnFyc2D8e0nJXGlFvJYS/UBV0m1hpdDFs87SBXeVxi4
        hKglEfpkVwTHeEvihB9nPKwCVkKnr0j1pcYWK1U=
X-Google-Smtp-Source: ABdhPJz7B+oHKHVLYtq3Qtr/xj5bZ4Thba2JhO5Af407EmoVlAs0S01WjWPVjDCOsbQlSd3jiucPf+utKJZMq/okRQ0=
X-Received: by 2002:a05:6122:508:: with SMTP id x8mr7959579vko.14.1642646647956;
 Wed, 19 Jan 2022 18:44:07 -0800 (PST)
MIME-Version: 1.0
References: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com> <5c65baaa-ad51-e7e3-c811-1860edb7fff4@web.de>
In-Reply-To: <5c65baaa-ad51-e7e3-c811-1860edb7fff4@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 19 Jan 2022 18:43:57 -0800
Message-ID: <CAPUEspjtz6KjWzyVGYCzqmh2n-_BmTi3TceY6qquuXNeq87JHg@mail.gmail.com>
Subject: Re: [PATCH] cache.h: auto-detect if zlib has uncompress2()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 11:49 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 17.01.22 um 18:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
> > index 722610b9718..915796e85ac 100644
> > --- a/compat/zlib-uncompress2.c
> > +++ b/compat/zlib-uncompress2.c
> > @@ -8,15 +8,12 @@
> >
> >  */
> >
> > -#include "../reftable/system.h"
> > -#define z_const
>
> Why is it safe to remove this definition?
> Because it's defined in
> zconf.h, included by zlib.h.  But why did we need it in the first place?

because really old versions of zlib don't have it defined in zconf.h,
and therefore the "compat" code would fail to build.

Carlo
