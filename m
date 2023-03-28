Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 19:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC1TvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1TvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 15:51:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611311996
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:51:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x20so13767905ljq.9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680033060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rir1pPpQd8i+tHTow2+Lenf0wxZp9AKH96vpNRdLhIM=;
        b=drKFhRjbFn03aTQIbs2FwRWIB07wKFT8JjmBFY4pete3aVM79c+9DoKlYDJhbyg93h
         ahoC7Ydppe3vPZ8g+F7Ds9j+lnysUiTsfEHwuMlHpBaQsysB4Ssjx0wmsZqroio9h0T2
         +dLAHDEhXGA4ELI2rsrnWgTBP5Mmv5UZspKXIaQ4efqYXpNjMZsIiE+v1+8QznCBbE7P
         +ZoUL9LIWGMjgLhxZwWD6bNtl9f879pmg2iUqHYiKFFKTsbvGGhIep/7as5refqrC1uK
         7Xbofqp4IsRh6A5p6xV2+4zkEHtpPSrXOxaJ4v48gXRuSSNj/aJ7obzfZnHTzShUyq6M
         18wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rir1pPpQd8i+tHTow2+Lenf0wxZp9AKH96vpNRdLhIM=;
        b=QOBtj9I6JV6MGqwK2amMIF55F+MeuHLS0YLy7Ca6PAKVTNG8JG3dXbBRmFi3u4jmYP
         EEqEnjQlzZss6HDXtljlKamahoTmHeygNrmxXVDh0c7zlHIYLndkcphJdFoC/Hdr4Mub
         zBJF/drM+GwjhPOr9BeWxX1e1a79iCNvbzvu58sSATQ3ifXQMfW5gI7Zb92ruWzO7txb
         gw0OV/o5oUwzRVtHWTk3kGRu5BpHpdvCFWz/M/uooPdjvAG+NagfWAMz+C+G6z1pDrDR
         o3RFyqt31QGA10mgETlW5PDVgTu5uUeOZlHzMSQBJrB8S0RKdPGQxm+iwSzOZNe2Cv5E
         cJCQ==
X-Gm-Message-State: AAQBX9eRp9Vg78/Q849simuZ8QYrOHl4+xnEVhVYItHlcw7paxnlCupv
        8HdhyZSetBY6wl7Acs25/QRsjaygWvS9b/eiUk0SwDXB
X-Google-Smtp-Source: AKy350bidTclYOu5IZXDeTN1XVY79k0Tt0/gGyGUc8WOgd42Zd7ALMSUldhEOCFaQKdNoDcgf5KMQPA63BBiwbVyipc=
X-Received: by 2002:a2e:86d2:0:b0:2a1:d819:f0ae with SMTP id
 n18-20020a2e86d2000000b002a1d819f0aemr5249119ljj.9.1680033060403; Tue, 28 Mar
 2023 12:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
 <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com>
 <ZBIIKqAIF+aF8vvx@coredump.intra.peff.net> <CAKc7PVDZ4Ra7s-pyFms1-sGqjYD9b407G1u0A0hHTkQRa-MPkQ@mail.gmail.com>
 <20230328175139.GA18558@coredump.intra.peff.net>
In-Reply-To: <20230328175139.GA18558@coredump.intra.peff.net>
From:   Sebastian Gniazdowski <sgniazdowski@gmail.com>
Date:   Tue, 28 Mar 2023 20:49:43 +0000
Message-ID: <CAKc7PVDUaQfcdZggraN15bnWs1M_Wk6n6u25unW+Mo5GCaEykQ@mail.gmail.com>
Subject: Re: A nice, beauty progress metter for Git Clone + a feature request
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Mar 2023 at 17:51, Jeff King <peff@peff.net> wrote:
> So I dunno. It might only be a few lines. It just feels like a weird
> feature to add.

I would perceive the feature as a nice, versatile trick instead of
weird=E2=80=A6 Current git clone progress is quite unexpected =E2=80=93 whe=
n I was
starting to use Git I've had a sensation of disappointment each time
I've run clone =E2=80=93 was expecting some nice progress bar and was serve=
d
with bunch of text lines with numbers that weren't any percentages=E2=80=A6
I'm not saying that the progress in the asciinema is some uber cool
solution, but then, it may serve as an example to draw attention to
beautifying the progress and the freedom of hooking any command via a
core.progress_pipe might result in some other nice scripts/apps to
bloom out there.

--=20
Best regards,
Sebastian Gniazdowski
