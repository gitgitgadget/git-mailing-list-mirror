Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D958C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E38360462
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhIWCBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWCBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:01:09 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A4AC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:59:38 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id y74so1958876vky.12
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5A2SLqdrBXH3egtJBXvnKqXW+yD8lCRuzy/PSmvW2xU=;
        b=FIsNxYB3sOBJPR4hQL7q+Tejs18zSzacWSO2/CrJQFKjZdOtvnmpnWc1tASPOAeSRP
         u2d2h4m8wULYI8oY2JWeesxrCawiYeYenHMjxGpMVeu0Z0mWIb0SmDvfLLMvPXpvvY6o
         +xgdejE9ayp6dwVOO6Zn1dKGLpgXxACY8Z4HJWvylij5WqsgrOWve8VSsNk7MBbw1hFJ
         ZnZsBewGuXVCZ+nIbotfzyvxRAleZNrHmbr0OHHTbvAA+0rC4o21RUbo6qVQhW//lfAe
         WPAqgXu/4Oy5zXuEnCoQvlC+oPVyoewfWI7LlwlntBF3xlkmm/XrUGPeGiYrgy1IbkNI
         8ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5A2SLqdrBXH3egtJBXvnKqXW+yD8lCRuzy/PSmvW2xU=;
        b=wUQLx85E08PtsA+O6RNOKgQgI38IEtvzgNw8K/YNX0Wj92Wvm0HnmGLoL+782pa5IE
         7TIiDBQVRAfVbe0XHIoJtZtuBacxMRhq/5E6WRO0/Gt77PkASZzjJ7UD+yd9mubOlXUF
         8dl+JMge8IwbgiZQhnaR8V3pTA7FdOEAgabGhOcQkN0h3lR/6vSbEGkuE1ZJ96aag/7/
         vLiXk8ROv0PwA+gXQk/1jid0Ec57rApby07WkXr10mvXLlSaIY/SVfMZk+KIbjwLCNe3
         nSKIZgSfgf8KCGwYt36L1YjQiWs4JFUGl86XfM3PuQ+UJJTXuQMtV6uyBc0ixm1T35QS
         1JNg==
X-Gm-Message-State: AOAM5328HIs8kfv5iam+nITOZiMTDGVsyd3rV3dG9qVHQ9EGjAkbEiMV
        73vbtvc95UYP+XIysF2OmuIT6MMfW4krtQSDtqFggAO9TUE=
X-Google-Smtp-Source: ABdhPJwOXjDxsveZE7BPis2reV65SlewVzRvzEX+ez7z0LvWPwkLRc5RQAmz8TFF8r/K9Vn/no7YKzK9kC7pvx9kIeY=
X-Received: by 2002:a1f:c9c1:: with SMTP id z184mr1758515vkf.7.1632362377940;
 Wed, 22 Sep 2021 18:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210922183311.3766-1-carenas@gmail.com> <20210922185702.4328-1-carenas@gmail.com>
 <YUvbU9HX6JA+MKd0@camp.crustytoothpaste.net>
In-Reply-To: <YUvbU9HX6JA+MKd0@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 18:59:26 -0700
Message-ID: <CAPUEspjJdkPgpWvLJKNks+Uu-tZmahw6U3pa+XBkMB6_m_dtRQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: avoid breaking compilation database
 generation with DEVELOPER
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        levraiphilippeblain@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 6:41 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> > diff --git a/Makefile b/Makefile
> > index 9df565f27b..d5c6d0ea3b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE =3D no
> >  endif
> >
> >  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> > -compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> > +compdb_check =3D $(shell $(CC) \
> >       -c -MJ /dev/null \
> >       -x c /dev/null -o /dev/null 2>&1; \
> >       echo $$?)
>
> Are you sure this results in a functional set of files?

no; it does not

This call is only meant to be used to check if your compiler supports
the feature (which as =C3=86var points out[1], might not be the best thing
to do in this case), though

After this fix the files are being generated (in a different place
with their expected flags) and look healthy, but would be helpful to
know you see no regressions.

Carlo

[1] https://lore.kernel.org/git/87tuic5cdo.fsf@evledraar.gmail.com/
