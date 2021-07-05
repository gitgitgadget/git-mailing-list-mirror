Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC5C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3066B613B6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGEGpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEGpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 02:45:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACBC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 23:42:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so22377334edc.7
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=P5gieoiQ7q5UV2i6iIEFrY8VvwdLVNs5wzoOB6V4k0g=;
        b=SI/nusoz1P2lFpz5D00N9hLBj8fa/cIB1/Uyb199MvP9Dcuw7kqDmXjf3gJMcSkZR0
         wy2vS1tXKDWqIVAkA0AoUIBFcnS+71rU6ODrU5CI5pmIlRiVvJgtge2HxeeOXJPn3cHF
         H+mT7W4ZNMsT8xVyepk6T5G6VAx7z8pf9W/XHcvzK1qtEaV1s7EG4L9VVoLBNhJwhQTD
         MpMPW4p/TcdUKEwu7hAh8xDcyexL2m6SFpLs17FPmwc2UoKvSzoesN8L3WEJCr6PdN/h
         kahDhoRd7jLOMKPoezIIrftRBJv90dXmnvlfoc3E2yFjhhbnkBVrEnERxqey4noNoQYp
         mF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=P5gieoiQ7q5UV2i6iIEFrY8VvwdLVNs5wzoOB6V4k0g=;
        b=ngUqwbDunXA0n2Tic20lxSvkmX9ssJJ531usLKG3WfvHkE/n1G0PUGAHAjx3dxMxCb
         QyEp/0cjSP/jFRNMVzDoTuVee9XSDH6vuHz1t1dowdnhMUlTFpvJpYp1T6D0Ruyv+qLI
         6CbL8Sx4C7eTsp79Y1F9NpNGNzRRz/OZaPXZQbxOTs1//+hvEqR5nemPxV1Qjzn4fNwT
         MBiG6zyMbt+Dc1CK5ERlIVCMkf6EJj/wYHul/x0rZoXNVxP+uRt1Bjbc8unsDRKlU1DY
         esoYZrwaYiBJPWTgUNHRZDlHdpHmS5enGe67ax5Qqj+pwkebUjag199982KIvW7s67PK
         XSOw==
X-Gm-Message-State: AOAM5329fT+o9YhPUApCLum9L0APQO16rnruMAxq8z1PFhoZb8z8Ju0g
        WNxBuYifXO4lmmzp8vtCCcA=
X-Google-Smtp-Source: ABdhPJzja4AOhEO8WiON2zz6Z/brot83NGCEvJQDpUuQ5mkmQRmhiwgSBz0J7Is6+X1hHZsBYiPr5g==
X-Received: by 2002:aa7:c799:: with SMTP id n25mr14063895eds.16.1625467341540;
        Sun, 04 Jul 2021 23:42:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v3sm2388678ejg.20.2021.07.04.23.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 23:42:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] artifacts-tar: respect NO_GETTEXT
Date:   Mon, 05 Jul 2021 08:33:11 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
 <c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.1625347592.git.gitgitgadget@gmail.com>
 <878s2m8ns9.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107050038520.8230@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107050038520.8230@tvgsbejvaqbjf.bet>
