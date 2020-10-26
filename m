Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEDC55178
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D322400
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtmOo+v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774883AbgJZMOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:14:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47060 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774876AbgJZMOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 08:14:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id 33so8996770edq.13
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJzWHqfgmljVtwnAhw1hb0B7BgTYB/uNS1t24W3I/dI=;
        b=WtmOo+v/40IgYnQdVnd4k1KomjRFj8I1efL+JJpRpgRY0LaTFx49mKRFwIxz77PoWG
         UuYS5qF1Licz+V+a/cRAR0TQP3cVxaePVOnKnI2YuAPCbToCAq0sJOddGheQxo/Dz/ma
         5ZzNxSw3mkt7oiBajZ2OXBkDypMYnRHt3eBmejmVWNMewQ3Xq7hjCUCA1i165ok6piS+
         CwDiiho4LijRGp3/oLHbib5riVcXk2dGzobuRLS761Zpi9pyk+UC+ZFcrsjtwCAlmxki
         TTSkmyDrkaXgIEUT+6UKJ7baZg2KUrzo5N3ddQWLJYDoEORktpvC1/jD1zoY6EKflRSy
         YB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJzWHqfgmljVtwnAhw1hb0B7BgTYB/uNS1t24W3I/dI=;
        b=oCKVh0GPQ7XwTyuI8EeL5j4Fm/wGqb7rA+915mDK6nXRNSvrpENv0Wt3/nnElsvT7+
         82I2VwIe6x2NWeMyf1Xge2DwDpxVe5xYy6BkzpDQTaJrirzryyEaKXYDBNFEseE7/lkE
         mGyrlzO9B5WFpq60C2qikd7QoMRXTYTNjZbPA16niqXmeNFU0dW0Ml0cw7JnwWkicIEt
         /sm9fP5m+vsQ4gdMjzOn2T8k+dWuW866RaP+MA6ACDMn/4w9A///loGRT2aGY8S7OX5Q
         SYErx7ci8ifxRCsp2fcdjzPtqax/NFBBpzJ4ZvvS/xyxtoD8A1kU7wwpTTkwsVSHKKyQ
         bziw==
X-Gm-Message-State: AOAM5316Hy5nI7lN8aCZ9CCMXrSJrCeAj5ZsgfY4ugHZsyZQH7uhfyxY
        ugIfPar2p6XBnsgBCHPUqY2c6baFu/mQ71hZY94=
X-Google-Smtp-Source: ABdhPJzi8Y3SXIBTMA3R+vzMG/GK1QCC3Mwg4g/YwWQMs/CsWuSefSvbJAE0+AItEe8Joy8X7lDbv9QHAvqsKUqoOQQ=
X-Received: by 2002:aa7:dd8d:: with SMTP id g13mr3061091edv.87.1603714452960;
 Mon, 26 Oct 2020 05:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-4-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-4-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Oct 2020 13:14:01 +0100
Message-ID: <CAP8UFD3=HLzG=b61DQYQfAErOg+KXAg-8x06MpDLi+1=NcgejQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] doc: mention canonicalization in git i-t manual
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:

> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 96ec6499f0..a4be8aed66 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -25,6 +25,11 @@ Otherwise, this command applies the arguments passed using the
>  `--trailer` option, if any, to the commit message part of each input
>  file. The result is emitted on the standard output.
>
> +When trailers read from input they will be changed into "canonical"

Do you mean "When trailers are read from standard input"?

> +form if the trailer has a corresponding 'trailer.<token>.key'
> +configuration value.

This doesn't explain what the canonical form is. So maybe something like:

"When there is a 'trailer.<token>.key' configuration value defined,
this value becomes the canonical form of the <token> trailer, so when
a trailer matching <token> is read from standard input, it is changed
to this canonical value."

> This means that it will use the exact spelling
> +(upper case vs lower case and separator) defined in configuration.

Maybe:

"This means that the key part of the trailer will use the exact
spelling (upper case vs lower case and separator) defined in the
configuration."
