Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855EC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B8D61212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhHXQMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhHXQMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:12:24 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B29C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:11:39 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id d30so5598547vkl.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apFMtvKhh6dtzBElLa/EG3c4286pYjKJCcIxttxqkPY=;
        b=KYW/2Zwz6YT9XZBgYi98nfFNQpACKVSQh9V7XslUV48K3duqTrXL83YIhydsYUoliu
         Jkjt3Yn5uXVfw0u9uQBkEqYpKdmIjTOeiJqZSoD9Esg7NtQPn0B9FR9yEM1pKXvCZMq0
         7CG/lF1eU9bOwzCjM2onj8jl3qnRGYbUad5vLJzw4cmB1chVF5dNypYXNUi9FqJJhkU9
         TYeq9DM9v+5mEDVW8vX5Y3DrKTFm/F4FSnpL3a4xY/TTAUx73Rpu0dEvnWyqtztBJ0eA
         uBwOfNnVuuvIAZRxp09gTNSk2OhZlon7f6+fWgMKjA+h00ziFD3D0MKloXSGgxqcwJwj
         NK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apFMtvKhh6dtzBElLa/EG3c4286pYjKJCcIxttxqkPY=;
        b=gxXF4Zr8cW7r4bCjWPZHR6WHZuXVyjBl/jkwIxyO2h7Tmh4n1ZwnmScfzOaawerJm3
         bXn2LpNIfforxi+Qfn1VCF4YirGXg9VxmdBN6w2fHRTBrIuOfE8Q/33M7ImWAnw0Zip/
         YBd/ugEaS/XEAuQdoZsbKbPuwl3YIKDwiZgCFzJq68vFs6vrw0fZQaq7uVg67O+uL52U
         aLR73idsdYcO7N0BGqOgIJ2TYV95nBqvYpd4iNsE/jR5vhLvaly9RnDazCIepTiR08m2
         OseRvMeT4ldzMp1rj1DWL7Vx/ietJqzPV5jc46Z7ik2B3aPkICRljzvHyYnk4uJUxSyu
         OJlA==
X-Gm-Message-State: AOAM530cRf76c99bIMQbnNEFGe+Wqsmq/aR8UTPPOabXFNSwxorgoKyd
        IS2O4ZcG1VmLPwMV0E/VmhwNEyrrxS+6Gek5riOypvGf
X-Google-Smtp-Source: ABdhPJxkASgXzPccu7tlnSgEDyAeAweLCA3InQQmv9kBCWT5wub2zb/Re85P00tRZ3zrEo6OcJ+/PiGcoQjKcBlO/Oo=
X-Received: by 2002:a67:f856:: with SMTP id b22mr20998509vsp.53.1629821487206;
 Tue, 24 Aug 2021 09:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210824114135.54810-1-carenas@gmail.com> <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
In-Reply-To: <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 24 Aug 2021 09:11:16 -0700
Message-ID: <CAPUEspgmKPhbPGs+ujy7KVJCyNxS95ph2Dwvd7A7cH2J0em20g@mail.gmail.com>
Subject: Re: [RFC PATCH] send-email: allow fixing the cover letter subject
To:     =?UTF-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 8:19 AM Marvin H=C3=A4user <mhaeuser@posteo.de> wro=
te:
> On 24/08/2021 13:41, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > @@ -1719,7 +1719,6 @@ sub process_file {
> >       @xh =3D ();
> >       my $input_format =3D undef;
> >       my @header =3D ();
> > -     $subject =3D $initial_subject;
>
> This change from my patch is still controversial, and I'd rather not
> submit the addition if it's immediately removed again.
> Why are you dropping it here anyway, does it break any related
> functionality?

I was expecting it to break --compose, but it didn't because in there
we were using $initial_subject directly instead.

AFAIK; I couldn't see a difference eitherway, but as Peff pointed out
it doesn't make sense leaving it only as a global so just found
instead a more useful place for it to be reset in the loop, which also
"fix" another issue of mine.

As pointed out in my original email; it doesn't fix the whole problem
though, because you still want to edit the rest of the cover letter
(could use --annotate for that though), but at least it is less
awkward than the current situation, where you will get the series
submission aborted because of an incorrect subject, even if a correct
one was provided and ended up being ignored.

Carlo

Carlo
