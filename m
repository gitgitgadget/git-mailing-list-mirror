Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72535ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 18:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiIASgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiIASg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 14:36:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D57FE53
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 11:35:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z8so14947289edb.6
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=qDrn60qj8aPt1sInx9UwNuw5Nut+3XFtykRPAGSjm8Q=;
        b=Wg4V661vv5DMHm3WfZ6efeMVITwKrCqxnWvsnhyVVeButeDxJuQVshGK73zNtGRltg
         m6AGyMUigOLEdAhmsgIHFgVyn/zPYVY/P/s9OvCU2FmcK8IGURFTNVRn2qy4WRshyoMG
         zH8t+ceLyl6TbZH2j9pZ3jwzFCu9Ll4MR7/8ykvrseCvOjj3tI5FDllugNu4zxmnmP2/
         +SddbaCbKrUf+RX886rhUdhO0uGCo9L4lnj7E8QFfBHrV4wcfb+67vNMRMJ9w6udAnV6
         dVxvcWymxw8PGvmWnA0ZiuQDEp69BFc+/9ty3N80SpI01nD4OWkiut1YHfSB+kERYQ59
         Oe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qDrn60qj8aPt1sInx9UwNuw5Nut+3XFtykRPAGSjm8Q=;
        b=FrKxa6z84ZQodU0p0uJ5kwWa0IZs9QcTBjafjTBUlCeR6JLFn04/so7/XJe5TfyD3j
         TvrbimXOXWZbiQdBsYemPdz6KkdOE4wQsLsMX0z3IzdlsPQoZChJE3c2H+0fiV22I0I9
         +i6gsl5TaMC4Nem2AkEDnHFyzrVGF5DuiuSxP03OjJRr6BjAVAcuXXO0QM/r/ucGCBiN
         UBaUEXoDCvw0GAHA4kN5GWJ/vk61fwdGlMS5O5h1S3RISNoFkC+n62f3rvyF9EGJ2ZaC
         cfFxfXhp19GroKgZYaRHd2noBzrBXslPG2o7j/SEv8i69WWv5+BQWAKZOqW+gm9sBVws
         jGWw==
X-Gm-Message-State: ACgBeo3+d/WB6h+PuFPMlLmHpOYC6dT7Wl2hIPGxt7gNQAmmAkTDKgmG
        SrgQq9TQdmWnWYok44S5nJV6iB9u9sMiWQ==
X-Google-Smtp-Source: AA6agR5CL+uIHue9D0RgJ5ABZYbsewV47IO3hlLKi1jlh93r9FZzM2IGa0WRTvpouMIGZht+W4kpcQ==
X-Received: by 2002:a05:6402:b15:b0:447:ee8c:7ace with SMTP id bm21-20020a0564020b1500b00447ee8c7acemr25461598edb.306.1662057334779;
        Thu, 01 Sep 2022 11:35:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lc18-20020a170906dff200b007307c4c8a5dsm6086ejc.58.2022.09.01.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:35:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTp2L-000Lsa-1f;
        Thu, 01 Sep 2022 20:35:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/9] cocci: make "coccicheck" rule incremental
Date:   Thu, 01 Sep 2022 20:04:45 +0200
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <patch-v2-7.9-120607b5da6-20220831T205130Z-avarab@gmail.com>
 <20220901163859.GA122568@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220901163859.GA122568@szeder.dev>
Message-ID: <220901.86y1v3hrii.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 01 2022, SZEDER G=C3=A1bor wrote:

> On Wed, Aug 31, 2022 at 10:57:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Optimize the very slow "coccicheck" target to take advantage of
>> incremental rebuilding, and fix outstanding dependency problems with
>> the existing rule.
>>=20
>> The rule is now faster both on the initial run as we can make better
>> use of GNU make's parallelism than the old ad-hoc combination of
>> make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
>> "--jobs" argument to "spatch(1)".
>
> On my machine a "from scratch" 'make -j4 coccicheck' without the
> inacceptably slow 'unused.cocci' takes 9m28s, with
> SPATCH_BATCH_SIZE=3D32 it takes 6m39s.  If we invoke 'spatch' like in
> the patch below and let one 'spatch' invocation process all source
> files one by one (i.e. unlike the batched invocations) and using its
> '--jobs' option then it takes 4m56s.
>
> This patch series is slower than any of the above, as it takes 10m3s.

But is such from-scratch building your primary use-case?

When I e.g. do a "make coccicheck" on master, then:

	git merge gitster/ac/bitmap-lookup-table

Or whatever, it takes much less time than before, ditto things like:

	time make -W grep.h contrib/coccinelle/free.cocci.patch

I.e. changing a file and wanting to re-run it for all of its reverse
dependencies (this is with the *.o files).

>>  * Before this change running "make coccicheck" would by default end
>>    up pegging just one CPU at the very end for a while, usually as
>>    we'd finish whichever *.cocci rule was the most expensive.
>>=20
>>    This could be mitigated by combining "make -jN" with
>>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
>>    spatch invocations, 2019-05-06). But doing so required careful
>>    juggling, as e.g. setting both to 4 would yield 16 workers.
>
> As pointed out previously, this is not the case.

Yes we discussed this in v1, I just missed this in the re-roll. Sorry!
Will fix it in the next iteration.

>  include config.mak.uname
>  -include config.mak.autogen
> @@ -3139,19 +3137,17 @@ COCCI_TEST_RES =3D $(wildcard contrib/coccinelle/=
tests/*.res)
>=20=20
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>  	$(QUIET_SPATCH) \
> -	if test $(SPATCH_BATCH_SIZE) =3D 0; then \
> -		limit=3D; \
> -	else \
> -		limit=3D'-n $(SPATCH_BATCH_SIZE)'; \
> -	fi; \
> -	if ! echo $(COCCI_SOURCES) | xargs $$limit \
> -		$(SPATCH) $(SPATCH_FLAGS) \
> -		--sp-file $< --patch . \
> +	filelist=3D$@.filelist; \
> +	: Blank lines between filenames are necessary to put each file in separ=
ate group ; \
> +	printf "%s\\n\\n" $(COCCI_SOURCES) >$$filelist && \
> +	if ! $(SPATCH) $(SPATCH_FLAGS) --jobs $(SPATCH_JOBS) \
> +		--sp-file $< --patch . --file-groups $$filelist \

Yes, I think it's unfortunate that there *are* faster ways to run it,
but they rely on doing things in batches of N, which doesn't really jive
well with make's incremental model of the world.

But I think we can either have that, or the ability to incrementally
(re)build.

Do you see some easy way to have our cake & eat it too here? If
you/others really feel strongly about this use case I could also keep
the old method, and just hide this all behind a SPATCH_INCREMENTAL=3DY
flag or something. But I'm hoping we can turn this (mostly) into some
win-win.
