Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDEFC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60CC61057
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhIBMtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344714AbhIBMtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:49:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C8C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:48:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ia27so4035154ejc.10
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mKo+dRa/bKKznoa0GzEIBZFxZBv0feIIMwIIBqplU/o=;
        b=mCuY8leSx5H4kHKZZEO6zhbQMiOr0Rdt51wAyWfRtd46cIp7gyo5kp8Qbr/vAeteKA
         RIJ7RGyoE2a1NT12xrtR+dDrSOv+JDnnFskIj5ZXj+l+ke5d5eOtq6YPSFrszKBwdez0
         7L1TJ0V8gFqE9Zt4utxo7rkAOfrUanEDzvqHNXS2F/+HkilNDcY5kigxu7+/YOVZjXYZ
         N3XXqUSMn2/TpjZyn4juqZvxWqIG4pQzlZoEFFYjmUHz7N1pWF7kT6AtRJg2xMSLoYAz
         adBoZ4Bdm3FXWhSkk32vw0GHFuybEHSf6yT3dklecxSwMMmUHfplxvttnddziny89BdH
         NX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mKo+dRa/bKKznoa0GzEIBZFxZBv0feIIMwIIBqplU/o=;
        b=gFtfQzbErxauDfruXp8DfdixfElbB2GSj/wA/kH07nIAsqDz4jVrwhwDyxJQ+8mhqT
         +ww1Z9ShHlRLTq4KeeNY+Jsj7vJNMtEk+yhTuVsQphYffghvTzeXZiLilzZbk392pqxK
         fukBVwn2Ej4HYYEmt48nBZohg5I6HQJFzXSkx5y1gPUZ4yiOv3V2ws0dUkiwFMBiNxqX
         4F9/bQ4MhpJQKoWK96PBMIp8ccMl+kUmcYq4VzQrPkf0tczgbRcnCCPODAL+uUvtYaWd
         walj1sS2FVIF0dhkWLNFFLGubP0pd5L4pfJfgpSYKCQN+nplomhxnV49S5RD/F9YL1Kg
         rryQ==
X-Gm-Message-State: AOAM532ftzcedRJSyt/6+/ACoWyExjWN08tRSYOcDFcXb4yBTqvdGcbv
        h/YkJ1NtuW15sgycnfKY1cc=
X-Google-Smtp-Source: ABdhPJw7C6x1/X2AioaRxqJnRdWDWjUvkAb+5fbIAa/ZiNAnzUB4E06sDu53CeJaylJ9f8VIZl7tJw==
X-Received: by 2002:a17:906:2c5a:: with SMTP id f26mr3640609ejh.205.1630586893547;
        Thu, 02 Sep 2021 05:48:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i7sm984232ejx.73.2021.09.02.05.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:48:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] add a test mode for SANITIZE=leak, run it in CI
Date:   Thu, 02 Sep 2021 14:25:33 +0200
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
Message-ID: <877dfzb0tw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Jeff King wrote:

> On Tue, Aug 31, 2021 at 03:35:34PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>  * In v2 compiling with SANITIZE=3Dleak would change things so only
>>    known-good passing tests were run by default, everything else would
>>    pass as a dummy. Now the default running of tests is unchanged, but
>>    if we run with GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue only those tests
>>    are run which set and export TEST_PASSES_SANITIZE_LEAK=3Dtrue.
>>=20
>>  * The facility for declaring known-good tests in test-lib.sh based on
>>    wildcards is gone, instead individual tests need to declare if
>>    they're OK under SANITIZE=3Dleak.[...]
>
> Hmm. This still seems more complicated than we need. If we just want a
> flag in each script, then test-lib.sh can use that flag to tweak
> LSAN_OPTIONS. See the patch below.

On the "pragma" include v.s. env var + export: I figured this would be
easier to read as I thought the export was required (I don't think it is
in most cases, but e.g. for t0000*.sh I think it is, but that's from
memory...).

> That has two drawbacks:
>
>   - it doesn't have any way to switch the flag per-test. But IMHO it is
>     a mistake to go in that direction. This is all temporary scaffolding
>     while we have leaks, and the script-level of granularity is fine.

We have a lot of tests that do simple checking of the tool itself, and
later in the script might be stressing trace2, or common sources of
leaks like "git log" in combination with the tool (e.g. the commit-graph
tests).

So being able to tweak this inside the script is useful, but that can of
course also be done with this proposed TEST_LSAN_OK + prereq.

>   - it runs the tests not marked as LSAN-OK, just without leak checking,
>     which is redundant in CI where we're already running them. But we
>     could still be collecting leak stats (and just not failing the
>     tests). See the patch below.

Sure, I'd prefer=20

>     If we do care about not running them, then I think it makes more
>     sense to extend the run/skip mechanisms and build on that.

The patch I have here is already nicely integrated with the skip
mechanism. I.e. we use skip_all which shows a summary in any TAP
consumer, and we can skip individual tests with prerequisites.

