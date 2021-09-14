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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED42C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73C960724
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhINKtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhINKtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:49:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686CC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:48:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ho42so27844531ejc.9
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ulvO2thvyPP83VIZ5xucSyi6dOUG6+SuyMhSDM3ZImM=;
        b=ZZvvOSyum5qCkjOfKhzpJbFtJlpRLQcMCf2wc+b12uPkOqaU3HPV4JibV1Sx7PXTKU
         we0ZqOiYDb5fX9dLJt2WVk0ISTiVpfuV1HLGJWuapqA/kkPMannvQ7SfEGB8ewREql8t
         L9/tvTzskEZvaIfs1o0brK+7jciBaqcQdDkAtHoYqrD9+GcBj+ol05YL3yQjcfyE+tNI
         pz84J3i841o2nBYutXrpcDVg5bk0plrUeXUg6xb9U1Oet0Y97IHPmhMVVZvYc/HG89Cm
         lcB+fi6CGEdPdvTkyaq3XTcM4PNOZhdZvhmrO/3yZmi6T2mx4B5hJI++n23m+Ek5kmMG
         /4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ulvO2thvyPP83VIZ5xucSyi6dOUG6+SuyMhSDM3ZImM=;
        b=oeUmeoB0OtRCzRFX7jrTT4d6oD5mMVYritW2VU4qaLuixqUkKDkyTxKAuhGKwOSMkI
         OTLzgDt+xCdFFdPta0EO/pe6qY2Y4nGiziRiCuwoo+kasQ7NsCk8bj7CEwFWSzs2w0j+
         U3m814gF4+fQ2076UmkMlyY25VWx99OrQnYB1sI+txfOx45aM/lVSkOTlBi7GjhkePAP
         8bwdeIxmAJBRlICufuLoxbEk+07pGrhKe7jfVTAsgn/uaqruDsKFFzAlENIRdAs7sB/z
         wDvmtH3IkPNSNWFFIFNIOI35DJYSpzrnnudyGq3X99oU9Tw/DI4PTyrqbWaEsZLkWzfD
         vVFw==
X-Gm-Message-State: AOAM5311WC6/rANEu596rUY4emUX7RbnavJixmLozvDF9DCgUr+Kc46t
        FEqpqVM6bqRBUKXuEoHqeW8IpR/Tmty/tw==
X-Google-Smtp-Source: ABdhPJx3Dgxxr494WQNDUZFiS2MMeayQOTH7VbX2rjSvY8uTM/DRd7H7MgaO0PnDZL73/5QZRp/xpA==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr18467032eju.118.1631616513843;
        Tue, 14 Sep 2021 03:48:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14sm4764550ejf.24.2021.09.14.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:48:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/15] scalar: create a rudimentary executable
Date:   Tue, 14 Sep 2021 12:47:04 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <b8c7d3f84508ae0fb300f47c726764f4cbf46be9.1630691688.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b8c7d3f84508ae0fb300f47c726764f4cbf46be9.1630691688.git.gitgitgadget@gmail.com>
Message-ID: <87r1dro2kf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/Makefile b/Makefile
> index c3565fc0f8f..2d5c822f7a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2447,6 +2447,10 @@ endif
>  .PHONY: objects
>  objects: $(OBJECTS)
>=20=20
> +SCALAR_SOURCES :=3D contrib/scalar/scalar.c
> +SCALAR_OBJECTS :=3D $(SCALAR_SOURCES:c=3Do)
> +OBJECTS +=3D $(SCALAR_OBJECTS)
> +
>  dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>  dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
>=20=20

Aside from anything else we may disagree with about the build system
integration, this breaks the "objects" target. You're adding things to
it, but it won't be reflected by those changes.

I have this fixup for it on top locally, the reference to 852ec00310 is
to a commit in your repo:

-- >8 --
Makefile: fix scalar "make objects" regression

In 852ec00310 (scalar: create a rudimentary executable, 2021-04-10)
the contrib/scalar/scalar.o file was added to OBJECTS, but was added
below the "objects" target.

That target was added in 029bac01a8 (Makefile: add
{program,xdiff,test,git,fuzz}-objs & objects targets, 2021-02-23)
along with others (git-objs, test-objs) to serve as ad-hoc targets for
e.g. compiling during interactive the targets need to come after we
fully declare the variable.

Before this change we'd still do /some/ scalar things on "make
objects", namely create the contrib/scalar/.depend/ directory (see
dep_dirs in the context), we just wouldn't create the object itself.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6e14f626e3..6ace4be141 100644
--- a/Makefile
+++ b/Makefile
@@ -2464,12 +2464,11 @@ OBJECTS +=3D $(FUZZ_OBJS)
 ifndef NO_CURL
 	OBJECTS +=3D http.o http-walker.o remote-curl.o
 endif
-.PHONY: objects
-objects: $(OBJECTS)
-
 SCALAR_SOURCES :=3D contrib/scalar/scalar.c
 SCALAR_OBJECTS :=3D $(SCALAR_SOURCES:c=3Do)
 OBJECTS +=3D $(SCALAR_OBJECTS)
+.PHONY: objects
+objects: $(OBJECTS)
=20
 dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
--=20
2.33.0.1013.ge8323766266

