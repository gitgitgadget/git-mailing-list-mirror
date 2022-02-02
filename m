Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D5AC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 19:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbiBBTpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbiBBTph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 14:45:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0687C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 11:45:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m4so659828ejb.9
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 11:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pU/36p9ZLRYnKGEFMgmNAzXYNkwah+n4xUa4BHwdrR8=;
        b=b86ATt71wBUZpYB8kL0O9vfAez2/Olw43pGx6WqHFUkHMPg/EqA9Dqf0ovB2ax7YWC
         jLTcuTaUUyPi1qOm0i8nTpjErwF9OB0wyCYrcd8bpXJ8+u1gUkkVkncYf3zSvKf1Xqjc
         vSBO6Ltr1BLdVbs45UA5it27gTMBfPX3zu2xYQq3oJ+2Ukh6dO4n7Z9wKvUC4zeg1qli
         TKLLiXTwSUVIX6TAPD2HaZzvf9+r+cEBOczYd1dHDAP1d5OPakeUdNt1Vhe2m6e3g1ji
         /V7h8A5O2s7Pgc9yd8Z9rBZXTRrHy5LxQHPG4BYuv5EIL+Htj6JhNMLuJendPgs91+um
         Cjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pU/36p9ZLRYnKGEFMgmNAzXYNkwah+n4xUa4BHwdrR8=;
        b=UB9E9DOp/FbDlGwK3J8XIyqPLkwxVzrwKhiREAyMDb9awg6xL2HiqMeH3aQrz+zEFE
         SQGpYxsdphhNVbY1TVKBjcoGi3jQ/bz59pHpCP9ZmdUQ3QCvvj8U+YAcF0FPO6RZ83+A
         tgd+nSRggzMQTPEal4hiKum9/CZFeMAKh44+qNByho+R9alEffWRaIze4jEQmfyd4Klt
         ftVNCsPTSrE/DLerpCOhLgVlnLaAe195/ev8gwtZwYg9ZE0wjKPIMzZdpnPXCvAb6etr
         NMZYXiBd0zCyrDEeJZB+gdlueqV2bYATDAAm8DgxBkFx4tCqQ5l3hSQiwvxACFhKr805
         XQuw==
X-Gm-Message-State: AOAM530MEl1pJ+MgCtCeB/puqYeKVFkoE2jXSB/VcOs1fGhvpbC0Jlfc
        xhkqkWdCJgTDcXDQGYhfQ9Q=
X-Google-Smtp-Source: ABdhPJwuNQh97CC7wGdiCHUVAYchiWhzgTUsdE+FJSKtfET3qTAUsOcll/HdOgWDcgol8ulvPxK3og==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr26708576ejc.767.1643831135919;
        Wed, 02 Feb 2022 11:45:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g27sm16009416ejf.108.2022.02.02.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:45:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFLZO-004fi2-Gn;
        Wed, 02 Feb 2022 20:45:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0051: use "skip_all" under !MINGW in single-test file
Date:   Wed, 02 Feb 2022 20:44:16 +0100
References: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
 <xmqq5ypycl7u.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq5ypycl7u.fsf@gitster.g>
Message-ID: <220202.86zgn96oip.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 01 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Have this file added in 06ba9d03e34 (t0051: test GIT_TRACE to a
>> windows named pipe, 2018-09-11) use the same "skip_all" pattern as an
>> existing Windows-only test added in 0e218f91c29 (mingw: unset PERL5LIB
>> by default, 2018-10-30) uses.
>>
>> This way TAP consumers like "prove" will show a nice summary when the
>> test is skipped, e.g.:
>
> ... as opposed to?  A failure?  A different appearance of the log
> message?  Something else?

In "prove" we go from simply showing "ok":
=20=20=20=20
    $ prove t0051-windows-named-pipe.sh
    t0051-windows-named-pipe.sh .. ok=20=20=20
    All tests successful.
    Files=3D1, Tests=3D1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.03 cu=
sr  0.01 csys =3D  0.06 CPU)
    Result: PASS
=20=20=20=20
To showing the skip message quoted here:

>>
>>     $ prove t0051-windows-named-pipe.sh
>>     [...]
>>     t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific t=
ests
>>     [...]

But YMMV. We're now making use of the right TAP-y way to communicate
this to the consumer. I.e. skipping the whole test file, v.s. skipping
individual tests (in this case there's only one test).

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> A trivial UX improvement for the "prove" output, so that we'll show a
>> notice in the same way as e.g. t0029-core-unsetenvvars.sh and
>> t5580-unc-paths.sh do (which are both Windows-specific).
>>
>>  t/t0051-windows-named-pipe.sh | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.=
sh
>> index 10ac92d2250..412f413360d 100755
>> --- a/t/t0051-windows-named-pipe.sh
>> +++ b/t/t0051-windows-named-pipe.sh
>> @@ -3,8 +3,13 @@
>>  test_description=3D'Windows named pipes'
>>=20=20
>>  . ./test-lib.sh
>> +if ! test_have_prereq MINGW
>> +then
>> +	skip_all=3D'skipping Windows-specific tests'
>> +	test_done
>> +fi
>>=20=20
>> -test_expect_success MINGW 'o_append write to named pipe' '
>> +test_expect_success 'o_append write to named pipe' '
>>  	GIT_TRACE=3D"$(pwd)/expect" git status >/dev/null 2>&1 &&
>>  	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
>>  	pid=3D$! &&

