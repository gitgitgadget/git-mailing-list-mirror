Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0441EEE6450
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjIOKKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjIOKKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 06:10:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875A2D45
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 03:10:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso261128966b.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694772606; x=1695377406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNymXi09XvUo1Q0GvgTk8RnpRQ5dzviRzV3FJ7gJhPc=;
        b=BHKxx3U9y483m3zffqyyytNX6JMXnxq9A/WYXMEUT7gmVhjbzr2QFfdYAlnY7RvAzi
         r+4tNZ9ru4gaNBg0Zn2jSpmwGMSpY9gliEXhQX0aC0/nB5KCjoWGlj2qbyVSBsdThCCl
         x798oa+PlwsMXVeKa0va0I5Ynxwq/UgJCgD5kInaa2Grvbthcha/ZXnq9u6/lyIkVU9k
         EmwLh17O1GCyhB1nxVEx7SNpOqqLyIgznYNwe+g096J2ySj50GP+4X8ff0BxLkhNsW3J
         JdzKvFGwTq0XYz+Wu0lCcKCZXftI6sSj6U8WFFG2PFeSyveBk37AZqAxHpAwZAkGD+th
         2Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772606; x=1695377406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNymXi09XvUo1Q0GvgTk8RnpRQ5dzviRzV3FJ7gJhPc=;
        b=UP/0ddJGVn1zFl6HxKo6HxkSypKz6fFSpHdH5VVXpNpYn/C77ipzjAnpfvEiq5eUlW
         UFrdPBOR7F3Ntszmyl5v6voWlr11dIqgxmW3vSAPxEV5fuKn0fpeoVsWHWmzr7IOVOUY
         M9+mlCp9vODPZgZX9mojtsjIqLMj7BRPOfS11rvFdyr3yxjrep4aMGOxvxZ5x7/F7Zwy
         DvtgEdyUw0Qptojt6Jk5R2zNR4qrNxPUmtwfQzqVR+ol+LQeHBCQBT7Xpa1trYZ2hVBY
         4/Hlfjwiivqiiu2W9fmavWhQSpuHlk1dzQs1rOEutHO9c037JsZZv4TaUv4i4HvptiRg
         lzew==
X-Gm-Message-State: AOJu0YwF6FPNTXpy/eR1pXtjxJgsJDElQK7TU42n7cxgjyZEZfPbNFzg
        Kb2RvWevoMQ45tni4+S0aAaZqrrHpfdwyzDs0p8=
X-Google-Smtp-Source: AGHT+IFmKxl5qeBcwBBPqws3amjpVCZQSTuYjQz3xZ8gsBYYSjY/4FggynMBqP/zy8m6ku0ikI/qHF6uKZifW49anIw=
X-Received: by 2002:a17:906:cc4b:b0:9a1:d0bb:d215 with SMTP id
 mm11-20020a170906cc4b00b009a1d0bbd215mr900664ejb.5.1694772605656; Fri, 15 Sep
 2023 03:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693946195.git.me@ttaylorr.com> <cover.1694632644.git.me@ttaylorr.com>
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2023 12:09:53 +0200
Message-ID: <CAP8UFD3nPeF1Dy+cbPAYTFS7AdZJFdGs8qnE5gESU5CQ9h2eng@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 9:17=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here is a small reroll of my series to clean up some of the internals of
> 'git repack' used to track the set of existing packs.
>
> Much is unchanged from the last round, save for some additional clean-up
> on how we handle the '->util' field for each pack's string_list_item in
> response to very helpful review from those CC'd.
>
> As usual, a range-diff is available below for convenience. Thanks in
> advance for your review!
>
> Taylor Blau (8):
>   builtin/repack.c: extract structure to store existing packs
>   builtin/repack.c: extract marking packs for deletion
>   builtin/repack.c: extract redundant pack cleanup for --geometric
>   builtin/repack.c: extract redundant pack cleanup for existing packs
>   builtin/repack.c: extract `has_existing_non_kept_packs()`
>   builtin/repack.c: store existing cruft packs separately
>   builtin/repack.c: avoid directly inspecting "util"
>   builtin/repack.c: extract common cruft pack loop

I think it would be a bit nicer with s/builtin\/repack.c/repack/ in
all the above commit subjects, but I don't think it's worth a reroll.

Except for another very small nit in a commit message also not worth a
reroll, this LGTM.

Thanks,
Christian.
