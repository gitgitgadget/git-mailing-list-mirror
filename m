Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C44C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 10:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC5660F42
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhIBKdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbhIBKdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 06:33:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068FC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 03:32:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1000026wmi.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TvbVgJ0rGNsNs3IsPZ0Xnj12D/5cqKu/IVMKww4iJRY=;
        b=J94D/Ssu6mPWQ06Wnc4Zy3vh1cflPUYdBlRyUeWwZ9ATicQSI/aDJlwyjWRvMPbnex
         gzMnfFF6sIvqApY5VOrMLgRPlH1u9D3wLEHE//IYhAGOhNyxZTNQ9UZFEQlX8RskNqJA
         ms9F48k49RN/AqWQr5csVD9cew4IJKx+s6zAgVTPI4evc+Bn3qMETkj/S8Vi3BE445EL
         N2IRCkNiqIDrlrZP5Qm4MSuxfPVxGtInpnLSBHt8FIQFz7zMiWKQw0rISifAhVjX/imj
         XYmkExl2PT4sngMw4JOOYS01IKvDRFLArYNBAE6m03xjLer6Uq5WooiLfdRcHIrnwxI7
         o9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TvbVgJ0rGNsNs3IsPZ0Xnj12D/5cqKu/IVMKww4iJRY=;
        b=gHMibE4FGUK/uz7DreAGb5LNeCLTNrZZY01NTK4nu6nqxANH8InFzulE8YUyGrSI3X
         IBg87Cjr3LGWRiJEt4ADo3Ask3uC+efsdMlXJ/pjnRy9l/EKhhfB4VQl+TcDTbRAK5tU
         n/9Bx7qIpTiK8N/w4m2CyFtCGFts98c3zstYmpwXMSohWV2xN4wX5/p4Vniad8KyBa/0
         nKhNh+bZWumNqWiokNl2Cwj9sq4cODz+4YoY5mKpNh9FUwJWDACfS1Abi/63LwWSmEZH
         gOw83QSxDxqYzfwZub1n1OJd1eoL8HSzMI7i88McUMoMdPUAFcB49I4SDCk0uy+O/I+o
         lL/g==
X-Gm-Message-State: AOAM530wn/YWtGci6fufnhMvWzah/z9aKVGQgkoy9roKYw+g8jiDCtR0
        bEdu0lLTbdk7tYnZMSUansI=
X-Google-Smtp-Source: ABdhPJz905H/9kxsBFIWaSFke1O4eSY7AJG/OdRd76H0NRNqssTaw8emkKfexM7npg/a8AENXQqnmA==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr2442819wmc.42.1630578732034;
        Thu, 02 Sep 2021 03:32:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23sm1263098wmc.24.2021.09.02.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:32:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] makefile: teach git about NO_MSGFMT (as supported in
 GUI and gitk)
Date:   Thu, 02 Sep 2021 12:27:56 +0200
References: <20210902085438.54121-1-carenas@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210902085438.54121-1-carenas@gmail.com>
Message-ID: <87ilzjuv2t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> NO_MSGFMT can be used to indicate there is no msgfmt available, so
> make git recognize that and avoid failing to build while trying to
> generate i18n files.

Why would we want to avoid failing the build if we don't have msgfmt?

I understand why you'd want NO_GETTEXT in that case, but what's the
point of building with NO_GETTEXT=3D NO_MSGFMT=3DY?

If we can't build the *.mo files we'll have a completely broken
installation that can't do anything useful with gettext, so why not just
build without gettext at that point?

When this patch is applied a lot of things related to gettext in our
tests fail if you build with NO_GETTEXT=3D NO_MSGFMT=3DY, because those
things are assuming that if NO_GETTEXT isn't defined we'll have the *.mo
files, po/build etc.

> while at it, refactor the change introduced in 4348824059
> (artifacts-tar: respect NO_GETTEXT, 2021-07-04) with something as
> functional but shorter.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9573190f1d..9f09a75801 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -86,6 +86,8 @@ all::
>  # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
>  # need -lintl when linking.
>  #
> +# Define NO_MSGFMT if you don't have msgfmt
> +#
>  # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
>  # doesn't support GNU extensions like --check and --statistics
>  #
> @@ -2691,10 +2693,8 @@ po/git.pot: $(GENERATED_H) FORCE
>  .PHONY: pot
>  pot: po/git.pot
>=20=20
> -ifdef NO_GETTEXT
> -POFILES :=3D
> -MOFILES :=3D
> -else
> +ifndef NO_MSGFMT
> +ifndef NO_GETTEXT
>  POFILES :=3D $(wildcard po/*.po)
>  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(P=
OFILES))
>=20=20
> @@ -2703,6 +2703,7 @@ endif
>=20=20
>  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
> +endif
>=20=20
>  LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/=
Git/*/*/*.pm)
>  LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))

