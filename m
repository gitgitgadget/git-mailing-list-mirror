Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC5C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiESKGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiESKGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:06:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C22C11B
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:06:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eg11so6328644edb.11
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sXi0OYD2u91RjQgIya+rpx/5FG7/qf8f6kRxuXFRQr8=;
        b=FnrtNRL9BjSYMhUR+QPoAUCYdEDajrF2A5BbANN7XMkhXrZOvxYSSWfj0EohM8Yj46
         AruLdLjSOjSBzgVGvrT6Nb002i0h+G6TjmWfVxLcd/9EtuTQqcdDfKDSBnJ2QO6SxiHM
         Bdd3lolLKwmUzcWJHcd6DVw5Ob9gimrxBgKh5Z9m2GZLJta7GGJORsJW09ES6FdYtjny
         suvSHDhnyIDjdZGAy4C4iZ0MLeokimBEgVL/EOveN9Cb/qpNd1k0JI/xo0F8DyhpNSzl
         39umd6l537X9NQ5+9/NGHov2oKL0obF/qMpdtv7L84yUUbBvNnoyFtoYbmT0LeDc/7Rb
         vkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sXi0OYD2u91RjQgIya+rpx/5FG7/qf8f6kRxuXFRQr8=;
        b=xFAdda+28cpoKnFbfMJ8oteVKokaoQvdsz2/JnEcj09pMruFMeRnAxQXb3pdFkqnlC
         IrpBrQqzvTpthKpI9GCBZ2efu3kwNOqX3cQZhSU06D9aBt59TulbrYh01WSP8VezhPvi
         EvM8a5p/4h0KuJ3di5n+27GLc2nYJqiegP2BoAHiunvVTX5wr5a3Nap9kYFeX5C7Vcyg
         V7IO/Ej35sx0kSRbvuIz5g3o59ssHYq75ixVmROIvuuruXIMnA0f0MKGB4RrtWjE7vbo
         nmausWgN5vmHz6hXmOTBoumS5c3B+bo8uypNAgHVdIHK13vj50AlA7H4SiMbkJ3VOz4Q
         wl/Q==
X-Gm-Message-State: AOAM531FZKhGJAJtve7GSO6NapWUpOP01GSU08K8/FmXL7HXcQiiRce9
        /yJuY5Nv61RWPRyb8D7Hms4=
X-Google-Smtp-Source: ABdhPJyMCAjfOn0Ms5M/HsrPJSz29j4yU5yP7XAMLvzU8aQuqCIq8oCyLBcMI7NWdByFa1ErZf/z5Q==
X-Received: by 2002:a05:6402:1704:b0:42a:c480:dcc8 with SMTP id y4-20020a056402170400b0042ac480dcc8mr4449704edu.59.1652954760216;
        Thu, 19 May 2022 03:06:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jy24-20020a170907763800b006f3ef214dfdsm1900975ejc.99.2022.05.19.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:05:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrd2c-0022s6-Fc;
        Thu, 19 May 2022 12:05:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 4/9] i18n CI: stop allowing non-ASCII source messages
 in po/git.pot