>     (I also think I prefer the central list of "mark these scripts as OK
>     for leak-checking", rather than annotating individuals. Because
>     again, this is temporary, and it's nice to keep it in a sandbox that
>     only people working on leak-checking would look at or touch).
>
> I realize this is kind-of bikeshedding, and I'm not vehemently opposed
> to what you have here. It just seems like fewer moving parts would be
> less likely to confuse folks who want to poke at it.

I can see that for the proposed v2 mechanism, but in this v3 nothing
changes unless you opt-in to things via new GIT_TEST_* setting. So the
chance for confusion seems minimal to nonexisting.

I was interested in doing some summaries of existing leaks
eventually. It seems even with LSAN_OPTIONS=3Ddetect_leaks=3D0 compiling
with SANITIZE=3Dleak make things a bit slower, but not by much (but actual
leak checking is much slower).

But I'd prefer to leave any "write out leak logs and summarize" step for
some later change.

>>    This is done via "export
>>    TEST_PASSES_SANITIZE_LEAK=3Dtrue", there's a handy import of
>>    "./test-pragma-SANITIZE=3Dleak-ok.sh" before sourcing "./test-lib.sh"
>>    itself to set this.
>
> I found the extra level of indirection added by this pragma confusing.
> We just need to set a variable, which is also a one-liner, and one that
> is more obvious about what it's doing. In your code you also export it,
> but that's not necessary for something that test-lib.sh is going to look
> at. Or if it's really necessary at some point, then test-lib.sh can do
> the export itself.

*nod*, will remove it per discussion above.

>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>>   Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS
>>   CI: refactor "if" to "case" statement
>>   tests: add a test mode for SANITIZE=3Dleak, run it in CI
>>   tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>   tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>   tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>   tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>   tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
> Sort of a meta-question, but what's the plan for folks who add a new
> test to say t0000, and it reveals a leak in code they didn't touch?

Then CI will fail on this job. We'd have those same failures now
(e.g. the mentioned current delta between master..seen), we just don't
see them. Having visibility on them seems like an improvement.

> They'll get a CI failure (as will Junio if he picks up the patch), so
> somebody is going to have to deal with it. Do they fix it? Do they unset
> the "this script is OK" flag? Do they mark the individual test as
> non-lsan-ok?

I'd think they'd fix it, or make marking the regression as OK part of
their re-roll, just like failures on master..seen now.

If you're getting at that we should start out this job as an FYI job
that doesn't impact the CI run's overall status if it fails I think that
would be OK as a start.

> I do like the idea of finding real regressions. But while the state of
> leak-checking is still so immature, I'm worried about this adding extra
> friction for developers. Especially if they get some spooky action at a
> distance caused by a leak in far-away code.

Yeah, ultimately this series is an implicit endorsement of us caring
more than we do now.

I think this friction point is going to be mitigated a lot by the
ability I've added to not just skip entire test scripts, but allow
prereq skipping of some tests, early bailing out etc.

It allows you to say add a "git log" test at the end of some test that
otherwise just uses some core API or a test tool and not have to throw
the baby out with the bathwater in terms of disabling all existing leak
checks there to make forward progress (or split up the entire test
script).

> Anyway, here's LSAN_OPTIONS thing I was thinking of.

Thanks, that & your follow-up is very interesting. Can I assume this has
your SOB? I'd like to add that redirect to fd 4 change to this series.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index df544bb321..b1da18955d 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -2,6 +2,7 @@
>=20=20
>  test_description=3D'git init'
>=20=20
> +TEST_LSAN_OK=3D1
>  . ./test-lib.sh
>=20=20
>  check_config () {
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index abcfbed6d6..62627afeaf 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -44,9 +44,30 @@ GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
>  : ${ASAN_OPTIONS=3Ddetect_leaks=3D0:abort_on_error=3D1}
>  export ASAN_OPTIONS
>=20=20
> -# If LSAN is in effect we _do_ want leak checking, but we still
> -# want to abort so that we notice the problems.
> -: ${LSAN_OPTIONS=3Dabort_on_error=3D1}
> +if test -n "$LSAN_OPTIONS"
> +then
> +	# Leave user-provided options alone.
> +	:
> +elif test -n "$TEST_LSAN_OK"
> +then
> +	# The test script has declared itself as LSAN-clean; turn on full leak
> +	# checking.
> +	LSAN_OPTIONS=3Dabort_on_error=3D1
> +else
> +	# The test script has possible LSAN failures. Just disable
> +	# leak-checking entirely. Another option would be to log the failures
> +	# with:
> +	#
> +	#   LSAN_OPTIONS=3Dexitcode=3D0:log_path=3D$TEST_DIRECTORY/lsan/out
> +	#
> +	# The results are rather confusing, though, as the logs are
> +	# per-process; you have no idea which one came from which test script.
> +	# Ideally we'd send them to descriptor 4 along with the rest of the
> +	# script log, but there's no LSAN_OPTION for that (recent versions of
> +	# libsanitizer do have a public function to do so, so we could hook it
> +	# ourselves via common-main).
> +	LSAN_OPTIONS=3Ddetect_leaks=3D0
> +fi
>  export LSAN_OPTIONS
>=20=20
>  if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS

