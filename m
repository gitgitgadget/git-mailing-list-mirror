Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE2C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657F020767
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLsH6LLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGJQrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:47:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1078C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ga4so6776546ejb.11
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4vE3VSTmJe50KIP8LPKbTeBre/rmrW32vvjdYrON2o=;
        b=PLsH6LLmUh/JiF7PS2T8qGuStTHiyDQ2reExuOt22n3HG+64U1mofwkcPzyFvSi/3F
         oqkKgsOnFWBFGTVqIm4f7ui78v0Tjd5a5qrOUy4gvRRdn8J05fX1pck6VgIJYWNRfVrk
         eeOYqwfS7yoFlTNSO4J2goIPIQGUsLfzOghfCjSL5/J/S0xlHKCG28UM6IFm5KR1bz1x
         KYRIY0rs/Op6+YEwV7Tnax+DgCBSQIIQwUUh4POGYYhOxU7V0TzK2Vyj6q1V1tPC3klv
         wDftRZlV/25ymJh4mnngtXpi+DjDQWiE/1Om2HWO+K81/MAARp4y9jkMy4pkmUZDuPjc
         MMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4vE3VSTmJe50KIP8LPKbTeBre/rmrW32vvjdYrON2o=;
        b=OnpwMGOypqhnpobenO89OOab/v85G34yt6akpWJ03AGhJfIK4/GCBzCMt4gdv2AGXM
         SbVloJKVdNdUyRddqQq/ZHD//cwxt381VoxR6uR0QYFEJ0emZqXKBAO13zmXTGCfrHEe
         FQwntciDAlyXhbvBjulXlu+IpgkuN0qZEZI8yNtFkumv+WbUMhMhusW2Rbidiz5DLTHS
         bHTI67x7nBjkH8azbtBLuVvFGRsuedqCctSYzhLyFoJJ0rT/u4wmKW6f5WE5RYaQYRqt
         +GJ1y0fQTp64pt4E7zA/aYTwf7iLf3qEbDDysYO3e464IftIGB9saxYwvlNGd/hhOiNs
         whWA==
X-Gm-Message-State: AOAM530x0AFhLo4708rJGILUg5qhex+W9lBZkYLH0OhHz/d3pTM9fWs0
        xikANOairLWqvKFOPAbr+pYqK/K1JPYrCGtWM7A=
X-Google-Smtp-Source: ABdhPJzu2xHMdwKBlmSzKXDFjh4kjZvVkn4lw75S9KlFfRo/DU6miWMohziGpqY14SuhC5L/moEQvUCDz71Ic90/weU=
X-Received: by 2002:a17:906:e299:: with SMTP id gg25mr60635305ejb.160.1594399640356;
 Fri, 10 Jul 2020 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
 <20200707174049.21714-2-chriscool@tuxfamily.org> <xmqqsge33z42.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsge33z42.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 10 Jul 2020 18:47:08 +0200
Message-ID: <CAP8UFD2vxYHvVV8nUBArCGNJTS9K1ynZ1LCBU1BBPBi9d5L77w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Documentation: clarify %(contents:XXXX) doc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 7, 2020 at 9:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +contents:subject::
> > +     The "subject" of the commit or tag message.  It's actually the
> > +     concatenation of all lines of the commit message up to the
> > +     first blank line.
>
> Let's avoid confusing readers by saying "A is X. It's actually Y".
>
>     The first paragraph of the message, which typically is a single
>     line, is taken as the "subject" of the commit or the tag
>     message.

Ok.

> > +contents:body::
> > +     The "body" of the commit or tag message.  It's made of the
> > +     lines after the first blank line.
>
>     The remainder of the commit or the tag message that follows the
>     "subject".

Ok.

> > +contents:signature::
> > +     The optional GPG signature.
>
> I _think_ this only applies to signed tag objects and not signed
> commit objects, but this text does not help to decide if I am
> right.

You are right. It doesn't work for commits:

---------------------------------------------------
$ git cat-file commit refs/heads/signed_commit
tree 9773e6a54521a5d99928685e5f62e937fc6a7593
parent 1d1083b4c06fbb6055a2bd3d665a6d81468db5f5
author Christian Couder <chriscool@tuxfamily.org> 1594397089 +0200
committer Christian Couder <chriscool@tuxfamily.org> 1594397089 +0200
gpgsig -----BEGIN PGP SIGNATURE-----

 iQGzBAABCgAdFiEElaRidyyI6IQbXM36ch8PKcZMVRkFAl8IkaEACgkQch8PKcZM
[...]
 dkYKcRC3
 =fRMN
 -----END PGP SIGNATURE-----

Signed commit
$ git for-each-ref --format='%(contents:signature)' refs/heads/signed_commit

---------------------------------------------------

So I changed the description to:

contents:signature::
    The optional GPG signature of the tag.
