Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EDC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjEBSLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjEBSLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:11:18 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B2310E7
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:11:13 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-54ca51db4fdso877309eaf.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683051072; x=1685643072;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZkryy9TZaDqlKn96JsRks9+KC+TUVgRk809yLk9Mao=;
        b=eGbH4faTIwJgXvdFbSX4WvyhbSGZi5zDEtCrh08mcQv2ds3Jecg30byD6kYbLUrnkA
         hQf7r29R0ZoD2xLT6AGyxh7pM+302FuJHDYYc12lpKVAd7uIt0692JYz2GyCGDiwF0Cu
         tcJLVFFtrug/gYzMzfT7IcEDxtfb1S/my1VKCRfWgkU7IL/ImCFXv94Fv9YJXfz+uYxy
         zT+WUhjG0QSdYNLjmDzVKZNcV1KxQ3GJIPgTINQ4mUpcrR9pZYJFe0t3/viYB9unXJ9+
         O2jZenJnTv6xhIH7nEhK+aAdZPeD5Vv9ni2N++1QchXtJoxd+f2HjlbzKhWc6lOV3Dpz
         7rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683051072; x=1685643072;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZkryy9TZaDqlKn96JsRks9+KC+TUVgRk809yLk9Mao=;
        b=Z8eUuZR7n8deoYfbmWpIFpqq5wpOjHtj0rDO2W47S9Wth+6aXiv83WfvWahiZTRCYv
         rdCTyWXnJELYvY42wKYy6C81VAzBWbW5k6+URmAOLXKJ+vXGxtT62//vN739SaNxBUKU
         0Eiopm9wfJtGXSqsNwCtCg73EWmPehEn+WK7PyGlbc0rdjl7HShGbxlubips413XiT8C
         jt7AOHMOFSuVAuGJ4LE8CQ3NPqjI4Jg5twQS2/etmDSoKyfPxKw4ZuAIkF6vTCKzS0rl
         gPjTHGc8Xle5u4MKj0ugMxpa3030KXw26blaXER+1XlxFjN9OxaN24fcuj0jU8xJTbBc
         WtfA==
X-Gm-Message-State: AC+VfDyFRdjgPlnDL0KC3VCRFSuM1LGhmgF+ocPMVNCMfUxs12aHK/KO
        15eVZvLbEl2jMLuQc6UJuBA0Xt0OSS4=
X-Google-Smtp-Source: ACHHUZ7fVgwc7lx9qF1rO5ibUEo+ziCEI89DfXCoAZ0fLVOEjcf75l46auc/9DVZ5Heqjng+ItaWtA==
X-Received: by 2002:a4a:bb8f:0:b0:545:8efc:190c with SMTP id h15-20020a4abb8f000000b005458efc190cmr8806552oop.8.1683051072431;
        Tue, 02 May 2023 11:11:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h9-20020a4ac449000000b0054248efdd67sm1306942ooq.29.2023.05.02.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:11:11 -0700 (PDT)
Date:   Tue, 02 May 2023 12:11:10 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Message-ID: <6451523ec8b47_1ba2d29427@chronos.notmuch>
In-Reply-To: <230502.86sfcehecl.gmgdl@evledraar.gmail.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <6451324ed84e2_1ba2d29454@chronos.notmuch>
 <230502.86sfcehecl.gmgdl@evledraar.gmail.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, May 02 2023, Felipe Contreras wrote:
> =

> > Phillip Wood wrote:
> >
> >> Unfortunately this library doesn't seem to offer any of those featur=
es. =

> >> It does support a lazy test plan but uses atexit() so will not detec=
t if =

> >> the test program exits before all the tests have run.
> >
> > I think there's a fundamental misunderstanding of how we use TAP.
> >
> > If a program generates this output:
> >
> >   1..3
> >   ok 1 - test 1
> >   ok 2 - test 2
> >
> > That's clearly not complete. It shouldn't be the job a test script to=
 check for
> > those cases.
> >
> > If you run the programm through a TAP harness such as prove, you get:=

