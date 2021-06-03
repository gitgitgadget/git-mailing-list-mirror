Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF0C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038166121D
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCKIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:08:51 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41719 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCKIv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:08:51 -0400
Received: by mail-oi1-f176.google.com with SMTP id c3so5723031oic.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YzAfclqLntikY9K//9U9uoFKvS86cTbUVhBUDHRn0GM=;
        b=tj7xRREwnejxxpX6eeStVeSomFrZcOfSq6MyApqlh9XkOnVnIa8+XxIcWyiYm1q3Pg
         9UorD8dT9cs8629KrZHlC7P7GcdhUngBhDeyz5PPmmueU1JKFEiaawOyq1gwZNG0FiDk
         fKX+hPvNHOoSZEf/TRlR7quCMhGSnQAtH1WHUVhcttAsgMzg30eajQLDO8YC/xZy4VIB
         rE6cb+4BsTlKwtLnnMUBIxgmWn1hu58+Q2GRCUudzspr8pgi4zEZRH6eS9QGaFR5FlMu
         qfWU5NCIiX3pBqUBdLaQp6x87oChukz2/uro6kh4fce3csHOW/+OkXLNpyOFOtNay1n9
         GfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YzAfclqLntikY9K//9U9uoFKvS86cTbUVhBUDHRn0GM=;
        b=GB5z8aSJEmU/MKkOvVW5zrO+hooOQ+ic6xQpoNZ+quBkTNMqE15C10ZeMa0m9sTl21
         TV4uP5QzKYFix5Zwl/K6kRccXKdejKMQtpYHza6++RXODbV1l8IQW99t3bn6GtiC8czF
         Z4LTs6X/YDFdsFdAUVVkhCSypkLzkIrzaTq1Lk6hizDJAm0sR8aatlzFPIM1PRqkwzHQ
         m8BMyjp0fKP/mLxUN2zR/nJvCTDtwGZlny49JAPPTNcrmGdH4Yu3xmj1oqb3z6cZQHs9
         pwP0ObfBTuKIQP0sE/pNV4pRI8V0L/JInESD1RHZSNnggSc+oqgqrzdxiPDeRyClQA9a
         eSjQ==
X-Gm-Message-State: AOAM531OjR4vkleuW84pmbuWKfgDLtCQvo8mQMJZbKgX+w0X+xG9H0Dn
        ou4x3EKSAoB5DQM/xjYC9gQ=
X-Google-Smtp-Source: ABdhPJzAWBxOfABChKW5nLmWZlvIoW1Ag5rKJ/yFTEEyjiMJNVrV66EvC+xfViL88CDT8BbtlKTVag==
X-Received: by 2002:aca:6109:: with SMTP id v9mr6502617oib.65.1622714766614;
        Thu, 03 Jun 2021 03:06:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u26sm583543ote.53.2021.06.03.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:06:06 -0700 (PDT)
Date:   Thu, 03 Jun 2021 05:06:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Message-ID: <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
In-Reply-To: <87eedj74dr.fsf@evledraar.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev>
 <60b70eb930614_4abd208ad@natae.notmuch>
 <87eedj74dr.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Tue, Jun 01 2021, Felipe Contreras wrote:
> =

> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> >> On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmai=
l.com> wrote:
> >> > > How about alias? It's part of my muscle memory.
> >> > =

> >> > No aliases.
> >> > =

> >> > If a new user doesn't have them, neither should you.
> >> > =

> >> > All VCSs have default aliases, and I advocated for git to do the s=
ame
> >> > [1], but it wasn't accepted.
> >> > =

> >> > The whole point is to suffer like them.
> >> =

> >> Get back to the alias topic.
> >> I also agree with other people's opinion in that thread.
> >> IOW, I support the decision to not accept those default alias ;)
> >
> > Why?
> >
> >> It's not required to be different people to have alias defined to
> >> different command. I have alias conditionally defined to different
> >> command based on git-dir. For example, I had ci alias to "commit" by=

> >> default, and "commit -s" on other repositories.
> >
> > So? They would still work.
> >
> >> So, Git decides alias for me will not only break my current alias, b=
ut
> >> also break my conditional alias.
> >
> > No it wouldn't. They are *default* aliases, not overriding aliases. T=
hey
> > would be used only if you haven't set the same alias yourself.
> >
> > Try it.
> >
> > --- a/alias.c
> > +++ b/alias.c
> > @@ -28,13 +28,27 @@ static int config_alias_cb(const char *key, const=
 char *value, void *d)
> >         return 0;
> >  }
> >  =

> > +struct config_alias_data default_aliases[] =3D {
> > +       { "co", "checkout" },
> > +       { "ci", "checkout" },
> > +       { "rb", "rebase" },
> > +       { "st", "status" },
> > +};
> > +
> >  char *alias_lookup(const char *alias)
> >  {
> >         struct config_alias_data data =3D { alias, NULL };
> > +       int i;
> >  =

> >         read_early_config(config_alias_cb, &data);
> > +       if (data.v)
> > +               return data.v;
> > +       for (i =3D 0; i < ARRAY_SIZE(default_aliases); i++) {
> > +               if (!strcmp(alias, default_aliases[i].alias))
> > +                       return xstrdup(default_aliases[i].v);
> > +       }
> >  =

> > -       return data.v;
> > +       return NULL;
> >  }
> >  =

> >  void list_aliases(struct string_list *list)
> >
> >
> >> Anyway, remotes/branches are all configuration values.
> >> Would you prefer:
> >
> > I meant global configurations. If it's a per-repository setting surel=
y
> > it wouldn't be something amenable for the Git project to set as defau=
lt.
> =

> I agree with this batteries included sentiment, but would very much lik=
e
> to not see this as hardcoding of ours, but us shipping optional config
> files to be included.

The problem with optional config files is that you can't standardize
that way.

If hard-coded default aliases they can be included in the documentation.

Pluse we all start to typing similar commands, instead of each having
completely different alias to the next.

For example in 3 days of doing this experiment I've typed 'g c'
countless of times (alias for `commit -v`). I added an alias for `ci`
instead, since that what other VCSs use, like Mercurial. But I don't
think `ci` makes sense for commit. It would be better if `co` was
available, but then checkout needs another alias.

If we could replace checkout with switch, then we could have an alias
`sw` for switch, and another `co` for commit.

But that requires that switch is actually usable (it isn't for me right
now).

This increases the urgency to fix `git switch` for me. If other
developers were trying the same aliases they might see the same issues.

> We could then just extend the include syntax rather easily to include
> "libraries", which would be like the current include.path, but would
> understand a library:: prefix (better name bikeshedding welcome). We'd
> then just ship these in /usr/share/git-core/config/includes or whatever=
,
> e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg

I wouldn't be against some some suggested defaults, but *in addition* to
some hardcoded default aliases that are documented.


I have been using git without aliases for 2 days, and I'm already fed up.=


-- =

Felipe Contreras=
