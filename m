Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F673C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 05:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE40B23124
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 05:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLVFYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 00:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLVFYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 00:24:15 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77446C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 21:23:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o11so10934461ote.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 21:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Ui51vLcAM4OGJZ8vrwPTnOHpyhifBTWgEHIXs59Zio=;
        b=Atwrwx6W5sTiK87q/jbjY76NybdLyXnR50t1ZNMpTNp9Qo6h3lgcmp1zZeWZphbyf8
         hP4Xhfw0CNv/zwzjMBtUgUAmf6HvdlRvjQFIWrl9G1oFgRG70RbZoMUNdWeSQZI/lPiy
         nXkxBG4AMtmAXxY5M5UYG4ZrOJo9TyxHLw0eQE/Ng5ctSlYjZpsTqZ5mdOMRs54rw94B
         i2uMg38TPjBwFP6ooiNPXNwx5n1mkPIFM81v9r0/6PM/ZfseKDL39oMqQvT+6uu6HtEp
         zJUjsH+VgbSOwjI77D7E2Jksw39gtqehpKIwvbGZWQoOV12Z8oFewp6LmmRU9u+dlslD
         PmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Ui51vLcAM4OGJZ8vrwPTnOHpyhifBTWgEHIXs59Zio=;
        b=ABMUJzfuKtAZlBIbvjV7NgIb296u77IKLjujVx5E5QWgeOzM6p3G7A2unhBw6wuGO2
         gWJJg9Ri7S1nLcRnOgpm7Lyovn+IVRgDNNGZWZXOGnLyny1glqfU/aLxnsKzMOW/5aje
         rfP9rTK9Jj0EBYg7Wmeyuk113QfU0K/NSpZ3xWWGjW1+9+AJWbSWZ77mKnJu0+ZLkGoy
         GQkuw4hqHBaLlQTK2Y+1m7ccrAMFDhw22HxwUS80lfEsqRZgQBjo4XnnNuTD4XRfdEwf
         LgV67gW7uObDQtFVn+IqaTp2oVbFcTdaHD0TlXsDWCC48ll159pQHVjDCeFzZRqPuekT
         rOEA==
X-Gm-Message-State: AOAM530hoE1qyGNMbXOGOf3HY2HsdQaO+CsGw7z8SYLJ6hBesjD1BHfU
        AtONy6Z6FqFBG1StxFNE1/eU8JDj6NYuX9N432Q=
X-Google-Smtp-Source: ABdhPJzGburi749jEWFdBnzBQtnlBFG/9q3D/SpDGy8hFN6FYI+48FyzLrLxSi7dcK9mczhqZnP4DSOSTtbS+7u7dCg=
X-Received: by 2002:a05:6830:1581:: with SMTP id i1mr14855965otr.35.1608614614923;
 Mon, 21 Dec 2020 21:23:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHjREB6QrR-FQzwOphgw1z1Rba=o7gNvEwomHc60aNH3EkQg5A@mail.gmail.com>
 <fde32488-97e7-55f3-86d5-25f525492844@gmail.com> <CAPig+cSh0L3RniJpEs3oddkzPGUyw5Ud39SAbYFoxwtBowLiaQ@mail.gmail.com>
In-Reply-To: <CAPig+cSh0L3RniJpEs3oddkzPGUyw5Ud39SAbYFoxwtBowLiaQ@mail.gmail.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Tue, 22 Dec 2020 10:53:23 +0530
Message-ID: <CAHjREB6y_zr-TrEsQu5MpwegpSHg_5XxWLf0O_HFRrSg+sFvQg@mail.gmail.com>
Subject: Re: Perf lib sanity tests fail on OSX
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Philippe and Eric,

Thanks for the workaround and the patch. The perf tests are now passing.

Thanks and regards,
Sangeeta

On Wed, Dec 16, 2020 at 1:14 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Tue, Dec 15, 2020 at 9:19 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
> > Le 2020-12-15 =C3=A0 14:08, Sangeeta a =C3=A9crit :
> > > The performance test, p0000-perf-lib-sanity.sh[1], is failing on my
> > > local OSX machine due to an error in the test_export of the foo
> > > variable. [...]
> >
> > It is not the export per se that fails (that would be very bad news
> > indeed), it is the shell magic in the 'test_run_perf_' function in
> > 'perf-lib.sh' that uses a non-portable sed(1) invocation:
> >
> > As you might already know, since macOS has some BSD background/ancestry=
,
> > most POSIX utilities are closer to the OpenBSD/FreeBSD versions than to
> > their GNU/Linux counterparts.
> >
> > I do not know sed syntax enough to fix the invocation to make it
> > portable (nor do I know if it's possible).
>
> A patch fixing the problem (correctly diagnosed by Philippe as
> non-portable `sed` usage) has been posted[1].
>
> [1]: https://lore.kernel.org/git/20201216073907.62591-1-sunshine@sunshine=
co.com/