> >
> >   foo.t .. Failed 1/3 subtests =

> >
> >   Test Summary Report
> >   -------------------
> >   foo.t (Wstat: 0 Tests: 2 Failed: 0)
> >     Parse errors: Bad plan.  You planned 3 tests but ran 2.
> >   Files=3D1, Tests=3D2,  0 wallclock secs ( 0.01 usr +  0.00 sys =3D =
 0.01 CPU)
> >   Result: FAIL
> >
> > Why do we bother generaing a TAP output if we are not going to take a=
dvantage
> > of it?
> =

> (As the person who added the TAP output to git.git)
> =

> Yeah, we could do the "plan ahead", but it would mean that tests would
> need to pre-declare the number of tests they have.

I'm not advocating for planning ahead.

In the case of the shell testing framework it makes sense to not plan
ahead and just print the test plan at the end with test_done(), as
that's very convenient.

But $subject is a new proposal for C unit tests with a test plan
specified ahead, therefore if the program exits before all the tests
have run, that should be obvious from the output. I'm not saying that is
good or desirable, merely that it is the case.

I personaly don't even think C is the way to write unit tests.

> In the Perl world that's the usual pattern, but as it involves having a=
:
> =

> 	plan tests =3D> 123;
> =

> At the top of the file that's guaranteed to give you merge conflicts if=

> two topics add/remove tests in different parts of the file.
> =

> It also doesn't work well in cases where the number of tests is hard to=

> determine in advance, i.e. when they're determined programatically.
> =

> I don't think there's any practical downside to using the "test_done"
> pattern to print a plan at the end as far as missing tests go.
> =

> There *is* a minor practical downside to it though, which is that we'll=

> get output like "25/?" or whatever, but not "25/100", as we don't know
> yet that we've got a total of 100 tests.
> =

> But I think that's a minor drawback, and really only matters if you're
> eyeballing the prove(1) output of a very slow test as it scrolls by.
> =

> I think on balance the "plan at the end" approach we're using now is
> much better, and would also be better in a future (or hypothetical)
> pure-C test framework.
>
> Well, there are ways to avoid the painful conflicts, e.g. by mandating
> that all tests are driven by callbacks in an array or something, so the=
n
> you won't get merge conflicts on the "plan" line, as it'll just be "the=

> number of tests is the number of items in this array".
> =

> But such a thing is painful to mandate, and has its own drawbacks,
> i.e. not being able to do a "test" at anything less than a function
> callback level of granularity.

If you are using an old-school language that doesn't have support for
anonymous functions, then yes, that is pretty much your only nice
maintenable option.

But the list of languages that don't have support for that is rather
small, it's pretty much limited to shell, C, Fortran and COBOL. Even
Perl has support for anonymous functions.

In all modern languages you can write test cases using anonymous
functions such as (JavaScript's ava [1]):

  test('test case', t =3D> {
    t.is('actual', 'expected');
  });

This can be done in Perl as well (see Test::Functional [2]).

So at the end of the script it is known how many test cases there are
*before* running any of them.

This is precisely the approach I followed in my new testing framework,
which I sent as a proposal to the ml [3].

  require 'testox'

  test('one') { ok(true) }
  test('two') { ok(true) }
  test('three') { ok(true) }
  test('four') { ok(true) }

  puts '# num tests: %s' % TestOx.tests.length

No test case is run until the script ends in at_exit:

  # num tests: 4
  1..4
  ok 1 - one
  ok 2 - two
  ok 3 - three
  ok 4 - four

There's no need to specify the number of test cases.

I don't see why we insist in using ancient languages like C and shell
for things that neither C nor shell are good at. Other languages exist
in 2023. Other languages exist for a reason.

Cheers.

[1] https://github.com/avajs/ava
[2] https://metacpan.org/pod/Test::Functional
[3] https://lore.kernel.org/git/20230502041113.103385-1-felipe.contreras@=
gmail.com/T/#t

-- =

Felipe Contreras=
