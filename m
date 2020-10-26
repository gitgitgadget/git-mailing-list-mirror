Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E37EC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FCC238E6
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3FaiCkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775339AbgJZMiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:38:24 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:39512 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775336AbgJZMiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 08:38:23 -0400
Received: by mail-ej1-f68.google.com with SMTP id qh17so13215312ejb.6
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGvvW2/P7g1pd2xtWUrLMqi31nyCnlHSOvrLCdpPeLo=;
        b=p3FaiCkp56MrF5JKVAamn7qXlv1UBdbZl+EyQK/DqbDzjQ9XrgvLzk2dDBhnJ27WbJ
         9BVG0qTSc2g1kIKXEE1UFdlXhzq9XROQdbWZoM7byUvwgPOQJFbPMO1uKnuCqbVeu9RV
         wbnwGhUZCKC1LODP6PDNp7M1zUwQXyVGGlkn9Gw9HiUb6NDmqUZzv/CBChFU8KvSHVEu
         5cdsblyqh8TwmCW5Vu2/pfZNvGmb4II5FMhFZKzAmcu9rzA1DpycR8WNB9Q283fejm+F
         VUrMSGiU2yWv/aZFzTuWylBrcEHX9zhkI+UrUJkmAB8Sc64iz08n/fLNhZYqcNvUfw9t
         3qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGvvW2/P7g1pd2xtWUrLMqi31nyCnlHSOvrLCdpPeLo=;
        b=pp7pWQid0zF/EMJv6yGxBo9aN/cfCtefNu+b/8VO83D/WGrPYAR5Okr88vZ+a+WRLK
         GJwM5nuK8HTYIshjbdXXlKRJulO4kog4E6kQHyDSbDUmvfMs49NBOhf6rHuUasegJ5E8
         kgrZM0XWrAMo0Q70CV9CGtpHuPkxprzm2jhfBiUGdXTUYPbO44udLsXvbeajsNb0zE4C
         cr5tJCBi26PNIk2zODXohYQtQ9GDYqmxyAosXono39nyCh9hC7fDC5s06sdNi44JwzTZ
         e6qs4PSrtJ/b5eeap045sW64XP1LZ4g50NGRBcFUCw53IPfLPD1I/hNISGXq3HsAcF4n
         LQig==
X-Gm-Message-State: AOAM533KiSjF6AxuuNp1OL9bhIadvZpPQUcWhwYC/5GLnMonnFMsXRkv
        pGNGdDtijT7LQCaApi5bk/JXCf4tBvP3hot9XgU=
X-Google-Smtp-Source: ABdhPJxf4m97Eha6pWZR61mfhL6wuuPLm47g0ocjlmQvHgggR//yYE/QUOZnyqODCPgEDV5Su4Ax2QZ06smEwyT1vRA=
X-Received: by 2002:a17:906:da1d:: with SMTP id fi29mr15511200ejb.160.1603715901461;
 Mon, 26 Oct 2020 05:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-5-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-5-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Oct 2020 13:38:10 +0100
Message-ID: <CAP8UFD31UwuiQrWmM7te1Am3i9Ryvi8_XgDLM6B1fs5WUn_GxQ@mail.gmail.com>
Subject: Re: [PATCH 04/21] pretty: allow using aliases in %(trailer:key=xyz)
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 84bbc7439a..1714fa447d 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -256,7 +256,9 @@ endif::git-rev-list[]
>  ** 'key=<K>': only show trailers with specified key. Matching is done
>     case-insensitively and trailing colon is optional. If option is
>     given multiple times trailer lines matching any of the keys are
> -   shown. This option automatically enables the `only` option so that
> +   shown. If `trailer.<token>.key` configuration option is set 'token'

s/If `trailer.<token>.key`/If the `trailer.<token>.key`/
s/is set 'token'/is set, '<token>'/

> +   can be used as an alias for showing trailers with the value in
> +   key.

Maybe:

"... for showing trailers case insensitively matching the value of
this configuration option."