Message-ID: <87r1gd6z3o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Sat, Jul 03 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > We obviously do not want to bundle `.mo` files during `make
>> > artifacts-tar NO_GETTEXT`, but that was the case.
>>
>> Should be:
>>
>>     make artifacts-tar NO_GETTEXT=3DYesPlease
>>
>> (Without the =3D<something> we try to find a "NO_GETTEXT" target)
>
> Correct. Will fix.
>
>> > To fix that, go a step beyond just fixing the symptom, and simply
>> > define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
>> > set.
>>
>> How about fixing the cause instead of the symptom...
>
> Yes, from my point of view, I did that.
>
>> > Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  Makefile | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index c3565fc0f8f..04e852be015 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -2675,10 +2675,13 @@ po/git.pot: $(GENERATED_H) FORCE
>> >  .PHONY: pot
>> >  pot: po/git.pot
>> >
>> > +ifdef NO_GETTEXT
>> > +POFILES :=3D
>> > +MOFILES :=3D
>> > +else
>> >  POFILES :=3D $(wildcard po/*.po)
>> >  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,=
$(POFILES))
>> >
>> > -ifndef NO_GETTEXT
>> >  all:: $(MOFILES)
>> >  endif
>>
>> ...i.e. this patch just seems like odd (ab)use of Makefile logic.
>>
>> Later on in the artifacts-tar rule we rely on our immediate dependency
>> list in $^ to feed to "tar czf", and here we're going to set $(MOFILES)
>> to an empty list, just to later interpolate that empty list into that
>> list of dependencies.
>>
>> Wouldn't the mores straightforward thing to do be the diff I've got at
>> the end here, perhaps with a preceding commit just for the split-up of
>> the dependency list?
>>
>> This matches how we do things elsewhere, i.e. we don't ifdef e.g. this a=
way:
>>
>>     LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm p=
erl/Git/*/*/*.pm)
>>     LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PER=
L))
>>
>> rather we keep the list as-is, and ifdef the actual addition of the
>> dependency, e.g.:
>>
>>     ifndef NO_PERL
>>     all:: $(LIB_PERL_GEN)
>>     [...]
>>     endif
>>
>> One reason we do it like this is because we *don't* want to forget what
>> the MOFILES were, because you want e.g. "make clean" to clean them up
>> (not that it matters in this case, we rm -rf po/build).
>
> We don't need to be careful about cleaning files we did not generate in
> the first place.
>
> Your suggestion amounts to unnecessary work. If we asked for NO_GETTEXT,
> why bother generating the list of `.po` files at all? (Rhetorical
> question; The answer is "we don't need to".)

I'm not saying that you in the Windows CI job generated them, but that
in general we want to support doing these in sequence:

    make NO_GETTEXT=3DY <target>
    make NO_GETTEXT=3D <target>

...

>> Doesn't matter much here, but following this pattern leads to subtle
>> "bugs", e.g. an outstanding issue in your 179227d6e21 (Optionally skip
>> linking/copying the built-ins, 2020-09-21) (which I noted on-list in
>> passing before, IIRC) where during a build we end up with stale
>> built-ins from a previous build in the build directory, because we
>> pruned the list during definition time, as opposed to adding an inverse
>> "I should remove this then" rule.
>>
>> ("bug" because it doesn't have any actual effect I know of other than
>> bothering me that I have e.g. a git-add in my build-dir still :)
>>
>> diff --git a/Makefile b/Makefile
>> index c3565fc0f8f..7fb1d4b6caa 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -3146,9 +3146,18 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
>>  OTHER_PROGRAMS +=3D $(shell echo *.dll t/helper/*.dll)
>>  endif
>>
>> -artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRA=
MS) \
>> -		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
>> -		$(MOFILES)
>> +ARTIFACTS_TAR =3D
>> +ARTIFACTS_TAR +=3D GIT-BUILD-OPTIONS
>> +ARTIFACTS_TAR +=3D $(ALL_COMMANDS_TO_INSTALL)
>> +ARTIFACTS_TAR +=3D $(SCRIPT_LIB)
>> +ARTIFACTS_TAR +=3D $(OTHER_PROGRAMS)
>> +ARTIFACTS_TAR +=3D $(TEST_PROGRAMS)
>> +ARTIFACTS_TAR +=3D $(test_bindir_programs)
>> +ifndef NO_GETTEXT
>> +ARTIFACTS_TAR +=3D $(MOFILES)
>> +endif
>> +
>> +artifacts-tar:: $(ARTIFACTS_TAR)
>
> Apart from going out of its way to retain the construction of the `.po`
> file list (which is totally pointless when operating under `NO_GETTEXT`),


..and that yes, generally speaking there *is* a point in doing
that. E.g. we have another discussion now on-list about incorrectly
spelled/copied config variables in po/*.po files.

It would be a natural thing to want to have some "lint" or "check"
target for that which used $(POFILES) as a source, and you'd not want
that:

    make check-pofiles

To do nothing under NO_GETTEXT=3DY, but still use other Makefile
dependencies, e.g. use config-list.h as a source of truth.

To be clear I don't think anything's breaking now with your patch, I
just find the pattern of conflating the declaration of files in the
Makefile with the current logic of the rules that happen to need them
right now to be an anti-pattern.

> this is also a sore to my eyes. So I won't do that.

I agree that converting it is an eyesore, that's quite verbose, but it
makes any later patch much easier to read. You'll just need to add
line(s), not modify that big dependency list in-place.

> Thank you for trying to assist in improving this patch series,
> Dscho

>>  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
>>  		SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
>>  	test -n "$(ARTIFACTS_DIRECTORY)"
>>
>>

