Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9163FC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C2060EBD
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhKDKWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhKDKWS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:22:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD40C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 03:19:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g14so19468614edz.2
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iaaqeqSAnZYpmI0d986qfq/iCQwo3Ey6eJsCRFXn1Ak=;
        b=ImhT+POwhyYykurdYVL6C9KdSmrZriKdLEleB4RO7gX4NOy4eBk+/NdIQpb1i/9JuE
         LVD98aQYD8mzFsjPHfN3rzt1pr6nrEhCwBoyjnuVq/iXtBmVyMGBpA29TcW8+uKz47sh
         62qoiJDey6p/4dI2B1cqz8+PUNlvYAzbzkBZmgD7JGbjsoAcFLdRfvyZV4anPT9fpkQy
         1ghW7WodXkJtGI7y3xDQvAEU5IIMGEpArG11tDq73dUhW77pmtJ7mAfXMgl3HtWy00AN
         4XEnirwLvgFtoaGklfDVJio1uNFIUUpCW3vDK7HZ47QkG015lQOkwxPHm72sYoYUxhF0
         wfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iaaqeqSAnZYpmI0d986qfq/iCQwo3Ey6eJsCRFXn1Ak=;
        b=gHhzRZ56Chlsv7QkYugtHf4anHV9lu02RhltyhzIEMktf9pBGpIZRo6LoQX+tr2Dqz
         HoIZ2fXhui+kdKObdJbYqQ7fN2s5NXQD7EN4J7SdCRuRAAsZV8zqJe+/hRM+iDf6xrBU
         M/StroujAcJgqHdQzojUHEllqgebdWR440xReHCu+kQoqIS/mAW290BAde8aH4nTEOkl
         I7YDWsw89jxq9GEv3s+DDslp+YarUS+hDotbIwJsrJhnWWGEmfCxHuvMpGSsf9dEabMO
         eq+Yfwu23JTa/pvOKXQLctHlV/i7mltNz7f+Vm9+hax1y0eCmAmnqiFYK0GPlRuT0HbA
         yExw==
X-Gm-Message-State: AOAM5328f4qbK6IgsteXZK0+5KcOWTLdjXIvhhjTR7bmbncObv27vP3G
        nyxqVHLgo/8qfyCsxU3p0yM=
X-Google-Smtp-Source: ABdhPJzVRL2XpGsM53Gwv0DzHA41ZZqAiNLC8TwLt+LCzHmMGCAyGPhYjnVvdWsVcBuQqQngcnGVsQ==
X-Received: by 2002:a17:907:3e85:: with SMTP id hs5mr61509376ejc.234.1636021179344;
        Thu, 04 Nov 2021 03:19:39 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb2sm2436311ejc.52.2021.11.04.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 03:19:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miZqM-0007PG-8x;
        Thu, 04 Nov 2021 11:19:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: Re* [PATCH v8 2/2] tests: add a test mode for SANITIZE=leak,
 run it in CI
Date:   Thu, 04 Nov 2021 11:06:15 +0100
References: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
 <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
 <patch-v8-2.2-90ecd49c910-20210923T091819Z-avarab@gmail.com>
 <xmqq4k8s6eri.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq4k8s6eri.fsf_-_@gitster.g>
Message-ID: <211104.86mtmki5ol.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 03 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue test
>> mode. When running in that mode, we'll assert that we were compiled
>> with SANITIZE=3Dleak. We'll then skip all tests, except those that we've
>> opted-in by setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>> ...
>> This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=3Dtrue" will
>> be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue:
>
> I've been playing with this locally, but cannot shake the nagging
> feeling that GIT_TEST_PASSING_SANITIZE_LEAK must default to true.
> Otherwise, it is one more thing they need to find out and set when
> they do
>
>     make SANITYZE=3Dleak test
>
> because they want to be a good developer and to ensure that they did
> not introduce new leaks.
>
> If we want to encourage folks to locally run the leak checks before
> declaring their own work "done", that is.
>
> Those who are hunting for and cleaning up existing leaks can and
> should set it to false, no?

I agree that that would make a lot more sense and be more useful :)

That was the behavior of the patch I originally suggested for
integrating this SANITIZE=3Dleak[1], but due to feedback on it I ended up
keeping the pre-image behavior of how SANITIZE=3Dleak worked, unless there
were any opt-in test modes etc. in play:
https://lore.kernel.org/git/patch-1.4-a61a294132-20210714T001007Z-avarab@gm=
ail.com/

I think at this point it's probably better to just keep it as it is...

> in any case, here is a small fallout out of my adventure into this
> corner.
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: t0006: date_mode can leak .strftime_fmt member
>
> As there is no date_mode_release() API function, and given the
> set of current callers it probably is not worth adding one, let's
> release the .strftime_fmt member that is obtained from strdup()
> before the caller of show_date() is done with it.
>
> This allows us to mark t0006 as passing under the leak sanitizer.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/helper/test-date.c | 2 ++
>  t/t0006-date.sh      | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git c/t/helper/test-date.c w/t/helper/test-date.c
> index 099eff4f0f..e15ea02626 100644
> --- c/t/helper/test-date.c
> +++ w/t/helper/test-date.c
> @@ -53,6 +53,8 @@ static void show_dates(const char **argv, const char *f=
ormat)
>=20=20
>  		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
>  	}
> +
> +	free((void *)mode.strftime_fmt);
>  }

I'd notice that failure before, but hadn't looked into it. That was
easier to fix than I thought.

This fix looks good to me, except that you also need to change this at
the top:

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index e15ea026267..9defeb57360 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -34,7 +34,7 @@ static void show_human_dates(const char **argv)
=20
 static void show_dates(const char **argv, const char *format)
 {
-       struct date_mode mode;
+       struct date_mode mode =3D { 0 };
=20
        parse_date_format(format, &mode);
        for (; *argv; argv++) {

I.e. this makes this specific thing pass, but in other tests we'd end up
freeing a non-NULL and randomly initialized pointer unless we init it to
zero.

>=20=20
>  static void parse_dates(const char **argv)
> diff --git c/t/t0006-date.sh w/t/t0006-date.sh
> index 6b757d7169..5d01f57b27 100755
> --- c/t/t0006-date.sh
> +++ w/t/t0006-date.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>=20=20
>  test_description=3D'test date parsing and printing'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>=20=20
>  # arbitrary reference time: 2009-08-30 19:20:00

And yeah, that's all that's needed in the test file then.
