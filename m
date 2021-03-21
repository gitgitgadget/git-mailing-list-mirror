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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DEBC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A746191A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCUA32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUA3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:29:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8762C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:29:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w18so15151833edc.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HPJQ+/YqtMqmthhjwQ2ob4XhO84rVdkDt25gvw9NsTw=;
        b=T6mV4NECUzEB+ZFCZYtWKW/VilGF3peKjKVxsz/WFsx23LHU1GB0qhJQ8GLFuTRp2h
         CAfGQOZdFHfToymDn4obxrX4Wm8rqMt3AJJs3FbC53f6yrLw6q0VMbicmgrrY7gy+tgX
         mhmLoi3/jj0+lGZFHIVGhzyJFdiRmepFAbw11nc1T0Ya1JiyM3qLOwTo0YmKPhD7hCUQ
         Qexd3xrOOu4dM8a1SHAqaLJLlKJ+240wQ3y9ip/E+UK9vCwWuZADLjAnLGetOAuHtpxn
         XHYBHXqdqAub6BUZ3ePXuhU4tnW1XXhaVj915cP1spc74sMjlX0otnz9q+nhsxjvbKl5
         GgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HPJQ+/YqtMqmthhjwQ2ob4XhO84rVdkDt25gvw9NsTw=;
        b=GRByrXC7LKFlQU61XqhM9Lh/Lsin4K3Z1f9hQ5/muTh3we807CqY/FNYC1TAZxTLJs
         Srb7tfgiZi0/XT8XAxOqA2saCxAqTh8j0+h3cadn/nrLLFeGcRxHLU5ePQtkf3k5HzZu
         XwWNH4wVtVT6sD5T2OOpjd2D2Iuq0+F+QOgUQtsqntseMesUXi1DgUkJeQxtg6HAecXt
         SBItBr83nI218amVSICwydyjSdlrzH8dZXsORxfn0B9KN2B2uTc5G4XSMAKkpCUBi+Xa
         CXPxICbZq1d5Go0Hy9jVOtha5leAXKsNJH2QZP2Feq/MvRenS/Z4UKrRdFSZj/mIreIq
         FhJw==
X-Gm-Message-State: AOAM531JGbbcT1h/g/BU3muXIbLFpArVaT+GCMPFBVHeOspCtGWp76PE
        xIeqluvfFNdjVIF9FE46Quk=
X-Google-Smtp-Source: ABdhPJzX0C9+6wsdXVXgAA8p6dmeV/FVO2vSJ0unmNlkGSuRJxFcLmWooXP7NQRZIp1bMzkkTPgiAg==
X-Received: by 2002:aa7:dd98:: with SMTP id g24mr17844222edv.75.1616286540032;
        Sat, 20 Mar 2021 17:29:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z9sm7473007edr.75.2021.03.20.17.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:28:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [RFC/PATCH 7/7] test-lib: generate JUnit output via TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-8-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2103191508280.57@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <nycvar.QRO.7.76.6.2103191508280.57@tvgsbejvaqbjf.bet>
Date:   Sun, 21 Mar 2021 01:28:58 +0100
Message-ID: <875z1lz6wl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 19 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 9 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Rewrite the home-brew JUnit output generation added in
>> 22231908151 (tests: optionally write results as JUnit-style .xml,
>> 2019-01-29) and other subsequent commits to be generated via the TAP
>> output.
>>
>> This is now possible that the TAP output emitted with --tee is
>> guaranteed to be valid TAP, see the preceding commit.
>>
>> The JUnit output is not bug-for-bug compatible with the previous
>> output, but it looks better to me.
>>
>> This also requires installing TAP::Formatter::JUnit[1], perhaps that's
>> not palatable to the users of the --write-junit-xml option.
>
> Indeed. I am trying to keep the dependencies required for the Windows jobs
> of our CI/PR builds to a minimum.

