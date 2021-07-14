Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA8FC47E4B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C6F610CB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhGNW64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbhGNW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:58:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA08C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:56:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dt7so5874316ejc.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x2ltDYK4QhFYhhIc5kK9vb0Pu45I/r6RUkjKzt2pNcs=;
        b=Tskazu3TB/hakHmAUzOGwB0S9wygRdR/e6wd8ldD48mqZw/Cua7mJ5NTbEFuDcVGbZ
         tef9iPeUvTjwE446+lnRVUaDUwCHUU9mmzsawexbgkkymM+b0TPxWSnzJ6GASxCZ2jkC
         t6vfVI8ZLJq72Qx6Nn82ScijAs4Gb4UlvjKsXo+7hv+zQOe8w2MqaXKK/BpbbvRqmZXK
         N3YLYFJy2kdUocWXhcFbUru+CFfLPAF+5zE4cSFOfpQn2ouulNmD49PsrxOi18xFiOAV
         W5oCOwEYBMLNgqC+bkSplnw5VFHv4WA0F8+dbpneXTGCiJ6M8q4FF8kGTNdoF/CeAvwq
         0XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x2ltDYK4QhFYhhIc5kK9vb0Pu45I/r6RUkjKzt2pNcs=;
        b=t6kbIQaUGD9XrIlWn02qI/fvTM0n0XT45IdjzMr+8MLl4rTt/aMRXIik6VhT4giSPG
         YQnxG8AlZBDaJU+LMCMpe9ZbxgnGMmsXhm1UCpDKcuSj/Wa0vFGM7w6m/ZCTcrYPlrGr
         uAsHMFNLTMzc+15rmtBALCxPh7wKfgO/g7CWFFH/h5UI48Vi/8Sxtz0aBx+ML35kZkSP
         4v9g8P5XPRLTCZzIn/jA1+x/gIFyf/jz8p+PfuleOPj+jRIBXAwCtzxEoIkonelwC9Ry
         p7tpfFsC47jL5RQhO4KWfAusgCx32dhBq7NMDzkkhPd04WXjF9WNlg3rCzSU9FVdU1RQ
         uZnQ==
X-Gm-Message-State: AOAM533Hqi32L8HSgK8evhqnJHNDueRazb85H1LatziTqoPitPYOTnOc
        dhKAjEb394jf07tUMyg5yHY=
X-Google-Smtp-Source: ABdhPJy3ZmoaL7hsNpOn1lDpzhF7Kk1o6oD64W/PFmnQJQ+iKoV8UpFs12gRxwr9u2lDnMtj+OFb5Q==
X-Received: by 2002:a17:906:718c:: with SMTP id h12mr617244ejk.6.1626303360654;
        Wed, 14 Jul 2021 15:56:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n18sm1212546ejl.74.2021.07.14.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:56:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Date:   Thu, 15 Jul 2021 00:39:12 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <eebb4f74-b5e3-6c11-3b84-fcee1b876992@ahunt.org>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <eebb4f74-b5e3-6c11-3b84-fcee1b876992@ahunt.org>
Message-ID: <87k0lszere.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Andrzej Hunt wrote:

