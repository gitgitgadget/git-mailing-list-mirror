Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFABC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiDNOpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348041AbiDNOCI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 10:02:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492303EB92
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 06:57:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so10225398ejd.5
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kVJ0gNEGGLWBlb2dxNue6B5HN1fP8sI5B8la9spoHww=;
        b=j6IJQvvyZgnrYqXv3/CkwgPDAFkJx16p2hilASZVPBZ44xGDhiPAEYfcsKUURmciLw
         Zyc/T3K9okT4W6HgendL6Kls6/yQq5c5cINu5+QrYaMQ2OQBht9UxxctHgMBOUAQ4Cl3
         aHMOBJrJq8NE/Ti7OtvilyelX9S04JVS9vYmBf8N8tpfdFrtQEfPSKD8Q65mzF6EslBV
         ExVO38wQKDjSWkJfshoGVBBuABfxpgPl9Rs2N8UiW/SC6pjxfngoBqd0OjUGNhg7KieN
         J2rBKGp3NOhVNBtQHdndAHARuXER4aN90IHJ7vEEvsgUnlDnoxT0xCa0/88An0Fv8NFE
         IXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kVJ0gNEGGLWBlb2dxNue6B5HN1fP8sI5B8la9spoHww=;
        b=kRHeHrce2/Jto3L1Az2pNilXvG1fzHqW4olzCZYyRc+Rrq72acs1zdjSRR/zT/VhCU
         heVL2xBRG2aa9mkEz7VF5yB3eWYUNpOyAOeRvebmqu5moAjNQnTITIciRrO38HcAImUE
         56q3Ijn+xhJSO9tPYc9UgPFuxuKIS84bPEYlasWzDYX6+E3VRoWmC6fJgsbf1zfmVoVl
         8fEFc2aI0TZTvJlr4Z1IU+Qu4oONwciFvB78UvJsOAXtBUGN3bwuQKGHhljFglwJ7oIS
         vJ36XbkN0XXJlhqt0E2zUisLFHyokCCy6mLjHINiBR85230KR0dFVdPZGyV/naqKevli
         Jq6Q==
X-Gm-Message-State: AOAM532ctEKhumfFXvEIJL1qPMfqMKXr1bCZ3PvkZVxVMBgKEPEiTJiu
        MD5VjWNkVBVnLtTHoLWG56G4Q3BJXpEFUw==
