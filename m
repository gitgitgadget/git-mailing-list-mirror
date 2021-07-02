Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA7C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29A06113B
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGBKPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKPV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:15:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B32C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:12:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so9572764otp.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AA795zjYtZsoXjAgn6DZjJLgATkUWMpu/DX8hsd3+iA=;
        b=Br/0lVGRUnf0Owvq54Dg9obnT327+7QQ+ZBLDC8hITh98GqjPRDB9Gu9tdL6bLoEak
         S9Ejj4x3XodipEPpy7m+UHhr6KMRzSCwjzJZGFtsrcb/onRombtc6DMOJfuwrI2Miq1s
         vB8x5KntYeuHxFyaFIYzxcPgRT0KSZ5lVBUxITZagVistzWHxDx/haOrqAhKWiyvaNO+
         cjn0aTgokwFkHPX9jvUfmfe+/2Dp8eRRP+h+yyTqBbzlUP2eOabsEi3e2NJicCsJ6KU+
         rBCV0KC3vS00054D3RteAOA3pQOaLNngf7THShX03vj+CNUAi4jBuqYZEE3SHPHnw9fU
         Fx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AA795zjYtZsoXjAgn6DZjJLgATkUWMpu/DX8hsd3+iA=;
        b=ah+MUSbM/6hsarTwDOYcjN5joNIDhgzpFkB3sAceOcDbfHZ2wkfwINRIqD7XbS51fU
         QK4wNe+mcdXwwfafOH6LaYRXFagwbny3UMGKUtz4WkWERE8vp71Hu4aceT4Fra147LIJ
         wb18QRU5141OUbkediM/2BFsG/s2PrJqy2+RBpFZ4ImMR/BShLy9vSsNWVjcpcO6UKN1
         i4xbmD5OiPR6VAoTzUa6pIJcCqL+COI5z/s52UwztHJo3yPBf2Wc9W8HE56TadS7IgOT
         l97eS6dNRh6Dvgup2jfJjU6TzylMiwYROPbWOJhLpc12sECkl1jfC3cP395JKDS7xhq4
         ZGBQ==
X-Gm-Message-State: AOAM530+W2IwAByyUtNlbqO0yHIl1GUONX4az8ilIl0iLnCVdTwwfR3x
        x7f4NIx4669F1OM03dttntM=
X-Google-Smtp-Source: ABdhPJxmSXoDv0MGRWmJDEHx3qv7Kdy+aobQC+cpk0ebYlFYXkPpM2Y14r7jgODItUkxxGVzKcD7dQ==
X-Received: by 2002:a05:6830:2478:: with SMTP id x56mr3933211otr.197.1625220769527;
        Fri, 02 Jul 2021 03:12:49 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t15sm387628oiw.16.2021.07.02.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:12:48 -0700 (PDT)
Date:   Fri, 02 Jul 2021 05:12:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Message-ID: <60dee69fb7cc7_2964b208fb@natae.notmuch>
In-Reply-To: <87zgw75dyi.fsf@evledraar.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev>
 <60b70eb930614_4abd208ad@natae.notmuch>
 <87eedj74dr.fsf@evledraar.gmail.com>
 <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
 <87zgw75dyi.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jun 03 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> >> We could then just extend the include syntax rather easily to includ=
e
> >> "libraries", which would be like the current include.path, but would=

> >> understand a library:: prefix (better name bikeshedding welcome). We=
'd
> >> then just ship these in /usr/share/git-core/config/includes or whate=
ver,
> >> e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg
> >
> > I wouldn't be against some some suggested defaults, but *in addition*=
 to
> > some hardcoded default aliases that are documented.
> =

> I'm talking about in terms of the flexibility of implementation of
> on-by-default defaults. We could implement it as I suggested and then
> just have a core.defaultIncludes, which would by default be set to
> git::aliases/svn-like.cfg or whatever, i.e. equivalent to:
> =

>     [core]
>     defaultIncludes =3D "git::default.cfg"
> =

> Which itself would include a
> /usr/share/git-core/config/includes/default.cfg which would do:

I really gave this a try, but the problem is that git doesn't even have
a stardard location to install shared files.

I started with $sharedir, but that's not git-specific. Then I added
$gitsharedir which required a bunch of changes to the Makefile, and
eventually I decided against it.

We don't have standard location for shared files. Period.

> In a way this is total bikeshedding, I just think it's worth doing it
> this way up-front.

Yes, maybe so, but git infraestructure is completely unprepared for that
(at this point).

So I just decied to hard-code them [1]

[1] https://lore.kernel.org/git/20210702100506.1422429-1-felipe.contreras=
@gmail.com/

-- =

Felipe Contreras=
