Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AAFC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15A06141C
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFYJHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2EC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:04:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bu12so14091005ejb.0
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lKAsZ9cKbcZrSiqD6ehfPsmhwfY9tu6uPeUfw3AVRck=;
        b=VQ9eSPlw+nKzot7hJY4sAb4rCxSB41F6YqSIcPWHdLlhK1Rb2zlRZ0KfxkRg/hdx1R
         nGlotc4QJV9uIRW5pv3e8kHzhKw5CM3CPKwbtQW0t1ZlFN2Dnelv1pdVF55elMkMeb/9
         VSYFIVKu8nwwa5dcu8vo7BHf0bh2+hujhYKMU35FI4iV3iOPRECOBysfxURL8S28RsjP
         Wf9w/WQuBWmiLCTDNpjiSrSvV53fLt7u+PTkNLW3hqtvWY3Tu3g1XPIA2/owuaQGH4Tn
         qRxUYS8zPta3GrULXVLU3uCcRBUd5H1EasFczANBnXcvgsI0jSHZN4laue+WykRReRgl
         go7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lKAsZ9cKbcZrSiqD6ehfPsmhwfY9tu6uPeUfw3AVRck=;
        b=hxeTETfWWie86DjMPlx11jhLEfID0CyIrzQWpsrICuX2rdpKPVKtJLgxeCp7P7375e
         jldT6j39sGbFl+gpA7DAgyeLM7+NzcJW5xCeBexfWGD8GrUtSc1cXva7GahUBgOJXBrK
         mwwkgVlW2outAv8W/jpw1dXu6i8x0BYecYpW3DIjj6VLLWxz4byAUMcCmHGMrTekbHyY
         uvTEHR5atV3CHAAbnnoorT15dN/DzUererpcbARBeqmvqqmftggOb8/UHCP3/4vRq9YZ
         8IDN0W5YC1KS4xlkrIgPHHsl4YcokOu+wr8YvD+oZ9BWyEMezYpzlIC2NbyVW5ldrvzI
         qdsg==
X-Gm-Message-State: AOAM530EsloWFyIRZBML5yFRhIKKuZ+5UdEEVvHX8bHvjSHbjq3mOOCd
        PaUJS49qPrxzZsBI9KL+fIU=
X-Google-Smtp-Source: ABdhPJze+hs3V7eCe0jC3TUrpRC8MnU3PfIh4/YN8VubkWASZDnXSfJTq5OXPW1sdyYhTDnfPrmHkw==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr10012996ejc.80.1624611889739;
        Fri, 25 Jun 2021 02:04:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ce26sm2378832ejc.4.2021.06.25.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:04:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Fri, 25 Jun 2021 11:01:18 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
 <fb23a23e-13be-14a8-4fbe-5ca2b4bcdb52@kdbg.org>
 <87r1gqxqxn.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <87r1gqxqxn.fsf@evledraar.gmail.com>
Message-ID: <87o8buxqkv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

Just one small thing I forgot to note:

> On Thu, Jun 24 2021, Johannes Sixt wrote:
>> I have two patches that speed up generate-cmdlist.sh a bit:
> [...]
> Interesting, but I think rather than micro-optimizing the O(n) loop it
> makes more sense to turn it into a series of O(1) in -j parallel,
> i.e. actually use the make dependency graph for this as I suggested in:
> https://lore.kernel.org/git/87wnqiyejg.fsf@evledraar.gmail.com/
> [...]
> diff --git a/.gitignore b/.gitignore
> index 311841f9bed..9b365395496 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -13,6 +13,7 @@
>  /GIT-USER-AGENT
>  /GIT-VERSION-FILE
>  /bin-wrappers/
> +/build/
>  /git
>  /git-add
>  /git-add--interactive
> diff --git a/Makefile b/Makefile
> index c3565fc0f8f..5e845bd0f69 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2231,12 +2231,30 @@ config-list.h: Documentation/*config.txt Document=
ation/config/*.txt
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
>  		>$@+ && mv $@+ $@
>=20=20
> -command-list.h: generate-cmdlist.sh command-list.txt
> +build/Documentation:
> +	$(QUIET_GEN)mkdir -p build/Documentation
> +.PRECIOUS: build/Documentation/git%.txt.cmdlist.in
> +build/Documentation/git%.txt.cmdlist.in: Documentation/git%.txt
> +	$(QUIET_GEN)if ! grep -w $(patsubst build/Documentation/%.txt.cmdlist.i=
n,%,$@) command-list.txt >$@; \
> +	then \
> +		# For e.g. git-init-db, which has a *.txt file, but no \
> +		# command-list.h entry \
> +		>$@; \
> +	fi
> +build/Documentation/git%.txt.cmdlist: build/Documentation/git%.txt.cmdli=
st.in
> +	$(QUIET_GEN)./generate-cmdlist.sh --tail $< >$@
>=20=20
> -command-list.h: $(wildcard Documentation/git*.txt)
> -	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
> +COMMAND_LIST_H_FILES =3D $(filter-out Documentation/git.txt,$(wildcard D=
ocumentation/git*.txt))
> +
> +COMMAND_LIST_GEN =3D $(patsubst Documentation/%.txt,build/Documentation/=
%.txt.cmdlist,$(COMMAND_LIST_H_FILES))
> +command-list.h: build/Documentation generate-cmdlist.sh command-list.txt=
 $(COMMAND_LIST_GEN)
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh --header \
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \

I left this --exclude-program code (added in 724d63569fe (help -a: do
not list commands that are excluded from the build, 2019-04-18)) in just
because I couldn't be bothered to rewrite it for this demo. But of
course that's also something that becomes much easier once we do this in
a Makefile-native way, we'd just $(filter) that list out ourselves, so
no need to have some shellscript deal with it.

That's also true on "master" right now, 724d63569fe doesn't discuss why
it went for the shellscript approach. I suspect it's just that the
author thought it was easier than dealing with some combination of
$(filter) and (a possibly nested) $(pathsubst).

> -		command-list.txt >$@+ && mv $@+ $@
> +		command-list.txt >$@+ && \
> +	echo "static struct cmdname_help command_list[] =3D {" >>$@+ && \
> +	cat build/Documentation/*.txt.cmdlist >>$@+ && \
> +	echo "};" >>$@+ && \
> +	mv $@+ $@
