Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4A7C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77D72465B
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GKLxSwvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgAVHhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:37:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43937 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVHhe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 02:37:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id s16so3582685vsc.10
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tx5rB17/kQOsdtHNKHdirO2koe5Otpg+M5HC2Pll3l8=;
        b=GKLxSwvQutbJEGJsEsGIXVwPXC0BuQ9jy3Fzxph/RIpjB5ZZeH3q0cZHbB6gttWdkA
         t9gBJaJPhMmuHId8sfXdOlBLawQhEBNrxVOlPQyBuQoU6W6eSkGdBrz2BrDZJZHuFp9l
         jRYehMnbrE/EvlCFzBabujLUxYHpK59f6LXOcZBUnR0x10Z/94XBV8SV4BKJMOKLhvxr
         SEdf544iiveDJehAtdBOfeh6vOYHXy7OtD4jYa7bPgwbAuiTEltdhGbpiXD4CmZL6cXT
         EK4ktrxTsvH1/jIz/GipaUjZoHRWUU8P2+8nglbIgZXjWTEdpyB2yixDX+1t0XQn/n9P
         Vq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx5rB17/kQOsdtHNKHdirO2koe5Otpg+M5HC2Pll3l8=;
        b=L3aVJaV2YyeumvhW1qDYPNDr6v3SeFQ6xxsv2kt3SFw1X+JsSXvInZ16kwSjYBCEH8
         jqZzmB2qnSdVtKL32asc6irtUDYQV/AuNd1aY7L01Q3z4FkwLtYOZsV4c+6NwKK3GoSt
         GOpV6aYemPQM2UnqV8xg0DDcVyqB7hf5774yAP7wEUL9YewglUKBOBWMfNtMnzTh3ck7
         M8R76RH9T79cfr3MxBVoDb2Sb8Bs0XyauV7S8otU8HuuKEBD7Mah8JzZrIXVAIZPW1D9
         IIrQ8d8hs1txc9p49PXJYyNLybm/bl1v3Ru73HaQB1arBT34vgB6oHnUWhNuz3mFb5OZ
         08XA==
X-Gm-Message-State: APjAAAVtp4/JWrExcMHTQDyeqxsa/WTA1UjsusEA1E5LN4CEAkfDJx4q
        DqUJcDf653fUfBsEuVSPknEOdxsQkTxGduf7+sU=
X-Google-Smtp-Source: APXvYqwUvEtdW5xrOdI0Eghgsv83D3uL4blvToxUYhV88eGTVWrf/QdWqzFRWHsUgnJDNiLgrigcRZSrtm785MJZ0U8=
X-Received: by 2002:a67:ec41:: with SMTP id z1mr1779412vso.197.1579678653280;
 Tue, 21 Jan 2020 23:37:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
 <04eb98389880c96e1dc18131031e9d6ad5830a40.1579598053.git.bert.wesarg@googlemail.com>
 <CAOjrSZsuPUc7kDPh6wTDMq10b2QM0R2Uq7-0TQ=W76yjk-eoJA@mail.gmail.com>
In-Reply-To: <CAOjrSZsuPUc7kDPh6wTDMq10b2QM0R2Uq7-0TQ=W76yjk-eoJA@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 22 Jan 2020 08:37:21 +0100
Message-ID: <CAKPyHN0=jBc1PYC2jSp0SV7EuMwmRb_RRifmK66KTqVtP5oFRQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] [RFC] config: make `scope_name` global as `config_scope_name`
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 1:12 AM Matt Rogers <mattr94@gmail.com> wrote:
>
> Logos good to me...
>
> As I'm a bit new, what would be the best way for me to work this into
> my workflow?

if you have done that change already locally, then you can ignore my
patch. I will wait for your re-roll and put my changes on top of
yours. If not, you could replace your patch with this one in your
series. Your call.

Bert

>
> On Tue, Jan 21, 2020 at 4:25 AM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> >
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> > Will be replaced by Matthew Rogers.
> >
> > Cc: Matthew Rogers <mattr94@gmail.com>
> > ---
> >  config.c               | 16 ++++++++++++++++
> >  config.h               |  1 +
> >  t/helper/test-config.c | 17 +----------------
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/config.c b/config.c
> > index d75f88ca0c..4c461bb7a3 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -3317,6 +3317,22 @@ enum config_scope current_config_scope(void)
> >                 return current_parsing_scope;
> >  }
> >
> > +const char *config_scope_name(enum config_scope scope)
> > +{
> > +       switch (scope) {
> > +       case CONFIG_SCOPE_SYSTEM:
> > +               return "system";
> > +       case CONFIG_SCOPE_GLOBAL:
> > +               return "global";
> > +       case CONFIG_SCOPE_REPO:
> > +               return "repo";
> > +       case CONFIG_SCOPE_CMDLINE:
> > +               return "cmdline";
> > +       default:
> > +               return "unknown";
> > +       }
> > +}
> > +
> >  int lookup_config(const char **mapping, int nr_mapping, const char *var)
> >  {
> >         int i;
> > diff --git a/config.h b/config.h
> > index 91fd4c5e96..c063f33ff6 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -301,6 +301,7 @@ enum config_scope {
> >         CONFIG_SCOPE_REPO,
> >         CONFIG_SCOPE_CMDLINE,
> >  };
> > +const char *config_scope_name(enum config_scope scope);
> >
> >  enum config_scope current_config_scope(void);
> >  const char *current_config_origin_type(void);
> > diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> > index 214003d5b2..1e3bc7c8f4 100644
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -37,21 +37,6 @@
> >   *
> >   */
> >
> > -static const char *scope_name(enum config_scope scope)
> > -{
> > -       switch (scope) {
> > -       case CONFIG_SCOPE_SYSTEM:
> > -               return "system";
> > -       case CONFIG_SCOPE_GLOBAL:
> > -               return "global";
> > -       case CONFIG_SCOPE_REPO:
> > -               return "repo";
> > -       case CONFIG_SCOPE_CMDLINE:
> > -               return "cmdline";
> > -       default:
> > -               return "unknown";
> > -       }
> > -}
> >  static int iterate_cb(const char *var, const char *value, void *data)
> >  {
> >         static int nr;
> > @@ -63,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
> >         printf("value=%s\n", value ? value : "(null)");
> >         printf("origin=%s\n", current_config_origin_type());
> >         printf("name=%s\n", current_config_name());
> > -       printf("scope=%s\n", scope_name(current_config_scope()));
> > +       printf("scope=%s\n", config_scope_name(current_config_scope()));
> >
> >         return 0;
> >  }
> > --
> > 2.24.1.497.g9abd7b20b4.dirty
> >
>
>
> --
> Matthew Rogers
