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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902FBC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57289610E8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhDHWIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:08:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80271C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:08:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u17so5548091ejk.2
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qg3vsjDaB1Ijg8BDANMv0E+V3dQpQ3QQT8ShZNgfb4U=;
        b=g++gLZpxMOQTN6dEWZ/bvfCG+dmrP6J9IFQQG6mIZ+sJSV7cUNBhdlKASyW5UZZ3Ng
         cVtkRMk4ZoFuYqUe6nwa8moBj20IMiWMwetQSM7tdAxD86JiePiUpmnEESE4ibARvLM8
         5mMrDy5rEYKCPnVYOwuM7KnG39I7cNDwTywmJWQQg2ibh6sdIYWvF2fbPUhRvnAxXJrS
         YEPr5m9u4ko6A5BrtW3n+RFPKUWTLnJatGdWquxNmbz/6TV0rmYYw9Nny5u6okQwHVoy
         ziy3dRGHygXVoMpRPCeDqiRFf/T0HO9rJ9xhWkMHZw3lAKgcssrMCJsz3CVFlz1oC9YD
         RS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qg3vsjDaB1Ijg8BDANMv0E+V3dQpQ3QQT8ShZNgfb4U=;
        b=M2UNjlSdiYQcvLbkhk6k16LsO5qaaFPSmevrXd10gxhNnw8Cb53E3A0a8TyfOVwsAn
         Gpqn+ICJywqBJ9CQYKpcozSJniRlWX+AprbUuL11tkx15Zbqe+8CCkxRhnXUoUu+H01r
         xg74299pls6efanJfsbJfe31lzHaRkh46DnA70OapUbcd3BNkUMgnFL8HLRM8OIbR6dn
         x9WC0gyWuxPAGQcdnpbZhkyK2RER0FGI78zDw3aCEVmuzGdYUoaWZ1IBOADCEttPMNmu
         vc+2v7i3hxPwVQxlnEsFj3nEvicPoYDt2gdWPYMEfiarhnr8Y3IykWCFtSjqjFchkN+V
         l2bA==
X-Gm-Message-State: AOAM5339bDZcNfs7ciU32eA633zsyry05kSVSrANAPQb7dz+KJ5HjGXs
        K2Y2B7pN8SGn67qdAmqJm9M=
X-Google-Smtp-Source: ABdhPJzuXCDeUDs9X01inyq3/dXRHXH9T3ahGwtqLzC5I1bLQOnvj7emyH88/Iwp/frql68/PSDDRQ==
X-Received: by 2002:a17:906:e5a:: with SMTP id q26mr5375804eji.263.1617919704041;
        Thu, 08 Apr 2021 15:08:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u13sm312061ejj.16.2021.04.08.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:08:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
References: <20200416211807.60811-2-emilyshaffer@google.com>
 <20210408212915.3060286-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210408212915.3060286-1-szeder.dev@gmail.com>
Date:   Fri, 09 Apr 2021 00:08:23 +0200
Message-ID: <87pmz4ig4o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, SZEDER G=C3=A1bor wrote:

> We auto-generate the list of supported configuration variables from
> 'Documentation/config/*.txt', and that list used to be created by the
> 'generate-cmdlist.sh' helper script and stored in the 'command-list.h'
> header.  Commit 709df95b78 (help: move list_config_help to
> builtin/help, 2020-04-16) extracted this into a dedicated
> 'generate-configlist.sh' script and 'config-list.h' header, and added
> a new target in the 'Makefile' as well, but while doing so it forgot
> to extract the dependencies of the latter.  Consequently, since then
> 'config-list.h' is not re-generated when 'Documentation/config/*.txt'
> is updated, while 'command-list.h' is re-generated unnecessarily:
>
>   $ touch Documentation/config/log.txt
>   $ make -j4
>       GEN command-list.h
>       CC help.o
>       AR libgit.a
>
> Fix this and list all config-related documentation files as
> dependencies of 'config-list.h' and remove them from the dependencies
> of 'command-list.h'.
>
>   $ touch Documentation/config/log.txt
>   $ make
>       GEN config-list.h
>       CC builtin/help.o
>       LINK git
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5a022367d4..2c41f125e0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2151,13 +2151,13 @@ $(BUILT_INS): git$X
>=20=20
>  config-list.h: generate-configlist.sh
>=20=20
> -config-list.h:
> +config-list.h: Documentation/*config.txt Documentation/config/*.txt
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
>  		>$@+ && mv $@+ $@
>=20=20
>  command-list.h: generate-cmdlist.sh command-list.txt
>=20=20
> -command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config=
.txt Documentation/config/*.txt
> +command-list.h: $(wildcard Documentation/git*.txt)
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>  		command-list.txt >$@+ && mv $@+ $@

This change makes sense.

I have a not-yet-submitted patch series where I added some more
config/*/*.txt that wouldn't be caught by this rule, I'd updated the
Documentation/Makefile, but missed this part in the top-level Makefile.

So a relation question: Does anyone actually prefer this state of
affairs of having a Makefile, Documentation/Makefile, t/Makefile
t/perf/Makefile and template/Makefile?

It seems to me with ever-closer coupling between them that it's getting
to be more of a hassle to manage state between them than it would be to
just move them all into one big Makefile.