I'm taking this to mean the dependency of the TAP::Formatter::JUnit CPAN
module. Since the tests already depend on Perl, and presumably that Perl
isn't so broken as to not have the built in TAP modules
(e.g. TAP::Parser).

> Note, also, that the JUnit output was mostly relevant for when we used
> Azure Pipelines: it has a specific UI to study test results, figure out
> flaky tests, performance, etc.
>
> Now that we use GitHub Actions, we do not have such a nice test aggregator
> anymore, but we might get one again in the future, who knows.

So there's no known current active user of this JUnit output target, or
at least if such a user exists it's not you anymore?

I'm guessing we'd be unlikely to miss someone targeting JUnit from
git.git's tests who's not on this list to chime in. So is it not used
currently & could be removed?

>> In any case, it'll be easy to whip up our own TAP emitter with a
>> TAP::Parser and TAP::Formatter, both of whom come with perl itself,
>> which we already rely on for tests.
>>
>> It should also be significantly faster on Windows,
>
> I really hate to have to harp on this when talking to you, but... well,
> how can I say it? Perl is _slooooooooooooow_ on Windows.
>
> Like, _really_ slow. Ridiculously slow.
>
> I know, you recently got riled up when Jeff suggested that the Perl hook
> calling FSMonior might be slow, but the truth is: it is super slow. It's
> not even funny how slow it is. And it fills me with no joy having to
> repeat it every time the question comes up whether running any part of Git
> that is written in Perl might affect performance on Windows. I really
> dislike having to be that messenger.

Riled up? No, perplexed: yes. You're referring to
https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/

So as an aside about that particular issue / slowness I haven't been
able to reproduce:

If it's really a reference to some Windows-specific issue with Perl on
Windows in particular that would certainly be helpful for the rest of us
trying to follow along wondering where these wildly different
performance numbers come from.

So not that we don't want to more to some other fsmonitor implementation
for other reasons, but the Perl part of that hook would be rather easy
to replace with some C JSON encoder or whatever.

> I doubt that you will ever be able to replace my (admittedly slightly
> hacky) C helper with anything written in Perl that does even come close to
> being faster.
>
> In other words, I fear that your work here might not have the outcome you
> hoped for.

We shell out to your C helper at least once for every test we run. By
converting the TAP after the full run we're only invoking Perl once
per-test.

If that one Perl invocation is still much more expensive than doing that
~20-50 times per-test we can easily move the loop to the Perl script and
invoke Perl once per test suite run. At that point you've got 1 run
v.s. >20k runs for the current helper being called in a loop by
test-lib.sh

But I don't have access to a Windows test box. So maybe it's slower than
I'm imagining. How long do the equivalent of these take on Windows (not
sure if the time built-in is there)?:
=20=20=20=20
    $ time perl -MTAP::Harness -wE 'say "hello world"'
    hello world
=20=20=20=20
    real    0m0.018s
    user    0m0.013s
    sys     0m0.005s
=20=20=20=20
    $ time (echo hi | helper/test-tool xml-encode)
    hi&#x0a;
    real    0m0.002s
    user    0m0.001s
    sys     0m0.002s


In any case, I regret focusing on the TAP::Formatter::JUnit part in this
RFC. The real meaty part is being able to have stable TAP output, and
thus not having to add N number of output formats into test-lib.sh
itself.

A tool that consumes that can then be e.g. Perl's TAP tooling, or just
some C program or shellscript that calls the code that the below quoted
diff is removing (aside from the test-lib.sh part, which would go away).

But it would be easier to write such tools using Perl's tooling, as it
saves one from writing a parser for TAP.

I'd be surprised if Perl was adding much overhead in that context, and I
see that the existing Windows CI jobs are running through "prove", so
presumably even on Windows e.g. this:

    time make T=3Dt000*.sh DEFAULT_TEST_TARGET=3Dprove

Is not much slower than:

    time make T=3Dt000*.sh DEFAULT_TEST_TARGET=3Dtest

