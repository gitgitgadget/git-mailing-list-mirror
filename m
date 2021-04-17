Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3FC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCE66101E
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhDQVqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhDQVqM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 17:46:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DFEC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 14:45:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o20so10046183edc.7
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ylVZnEVyp4l2DCdzEMYNHXSoFLVzL3GqtpPLwzBuI6w=;
        b=XochrcluaVPHIKM72MZWzVFeBzUSy+hPnIBF5lSh0q4a/PjoavZxZwGXyPIsnav5Is
         Zv6F+QjNex1zF+koxr++o8J3Jse5AiGElvVR+rdsureZ1sZphTJepgi3vWMO6zFADPHa
         8P44udZUGkIf59OIcQV64lMuGd+Wx2n28ARTA3+y+Dgq7ssVP59BpdtdtFMkRadl/wyz
         qbw8Mx5VX0n+R5/Vl0rHDAmLanic9ziERHD+Mk84n5lWjeW0p3dNx2/Q8Wk0xrqXkBcz
         fi3fSaj40ocoWWEHHPlcTQ9XnU3jqMO7hiwQtnIzB75k0wnQyMhPkoKtDIhXg4/wLB7I
         8Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ylVZnEVyp4l2DCdzEMYNHXSoFLVzL3GqtpPLwzBuI6w=;
        b=b88Weepbtr3J0HEAxqpwyoPPq5DMIG6rjR6B1Gr2Dutlu8F3txIiJaKBRI4bEiy5P9
         cAuOoZaTyVkRdNpZIczpk1/h5L5k8MzA/KN8RzfDDQwlOGLc/Rjf/htO7PS1yAbauXSB
         TyB4mqwF+oK1RAIOcC8lyesC9NFbUx/rpnTXu76cujSJotO/LHduChlhXnCScnp1PqwU
         TQQQXsbg4o91yAYnR4abktokW+RdPyS3sM2EBzK7HdkSVwMZfgMSR3fcgylig6YYNIbV
         5eYQUuta4kVc+28reVH3V4/i2RUi3pU2CM6lT7GjeTAEuTRjsu0T76Fs30Wy/y1y5jpo
         UqrA==
X-Gm-Message-State: AOAM532NOM0GV7nav7iOyhHCuCc+YfRli9YgZ+GZCkStiAJmUW175QMk
        Oh7tU1BLcMgY/MjDteiJNSGlO64yAopdRA==
X-Google-Smtp-Source: ABdhPJx3qn6XdWJZwHrxUzM4sTS4Z+UedPrmVmmCAxFTRzn0Qhk5XoeU06LOKnnBy/HitB2y9pm7ow==
X-Received: by 2002:a05:6402:6da:: with SMTP id n26mr5017125edy.203.1618695942656;
        Sat, 17 Apr 2021 14:45:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s11sm9134740edt.27.2021.04.17.14.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 14:45:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 12/12] test-lib: split up and deprecate
 test_create_repo()
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <patch-12.12-a3e20ef18f7-20210417T124424Z-avarab@gmail.com>
 <20210417154218.GS2947267@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210417154218.GS2947267@szeder.dev>
Date:   Sat, 17 Apr 2021 23:45:41 +0200
Message-ID: <87h7k41t6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 17 2021, SZEDER G=C3=A1bor wrote:

> On Sat, Apr 17, 2021 at 02:52:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Remove various redundant or obsolete code from the test_create_repo()
>> function, and split up its use in test-lib.sh from what tests need
>> from it, leaving us with a pass-through wrapper for "git init" in
>> test-lib-functions.sh
>>=20
>> Reasons for why we can remove various code from test_create_repo():
>>=20
>>  1. "mkdir -p" isn't needed because "git init" itself will create
>>     leading directories if needed.
>>=20
>>  2. Since we're now a simple wrapper for "git init" we don't need to
>>     check that we have only one argument. If someone wants to run
>>     "test_create_repo --bare x" that's OK.
>>=20
>>  3. We won't ever hit that "Cannot setup test environment"
>>     error.
>>=20
>>     Checking the test environment sanity when doing "git init" dates
>>     back to eea420693be (t0000: catch trivial pilot errors.,
>>     2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
>>     was successfully created, 2006-01-05).
>>=20
>>     We can also see it in another form a bit later in my own
>>     0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
>>     $old, 2010-08-30).
>>=20
>>     But since 2006f0adaee (t/test-lib: make sure Git has already been
>>     built, 2012-09-17) we already check if we have a built git
>>     earlier.
>>=20
>>     The one thing this was testing after that 2012 change was that
>>     we'd just built "git", but not "git-init", but since
>>     3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
>>     repositories, 2018-11-12) we invoke "git", not "git-init".
>>=20
>>     So all of that's been checked already, and we don't need to
>>     re-check it here.
>>=20
>>  4. We don't need to move .git/hooks out of the way.
>>=20
>>     That dates back to c09a69a83e3 (Disable hooks during tests.,
>>     2005-10-16), since then hooks became disabled by default in
>>     f98f8cbac01 (Ship sample hooks with .sample suffix, 2008-06-24).
>>=20
>>     So the hooks were already disabled by default, but as can be seen
>>     from "mkdir .git/hooks" changes various tests needed to re-setup
>>     that directory. Now they no longer do.
>>=20
>>  5. Since we don't need to move the .git/hooks directory
>
> Since we don't change directory anymore...
>
>> we don't need
>>     the subshell here either.
>>=20
>>     That wasn't really needed for the .git/hooks either, but was being
>>     done for the convenience of not having to quote the path to the
>>     repository as we moved the hooks.
>
> And then this dubious explanation will not be necessary.

Why dubious? That's why we had the subshell-ing. See 0d314ce834
(test-lib: use subshell instead of cd $new && .. && cd $old,
2010-08-30).

I don't mind rewording or not including some of this verbosity per-se,
but I wonder why you're honing in on the subshell part in
particular. Maybe there's something I'm missing...

The goal of the commit messsage is to point-by-point tear apart facets
of the previous behavior, and assure the reader that e.g. the
subshelling isn't needed for some other subtle reason.

>>  6. We can drop the --template argument and instead rely on the
>>     GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
>>     8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)
>>=20
>>  7. We only needed that ">&3 2>&4" redirection when invoked from
>>     test-lib.sh, and the same goes for needing the full path to "git".
>>=20
>>     Let's move that special behavior into test-lib.sh itself.
>
> Quoting myself from my review of the previous version of this patch:
>
>   PATH is already set up to start with GIT_TEST_INSTALLED and/or
>   GIT_EXEC_PATH before 'test_create_repo' is called to init the repo in
>   the trash directory, so we could simply run 'git' and rely on PATH
>   lookup choosing the right executable.
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 9ebb595c335..f73c3c6fc72 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1364,7 +1364,10 @@ rm -fr "$TRASH_DIRECTORY" || {
>>  remove_trash=3Dt
>>  if test -z "$TEST_NO_CREATE_REPO"
>>  then
>> -	test_create_repo "$TRASH_DIRECTORY"
>> +	"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" \
>> +		init \
>> +		"$TRASH_DIRECTORY" >&3 2>&4 ||
>
> So this could be just:
>
>   git init "$TRASH_DIRECTORY" >&3 2>&4 ||

Ah yes, I see that now. FWIW I managed to misread that in the last round
as it applying only once we were calling the test-lib-functions.sh
helper, but I see it's finishe setting up a few lines before the
test_create_repo in test-lib.sh too, nice.
