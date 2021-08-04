Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57154C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C2660F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhHDG1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbhHDG1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 02:27:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF27C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 23:27:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t9so2634073lfc.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YPur7wCkmhrl13TerncNUNoHA07yOIR+0GUFJwZidcM=;
        b=suVSNrh+JmpcbYQzu1VUdQx+3ekvKtXXUdMwrLINgYrgfwW/YAJO37si+uXiz9bWDd
         4MhdvUSX9gDqh3v9qusE/jzp/Z6oNbNQxN94LXrXYDne+DXnI+977EMO+dQxA5KLdeXd
         CUE0CXdPGbp5154Ww8QvQ6awhYK7iO6J6qcFzTLSkQ4YkNeQNvKdijRJkSgfXEJo3/py
         Ap5/K4190Vi0z4vtrvHXOeh+5YV8KCAROVLacwVRPYso86x3DTLx6H8vmg+gn0N+5vm0
         bcRkjEK1L8MhAm16w5+BbxZco/kXIJsqAhZkwthxxIUwG5I2Bx24qBykObUb+vcW8fXQ
         AOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YPur7wCkmhrl13TerncNUNoHA07yOIR+0GUFJwZidcM=;
        b=so3mAIjASe/BhRH28kiIMeei3+FRPeoYR6UeYmonArt77nEfQg754U9Lvrq1wV6xtM
         oqqx3VYM26falfYji8gvdtOtBO5AQIurZo7/5bT056KRjJC7Tyr1nTzHsG3VUsburxUq
         bnNggL9OBuziF8ZZqji8AJei3rpEpoDvohLkjcmTnQw0h8MuLWMi0fxqh5ggwaqGKVkT
         RO3JfsN81qr32cjRC76LLztuWg9Er37Th5H9NXVHydn8w4HkYG9ZWjuMX1TWu1DE0Sk8
         LoOlwbp2zSkqbbnYE/Pu5OLBqoEo5KwazdJqS/u9ESzT7w82h4bvGskFJMOJ+F1dFwey
         kO1w==
X-Gm-Message-State: AOAM530PMgjrWIZIvZVlih38jHL2A6OrLFcKkcVTbvxKDDjFWm+zL92k
        MtkNpcjw529m9gnx9XOlH0dT9YKzDxFcSz7uV/g=
X-Google-Smtp-Source: ABdhPJwYDsDQhplQlsbefvwcguZfJgCBLDuTvuDomW/N4Vd3qPZs7U5eKp1sosjA60KjagbBJBFbaeD4tc/FJr1Zg1o=
X-Received: by 2002:a05:6512:942:: with SMTP id u2mr19064287lft.501.1628058446105;
 Tue, 03 Aug 2021 23:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210804010900.33133-1-carenas@gmail.com> <20210804010900.33133-4-carenas@gmail.com>
In-Reply-To: <20210804010900.33133-4-carenas@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 3 Aug 2021 23:27:14 -0700
Message-ID: <CAPx1Gvdp85H_EY9qLY3jkxktXCDAwJyznMWfDDGHy56db7sc6Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] gitk: check main window visibility before waiting for
 it to show
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, paulus@samba.org,
        pietzsch@mycroft.speedport.ip,
        Eric Sunshine <sunshine@sunshineco.com>,
        tair.sabirgaliev@bee.kz, lists@haller-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 6:51 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> From: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
>
> If the main window is already visible when gitk waits for it to
> become visible, gitk hangs forever.
> This commit adds a check whether the window is already visible.
> See https://wiki.tcl-lang.org/page/tkwait+visibility
>
> Signed-off-by: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index b62c12f..cc587b5 100755
> --- a/gitk
> +++ b/gitk
> @@ -12664,7 +12664,7 @@ catch {
>      wm iconphoto . -default gitlogo gitlogo32
>  }
>  # wait for the window to become visible
> -tkwait visibility .
> +if {![winfo viewable .]} {tkwait visibility .}
>  set_window_title
>  update
>  readrefs

I have no objection to this patch (and the other two look fine to me)
but I would like to say that this whole idea looks racy in general,
and that it would be better to fix this inside Tk itself: the internal
visibility-wait should be doing the visibility-check already. Given
that it's obviously *not*, this, as a workaround, seems OK.

Chris
