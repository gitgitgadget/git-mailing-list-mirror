Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9DDC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE82076E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sOQvoTu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCUSzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:55:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUSzm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:55:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id w4so10076250lji.11
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTcH/HkEk/6PYeS+tRhbYg35lLvO0KORyMvR6k0evqQ=;
        b=sOQvoTu+iNjau/t8i7nAUVFio6EoOGd/Ikjajho5VVnPYUxCvgwJAVbdsUhMJI6KSY
         wP9IcBcDS+lg5gcXsPRZutyZFU8OlVxuJjvFp308GDIZgI2LyITUkTV2mT0F8BmDvUkj
         s8MtoUro0oBJp+8Lkj58MbsXQhOhjy1d7Ty9rA3W5L9Zr/h5tNhvNVnVurcA9oPVH1W4
         ZtHfK192kY+LV6WBnEbFFR0NvkkiHGdb52U4nujwYD7OJYLz2HFmJwmzK9cX7wLh/RFn
         FKC4KOjBvk5ZBtArNcVzpNI27Hc5JRxdWEYPtoi7VUlDU8yLHchinTlHo8jkeJH8nPer
         0bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTcH/HkEk/6PYeS+tRhbYg35lLvO0KORyMvR6k0evqQ=;
        b=HmNwbY3ssTHT3LGnI9FaBARMlfAoGG1K/BciFWB/PgQVR7uy3oTGjJBNxc/peJC2PF
         VuubplnjouGZpRp8kXTnQBV7yz8ymFB+4KQErHB7W4AyaIQLSXwor0PAYXp9bFM025yg
         P1DCRvD0icr8O7KSSr2iFp8iirhAUd2AneMsCmscTA1HYbSZoGoteJXOP/3/EF3/+9Kh
         ZOLlyJ+gbuQV4ir8Eb8PDECoxKM4cN0KtoyS7YyNr2mWL9z493VU4HOF9kyy1iTKTxS+
         3crIWSNeR11IY92NkTKfRjN7UzhsRElQx6Py7AnBBUlL90Q0eawxEiZtX56XL/rx4lkh
         7Dyg==
X-Gm-Message-State: ANhLgQ3MKWvBy7aJPqy1ybizjyQY0Pxqa8eRoXkNMg6oHyKEWioA+fLh
        FIx+15QRYXvyrrhiiO7T/Tgvh4DtGkIiQvbEpgUIvQ==
X-Google-Smtp-Source: ADFU+vvPgRTAsSjoi5NucM5d1m8GcRruYpWhpXXdmvA1FnVwN2wV+umxbIboDjYJ4N5m2Ky1LQMTz+YsF3UGWFj3YYM=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr9374365ljh.44.1584816938715;
 Sat, 21 Mar 2020 11:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
 <2a54d866-c40e-da5e-4c0c-6bfcb56eb8f7@kdbg.org>
In-Reply-To: <2a54d866-c40e-da5e-4c0c-6bfcb56eb8f7@kdbg.org>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 21 Mar 2020 15:55:27 -0300
Message-ID: <CAHd-oW73xp2=XcFr1F57fo2UtAyuZ2aeXVSc_A50bYKKVN7fJw@mail.gmail.com>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 5:55 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 21.03.20 um 04:07 schrieb Matheus Tavares:
> >
> > +for opt
> > +do
> > +     if test -n "$store_arg_to"
> > +     then
> > +             eval $store_arg_to=\$opt
> > +             store_arg_to=
> > +             prev_opt=
> > +             continue
> > +     fi
> > +
> > +     case "$opt" in
> > +     --*)
>
> Can we please have a case arm for -? here:
>
>         --* | -?)
>
> so that we do not pay the price of many sub-processes when options are
> _not_ stacked?

Makes sense, thanks. However, using Peff's suggestion[1] for the
character iteration already eliminates the need for extra processes.
So it will cover this case as well.

[1]: https://lore.kernel.org/git/20200321062611.GA1441446@coredump.intra.peff.net/