X-Google-Smtp-Source: ABdhPJxwDcUav4p7eUhRC+WMZ75izK24O8pJ01Q+qyJH/3BKQh3LpaDZgHQ4sGzaiSrfxeyW7YGRDw==
X-Received: by 2002:a17:907:9482:b0:6da:8ad6:c8b5 with SMTP id dm2-20020a170907948200b006da8ad6c8b5mr2402029ejc.372.1649944662516;
        Thu, 14 Apr 2022 06:57:42 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402278c00b004195a50759fsm1120533ede.84.2022.04.14.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:57:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nezyf-005R2p-Bo;
        Thu, 14 Apr 2022 15:57:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 29/29] CI: make it easy to use ci/*.sh outside of CI
Date:   Thu, 14 Apr 2022 15:51:30 +0200
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-29.29-2e3c02fa0df-20220413T194847Z-avarab@gmail.com>
 <214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com>
Message-ID: <220414.86pmljday2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Eric Sunshine wrote:

> On 4/13/22 3:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> In preceding commits the ci/.sh scripts have lost most of their
>> CI-specific assumptions. Let's go even further and explicitly support
>> running ci/lib.sh outside of CI.
>>
>> This was possible before by faking up enough CI-specific variables,
>> but as shown in the new "help" output being added here using the
>> ci/lib.sh to provide "CI-like" has now become trivial.
>>
>> The ci/print-test-failures.sh scripts can now be used outside of CI as
>> well, the only GitHub CI-specific part is now guarded by a check that
>> we'll pass if outside of GitHub CI.
>>
>> There's also a special-case here to not clobber $MAKEFLAGS in the
>> environment if we're outside of CI, in case the user has e.g. "jN" or
>> other flags to "make" that they'd prefer configured already.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> @@ -1,6 +1,30 @@
>> +#  Usage
>> +CI_TYPE_HELP_COMMANDS=3D'
>> +	# run "make all test" like the "linux-leaks" job
>> +	(eval $(jobname=3Dlinux-leaks ci/lib.sh --all) && make test)
>> +
>> +	# run "make all test" like the "linux-musl" job
>> +	(eval $(jobname=3Dlinux-musl ci/lib.sh --all) && make test)
>> +
>> +	# run "make test" like the "linux-TEST-vars" job (uses various
>   GIT_TEST_* modes)
>> +	make && (eval $(jobname=3Dlinux-TEST-vars ci/lib.sh --test) && make te=
st)
>> +
>> +	# run "make test" like the "linux-sha256" job
>> +	make && (eval $(jobname=3Dlinux-sha256 ci/lib.sh --test) && make test)
>> +'
>> +
>> +CI_TYPE_HELP=3D"
>> +running $0 outside of CI? You can use ci/lib.sh to set up your
>> +environment like a given CI job. E.g.:
>> +$CI_TYPE_HELP_COMMANDS
>> +
>> +note that some of these (e.g. the linux-musl one) may not work as
>> +expected due to the CI job configuring a platform that may not match
>> +yours."
>> +
>> @@ -9,6 +33,10 @@ mode=3D$1
>>   if test -z "$mode"
>>   then
>>   	echo "need a $0 mode, e.g. --build or --test" >&2
>> +	if test -z "$CI_TYPE"
>> +	then
>> +		echo "$CI_TYPE_HELP" >&2
>> +	fi
>>   	exit 1
>>   fi
>
> It would never occur to me to try running a script named ci/lib.sh in
> the first place, and I'm not sure I would even think to poke around in
> the `ci` directory with the idea of being able to run CI tasks
> locally. Would it make sense to aid discovery by mentioning this new
> feature in the "GitHub CI" section of SubmittingPatches as a follow up
> to this series? (If so, perhaps the "GitHub CI" section should be
> renamed to "CI".)

Yes, I'd like to do that, but as a follow-up, specifically to have
failing tests in CI suggest a way to run them locally.

It would be better as ci/config.sh or something, but it was ci/lib.sh
already, and this way minimized the diff/conflicts.

>> @@ -76,10 +108,29 @@ CC_PACKAGE=3D
>>   # How many jobs to run in parallel?
>>   NPROC=3D10
>> +case "$CI_TYPE" in
>> +'')
>> +	if command -v nproc >/dev/null
>
> You need to redirect stderr too in order to avoid a scary error
> message on platforms lacking `nproc`:
>
>     if command -v nproc >/dev/null 2>&1

I figured the scary error would be useful, it's only if you run it
ad-hoc, so it would be a nice hint as to why we fallback on the default
nproc.

>> +	then
>> +		NPROC=3D$(nproc)
>> +	else
>> +		NPROC=3D1
>> +	fi
>
> Neither macOS nor BSD has an `nproc` command, however, they do have
> `sysctl`:
>
>     elif command -v sysctl >/dev/null 2>&1
>     then # macOS & BSD
>         NPROC=3D$(sysctl -n hw.ncpu 2>/dev/null)
>
> and Windows provides a suitable environment variable:
>
>     elif test -n "$NUMBER_OF_PROCESSORS"
>     then # Windows
>         NPROC=3D"$NUMBER_OF_PROCESSORS"

*nod*

I'd rather not finish this part up though and instead just have this
call some moral equivalent of t/helper/test-online-cpus.c.

Most of our CI is linux, so just nproc for now felt like a good initial
addition which we could expand on later.

>> +	if test -n "$MAKEFLAGS"
>> +	then
>> +		COMMON_MAKEFLAGS=3D"$MAKEFLAGS"
>> +	else
>> +		COMMON_MAKEFLAGS=3D--jobs=3D$NPROC
>> +	fi
>> +	;;

