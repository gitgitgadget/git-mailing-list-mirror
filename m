Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E73C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiESK2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiESK15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:27:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EEAEE1E
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:27:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ch13so8976471ejb.12
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Zk9QPqkzlAfXYyAeyDKseMcII4VaDZot3Tt1afx3wuo=;
        b=OO8Tl9xcEUvMfJuRfnL+KWAc7CaZLeJtwXTHzR4DH6VpeABcXm9u+yVL+nPzCixytH
         ukJtHjLroz/oyotbRR+GzjfqUwHotkavESLw6Wn1KMiv7iW7riTA+bZJMqMwaFJ3kKIu
         mJ+byO55e7x+7tbw0ipthXCx52RPwmHsEnNZ3Tuakf7AQzziimyZDHcXCaPX9rX55Jxy
         W+gfmps3VDVyYPoLn14beTsDvOfkBO606qbukdbHMNj+hOMUUcQIbvB7dR6uCTziGenN
         5IFBwKmoBjp/1HNhvj9wHUwY0u/OsepPmu4M0HBU0qz1g2U6o355AGgmOzQqzsq8SYjE
         kBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Zk9QPqkzlAfXYyAeyDKseMcII4VaDZot3Tt1afx3wuo=;
        b=Qc/8oXuUwc8j5yfw8rVL6oVmzlBhmUGxZ0zM8FA/5rq3p05TEeTA6F4bioHZOuNMkb
         ZWQYO/IpoJUhkQVTjH3tZUpy79hyqmNL4uyDqdXW6lY4cf6KkBfCVGzZ9wxdAiYV0u42
         JV1ZIEYlFyo9Bv3PBW8Uxd1N1uq4ho5g8QTfdAoTZw46cbaGaij3EjsMk7Rur9gFrhRc
         be/OIiiqLV9vymDW23JJDqw6Fh2g0LDuEPDomXjODBHLIOty9+3n95GRoc47jZFv45Q2
         pKf125H9r/wx3squZOJWa8fBGEqYYSUQIpeSWyJkWvMRwQ7c1/4uSDqAD85yu236tL01
         /60Q==
X-Gm-Message-State: AOAM531gXGFRcwj2WimHwQb3cRmZpvpFBoo3FRi2fCDX/oXWjx8UajQa
        MKubc3RjKLlqRpbkTWqO3Ww=
X-Google-Smtp-Source: ABdhPJxq58p+IfYnAvNcDm3sKVdnZA6EPFGsU0hyaQ4VRtR4K8m0jhcLoHaNzIS5m1n5/jRqd7T5IQ==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr3546663ejc.66.1652956067055;
        Thu, 19 May 2022 03:27:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c25-20020aa7d619000000b0042a5a39ba7esm2637015edr.25.2022.05.19.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:27:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrdNg-0023Zd-QN;
        Thu, 19 May 2022 12:27:44 +0200
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
Subject: Re: [PATCH v2 8/9] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Thu, 19 May 2022 12:22:17 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-9-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-9-worldhello.net@gmail.com>
Message-ID: <220519.868rqx6cm7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> The core translation is the minimum set of work that must be done for a
> new language translation.
>
> There are over 5000 messages in the template message file "po/git.pot"
> that need to be translated. It is not a piece of cake for such a huge
> workload. So we used to define a small set of messages called "core
> translation" that a new l10n contributor must complete before sending
> pull request to the l10n coordinator.
>
> By pulling in some parts of the git-po-helper[^1] logic, we add rule
> "core-pot" to create this core translation message "po/git-core.pot":
>
>     make core-pot
>
> To help new l10n contributors to initialized their "po/XX.pot" from
> "po/git-core.pot", we also add new rules "po-init":
>
>     make po-init POT_FILE=3Dpo/XX.po

This is a typo, you mean PO_FILE, not POT_FILE.

>  Makefile      | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  po/.gitignore |  1 +
>  shared.mak    |  1 +
>  3 files changed, 46 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index edebd44d5c..0a687a6eb2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2801,6 +2801,7 @@ po-update: po/git.pot
>  	$(check_po_file_envvar)
>  	@if test ! -e $(PO_FILE); then \
>  		echo >&2 "error: $(PO_FILE) does not exist"; \
> +		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=3Dp=
o/XX.po"'; \

Correct here.

>  		exit 1; \
>  	fi
>  	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
> @@ -2808,6 +2809,49 @@ po-update: po/git.pot
>  .PHONY: check-pot
>  check-pot: $(LOCALIZED_ALL_GEN_PO)
>=20=20
> +### TODO FIXME: Translating everything in these files is a bad
> +### heuristic for "core", as we'll translate obscure error() messages
> +### along with commonly seen i18n messages. A better heuristic would
> +### be to e.g. use spatch to first remove error/die/warning
> +### etc. messages.
> +LOCALIZED_C_CORE =3D
> +LOCALIZED_C_CORE +=3D builtin/checkout.c
> +LOCALIZED_C_CORE +=3D builtin/clone.c
> +LOCALIZED_C_CORE +=3D builtin/index-pack.c
> +LOCALIZED_C_CORE +=3D builtin/push.c
> +LOCALIZED_C_CORE +=3D builtin/reset.c
> +LOCALIZED_C_CORE +=3D remote.c
> +LOCALIZED_C_CORE +=3D wt-status.c
> +
> +LOCALIZED_C_CORE_GEN_PO =3D $(LOCALIZED_C_CORE:%=3D.build/pot/po/%.po)
> +
> +.PHONY: core-pot
> +core-pot: po/git-core.pot
> +
> +.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
> +		-o - /dev/null | \
> +	sed -e 's|charset=3DCHARSET|charset=3DUTF-8|g' >$@ && \
> +	echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$@
> +

This looks OK to me, FWIW in the version I have on my branch I tried to
munge some of this a bit more. So the diff between my (-)/yours (+) is:
=09
	--- po/fo.po    2022-05-19 12:23:02.548459230 +0200
	+++ po/fo.po.jx 2022-05-19 12:22:50.608563768 +0200
	@@ -1,19454 +1,1224 @@
	+# Faroese translations for Git package.
	+# Copyright (C) 2022 THE Git'S COPYRIGHT HOLDER
	 # This file is distributed under the same license as the Git package.
	+# Automatically generated, 2022.
	+#
	 msgid ""
	 msgstr ""
	 "Project-Id-Version: Git\n"
	-"Last-Translator: make by the Makefile\n"
	-"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
	+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
	+"POT-Creation-Date: 2022-05-19 12:22+0200\n"
	+"PO-Revision-Date: 2022-05-19 12:22+0200\n"
	+"Last-Translator: Automatically generated\n"
	+"Language-Team: none\n"
	 "Language: fo\n"
	 "MIME-Version: 1.0\n"
	 "Content-Type: text/plain; charset=3DUTF-8\n"
	 "Content-Transfer-Encoding: 8bit\n"
	 "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
	-"PO-Revision-Date: 2022-04-11 11:05+0200\n"

So yours has the "Faroese translations for Git package" (good), but I
also omitted/corrected some of the headers. See 72ed0c8b2e6 (i18n:
migrate to line-number-less i18n workflow, 2022-04-03) in my fork.

This version is also fine, but just in case you wanted to steal
something from it...