> On 14/07/2021 19:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> While git can be compiled with SANITIZE=3Dleak there has been no
>> corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
>> fixed as one-offs without structured regression testing.
>> This change add such a mode, we now have new
>> linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
>> tests as linux-{clang,gcc}, except that almost all of them are
>> skipped.
>> There is a whitelist of some tests that are OK in test-lib.sh, and
>> individual tests can be opted-in by setting
>> GIT_TEST_SANITIZE_LEAK=3Dtrue before sourcing test-lib.sh. Within those
>> individual test can be skipped with the "!SANITIZE_LEAK"
>> prerequisite. See the updated t/README for more details.
>> I'm using the GIT_TEST_SANITIZE_LEAK=3Dtrue and !SANITIZE_LEAK pattern
>> in a couple of tests whose memory leaks I'll fix in subsequent
>> commits.
>> I'm not being aggressive about opting in tests, it's not all tests
>> that currently pass under SANITIZE=3Dleak, just a small number of
>> known-good tests. We can add more later as we fix leaks and grow more
>> confident in this test mode.
>> See the recent discussion at [1] about the lack of this sort of test
>> mode, and 0e5bba53af (add UNLEAK annotation for reducing leak false
>> positives, 2017-09-08) for the initial addition of SANITIZE=3Dleak.
>> See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
>> 7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
>> 936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
>> past history of "one-off" SANITIZE=3Dleak (and more) fixes.
>> When calling maybe_skip_all_sanitize_leak matching against
>> "$TEST_NAME" instead of "$this_test" as other "match_pattern_list()"
>> users do is intentional. I'd like to match things like "t13*config*"
>> in subsequent commits. This part of the API isn't public, so we can
>> freely change it in the future.
>> 1. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   .github/workflows/main.yml |  6 ++++
>>   Makefile                   |  5 ++++
>>   ci/install-dependencies.sh |  4 +--
>>   ci/lib.sh                  | 18 ++++++++----
>>   ci/run-build-and-tests.sh  |  4 +--
>>   t/README                   | 16 ++++++++++
>>   t/t5701-git-serve.sh       |  2 +-
>>   t/test-lib.sh              | 60 ++++++++++++++++++++++++++++++++++++++
>>   8 files changed, 105 insertions(+), 10 deletions(-)
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 73856bafc9..752fe187f9 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -297,6 +297,12 @@ jobs:
>>             - jobname: linux-gcc-default
>>               cc: gcc
>>               pool: ubuntu-latest
>> +          - jobname: linux-clang-sanitize-leak
>> +            cc: clang
>> +            pool: ubuntu-latest
>> +          - jobname: linux-gcc-sanitize-leak
>> +            cc: gcc
>> +            pool: ubuntu-latest
>
> Is there any advantage to running leak checking with both gcc and
> clang? My understanding is that you end up using the same sanitiser=20
> implementation under the hood - I can't remember if using a different
> compiler actually helps find different leaks though.

I didn't know that, makes sense. I'll make it one job and have it use
whatever CC is.

> My other question is: if we are adding a new job - should it really be
> just a leak checking job? Leak checking is just a subset of ASAN=20
> (Address Sanitizer). And as discussed at [1] it's possible to run ASAN
> and UBSAN (Undefined Behaviour Sanitizer) in the same build. I feel
> like it's much more useful to first add a combined ASAN+UBSAN job,
> followed by enabling leak-checking as part of ASAN in those jobs for
> known leak-free tests - as opposed to only adding leak checking. We
> currently disable Leak checking for ASAN here [2], but that could be
> made conditional on the test ID (i.e. check an allowlist to enable
> leak checking for some tests)?

It sounds good to support that, but at least right now I've got the itch
of finding leaks during development, and I think in any case being able
to do a full run with just sanitizing, leak checking (or combined) makes
sense, i.e. to make GIT_TEST_SANITIZE_LEAK=3D* the top-level interface.

I haven't checked how noisy ASAN is, is it like the leak checking where
we fail almost all tests now?

Anyway, once we have some test mode like this it'll be trivial to extend
it. I mainly want us to get this into CI so we can have an expanding
line in the sand with regressions.

> I think it's worth focusing on ASAN+UBSAN first because they tend to
> find more impactful issues (e.g. buffer overflows, and other real
> bugs) - whereas leaks... are ugly, but leaks in git don't actually
> have much user impact?

We have one-off commands, but also long-lived things like "git cat-file
--batch", it's useful if we don't leak in those.

The entry point to those tends to be one-off commands in tests, so
checking leaks for all commands in a test (if you can get there) is a
useful indicator for how the underlying API performs.

I think in the git.git codebase we don't have much of an issue with
buffer overflows etc, because we tend to consistently use APIs like
strbuf that avoid those issues, but then again I haven't run the tests
with that, maybe I'll be unpleasantly surprised.

I also find leak checking to be useful during development to spot faulty
assumptions, i.e. the leak itself may not be a big deal, but it's
usually an early sign that I'm structuring something incorrectly.

