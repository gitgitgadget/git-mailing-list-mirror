Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE41C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C2F23899
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuVZSU4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgI0OjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgI0OjI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:39:08 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C71C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:39:08 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p24so4307916vsf.8
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXa3avErV0dYopK39g/X1fd4r/G3DZFGf/1sOfHomsE=;
        b=MuVZSU4riRdP27pB5siLXiNFXo5ZtgOHvxbVmd3RtkBPooyfOHdZDlp9Y/3Jw71OAs
         sp02sdUB39Aa/DscjD2qek7t2tN/wLbfbKWgAn19BU8KvwoQauJkSc7S0Nq5l7XviFea
         HP+DtdtJ9r58LDhjm8QTZ5UamFc7BtA3eSeYlXG4oTvfIXLLXYqq/V5S888Qzcj7O/mv
         zA6ZcyTabQEML0SC7A6ClcKLNlmKcHs1BFLeUNmtQqEqSmpqRSCGaIUlAx8gXTM8D4xM
         DwVbYEIcGxe739S5HqocjOrA2t6Cb0xheOuRBMiPegCYUkpFJITFZEimODoavkKWduhw
         Vkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXa3avErV0dYopK39g/X1fd4r/G3DZFGf/1sOfHomsE=;
        b=dsxw1wOAWl0mg9j7DwVh6IYiFQI03PyZ/HIq6cTiowRrL439QDB+/OSJWvccpIdrUP
         35xiTIhOXzZzsqizaVKr7S5c35adhlb6+0s5YpNFcKz22hqZW88FmXGAVzB0vtenLlZy
         n/OjGkJgLAWWA/Mqpy8GYngERUOCKMok5ynZVYtJZqlwbxXFv//ZYnAwkQVWPGEulac9
         BM/ilvS0rhZrKMnTmkeD/y/kgQVIMqmeh2nvb6BTWGebs8u4OJxdJOizxr/Wezude+X+
         cNJ4vncLgnuiI4U+PzSTry+xAOgYlkkrI0uCX6Il8PUDdbbfYqk8XRjRA4k64YOkQ2cF
         nuoQ==
X-Gm-Message-State: AOAM532DKr72ZjF7t4go6+sxxW5WM7SHY2lDE28KhGhKTsA6LuGpfZQg
        uvr1bejS7Vx/D/qMxH+yuO8xqsDO35GPAb4D57sKxicW118=
X-Google-Smtp-Source: ABdhPJwbF+voea8OqyQ9EihnZnRqGn8X+/K/fZovoSOEdq1dIPgsQWGMSLEZ8dd4+3Pw/5WzsLmEzmnqu3Mn5/baMeg=
X-Received: by 2002:a67:fd93:: with SMTP id k19mr3218986vsq.35.1601217547288;
 Sun, 27 Sep 2020 07:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200927083933.GA2222823@coredump.intra.peff.net>
In-Reply-To: <20200927083933.GA2222823@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 27 Sep 2020 16:38:54 +0200
Message-ID: <CAN0heSqXsnMq5TiMaDow4GKQ_uWnjb=a7JRvD854JocSK5Hrrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] parsing trailers with shortlog
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 27 Sep 2020 at 10:39, Jeff King <peff@peff.net> wrote:
>
> Here's a re-roll with some cosmetic fixups. All except the first address
> the points raised by Eric and Martin (thanks, both):
>
>   - put the --group=<type> unordered list into a delimited block, so
>     that the follow-on paragraph about multiple --group options isn't
>     indented with "trailer" item

Yep, that makes sense. The result looks good.

This v2 addresses my comments on v1 and, FWIW, looks good to me.

Martin
