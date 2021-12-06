Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 03:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhLFDYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLFDYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 22:24:04 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37846C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 19:20:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b1so21834062lfs.13
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 19:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MwQ/6dBbKoCvXNBpBcoVv2F+oeqKZ+CgDq5t45Yvvy4=;
        b=IdBcTTLiLGFBphctaGbfcdPP2PG3I6L6SGvxr0E194ARXGGMDXy7/37g1gIn1ZogMY
         g/A7rmG/CQfaUg71eWKl4+frucfodH4hEfpK6Q8p7yOFfTBeVxNsWyzSdstmWwLyaoix
         nB+8koo2eG2TCAGEvtzGxIsD2h1M+M4/zDJIZOnHWmM0qr4qyJCC2+48b9sNIxBBtjQh
         R0eR/67+I7dUXB9m3YiYHcN7b/EOco5Ji3HS5uufv9EFGwnrnHtJeOHU+PLJZ1wiolBD
         E9dpOX//i/KvuYYnd1/DuteKgqmw0omxfnsWFBKnfZbMnbbPaOhAy+yaPlX2I0Kyq1/s
         JnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwQ/6dBbKoCvXNBpBcoVv2F+oeqKZ+CgDq5t45Yvvy4=;
        b=2yDIJPGcD3Zb//nNMbP/FPL2Ji4DgtIEVvmbcop+jeEQMRcUdh3r2PNTbmHM6dTHQs
         LMPeRPpnbqp0Pn7lvMp0UlBjQ8qvvVbqnDMAXCvoJQMTv/i7hGZm3tkdVnzRQYa2piac
         lV1JkbQ6/epZCvrD8hXD2vf3mHNxTeq5LbjLSZP8+gXb9FqFN2pHH2NOyA2foyH7bNaH
         YoN9HH8LYjZz3aFrKqEK8mTukw22Zm6EUygPG7WyX4SCGgRMFt+C9SE8M7dkzHr2rjUJ
         Xb0VEQ84qOUcnRPNfAVlLcgtOwcckVwxAaMRefLziuQDA5nlm41YmvzYIoX9WzmbSEzY
         qZGA==
X-Gm-Message-State: AOAM531DxgXtKVNDz2jGZ4KBDAOILn0huprocvLeddspsXLbg8tQIpoN
        9toBBHmbtWw8YtoKhm3e7rGRdAB75uVhdGeTLVw=
X-Google-Smtp-Source: ABdhPJxtcKanHg2FdpK3jQjVFTOcQDFCBzbSddm7DyDsDmhpYgc05DrMxGMNWSP38w2N+fK55ZI/8v1spJw80KE1VQI=
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr31971636lfu.51.1638760834498;
 Sun, 05 Dec 2021 19:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20211122033220.32883-1-chiyutianyi@gmail.com> <20211203093530.93589-5-chiyutianyi@gmail.com>
 <211203.86ee6tss9p.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.86ee6tss9p.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Mon, 6 Dec 2021 11:20:23 +0800
Message-ID: <CAO0brD2zHETRWz-0Bcy1+tjkFS0XF94+SdBj-sDfZcq5iG=6ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] unpack-objects.c: add dry_run mode for get_data()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 10:00 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 03 2021, Han Xin wrote:
>
> > +     unsigned long bufsize =3D dry_run ? 4096 : size;
> > +     void *buf =3D xmallocz(bufsize);
>
> It's probably nothing, but in your CL you note that you changed another
> hardcoding from 4k to 8k, should this one still be 4k?
>
> It's probably fine, just wondering...

Yes, I think this is an omission from my work.
