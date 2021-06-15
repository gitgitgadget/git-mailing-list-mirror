Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84137C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D92613FA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFOC7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOC7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:59:23 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03785C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 19:57:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p15so3183252ybe.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bg4MXAdmM4auwPOK5PEfvaUZflECUGO0ALeR6RlFbEk=;
        b=NrSMUvbpWX9uvIIv9X3M678Zjo5qfRB3uuKzvdJNMMuWpO9NR5CGo+wVdZeBnvIlJn
         3DONAOuvE+avDPzuymRPsjHK88oXiR/k+KHXXEjhHR6UKghlgqR4wCzMzHqo7R+w8Dxl
         hV42ut0RhdeRMebQKVXsRC8kBOACipE4XT1+jLPYW7TXC4Z4+Kp7mx9HjbuqI8R7PEjp
         nZNBpUikspvHZA3jZ3mxVs7Pje0B5gdJ/W2nyjfnTQ1hsxLAYIgud4QAlvHusTdIVZmb
         /DLsmONmjL+TDgswsuMFBK2wuEaN58Wo7Qw9MN8hvXh5Ou7R5sfCBtpLwZWiI6h7eQuA
         YrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bg4MXAdmM4auwPOK5PEfvaUZflECUGO0ALeR6RlFbEk=;
        b=f5K69fE2n+ZHfq+gus6M64bRVzxCle5ijJNPVTGZpCKuwwO5rfaW3I1CEq6MExLcQK
         U7+o9ss0aPcYuR4O6InC0VU/q91Ex2spsBshroKHeS9RC1iwZ4Ea9BZPy2QcYwvifqY1
         Uqbve172I9VkcsXlQLt4dFJtaIwjHQjk6JjOFfAULRDKUq7Daj0dY1pZT0tgrYiYYtk/
         bZGbD5OngkFNc0x1tVoJ0UHZrXYaaaR2D3fzYdnnQh7xwvaCOInZqWZ3G2B4fJlCKsaS
         7LMMHtksUybl9sdMNqJlNyftVU1R6jUbTMVbR7An0FuYX2MVsSZG1d13fdi2UtOve95F
         gzQw==
X-Gm-Message-State: AOAM532b9FrOSrpf9rJETrE0W/2bxdUA6gtfsZCLHeDJ7FEnPcXjgPHX
        c2+DekkTUp4CrTl5pbOaXov9QJ3Hp7XXdB6xqnruEIm/+oXkYw==
X-Google-Smtp-Source: ABdhPJzoN9WokwRqc8h+veBmhGVaAb4l4GMbnXHxWF8jVATE+7ObO6RTVsPA99TZf8ciSsyjbEfy4xVGVSSsZKr0hs0=
X-Received: by 2002:a5b:5c6:: with SMTP id w6mr28186229ybp.279.1623721670733;
 Mon, 14 Jun 2021 18:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com>
 <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
 <xmqqk0mwylhc.fsf@gitster.g>
In-Reply-To: <xmqqk0mwylhc.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 15 Jun 2021 09:47:39 +0800
Message-ID: <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
To:     Junio C Hamano <gitster@pobox.com>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >     /*
> >      * Let's insert a suffix to clear the end
> >      * of the screen line, but only if current
> >      * line data actually contains something.
> >      */
> >
> > So my implementation is to try not to break the original
> > implementation, and keep the linelen unchanged.
>
> I knew what you wanted to do from your code---I am questioning if
> that "only when something is there" was really sensible, or if it
> was just attracting bugs.
>

@Nicolas, what's your opinion? Is it ok to add clear-to-eol suffix to
each line even empty ones?

--
Jiang Xin
