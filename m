Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F1C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189D7613DE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFCMb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:31:57 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:44618 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhFCMb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 08:31:56 -0400
Received: by mail-ej1-f45.google.com with SMTP id c10so8902595eja.11
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uofwxwu+dBNNX5ucM21MVjfguBfnetoO3MAVjzWHMr0=;
        b=ozDlKtulGeZTZqQxrf04I8TZIbL693XK2N3ULgFzbRwW/pwp1E9phnGFbKn/Ceu/Xf
         parTxLjEWIwbhppE5OWsm7HH2ItnVvYIvdqt8wNdnnrT6XCw8DzjDe24lbUHyl9hmoE4
         3JpHWsLY0SEwmk7aH3+pDygWqxOorL78HEDX/YU5GsQ7ZeN0CWhEMe4CrFaiq2+tbgJp
         w12SYqr3MTdFtIAMcpLe8FCjSsVE4Jrk/GxUl6kOpGmfmsiQlsQonYZK8VeS67iheo1/
         YvtNBtSIq7nrJqDND5ToL8NbC9lwtOKwfZsYySeOsK0A2iWTf/umAxJzfb2zitLS9SeQ
         jxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uofwxwu+dBNNX5ucM21MVjfguBfnetoO3MAVjzWHMr0=;
        b=OE+puXmmOPMPPhykupo9bUMjCTwlG2QE2rpDv1erENF/66SFYX0gR0eY8osqg2QD33
         PeNMT3YBOiRbw1nd2pAKtuVcfXSPUNOVmzATOj/H/9BVRTSyi5cqQkumxTkteGXKMDuV
         JLkFcavOVddUiG1zJpHVH/4y3AZHkpJkXfY825oS74FNkZzdlZp1Y8/RoJ/QjpXiw0Q+
         hchfgP9YhXTeJveOmFFe64IePZuQPwpi20no4/c/wIYtr+vuLX+DLYv5/AjfTO6m7pDN
         j80+e6k6u73iV04e9JdEoCCX4ZPPMtsZluz6PxuvefTWVykHUnLcAcugLOW1blBIzywE
         yyvg==
X-Gm-Message-State: AOAM531CBiXQwFNcO2IHWFZPGlTjXiFCihhdwr6g2KlcRfIadorUwuk3
        SQ8bSHEoJDy1sc7V9XW1TZE=
X-Google-Smtp-Source: ABdhPJyMFN7ZJTTcDZHFcPtQN9PMksdN4cBPWPFlWvxBIhNEvlPelpP6eH+WY1cD2oosMhUz56rI7A==
X-Received: by 2002:a17:907:7747:: with SMTP id kx7mr38967972ejc.400.1622723351044;
        Thu, 03 Jun 2021 05:29:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id fn3sm1431144ejc.96.2021.06.03.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:29:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Thu, 03 Jun 2021 14:18:15 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev> <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev> <60b70eb930614_4abd208ad@natae.notmuch>
 <87eedj74dr.fsf@evledraar.gmail.com>
 <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
