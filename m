Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA6C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiFWPr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWPr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:47:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697832BF8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:47:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so22604481ejb.6
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oWm8cMPJCWbiUEZFpZh4Sdr4ZFZZES0ciFM4LaBgeCE=;
        b=N1tbp9/aW8PmZeZqQ+4HijS+DU1k09EdwqrO/2lCV44w64tL0YtJmR6EplAI/my+Oy
         SoCC80hXnIwRepS3aSpiksn+w7FEEygR24ynOIyqBptjiq76e/jLEMNHUTWumtngOZrP
         uQSKEUilhMWVJIZa5xqcgorrofT8PJLZp2zyDmrJVCozpJlApxtayFCX1O3z2Vg+c/1C
         DpM28ylJaAXzMrdIiSu9dG2SCl8NcnDOAaw80QSajtQ+KlDaWbzBQyUQTkoXNDkYyfyH
         MPa+iNdYdg4jTuFg1QPFEiwaApNVrKklSF6hOq4JXJ9x4I1jShXwUrnjBVouCz1xRYlG
         0osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oWm8cMPJCWbiUEZFpZh4Sdr4ZFZZES0ciFM4LaBgeCE=;
        b=8AwPO6QNjk4yhGc3CEVYPPsnlcQalli7+Vst/SkldykeltRikmasmvyqTEJC9IChuc
         L2KSKvHgW2roCZ3aGRH4ALgRZn7KJLP8Giv4WLuqMBc1crvXYhJV/mgEcd7rKYcSQeQK
         UetYX5FvoSJneoF77uoNLg1U5rMKJTJkXM8Zv9Fk0S6yWNAXi+QH+YV12CMmDscPZCal
         4YBk8o5haH/fOOKW3/kdc0wOrmtI2yg5nm+jDx/A3eddTbkprEa5JbEVsYmnCRyw6aFT
         Ig1S/78nQbn+2UOzvPJOQj+PbrUZrnJmU/1YJaeVgh/Ou+h2odypfEqqwHsSMw/4ll/9
         03xg==
X-Gm-Message-State: AJIora8iYzrrV8zcimwpR45BwFawsiO7xqdI/LmD2ozKxqEkKTV9B1mQ
        0lmZxTZzyw9Rg+pZp+j7ddEFBR51ytSBCA==
X-Google-Smtp-Source: AGRyM1v2AIKeb53QgLdhEvQ7ONgkH59JICBavrrj1hZopUPQS/MVI1fP51HbBWtyDtAoHOGxnV6uaw==
X-Received: by 2002:a17:907:72d2:b0:722:f9c8:c3fa with SMTP id du18-20020a17090772d200b00722f9c8c3famr6479200ejc.608.1655999272363;
        Thu, 23 Jun 2022 08:47:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906318a00b00711aed17047sm10962765ejy.28.2022.06.23.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:47:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4P3f-0011pT-58;
        Thu, 23 Jun 2022 17:47:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/1] scalar: move to the top-level, test, CI and
 "install" support
Date:   Thu, 23 Jun 2022 17:30:00 +0200
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
 <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
 <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
Message-ID: <220623.86k097js9k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Derrick Stolee wrote:

> On 6/23/2022 6:26 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This one-patch series integrates the "scalar" command to the
>> top-level, meaning we build the "scalar" binary by default, and run
>> its tests on "make test" and in CI. We'll also build and test its
>> documentation. We now also have "install" support, both for the
>> program and its docs, but you'll need to:
>>=20
>>     make <install-target> INSTALL_SCALAR=3DY
>>=20
>> I'm sending this out now to avoid needless duplicate work.
>
> As mentioned on the list earlier, Victoria is taking over the
> remaining work to complete the Scalar project. Nothing has been
> sent to the list because we didn't want to cause a distraction
> from the release window.

I was on the fence about sending this out, but given that the "CI"
thread was going on until the start of that window, and wanting to save
her the work of re-discovering the subtle issues with the integration
I'd already fixed I thought it was better ot send it out.

> Victoria is taking time to incorporate your previous thoughts on
> how Scalar is built and its location in the codebase and create
> a complete narrative of how to get from our current state to that
> point.

