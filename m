Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BAEC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8989D221EB
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koeP3IJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgKNMMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNMMb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 07:12:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A139C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:12:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f20so17716986ejz.4
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qfR/aQ7goug0wM1gim1IyJKIkORB0twcG1YURVZxOMo=;
        b=koeP3IJq7VX4VNq7y2agE9rvBR93JMZtscQyYKa0xlYnGe1XaFUX3hpO1s9qSxIKQX
         WqlD3n+FoJbFhB3EBirfgfB92aPUwjyiIEm/KgiIMgqeO5+aFl5WyAEyMC9ek1Mu/RXT
         8F+u/BRexqj0W7FbWHGJ8mwr2fMC6C6dmRUlK5vmR748RFxA4ZsdbosU8OWLvuLFPFaH
         GtYuqI3FwNUIFYZ3wZc6JpUKTceHhKk5nSWypbhu08Vezxxu3owRcyyqeRG7tuVY/15g
         3DNNaEPeGlrqEkO0/kcVnsB6My492qfckBeJDZcp+qVkmBJLmYWFZsbQ5uQQosqXhFsj
         x5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qfR/aQ7goug0wM1gim1IyJKIkORB0twcG1YURVZxOMo=;
        b=c7Ffz9aU7B+rQk4YQFYIgZJyaOX1bPX3YfX6Dr2NTfCzIk/P6BG/xHRrrR8khlymbS
         wso4kBwN7POfYSnnW2j5xcYzDrHBrQgxPYCIbrAj4sbXwaFuwN4TIbUz6YN+BERhgwoZ
         sUzoI99E7/UVCxVOYLreSKbpL35JiiL1RoZDvOBtaL/2Y0PgCBcmkRwh7FcQI2rYTS+N
         Pz6Y9zTaY6U25HEFMrkFk3UDEtYAAVbTP7fwZVxvVVjewCss01IzU+WN/OYppt6EM33Z
         1QdpOcRBniBBXsExMYmjRTnpq52aWGXCRjfs1HyP0K7g7Nt4AJfW93PaHRvPtiyTcTWE
         Qohg==
X-Gm-Message-State: AOAM532Hd2fZrG/JhoBr/SPLFEcKTXdG9WBLHQeGEcqvJ4Vam1AoF2Py
        czlbVs0zzmqRsFRYBUZa7hF6QHW4ghomrg==
X-Google-Smtp-Source: ABdhPJwebegaTbTFH5Sjg1hHwBlX94jprKNPRA71DEe+nUAGXPxnFxg4y0O4F6RkhN1Ui3N4GIa5iA==
X-Received: by 2002:a17:906:1e45:: with SMTP id i5mr6170115ejj.203.1605355949592;
        Sat, 14 Nov 2020 04:12:29 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id mj17sm6349257ejb.59.2020.11.14.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:12:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Jeff King" <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: How do I "git fetch" with a custom <refspec> but a default remote?
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com> <20201111151754.31527-1-avarab@gmail.com> <877dqqhd3s.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <877dqqhd3s.fsf@evledraar.gmail.com>
Date:   Sat, 14 Nov 2020 13:12:28 +0100
Message-ID: <87eekwf87n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Nov 11 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> In any case, this is one thing that came out of that
>> investigation. The code we're keeping by moving it to git-submodule.sh
>> can also be replaced by some C code we have, but I wanted to leave
>> that to another submission (if I'll get to it), and make this simply a
>> code removal.
>
> I may have missed a way to do $subject, but I don't think it's
> possible. The reason I want it is because git-submodule.sh does this:
>
>     git fetch $(get_default_remote) "$@" ;;
>
> Where that shellscript function gets the name of the remote configured
> for the current branch. If you do just a:
>
>     git fetch
>
> Then it will do the right thing, per its documentation:
>
>      When no remote is specified, by default the origin remote will be
>      used, unless there=E2=80=99s an upstream branch configured for the c=
urrent
>      branch.
>
> But git-submodule.sh wants to do:
>
>     git fetch <default-remote> <some-sha1>
>
> So the caller is forced to find out what that is.
>
> I came up with this patch:
>=20=20=20=20=20
>     diff --git a/builtin/fetch.c b/builtin/fetch.c
>     index f9c3c49f14..f110ac8d08 100644
>     --- a/builtin/fetch.c
>     +++ b/builtin/fetch.c
>     @@ -56,6 +56,7 @@ static int prune_tags =3D -1; /* unspecified */
>      #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>=20=20=20=20=20=20
>      static int all, append, dry_run, force, keep, multiple, update_head_=
ok;
>     +static int default_remote;
>      static int write_fetch_head =3D 1;
>      static int verbosity, deepen_relative, set_upstream;
>      static int progress =3D -1;
>     @@ -140,6 +141,8 @@ static struct option builtin_fetch_options[] =3D {
>             OPT__VERBOSITY(&verbosity),
>             OPT_BOOL(0, "all", &all,
>                      N_("fetch from all remotes")),
>     +       OPT_BOOL(0, "default-remote", &default_remote,
>     +                N_("fetch from default remote")),
>             OPT_BOOL(0, "set-upstream", &set_upstream,
>                      N_("set upstream for git pull/fetch")),
>             OPT_BOOL('a', "append", &append,
>     @@ -1852,7 +1855,7 @@ int cmd_fetch(int argc, const char **argv, cons=
t char *prefix)
>                     else if (argc > 1)
>                             die(_("fetch --all does not make sense with r=
efspecs"));
>                     (void) for_each_remote(get_one_remote_for_fetch, &lis=
t);
>     -       } else if (argc =3D=3D 0) {
>     +       } else if (argc =3D=3D 0 || default_remote) {
>                     /* No arguments -- use default remote */
>                     remote =3D remote_get(NULL);
>             } else if (multiple) {
>
> Which allows me to do:
>
>     -               git fetch $(get_default_remote) "$@" ;;
>     +               git fetch --default-remote "$@" ;;
>
>
> So it works, but what do we think about this calling convention? Do we
> have any prior art for commands that take positional arguments like
> <remote> and <refspec> where you'd like to use a default for an earlier
> argument to provide a subsequent one?
>
> To make it more general and consistent we'de probably like a --remote=3D*
> and --refspec arguments, so the invocation would be:
>
>     git fetch ([--remote=3D]<name> | --default-remote) [([--refspec=3D]<r=
efspec> | --default-refspec)]
>
> But maybe I'm overthinking it...

To reply to my own question, this is possible with the --stdin option:

    echo <refpec> | git fetch --stdin

See 2b713c272c ("fetch: allow refspecs specified through stdin",
2020-08-17)[1].

1. https://lore.kernel.org/git/9f277f1631a37785dcd72a552dd86738d639ea59.159=
7722942.git.jonathantanmy@google.com/
