Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87077C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 13:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhK3NQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbhK3NQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 08:16:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B6C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:13:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so86778738edc.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CspKJj4kB16KAxaacjNjY5INhc5gcMJKHP+9bzM/RYk=;
        b=VdOXF+OnnFqBuofzcKJYn4FRe6OBsZCirigKe7JwhmocUeTNp153+6y/9hjeplJtZH
         vYxgAD2B+TnWssfQrUp7XAiGNw5EqGYsp5sdOmxXq+Xr9+jJQ3F+5wfAqsBQo3WZsN5L
         v2pznEkCD20/6S4QRvUJg6ZUhiZA3bNLpG8eRDjC/ABvKl7a824q4pXUiL/ooIsQQZPV
         aZsFCwdbXvij5FMnrLnPWIWr5PE1gCsCPMeE16KDcxBBtkCBVm0PYLC5qTBwIYsYRx1f
         QwZ5KJi82VjbykKXylLfp2XsNNE+A4K21H2166pDEr+ky98TjwRYCUcbhAc+54F/SlW3
         ceMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CspKJj4kB16KAxaacjNjY5INhc5gcMJKHP+9bzM/RYk=;
        b=1eq/4diVDBhyFBmYlvAaS0iQE39KHnToIx8qCKgt6mloUjY4/c1KmI6iI6bC/02EKQ
         jYuHzukBKV6rQwJbP81X0k9pdzUsZ95d7Tx8J0Mcood5SahU4yfCMldpnt0uy3vJph2z
         EazuM3BGBfFOiWQ4B5i8KDNAS/Z+6Vddg6Myqamgc97XECRDTbLSvMOc+2SiOLRK8mif
         2zdwb8vQYHxMT5F9rfrQIk6gELi78yRb+t2I+XQpg1X9YN7YfYoAyuuZIEfNpSX9cG5Y
         qTRv1KO6RPWY/B0LTkYOqF3qT6OcGTbxgQq5WGaspLCD8PgknfQC31vYw4G04qkIfHKk
         pW4w==
X-Gm-Message-State: AOAM5319Lx03Wyj/dfEAEbGNyqnODqDeUuF1t3rDVYwoaSMFBzYvoxYY
        54oddfnm2JKkLNEWPNLvhNpvJkvw54mqSQ==
X-Google-Smtp-Source: ABdhPJxP/cS7clFIes4YH+S2k3ccqwo8y5+CovaRCFvaO7SGtW14C9BH0GHqU9J44R0TzgpfKqLAOg==
X-Received: by 2002:aa7:c2c6:: with SMTP id m6mr80522383edp.42.1638277990858;
        Tue, 30 Nov 2021 05:13:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb28sm9596982ejc.93.2021.11.30.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:13:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms2wX-000zhb-Q3;
        Tue, 30 Nov 2021 14:13:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
Date:   Tue, 30 Nov 2021 13:16:37 +0100
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
 <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
Message-ID: <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Johannes Schindelin via GitGitGadget wrote:

> [...]
>  * The rebase on top of v2.34.0, which changed the default merge strategy=
 to
>    ORT, should have changed the default for merge.renames to true. This is
>    now the case.
>  * Accommodate preemptively for ab/ci-updates which invalidates assumptio=
ns
>    made by this patch series that would still hold true with v2.34.0 but =
are
>    no longer valid in seen and would trigger CI build breakages.
> [...]
>   1:  3a2e28275f1 =3D  1:  3a2e28275f1 scalar: add a README with a roadmap
>   2:  50160d61a41 =3D  2:  50160d61a41 scalar: create a rudimentary execu=
table
>   3:  74cd6410931 =3D  3:  74cd6410931 scalar: start documenting the comm=
and
>   4:  37231a4dd07 =3D  4:  37231a4dd07 scalar: create test infrastructure
>   5:  a39b9c81214 =3D  5:  a39b9c81214 cmake: optionally build `scalar`, =
too
>   6:  8e3542e43f7 !  6:  8c6762def30 ci: also run the `scalar` tests
>      @@ .github/workflows/main.yml: jobs:
>            - name: upload tracked files and build artifacts
>=20=20=20=20=20=20=20
>        ## ci/run-build-and-tests.sh ##
>      -@@ ci/run-build-and-tests.sh: linux-gcc-4.8|pedantic)
>      - 	make test
>      - 	;;
>      - esac
>      -+make -C contrib/scalar test
>      +@@ ci/run-build-and-tests.sh: esac
>=20=20=20=20=20=20=20=20
>        check_unignored_build_artifacts
>=20=20=20=20=20=20=20=20
>      ++make && make -C contrib/scalar test
>      ++
>      + save_good_tree

This gets rid of the hard CI failure we saw in "seen" but still carries
forward the logic error noted in [1] and of the "pedantic"
compilation-only job now running tests, which isn't what that job is
supposed to be doing.

See the "Don't run the tests" comment in cebead1ebfb (ci: run a pedantic
build as part of the GitHub workflow, 2021-08-08). As noted before you
can see that at the tail-end of your own CI output[2] on top of
"master".

There's other seemingly unintended interactions with the ci/ code on
"master" here (which I also also noted in previous threads). FWIW the
na=C3=AFve merge with ab/ci-updates happens to fix at least one of
those. I.e. the issue here of "linux-gcc" and "linux-clang" only running
the scalar tests in one half of their test modes, but running everything
else in both.

I think it's clear from past exchanges that you vehemently disagree with
my proposed direction for solving these and other issues in one fell
swoop[3], which is fair enough.

But I really don't think it's OK to continue to ignore reports from me
of specific issues in this series just because you don't like that
larger set of fixes [3].

I honestly don't care if you'd pick that up as-is, just as long as
outstanding issues it addressed are either fixed, or commit
messages/docs are updated to note that the bugs/behavior changes are
intentional.

In this case I think it would be fine to keep the patch as-is and have
the commit message argue for why the scalar tests should be a special
snowflake in being the only tests that are run in "pedantic".

Or to just fix the seemingly unintentional behavior change in some
smaller way. I think the "added thusly" comment I hade in [4] should be
the easiest way to do that (well, [3] is easier, but let's leave that
aside...).

1. https://lore.kernel.org/git/211122.86ee78yxts.gmgdl@evledraar.gmail.com/
2. https://github.com/gitgitgadget/git/runs/4292915519?check_suite_focus=3D=
true
3. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avara=
b@gmail.com/
4. https://lore.kernel.org/git/211123.86ilwjujmd.gmgdl@evledraar.gmail.com/