I wasn't sure she was even aware of it, and given that the WIP patch I
saw in my "git fetch" was pretty much a subset of the upthread v1 it
seemed that there was needless duplicate work going on.

It seemed clear that that WIP patch was attempting to head in the same
direction, but hadn't yet discovered some of the hurdles with
e.g. documentation building & installation that I'd fixed
already. There's also the CMake integration, which I finished up for
this v2.

> To that point, this thread is the duplicate work you're trying
> to avoid. Please instead wait for Victoria to present her plan in
> July instead of moving forward with this topic.

By "duplicate work" I mean that back in October of last year I sent a
patch that was a more complete version of some WIP code I spotted
written in the past few days.

But you're probably talking about duplication in the sense of some
larger integration of scalar changes into git.git?  Or at least that's
the only way I can make sense of the seemingly reversed chronology.

I'm all too happy to leave that to someone else that's more interested,
perhaps this will save them some time.

Although (sans release window etc.) I think this change is in a state
that's ready for pickup, and it seems that here's a consensus on this
direction from everyone involved.

Although perhaps there's some minor disagreement about details, such as
whether we should have an "optionalcontrib" documentation section etc.

I do think the current state on "master" is slightly confusing, one
oddity I spotted is that we've already asked translators to translate
contrib/scalar/scalar.c, but we never install it, and it's "in
contrib".

It seems that part was unintentional in 0a43fb22026 (scalar: create a
rudimentary executable, 2021-12-03), and later formalized in 9f555783c0b
(Makefile: generate "po/git.pot" from stable LOCALIZED_C,
2022-05-26). Maybe it's all water under the bridge at this point,
i.e. we'd rather keep it than throw away now-existing translations...

FWIW I have this local change queued on top of this v2, it's all
cosmetic, but probably a good idea.

The $(SCALAR_SOURCES) bit is something I missed, but which Victoria
didn't in her WIP patch (I stole it from there). That part had been
added since October, so I managed to miss it when rebasing, it's the
part that's been adding contrib/scalar/scalar.c to po/git.pot (see
9f555783c0b).

1:  9743e2a1e6a ! 1:  11404988785 scalar: reorganize from contrib/, still k=
eep it "a contrib command"
    @@ Commit message
=20=20=20=20=20
      ## .gitignore ##
     @@
    + /config.mak.append
      /configure
      /.vscode/
    - /tags
     +/scalar
    + /tags
      /TAGS
      /cscope*
    - /compile_commands.json
=20=20=20=20=20
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: MAN1_TXT +=3D $(filter-out \
    @@ Makefile: ifndef NO_CURL
      endif
=20=20=20=20=20=20
     -SCALAR_SOURCES :=3D contrib/scalar/scalar.c
    -+SCALAR_SOURCES :=3D scalar.c
    - SCALAR_OBJECTS :=3D $(SCALAR_SOURCES:c=3Do)
    +-SCALAR_OBJECTS :=3D $(SCALAR_SOURCES:c=3Do)
    ++SCALAR_OBJECTS :=3D scalar.o
      OBJECTS +=3D $(SCALAR_OBJECTS)
=20=20=20=20=20=20
    + .PHONY: objects
     @@ Makefile: $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.=
o GIT-LDFLAGS $(GITLIBS
      	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$=
^) \
      		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
    @@ Makefile: $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o=
 GIT-LDFLAGS
      	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
      		$(filter %.o,$^) $(LIBS)
=20=20=20=20=20=20
    +@@ Makefile: XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShel=
l \
    + XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
    + 	--keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
    + MSGMERGE_FLAGS =3D --add-location --backup=3Doff --update
    +-LOCALIZED_C =3D $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR=
_SOURCES) \
    +-	        $(GENERATED_H))
    ++LOCALIZED_C =3D $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(GENERA=
TED_H))
    + LOCALIZED_SH =3D $(sort $(SCRIPT_SH) git-sh-setup.sh)
    + LOCALIZED_PERL =3D $(sort $(SCRIPT_PERL))
    +=20
     @@ Makefile: GIT-PYTHON-VARS: FORCE
                  fi
      endif

