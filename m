Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B94C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C2A64E68
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBRGhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBRGaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 01:30:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70398C06178C
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:28:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a9so681278plh.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 22:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u2kUNkkiAjcQ2JJPIukIruNVaVvfpg4nmvXjxRI1+fU=;
        b=gUhg/VHJI3cjgd2NFWhAWiBocAjBqnBg8nfmtFCu6f90QkyOuBsVX1ciFzBtPb0jC8
         T41fMGnstutG+THZ32bMldiAMRtBjisMn5rsFIWrZ2bFadrBe1T7fF0qp4sE1SwB4d2y
         rDYtDoxjm0eIcGvn4Cv49YlGeHtYN7VyoRnd0a6585QCtcFKtx2/eoNCi9SUpXgaBMWs
         XaJqO1a01oo6rQgOybstDdHmyDnj/MbClz/dr5w8kz35XYnPWUxnZ9N5nwJOf+Q1ho5U
         4/PO7sKdjkpNL7fVc1nx6aL5DtOgsZBix6614LpVPQ3zILSXQUvJmb5Mejel+Wqp/Cpm
         oV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u2kUNkkiAjcQ2JJPIukIruNVaVvfpg4nmvXjxRI1+fU=;
        b=Qo/YA6GfycogVUG7k08KXv5CV4KLJi9Bt9ldUUg5kszbNT0Pam9ajfT9J1KLZW+vWD
         hnZQE6Gamv5i3U/oJqNeV5pnzaR79eeV5gdiNBDMBphD6yv7pG+QRXkFLwS7EZFQIlks
         hsBLjiEsmVBOGOCOg7yAAn+0aac/zeTCfpA+R7pp1BD/wXpzqxtHyBcpiimQ0d85NQDy
         WwMbUi8TzYWlh7CCCW+lDhRB+lR14/0NXW9HHdY/Dp6uG74vMW9u4FNIYvpaBDaQ/sNN
         rKxEMpVc/lJQ8jVUZLp1i6o6kmGDTwSzbiqe73bkARUKjNvl6bonjRXr2qUJa3M+/W3Z
         4wSQ==
X-Gm-Message-State: AOAM533nRxLfddqhmOziiq1EsSncTg6WjnLY112VVhIFIL6gHkQKm43B
        H5eU1LoqcJ3yhC9d6Xrorw+wX0dMhknIZ6iio60=
X-Google-Smtp-Source: ABdhPJxDjpa72VWp6icLzpBXXd/1Jfecm2k2FwlLPScPBSWI7ex3z9G0iXnw2Acf+ROAsvpYEFzQioTzJWEo7CuKGxw=
X-Received: by 2002:a17:90a:5510:: with SMTP id b16mr2611512pji.87.1613629720971;
 Wed, 17 Feb 2021 22:28:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613590761.git.martin.agren@gmail.com> <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
 <CAPx1GvdcFGmAi_zJ9H0+40uZw49qhTs8C_afnMMVj32EFJXqBQ@mail.gmail.com>
In-Reply-To: <CAPx1GvdcFGmAi_zJ9H0+40uZw49qhTs8C_afnMMVj32EFJXqBQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 18 Feb 2021 07:28:29 +0100
Message-ID: <CAN0heSoZJgdKHmWcm3BF2-eWtWMPvSf9YSsKuE7+PaBY4LMKtA@mail.gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Feb 2021 at 23:47, Chris Torek <chris.torek@gmail.com> wrote:
>
> On Wed, Feb 17, 2021 at 1:21 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> >
> > When we write `<name>`s with the "s" tucked on to the closing backtick,
> > we end up rendering the backticks literally. Rephrase this sentence
> > slightly to render this as monospace.
>
> That seems fine, but one question (diff trimmed way down to
> make it clearer I hope):
>
> >  +           contain an equals sign to avoid ambiguity with <name> cont=
aining
>
> > +       to avoid ambiguity with `<name>` containing one.
>
> One replacement drops the backquotes entirely.  The other keeps
> them.  Surely these two shouldn't be *different*...?

I included the output of our "doc-diff" script below the double-dash
line. The patch applies just as fine anyway, but I did wonder if it
would trip up human readers. :-/

Quoting my original, slightly less trimmed:

On Wed, 17 Feb 2021 at 20:56, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>  doc-diff:
>  --- a/.../man/man1/git.1
>  +++ b/.../man/man1/git.1
>  -           contain an equals sign to avoid ambiguity with `<name>`s whi=
ch
>  -           contain one.
>  +           contain an equals sign to avoid ambiguity with <name> contai=
ning
>  +           one.

So that's how the rendering is changed. From "oops, we rendered the
backticks literally" to "we no longer do". (It's not clear from the
doc-diff that they're rendered monospace/bold, but at least this is no
longer obviously broken.)

(Note the extra indentation of all of that. This is where one might
place some commentary that one don't want to burden the commit message
with, but which also isn't part of the actual diff. Now that this looks
very much like a diff, I can see how it's confusing.)

And that's because of this change to the actual sources:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d36e6fd482..3a9c44987f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> -       to avoid ambiguity with `<name>`s which contain one.
> +       to avoid ambiguity with `<name>` containing one.

I hope that clarifies it? It's a bit unfortunate that the misrendering
is so similar to the source in the txt file. But I guess that's still
better than some of those misrenderings where some cogwheel slips and
everything spins out of control through the rest of the paragraph.

Martin