Date:   Thu, 19 May 2022 12:02:33 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-5-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-5-worldhello.net@gmail.com>
Message-ID: <220519.86h75l6dmh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> In the preceding commit we moved away from using xgettext(1) to both
> generate the po/git.pot, and to merge the incrementally generated
> po/git.pot+ file as we sourced translations from C, shell and Perl.
>
> Doing it this way, which dates back to my initial
> implementation[1][2][3] was conflating two things: With xgettext(1)
> the --from-code both controls what encoding is specified in the
> po/git.pot's header, and what encoding we allow in source messages.
>
> We don't ever want to allow non-ASCII in *source messages*, and doing
> so has hid e.g. a buggy message introduced in
> a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
> 2021-08-10) from us, we'd warn about it before, but only when running
> "make pot", but the operation would still succeed. Now we'll error out
> on it when running "make pot".
>
> Since the preceding Makefile changes made this easy: let's add a "make
> check-pot" target with the same prerequisites as the "po/git.pot"
> target, but without changing the file "po/git.pot". Running it as part
> of the "static-analysis" CI target will ensure that we catch any such
> issues in the future. E.g.:
>
>     $ make check-pot
>         XGETTEXT .build/pot/po/builtin/submodule--helper.c.po
>     xgettext: Non-ASCII string at builtin/submodule--helper.c:3381.
>               Please specify the source encoding through --from-code.
>     make: *** [.build/pot/po/builtin/submodule--helper.c.po] Error 1
>
> 1. cd5513a7168 (i18n: Makefile: "pot" target to extract messages
>    marked for translation, 2011-02-22)
> 2. adc3b2b2767 (Makefile: add xgettext target for *.sh files,
>    2011-05-14)
> 3. 5e9637c6297 (i18n: add infrastructure for translating Git with
>    gettext, 2011-11-18)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile                    | 6 ++++--
>  builtin/submodule--helper.c | 2 +-
>  ci/run-static-analysis.sh   | 2 ++
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c32ac4ca30..304cd03276 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2708,8 +2708,7 @@ XGETTEXT_FLAGS =3D \
>  	--add-comments=3DTRANSLATORS: \
>  	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
>  	--package-name=3DGit \
> -	--sort-by-file \
> -	--from-code=3DUTF-8
> +	--sort-by-file
>  XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
>  	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
>  XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell \
> @@ -2788,6 +2787,9 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_G=
EN_PO)
>  .PHONY: pot
>  pot: po/git.pot
>=20=20
> +.PHONY: check-pot
> +check-pot: $(LOCALIZED_ALL_GEN_PO)
> +
>  ifdef NO_GETTEXT
>  POFILES :=3D
>  MOFILES :=3D
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2c87ef9364..b97f02eed5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3378,7 +3378,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix)
>  			   N_("reference repository")),
>  		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from ref=
erence repositories")),
>  		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
> -			   N_("sets the submodule=E2=80=99s name to the given string "
> +			   N_("sets the submodule's name to the given string "
>  			      "instead of defaulting to its path")),
>  		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones"=
)),
>  		OPT_END()
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index 65bcebda41..0d51e5ce0e 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -29,4 +29,6 @@ fi
>  make hdr-check ||
>  exit 1
>=20=20
> +make check-pot
> +
>  save_good_tree

In my latest version of this (range-diff below, yours is the RHS) I had
this depend on the full po.git pot file, i.e. .build/pot/git.pot. You're
instead making it depend on only the intermediate files we msgcat from
it.

What I was going for was to detect that non-ASCII issue, which your
version will also do, but out of general paranoia I thought running it
thorugh the same toolchain and produce the end result made sense.

So if there's any issue that the msgcat that produces po.git would spot
we'll miss it here, but I don't know of any such problem.

So maybe there's nothing to worry about here, but it's probably worth
noting that we're confident that we won't have any trouble because of
not checking the end result po.git in the commit message...

1:  a7f8122d43f ! 1:  e2cfb1a2408 i18n CI: stop allowing non-ASCII source m=
essages in po/git.pot
    @@ Commit message
         on it when running "make pot".
=20=20=20=20=20
         Since the preceding Makefile changes made this easy: let's add a "=
make
    -    check-pot" target and run it as part of the "static-analysis" CI
    -    target, this will ensure that we catch any such issues in the futu=
re.
    +    check-pot" target with the same prerequisites as the "po/git.pot"
    +    target, but without changing the file "po/git.pot". Running it as =
part
    +    of the "static-analysis" CI target will ensure that we catch any s=
uch
    +    issues in the future. E.g.:
    +
    +        $ make check-pot
    +            XGETTEXT .build/pot/po/builtin/submodule--helper.c.po
    +        xgettext: Non-ASCII string at builtin/submodule--helper.c:3381.
    +                  Please specify the source encoding through --from-co=
de.
    +        make: *** [.build/pot/po/builtin/submodule--helper.c.po] Error=
 1
=20=20=20=20=20
         1. cd5513a7168 (i18n: Makefile: "pot" target to extract messages
            marked for translation, 2011-02-22)
    @@ Commit message
            gettext, 2011-11-18)
=20=20=20=20=20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
=20=20=20=20=20
      ## Makefile ##
    -@@ Makefile: pdf:
    - XGETTEXT_FLAGS =3D \
    - 	--force-po \
    +@@ Makefile: XGETTEXT_FLAGS =3D \
      	--add-comments=3DTRANSLATORS: \
    --	--from-code=3DUTF-8 \
    - 	--omit-header
    -=20
    + 	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
    + 	--package-name=3DGit \
    +-	--sort-by-file \
    +-	--from-code=3DUTF-8
    ++	--sort-by-file
      XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
    -@@ Makefile: po/git.pot: .build/pot/git.pot FORCE
    + 	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
    + XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell \
    +@@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      .PHONY: pot
      pot: po/git.pot
=20=20=20=20=20=20
     +.PHONY: check-pot
    -+check-pot: .build/pot/git.pot
    ++check-pot: $(LOCALIZED_ALL_GEN_PO)
     +
      ifdef NO_GETTEXT
      POFILES :=3D
