Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA4C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E742A61285
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhFIFhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:37:31 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35763 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFIFha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:37:30 -0400
Received: by mail-oi1-f176.google.com with SMTP id v22so24056817oic.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 22:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtKzMTCxjI0V1dOAdGLSrAsxRNRgfDCHf5666aIEamI=;
        b=Kww3L9Aryz64LwhXMRipae4Wv/Uh32MXXLucCMvDGiyz5WTicKh7/KFMmt1xkB1SNe
         O3+eo3LIftMj7Tr4AntiLzk4hIiu3XrO1UGvG3X5G8E9FM0Duz13XwsuIqAco7Df/tEd
         s1pq5ejmUgGIAUhYf02r53Rn5QK3XZsuzIRhkJWcgDpyx4XduQ+3GpE+WFufaOM2AM4k
         rviNfxSmyuA4amQFalOMu0NzulKQVNW7FZCY/x6AlnBOsQ9LfOiZobPnzi8tTBAcqh/u
         YtY8YytxCNPYj/tuVXm5fDDsFp0adSN5xVMKjSOVqlZdjN2sJxhrLbL/voYMVYb4be2O
         h1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtKzMTCxjI0V1dOAdGLSrAsxRNRgfDCHf5666aIEamI=;
        b=L47wgYyDiL6TNip/Ioj1iOV70R3I4lksfklsSFYQ0rEwyVibKb84w+LmpQN9PGXkaT
         JbkfhNNLoz+2JCQj7sD7zGecegc18IWIE8nvpRCdPSDxhYu8DNi3ND5H/ggo9FYJ2f4S
         Mculq2HgXRZCgzZlFXnzWlHgqXRQYMOCi3b84A37EKgwQciliWwN/G3xMoljocWbd5xW
         K8cRosq2lnAqhH+BL3ML7u/YJJ0QQQAxydwbOxcxN9kKXIPpYaqtd491TKpMEupfonBo
         V9IwaPr055azX2+KA1tokeejmFsVsmDwBRxInl7c6ttj1Y2MZfSYWFlpHDhRyzSH+gKz
         8PKQ==
X-Gm-Message-State: AOAM531Lm+oXcBYMrs67Gh2bppPVJK9IqqvDwi8Lf4fGt7mDLA8zzPBx
        sGfGEnAPQpBstcmn7mvAE43bX3YF8bo5MIti5mo=
X-Google-Smtp-Source: ABdhPJwbPadawkbFUz/EM3GS7ix3nhbUd/EgCDJC4TWvwivvobzPZYSyH2PHpwU6L1V4TgiC7/cVcUWksIBeh80juDg=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr5403500oiw.31.1623216876685;
 Tue, 08 Jun 2021 22:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEn+yksK1KhncL8jWAya+ikGPUtsWpoZhrJrgRH2ORajw@mail.gmail.com>
 <20210609044441.2326555-1-jonathantanmy@google.com>
In-Reply-To: <20210609044441.2326555-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 22:34:25 -0700
Message-ID: <CABPp-BHt3db__cMpTY1a7y4u064NdVZGNCmnoR25aqhrWMfJcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 8, 2021 at 9:44 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > @@ -99,6 +94,15 @@ static int promisor_remote_config(const char *var, const char *value, void *data
> > >         size_t namelen;
> > >         const char *subkey;
> > >
> > > +       if (!strcmp(var, "extensions.partialclone")) {
> > > +               /*
> > > +                * NULL value is handled in handle_extension_v0 in setup.c.
> > > +                */
> > > +               if (value)
> > > +                       repository_format_partial_clone = xstrdup(value);
> > > +               return 0;
> > > +       }
> >
> > This is actually slightly hard to parse out.  I was trying to figure
> > out where repository_format_partial_clone was initialized, and it's
> > not handled when value is NULL in handle_extension_v0; it's the fact
> > that repository_format_partial_clone is declared a static global
> > variable.
> >
> > But in the next patch you make it a member of struct
> > promisor_remote_config, and instead rely on the xcalloc call in
> > promisor_remote_init().
> >
> > That means everything is properly initialized and you haven't made any
> > mistakes here, but the logic is a bit hard to follow.  Perhaps it'd be
> > nicer to just write this as
> >
> > +       if (!strcmp(var, "extensions.partialclone")) {
> > +               repository_format_partial_clone = xstrdup_or_null(value);
> > +               return 0;
> > +       }
> >
> > which makes the code shorter and easier to follow, at least for me.
>
> Hmm...is your concern about the case in which
> repository_format_partial_clone is uninitialized, or about ignoring a
> potential NULL value? If the former, I don't see how your suggestion
> fixes things, since extensions.partialclone may never have been in the
> config in the first place (and would thus leave
> repository_format_partial_clone uninitialized, if it weren't for the
> fact that it is in static storage and thus initialized to 0). If the
> latter, I guess I should be more detailed about how it's being handled
> in setup.c (or maybe just leave out the comment altogether - the code
> here can handle a NULL repository_format_partial_clone for some reason).

My comment was about the latter; I was trying to understand what the
comment meant relative to that case, and how and where that case would
be handled in the code.  With that frame of reference, the comment
seemed misleading to me...though perhaps the comment was intended to
answer some other question entirely.