Message-ID: <87zgw75dyi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Jun 01 2021, Felipe Contreras wrote:
>>=20
>> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>> >> On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail=
.com> wrote:
>> >> > > How about alias? It's part of my muscle memory.
>> >> >=20
>> >> > No aliases.
>> >> >=20
>> >> > If a new user doesn't have them, neither should you.
>> >> >=20
>> >> > All VCSs have default aliases, and I advocated for git to do the sa=
me
>> >> > [1], but it wasn't accepted.
>> >> >=20
>> >> > The whole point is to suffer like them.
>> >>=20
>> >> Get back to the alias topic.
>> >> I also agree with other people's opinion in that thread.
>> >> IOW, I support the decision to not accept those default alias ;)
>> >
>> > Why?
>> >
>> >> It's not required to be different people to have alias defined to
>> >> different command. I have alias conditionally defined to different
>> >> command based on git-dir. For example, I had ci alias to "commit" by
>> >> default, and "commit -s" on other repositories.
>> >
>> > So? They would still work.
>> >
>> >> So, Git decides alias for me will not only break my current alias, but
>> >> also break my conditional alias.
>> >
>> > No it wouldn't. They are *default* aliases, not overriding aliases. Th=
ey
>> > would be used only if you haven't set the same alias yourself.
>> >
>> > Try it.
>> >
>> > --- a/alias.c
>> > +++ b/alias.c
>> > @@ -28,13 +28,27 @@ static int config_alias_cb(const char *key, const =
char *value, void *d)
>> >         return 0;
>> >  }
>> >=20=20
>> > +struct config_alias_data default_aliases[] =3D {
>> > +       { "co", "checkout" },
>> > +       { "ci", "checkout" },
>> > +       { "rb", "rebase" },
>> > +       { "st", "status" },
>> > +};
>> > +
>> >  char *alias_lookup(const char *alias)
>> >  {
>> >         struct config_alias_data data =3D { alias, NULL };
>> > +       int i;
>> >=20=20
>> >         read_early_config(config_alias_cb, &data);
>> > +       if (data.v)
>> > +               return data.v;
>> > +       for (i =3D 0; i < ARRAY_SIZE(default_aliases); i++) {
>> > +               if (!strcmp(alias, default_aliases[i].alias))
>> > +                       return xstrdup(default_aliases[i].v);
>> > +       }
>> >=20=20
>> > -       return data.v;
>> > +       return NULL;
>> >  }
>> >=20=20
>> >  void list_aliases(struct string_list *list)
>> >
>> >
>> >> Anyway, remotes/branches are all configuration values.
>> >> Would you prefer:
>> >
>> > I meant global configurations. If it's a per-repository setting surely
>> > it wouldn't be something amenable for the Git project to set as defaul=
t.
>>=20
>> I agree with this batteries included sentiment, but would very much like
>> to not see this as hardcoding of ours, but us shipping optional config
>> files to be included.
>
> The problem with optional config files is that you can't standardize
> that way.
>
> If hard-coded default aliases they can be included in the documentation.
>
> Pluse we all start to typing similar commands, instead of each having
> completely different alias to the next.
>
> For example in 3 days of doing this experiment I've typed 'g c'
> countless of times (alias for `commit -v`). I added an alias for `ci`
> instead, since that what other VCSs use, like Mercurial. But I don't
> think `ci` makes sense for commit. It would be better if `co` was
> available, but then checkout needs another alias.
>
> If we could replace checkout with switch, then we could have an alias
> `sw` for switch, and another `co` for commit.
>
> But that requires that switch is actually usable (it isn't for me right
> now).
>
> This increases the urgency to fix `git switch` for me. If other
> developers were trying the same aliases they might see the same issues.
>
>> We could then just extend the include syntax rather easily to include
>> "libraries", which would be like the current include.path, but would
>> understand a library:: prefix (better name bikeshedding welcome). We'd
>> then just ship these in /usr/share/git-core/config/includes or whatever,
>> e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg
>
> I wouldn't be against some some suggested defaults, but *in addition* to
> some hardcoded default aliases that are documented.

I'm talking about in terms of the flexibility of implementation of
on-by-default defaults. We could implement it as I suggested and then
just have a core.defaultIncludes, which would by default be set to
git::aliases/svn-like.cfg or whatever, i.e. equivalent to:

    [core]
    defaultIncludes =3D "git::default.cfg"

Which itself would include a
/usr/share/git-core/config/includes/default.cfg which would do:

    [include]
    path =3D "git::aliases/svn-like.cfg"
    paht =3D <some other default file>

So it would work out of the box on a vanilla git install, you could then
in ~/.gitconfig or whatever set:

    [core]
    defaultIncludes =3D false

Or whatever, which we'd check for early with repo_config_get_bool() (see
repo-settings.c).

So you'd have an out from these optional vanilla includes. Then to
address the concern in [1] we could (sans the user-diff specific
limitations in that thread) treat the default userdiff "config" this way
and (optionally) slurp these up into a generated *.c file at build-time.

In a way this is total bikeshedding, I just think it's worth doing it
this way up-front.

It gives you a lot more flexibility than hardcoding these in the source
somewhere. It becomes easy e.g. to have multiple "default" variants, so
feature.experimental or whatever could give you early opt-in to new
aliases, or the other way around of new versions maintaining
compatibility with older style invocations via aliases.

1. https://lore.kernel.org/git/87czvoowg2.fsf@evledraar.gmail.com/
