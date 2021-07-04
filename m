Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B39C07E96
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A7B61483
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGDIyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDIyM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 04:54:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE15C061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 01:51:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h2so19595074edt.3
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FTUC4TepmCBraNqjAfyjONfBkX2iZg+9r5a2FW2uDVs=;
        b=YpP3jrD5uCxjC/NGEccgNeA2pwUiC2jUVsf429Q77ZQ+vYMxnHqAxBqkDskmjzwHKo
         Hr26ma91b0K6Jdmc7DvBpFTCIRRdEP2t+9BIHAWo8SOVhiXDTcK/CSO5jRB/l4Erd/4l
         fTT6JFP+xtNMdc01FUgtEYgW8O1GGG8+5MC/+1Ei505Sh/At2/9SfalMDyrZalKDWnW2
         Nxy+8z0+zKT7k606iegC+1wavYYaqh+f9l1m7JKcNl5vj1ul5yRL1ZN8FAZSszPwjLgS
         Iv/Xxd2UpLSsZFyW7eJ5r3MLGVncl6/Air9lEm75D48u4YBEKId2ZFPm/i9SYg5mAgD2
         bgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FTUC4TepmCBraNqjAfyjONfBkX2iZg+9r5a2FW2uDVs=;
        b=pHILWjdPd7eFDpfXBAIeKQ79gLtdiyzGW0Q4HZQA9O22fehVYV4NqLqOhrkZzi7O7X
         Joi2wI/nFYU6NWUIMVe433e1lfek1w0VcQEe76zlWyPL3FCXs/VPD1wdkI3XlqcPfezz
         hY3yEhg30RmXOlHZJOv64lPv5aexbYdl0wDrgTDlnQCwgj3C70abD0W95rHpNeeIsxP2
         FsVm5BjpC0adiBJh9EiLzxHJIWKW2KsknDWdwoErn0IX+EFsfr8wIgUsAdhVvP+ZPvcD
         pnvTHpfLYJPhIMT+E7AVoIofH+Chp1q0qB/OhW/ZXD5jLg7N2MW8HaB7bpoX7xzskypF
         JxSA==
X-Gm-Message-State: AOAM532cbgEQr5NHZ8+Ic0FPpqJ5O7tvo6DL0Dqd4oVlIRODHa5w74Bp
        CX48f095T3UoeGMj3D1/ISI=
X-Google-Smtp-Source: ABdhPJxoEc17oHWt5k19PtdzZbyyRKSvCD6TX7MkqInV5cCAKEYWnW+EGy8gjpun0jLjChwG+BSTkg==
X-Received: by 2002:a05:6402:35cf:: with SMTP id z15mr9638888edc.208.1625388695684;
        Sun, 04 Jul 2021 01:51:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s21sm1531301edr.15.2021.07.04.01.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 01:51:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] artifacts-tar: respect NO_GETTEXT
Date:   Sun, 04 Jul 2021 10:30:27 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
 <c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.1625347592.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.1625347592.git.gitgitgadget@gmail.com>
Message-ID: <878s2m8ns9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We obviously do not want to bundle `.mo` files during `make
> artifacts-tar NO_GETTEXT`, but that was the case.

Should be:

    make artifacts-tar NO_GETTEXT=3DYesPlease

(Without the =3D<something> we try to find a "NO_GETTEXT" target)

> To fix that, go a step beyond just fixing the symptom, and simply
> define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
> set.

How about fixing the cause instead of the symptom...

> Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8f..04e852be015 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2675,10 +2675,13 @@ po/git.pot: $(GENERATED_H) FORCE
>  .PHONY: pot
>  pot: po/git.pot
>=20=20
> +ifdef NO_GETTEXT
> +POFILES :=3D
> +MOFILES :=3D
> +else
>  POFILES :=3D $(wildcard po/*.po)
>  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(P=
OFILES))
>=20=20
> -ifndef NO_GETTEXT
>  all:: $(MOFILES)
>  endif

...i.e. this patch just seems like odd (ab)use of Makefile logic.

Later on in the artifacts-tar rule we rely on our immediate dependency
list in $^ to feed to "tar czf", and here we're going to set $(MOFILES)
to an empty list, just to later interpolate that empty list into that
list of dependencies.

Wouldn't the mores straightforward thing to do be the diff I've got at
the end here, perhaps with a preceding commit just for the split-up of
the dependency list?

This matches how we do things elsewhere, i.e. we don't ifdef e.g. this away:

    LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl=
/Git/*/*/*.pm)
    LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))

rather we keep the list as-is, and ifdef the actual addition of the
dependency, e.g.:

    ifndef NO_PERL
    all:: $(LIB_PERL_GEN)
    [...]
    endif

One reason we do it like this is because we *don't* want to forget what
the MOFILES were, because you want e.g. "make clean" to clean them up
(not that it matters in this case, we rm -rf po/build).

Doesn't matter much here, but following this pattern leads to subtle
"bugs", e.g. an outstanding issue in your 179227d6e21 (Optionally skip
linking/copying the built-ins, 2020-09-21) (which I noted on-list in
passing before, IIRC) where during a build we end up with stale
built-ins from a previous build in the build directory, because we
pruned the list during definition time, as opposed to adding an inverse
"I should remove this then" rule.

("bug" because it doesn't have any actual effect I know of other than
bothering me that I have e.g. a git-add in my build-dir still :)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..7fb1d4b6caa 100644
--- a/Makefile
+++ b/Makefile
@@ -3146,9 +3146,18 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS +=3D $(shell echo *.dll t/helper/*.dll)
 endif
=20
-artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS)=
 \
-		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(MOFILES)
+ARTIFACTS_TAR =3D
+ARTIFACTS_TAR +=3D GIT-BUILD-OPTIONS
+ARTIFACTS_TAR +=3D $(ALL_COMMANDS_TO_INSTALL)
+ARTIFACTS_TAR +=3D $(SCRIPT_LIB)
+ARTIFACTS_TAR +=3D $(OTHER_PROGRAMS)=20
+ARTIFACTS_TAR +=3D $(TEST_PROGRAMS)
+ARTIFACTS_TAR +=3D $(test_bindir_programs)
+ifndef NO_GETTEXT
+ARTIFACTS_TAR +=3D $(MOFILES)
+endif
+
+artifacts-tar:: $(ARTIFACTS_TAR)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