> [1]
> https://lore.kernel.org/git/YMI%2Fg1sHxJgb8%2FYD@coredump.intra.peff.net/
>
> [2] https://git.kernel.org/pub/scm/git/git.git/tree/t/test-lib.sh#n44
>
>>       env:
>>         CC: ${{matrix.vector.cc}}
>>         jobname: ${{matrix.vector.jobname}}
>> diff --git a/Makefile b/Makefile
>> index 502e0c9a81..d4cad5136f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1216,6 +1216,9 @@ PTHREAD_CFLAGS =3D
>>   SPARSE_FLAGS ?=3D
>>   SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>>   +# For informing GIT-BUILD-OPTIONS of the SANITIZE=3Dleak target
>> +SANITIZE_LEAK =3D
>> +
>>   # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>>   # usually result in less CPU usage at the cost of higher peak memory.
>>   # Setting it to 0 will feed all files in a single spatch invocation.
>> @@ -1260,6 +1263,7 @@ BASIC_CFLAGS +=3D -DSHA1DC_FORCE_ALIGNED_ACCESS
>>   endif
>>   ifneq ($(filter leak,$(SANITIZERS)),)
>>   BASIC_CFLAGS +=3D -DSUPPRESS_ANNOTATED_LEAKS
>> +SANITIZE_LEAK =3D YesCompiledWithIt >   endif
>>   ifneq ($(filter address,$(SANITIZERS)),)
>>   NO_REGEX =3D NeededForASAN
>> @@ -2793,6 +2797,7 @@ GIT-BUILD-OPTIONS: FORCE
>>   	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
>>   	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' =
>>$@+
>>   	@echo DC_SHA1=3D\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>> +	@echo SANITIZE_LEAK=3D\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK=
)))'\' >>$@+
>>   	@echo X=3D\'$(X)\' >>$@+
>>   ifdef TEST_OUTPUT_DIRECTORY
>>   	@echo TEST_OUTPUT_DIRECTORY=3D\''$(subst ','\'',$(subst ','\'',$(TEST=
_OUTPUT_DIRECTORY)))'\' >>$@+
>> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> index 67852d0d37..8ac72d7246 100755
>> --- a/ci/install-dependencies.sh
>> +++ b/ci/install-dependencies.sh
>> @@ -12,13 +12,13 @@ UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-opens=
sl-dev libexpat-dev
>>    libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
>>     case "$jobname" in
>> -linux-clang|linux-gcc)
>> +linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
>
> How about `linux-clang*|linux-gcc*)` here and below?

I did that in v1, as =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh pointed out=
 we have other jobs
that would match that.

>>   	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>>   	sudo apt-get -q update
>>   	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>>   		$UBUNTU_COMMON_PKGS
>>   	case "$jobname" in
>> -	linux-gcc)
>> +	linux-gcc|linux-gcc-sanitize-leak)
>>   		sudo apt-get -q -y install gcc-8
>>   		;;
>>   	esac
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> index 476c3f369f..bb02b5abf4 100755
>> --- a/ci/lib.sh
>> +++ b/ci/lib.sh
>> @@ -183,14 +183,16 @@ export GIT_TEST_CLONE_2GB=3Dtrue
>>   export SKIP_DASHED_BUILT_INS=3DYesPlease
>>     case "$jobname" in
>> -linux-clang|linux-gcc)
>> -	if [ "$jobname" =3D linux-gcc ]
>> -	then
>> +linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
>> +	case "$jobname" in
>> +	linux-gcc|linux-gcc-sanitize-leak)
>>   		export CC=3Dgcc-8
>>   		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3"
>> -	else
>> +		;;
>> +	*)
>>   		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python2"
>> -	fi
>> +		;;
>> +	esac
>>     	export GIT_TEST_HTTPD=3Dtrue
>>   @@ -233,4 +235,10 @@ linux-musl)
>>   	;;
>>   esac
>>   +case "$jobname" in
>> +linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
>> +	export SANITIZE=3Dleak
>> +	;;
>> +esac
>> +
>
> Have you considered doing this in the yaml job configuration instead?
> It's possible to set env-vars in yaml, although it will require some=20
> careful tweaking - here's an example where I'm setting different
> values for SANITIZE depending on job (you'd probably just have to set
> it to empty for the non leak-checking jobs):
>
> https://github.com/ahunt/git/blob/master/.github/workflows/ahunt-sync-nex=
t2.yml#L51-L69
>
> That does make the yaml more complex, but I think it's worth it to
> reduce the amount of special-casing elsewhere (and is also worth it if=20
> we ever add other sanitisers)?

I'm not too familiar with git.git's ci/* dir, but I think it's like that
in general because we don't just run in GitHub CI, but want to support
Azure, Travis etc.

So almost all of the logic is in those shellscripts, right now this
target just runs in the GitHub CI, but it would be useful to make it
drop-in enabled elsewhere.

I think given that that doing anything overly clever in the YAML would
probably be counter-productive.