I think this is the Nth time we've had some variant of this "Perl in
git's tests" discussion.

I'm all for finding solutions to whatever issues you have, but I find it
confusing that in these discussions you seem to conflate and jump
between some or all of (just the ones I'm remembering):

 1. Some imagined future state where there's no Perl whatsoever in the
    test suite or git.git's build toolchain, which isn't the case now,
    or anywhere in the forseeable future.

 2. A future state where GFW etc. don't need to ship a Perl to users (I
    believe this is either close or already there, I haven't kept up..)

 3. The slowness of Perl for: tight loops, a few per test, once per test
    suite run.

 4. How #3 e.g. in a tight loop compares to calling say sed or awk in a
    tight shell loop. Is perl uniquely bad on Windows, or is it really a
    gripe about our use of shellscripting in general?

 6. Not wanting to (understandably) package any more non-core Perl
    stuff, understandable, but we always have the option of extending
    perl/FromCPAN/ if we find something truly useful (in this case just
    having a custom JUnit XML emitter, if it's actually needed by anyone
    anymore, should be rather easy).

So e.g. in this case I can guess at some of the gaps and *think* that
some code in t/ that uses TAP::Parser (a perl core module) and was
invoked either once per test-lib.sh invocation, or better (but perhaps
not needed, as it would make it a bit more complex) once per test-suite
run should be fine.

That code could even be implemented as a prove(1) plugin, at which point
we'd be invoking Perl exactly as many times as we are now, but I'd
rather not paint myself into that particular corner without good reason.


>> as we can e.g. write all the *.out files, and only do that conversion at
>> the end for all files in a batch, as opposed to the current
>> implementation of shelling out to test-tool in a loop for each test.
>>
>> 1. https://metacpan.org/pod/distribution/TAP-Formatter-JUnit/script/tap2=
junit
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Makefile                   |   1 -
>>  t/helper/test-date.c       |  12 ----
>>  t/helper/test-path-utils.c |  21 -------
>>  t/helper/test-tool.c       |   1 -
>>  t/helper/test-tool.h       |   1 -
>>  t/helper/test-xml-encode.c |  80 ------------------------
>>  t/test-lib.sh              | 123 ++++---------------------------------
>>  7 files changed, 12 insertions(+), 227 deletions(-)
>>  delete mode 100644 t/helper/test-xml-encode.c
>>
>> diff --git a/Makefile b/Makefile
>> index d26b9d62ee9..fa7c52f7a42 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -748,7 +748,6 @@ TEST_BUILTINS_OBJS +=3D test-urlmatch-normalization.o
>>  TEST_BUILTINS_OBJS +=3D test-wildmatch.o
>>  TEST_BUILTINS_OBJS +=3D test-windows-named-pipe.o
>>  TEST_BUILTINS_OBJS +=3D test-write-cache.o
>> -TEST_BUILTINS_OBJS +=3D test-xml-encode.o
>>
>>  # Do not add more tests here unless they have extra dependencies. Add
>>  # them in TEST_BUILTINS_OBJS above.
>> diff --git a/t/helper/test-date.c b/t/helper/test-date.c
>> index 099eff4f0fc..ebf133943b3 100644
>> --- a/t/helper/test-date.c
>> +++ b/t/helper/test-date.c
>> @@ -8,7 +8,6 @@ static const char *usage_msg =3D "\n"
>>  "  test-tool date parse [date]...\n"
>>  "  test-tool date approxidate [date]...\n"
>>  "  test-tool date timestamp [date]...\n"
>> -"  test-tool date getnanos [start-nanos]\n"
>>  "  test-tool date is64bit\n"
>>  "  test-tool date time_t-is64bit\n";
>>
>> @@ -92,15 +91,6 @@ static void parse_approx_timestamp(const char **argv)
>>  	}
>>  }
>>
>> -static void getnanos(const char **argv)
>> -{
>> -	double seconds =3D getnanotime() / 1.0e9;
>> -
>> -	if (*argv)
>> -		seconds -=3D strtod(*argv, NULL);
>> -	printf("%lf\n", seconds);
>> -}
>> -
>>  int cmd__date(int argc, const char **argv)
>>  {
>>  	const char *x;
>> @@ -120,8 +110,6 @@ int cmd__date(int argc, const char **argv)
>>  		parse_approxidate(argv+1);
>>  	else if (!strcmp(*argv, "timestamp"))
>>  		parse_approx_timestamp(argv+1);
>> -	else if (!strcmp(*argv, "getnanos"))
>> -		getnanos(argv+1);
>>  	else if (!strcmp(*argv, "is64bit"))
>>  		return sizeof(timestamp_t) =3D=3D 8 ? 0 : 1;
>>  	else if (!strcmp(*argv, "time_t-is64bit"))
>> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
>> index 313a153209c..090596ac492 100644
>> --- a/t/helper/test-path-utils.c
>> +++ b/t/helper/test-path-utils.c
>> @@ -407,27 +407,6 @@ int cmd__path_utils(int argc, const char **argv)
>>  		return !!res;
>>  	}
>>
>> -	if (argc =3D=3D 4 && !strcmp(argv[1], "skip-n-bytes")) {
>> -		int fd =3D open(argv[2], O_RDONLY), offset =3D atoi(argv[3]);
>> -		char buffer[65536];
>> -
>> -		if (fd < 0)
>> -			die_errno("could not open '%s'", argv[2]);
>> -		if (lseek(fd, offset, SEEK_SET) < 0)
>> -			die_errno("could not skip %d bytes", offset);
>> -		for (;;) {
>> -			ssize_t count =3D read(fd, buffer, sizeof(buffer));
>> -			if (count < 0)
>> -				die_errno("could not read '%s'", argv[2]);
>> -			if (!count)
>> -				break;
>> -			if (write(1, buffer, count) < 0)
>> -				die_errno("could not write to stdout");
>> -		}
>> -		close(fd);
>> -		return 0;
>> -	}
>> -
>>  	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
>>  		int res =3D 0;
>>  		long offset, stride, i;
>> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
>> index 1876bad8f42..3fa02011b61 100644
>> --- a/t/helper/test-tool.c
>> +++ b/t/helper/test-tool.c
>> @@ -73,7 +73,6 @@ static struct test_cmd cmds[] =3D {
>>  	{ "tee", cmd__tee },
>>  	{ "trace2", cmd__trace2 },
>>  	{ "urlmatch-normalization", cmd__urlmatch_normalization },
>> -	{ "xml-encode", cmd__xml_encode },
>>  	{ "wildmatch", cmd__wildmatch },
>>  #ifdef GIT_WINDOWS_NATIVE
>>  	{ "windows-named-pipe", cmd__windows_named_pipe },
>> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
>> index 9b3c1f75267..5028730807e 100644
>> --- a/t/helper/test-tool.h
>> +++ b/t/helper/test-tool.h
>> @@ -63,7 +63,6 @@ int cmd__subprocess(int argc, const char **argv);
>>  int cmd__tee(int argc, const char **argv);
>>  int cmd__trace2(int argc, const char **argv);
>>  int cmd__urlmatch_normalization(int argc, const char **argv);
>> -int cmd__xml_encode(int argc, const char **argv);
>>  int cmd__wildmatch(int argc, const char **argv);
>>  #ifdef GIT_WINDOWS_NATIVE
>>  int cmd__windows_named_pipe(int argc, const char **argv);
>> diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
>> deleted file mode 100644
>> index a648bbd961c..00000000000
>> --- a/t/helper/test-xml-encode.c
>> +++ /dev/null
>> @@ -1,80 +0,0 @@
>> -#include "test-tool.h"
>> -
>> -static const char *utf8_replace_character =3D "&#xfffd;";
>> -
>> -/*
>> - * Encodes (possibly incorrect) UTF-8 on <stdin> to <stdout>, to be emb=
edded
>> - * in an XML file.
>> - */
>> -int cmd__xml_encode(int argc, const char **argv)
>> -{
>> -	unsigned char buf[1024], tmp[4], *tmp2 =3D NULL;
>> -	ssize_t cur =3D 0, len =3D 1, remaining =3D 0;
>> -	unsigned char ch;
>> -
>> -	for (;;) {
>> -		if (++cur =3D=3D len) {
>> -			len =3D xread(0, buf, sizeof(buf));
>> -			if (!len)
>> -				return 0;
>> -			if (len < 0)
>> -				die_errno("Could not read <stdin>");
>> -			cur =3D 0;
>> -		}
>> -		ch =3D buf[cur];
>> -
>> -		if (tmp2) {
>> -			if ((ch & 0xc0) !=3D 0x80) {
>> -				fputs(utf8_replace_character, stdout);
>> -				tmp2 =3D NULL;
>> -				cur--;
>> -				continue;
>> -			}
>> -			*tmp2 =3D ch;
>> -			tmp2++;
>> -			if (--remaining =3D=3D 0) {
>> -				fwrite(tmp, tmp2 - tmp, 1, stdout);
>> -				tmp2 =3D NULL;
>> -			}
>> -			continue;
>> -		}
>> -
>> -		if (!(ch & 0x80)) {
>> -			/* 0xxxxxxx */
>> -			if (ch =3D=3D '&')
>> -				fputs("&amp;", stdout);
>> -			else if (ch =3D=3D '\'')
>> -				fputs("&apos;", stdout);
>> -			else if (ch =3D=3D '"')
>> -				fputs("&quot;", stdout);
>> -			else if (ch =3D=3D '<')
>> -				fputs("&lt;", stdout);
>> -			else if (ch =3D=3D '>')
>> -				fputs("&gt;", stdout);
>> -			else if (ch >=3D 0x20)
>> -				fputc(ch, stdout);
>> -			else if (ch =3D=3D 0x09 || ch =3D=3D 0x0a || ch =3D=3D 0x0d)
>> -				fprintf(stdout, "&#x%02x;", ch);
>> -			else
>> -				fputs(utf8_replace_character, stdout);
>> -		} else if ((ch & 0xe0) =3D=3D 0xc0) {
>> -			/* 110XXXXx 10xxxxxx */
>> -			tmp[0] =3D ch;
>> -			remaining =3D 1;
>> -			tmp2 =3D tmp + 1;
>> -		} else if ((ch & 0xf0) =3D=3D 0xe0) {
>> -			/* 1110XXXX 10Xxxxxx 10xxxxxx */
>> -			tmp[0] =3D ch;
>> -			remaining =3D 2;
>> -			tmp2 =3D tmp + 1;
>> -		} else if ((ch & 0xf8) =3D=3D 0xf0) {
>> -			/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
>> -			tmp[0] =3D ch;
>> -			remaining =3D 3;
>> -			tmp2 =3D tmp + 1;
>> -		} else
>> -			fputs(utf8_replace_character, stdout);
>> -	}
>> -
>> -	return 0;
>> -}
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 0070d05234b..4dc41eeccc2 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -371,6 +371,17 @@ then
>>  		--escape-stdout ${HARNESS_ACTIVE+--escape-file} \
>>  		"$GIT_TEST_TEE_OUTPUT_FILE"
>>  	test "$(cat "$TEST_RESULTS_BASE.exit")" =3D 0
>> +	if test -n "$write_junit_xml"
>> +	then
>> +		junit_xml_dir=3D"$TEST_OUTPUT_DIRECTORY/out"
>> +		mkdir -p "$junit_xml_dir"
>> +		junit_xml_base=3D${0##*/}
>> +		junit_xml_path=3D"$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
>> +		junit_attrs=3D"timestamp=3D\"$(TZ=3DUTC date +%Y-%m-%dT%H:%M:%S)\""
>> +		tap2junit --name=3D"$TEST_NAME" - \
>> +			<"$GIT_TEST_TEE_OUTPUT_FILE" \
>> +			>"$junit_xml_path"
>> +	fi
>>  	exit
>>  elif test -n "$verbose" -a -n "$HARNESS_ACTIVE"
>>  then
>> @@ -588,7 +599,6 @@ export TERM
>>
>>  error () {
>>  	say_color error "error: $*"
>> -	finalize_junit_xml
>>  	GIT_EXIT_OK=3Dt
>>  	exit 1
>>  }
>> @@ -672,56 +682,24 @@ trap '{ code=3D$?; set +x; } 2>/dev/null; exit $co=
de' INT TERM HUP
>>  # the test_expect_* functions instead.
>>
>>  test_ok_ () {
>> -	if test -n "$write_junit_xml"
>> -	then
>> -		write_junit_xml_testcase "$*"
>> -	fi
>>  	test_success=3D$(($test_success + 1))
>>  	say_color_tap "${verbose:+pass}" "ok $test_count - $@"
>>  }
>>
>>  test_failure_ () {
>> -	if test -n "$write_junit_xml"
>> -	then
>> -		junit_insert=3D"<failure message=3D\"not ok $test_count -"
>> -		junit_insert=3D"$junit_insert $(xml_attr_encode "$1")\">"
>> -		junit_insert=3D"$junit_insert $(xml_attr_encode \
>> -			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
>> -			   then
>> -				test-tool path-utils skip-n-bytes \
>> -					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
>> -			   else
>> -				printf '%s\n' "$@" | sed 1d
>> -			   fi)")"
>> -		junit_insert=3D"$junit_insert</failure>"
>> -		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
>> -		then
>> -			junit_insert=3D"$junit_insert<system-err>$(xml_attr_encode \
>> -				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
>> -		fi
>> -		write_junit_xml_testcase "$1" "      $junit_insert"
>> -	fi
>>  	test_failure=3D$(($test_failure + 1))
>>  	say_color_tap error "not ok $test_count - $1"
>>  	shift
>>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
>> -	test "$immediate" =3D "" || { finalize_junit_xml; GIT_EXIT_OK=3Dt; exi=
t 1; }
>> +	test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
>>  }
>>
>>  test_known_broken_ok_ () {
>> -	if test -n "$write_junit_xml"
>> -	then
>> -		write_junit_xml_testcase "$* (breakage fixed)"
>> -	fi
>>  	test_fixed=3D$(($test_fixed+1))
>>  	say_color error "ok $test_count - $@ # TODO known breakage vanished"
>>  }
>>
>>  test_known_broken_failure_ () {
>> -	if test -n "$write_junit_xml"
>> -	then
>> -		write_junit_xml_testcase "$* (known breakage)"
>> -	fi
>>  	test_broken=3D$(($test_broken+1))
>>  	say_color_tap warn "not ok $test_count - $@ # TODO known breakage"
>>  }
>> @@ -983,10 +961,6 @@ test_start_ () {
>>  	test_count=3D$(($test_count+1))
>>  	maybe_setup_verbose
>>  	maybe_setup_valgrind
>> -	if test -n "$write_junit_xml"
>> -	then
>> -		junit_start=3D$(test-tool date getnanos)
>> -	fi
>>  }
>>
>>  test_finish_ () {
>> @@ -1029,13 +1003,6 @@ test_skip () {
>>
>>  	case "$to_skip" in
>>  	t)
>> -		if test -n "$write_junit_xml"
>> -		then
>> -			message=3D"$(xml_attr_encode "$skipped_reason")"
>> -			write_junit_xml_testcase "$1" \
>> -				"      <skipped message=3D\"$message\" />"
>> -		fi
>> -
>>  		say_color_tap skip "ok $test_count # skip $1 ($skipped_reason)"
>>  		: true
>>  		;;
>> @@ -1050,53 +1017,6 @@ test_at_end_hook_ () {
>>  	:
>>  }
>>
>> -write_junit_xml () {
>> -	case "$1" in
>> -	--truncate)
>> -		>"$junit_xml_path"
>> -		junit_have_testcase=3D
>> -		shift
>> -		;;
>> -	esac
>> -	printf '%s\n' "$@" >>"$junit_xml_path"
>> -}
>> -
>> -xml_attr_encode () {
>> -	printf '%s\n' "$@" | test-tool xml-encode
>> -}
>> -
>> -write_junit_xml_testcase () {
>> -	junit_attrs=3D"name=3D\"$(xml_attr_encode "$this_test.$test_count $1")=
\""
>> -	shift
>> -	junit_attrs=3D"$junit_attrs classname=3D\"$this_test\""
>> -	junit_attrs=3D"$junit_attrs time=3D\"$(test-tool \
>> -		date getnanos $junit_start)\""
>> -	write_junit_xml "$(printf '%s\n' \
>> -		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
>> -	junit_have_testcase=3Dt
>> -}
>> -
>> -finalize_junit_xml () {
>> -	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
>> -	then
>> -		test -n "$junit_have_testcase" || {
>> -			junit_start=3D$(test-tool date getnanos)
>> -			write_junit_xml_testcase "all tests skipped"
>> -		}
>> -
>> -		# adjust the overall time
>> -		junit_time=3D$(test-tool date getnanos $junit_suite_start)
>> -		sed -e "s/\(<testsuite.*\) time=3D\"[^\"]*\"/\1/" \
>> -			-e "s/<testsuite [^>]*/& time=3D\"$junit_time\"/" \
>> -			-e '/^ *<\/testsuite/d' \
>> -			<"$junit_xml_path" >"$junit_xml_path.new"
>> -		mv "$junit_xml_path.new" "$junit_xml_path"
>> -
>> -		write_junit_xml "  </testsuite>" "</testsuites>"
>> -		write_junit_xml=3D
>> -	fi
>> -}
>> -
>>  test_atexit_cleanup=3D:
>>  test_atexit_handler () {
>>  	# In a succeeding test script 'test_atexit_handler' is invoked
>> @@ -1119,8 +1039,6 @@ test_done () {
>>  	# removed, so the commands can access pidfiles and socket files.
>>  	test_atexit_handler
>>
>> -	finalize_junit_xml
>> -
>>  	if test -z "$HARNESS_ACTIVE"
>>  	then
>>  		mkdir -p "$TEST_RESULTS_DIR"
>> @@ -1364,23 +1282,6 @@ then
>>  	test_done
>>  fi
>>
>> -if test -n "$write_junit_xml"
>> -then
>> -	junit_xml_dir=3D"$TEST_OUTPUT_DIRECTORY/out"
>> -	mkdir -p "$junit_xml_dir"
>> -	junit_xml_base=3D${0##*/}
>> -	junit_xml_path=3D"$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
>> -	junit_attrs=3D"name=3D\"${junit_xml_base%.sh}\""
>> -	junit_attrs=3D"$junit_attrs timestamp=3D\"$(TZ=3DUTC \
>> -		date +%Y-%m-%dT%H:%M:%S)\""
>> -	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
>> -	junit_suite_start=3D$(test-tool date getnanos)
>> -	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
>> -	then
>> -		GIT_TEST_TEE_OFFSET=3D0
>> -	fi
>> -fi
>> -
>>  # Convenience
>>  # A regexp to match 5, 35 and 40 hexdigits
>>  _x05=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>> --
>> 2.31.0.rc1.210.g0f8085a843c
>>
>>

