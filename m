Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4AFC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 19:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBNT5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBNT5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 14:57:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9A2BF15
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 11:57:01 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id s203so14414914ybc.11
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 11:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCVRHibJPk8E2uDHWD3mAqBvsLFaqLOITGHfwt5s0tk=;
        b=OomyeCX8uRGdOHNGK7vj0xkQdWR7nDFIv5oMnXJKwnVZRGyv12HvAemZYeYwPtc+c5
         l6MwcEjkwJCaPmSwuslzYeXc4zBH4IvcV13/a596gTiEjjteBHrw1oRpAzDWgqUjyQNC
         mqG1fVPYCxZ8NuGDjAMnqncYq5Yat3QxovqPGiTxYXQnc55+1vovPfSIaoUhPIiXmPxi
         y26nOADjzF98yyVZovTizkBdwYXDoqso9v+WdMrvjeSsvJSrdn7iFpR+1MNG8xr+80yr
         VwRblkszHo1D5aa0Fn2VCMvrDNE2fNve7wmv8LNjaPF6qgs2fjwqnrcwbFkEMY3Dqq0h
         d66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCVRHibJPk8E2uDHWD3mAqBvsLFaqLOITGHfwt5s0tk=;
        b=X/RFLtqxOx+lPpUwWHwhngQNejug0XBYv9KSSbZTGuv9Jfk0IO9FZDh3w1JAlAtrt0
         YYF8h3ACoLiEoXpuxnaQuH1IoUeazAR7mBt35/ZTP0KK+bohgQDCMASJuNdtMJXLK34x
         QVpaN/IEHbrNUtsQdNxD1zu0IPN46n6TgtudvMuTX58BJ6fccg31U8cENDZjpDs3cx3R
         qSwLW+QCrR0KEcL4HFQfQmZSWU4NX/nFcuPdJFBjybgZJ8TzAu7/lP7qCAJ/YjmS1ul1
         pZgTzskeZNr/RifL+URPrpsj+JQ9pX1xWs6kXErV5Q9bZwUYBizgHlCSLc1WIQo2OZki
         kaGQ==
X-Gm-Message-State: AO0yUKVrDuImj6jkW8SXvOv9tIbYhb+90aWX1V5m/u7pDSoISUju0jzp
        E+Pn5DSImvZE/IVwWhFNBviFOCwPTyaSnqFfAM/t+Q==
X-Google-Smtp-Source: AK7set8qV9QpMrXD00hvhPxyDYRKKqHZDHL1e0HumhxoyyUSN2AQpfLYfFXKzLbgtlVnHPTrYhApuj2h4sS1HNL5mR0=
X-Received: by 2002:a5b:103:0:b0:918:3e8f:5e70 with SMTP id
 3-20020a5b0103000000b009183e8f5e70mr395034ybx.573.1676404621020; Tue, 14 Feb
 2023 11:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-2-calvinwan@google.com> <xmqqk00lbc8k.fsf@gitster.g>
In-Reply-To: <xmqqk00lbc8k.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 14 Feb 2023 11:56:50 -0800
Message-ID: <CAFySSZBAXCGTEhTK+rpLaZz4_RhdEDV5e5QewUwN-LHgSOTe2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] leak fix: cache_put_path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 11:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > hashmap_put returns a pointer if the key was found and subsequently
> > replaced. Free this pointer so it isn't leaked.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > ---
> >  submodule-config.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/submodule-config.c b/submodule-config.c
> > index 4dc61b3a78..90cab34568 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> > @@ -128,9 +128,11 @@ static void cache_put_path(struct submodule_cache *cache,
> >       unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
> >                                           submodule->path);
> >       struct submodule_entry *e = xmalloc(sizeof(*e));
> > +     struct hashmap_entry *replaced;
> >       hashmap_entry_init(&e->ent, hash);
> >       e->config = submodule;
> > -     hashmap_put(&cache->for_path, &e->ent);
> > +     replaced = hashmap_put(&cache->for_path, &e->ent);
> > +     free(replaced);
> >  }
>
> Out of curiosity, I've checked all the grep hits from hashmap_put()
> in the codebase and this seems to be the only one.  Everybody else
> either calls hashmap_put() only after hashmap_get() sees that there
> is no existing one, or unconditionally calls hashmap_put() and dies
> if an earlier registration is found.
>
> The callers of oidmap_put() in sequencer.c I didn't check.  There
> might be similar leaks there, or they may be safe---I dunno.  But
> all other callers of oidmap_put() also seem to be safe.
>
> Back to the patch itself.  The only caller of this function does
>
>         if (submodule->path) {
>                 cache_remove_path(me->cache, submodule);
>                 free(submodule->path);
>         }
>         submodule->path = xstrdup(value);
>         cache_put_path(me->cache, submodule);
>
> It is curious how the same submodule->path is occupied by more than
> one submodule?  Isn't that a configuration error we want to report
> to the user somehow (not necessarily error/die), instead of silently
> replacing with the "last one wins" precedence?
>
> Assuming that the "last one wins" is the sensible thing to do, the
> change proposed by this patch does seem reasonable way to plug the
> leak.

Swapping this functionality to "first one wins" or erroring out breaks many
tests that are setup improperly. If we continue with the "last one wins"
precedence, then a warning and documentation should be added. We
definitely should not swap it to "first one wins" -- one doesn't make sense
than the other, but "last one wins" at least has precedence. If we choose
to error out during config parsing when duplicated submodule paths are
detected, then those respective tests will also need to be updated.

I'm leaning towards leaving the functionality as is since a user would
have to manually edit the .gitmodules file to get into the state and is
protected from it with `git submodule add`. What do you think about
adding a warning and possibly documentation?
