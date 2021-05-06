Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3EC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACFF613BA
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhEFPf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhEFPeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:34:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67EC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:33:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so8917060ejj.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uD1PrAkISkAG5EnFYM8Xd/dYvSArhV5f/I8mEGbjnKk=;
        b=qR8QZCRBlL2gWkw7MaDGS6RSTxD170952/+rakOlCi0YeDe7ftLneX65fAPZD/HvNT
         nIariuGAsOHF9bJql9OpxzuQkVvm6ZZUY2pTXBZlg0L4aYWtpCCAvgkpIeUsGTv9+e+x
         TfphAtphBzdQe72cm7Dg3WZs8m3stB2SbWU0tuWeZhYJPkqw/LKPfY/uOm0evOYFnMxg
         hEJuNhD0/m66goTHCXMSCV8i839KF7vntUx1jv5LUZtGb9cuNPfbi9XxlZzMjsyd7Iez
         /UBbt0eka3TEX1EySU8xi7dFoapwjcbPzn+vz3HbDnY58mls0jvgENhKwS5h2l/1yg/n
         DMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uD1PrAkISkAG5EnFYM8Xd/dYvSArhV5f/I8mEGbjnKk=;
        b=U0IMNcm+ODiQ1m5y5xQRJ9Huq1Tpe46gFbZwb6gF3u7f79pJZuxybVUQ5TFobZclN2
         Vv1RoRtydujYM3f6UPJEgw98CVUo3sQH5XViCEolMt4YzStCKaS1CP8JKM1r380vqVpk
         exdysmlkPU8omSrub1lHU/xAO2KHvUPJyN2phshQNR+5c1h2K5ld8+IhwjpmoAycPzLf
         CuLf6PxIUj7n+mr+yJwCuUn+2T4tUZixEM5iv0nnlj0XCJdnP4POSRPhtsFO1dwTpYjH
         X8h8lCTu55JOY/82WsbehM86gtvZBPiUTw57AFtXgM0BQoH4k6wBe6AJw6NsVwgLnx3y
         YH3g==
X-Gm-Message-State: AOAM530768bekN8lsLeNFbI1DH3xk19EuDquE8wsoe4gpYGfimUqUM3K
        4sul9oolbOu3nPfqwK1GxS5pHtzyXveW3A==
X-Google-Smtp-Source: ABdhPJzfzscOduAwTUR0z+nDCaw2y5n3qFxdna3/SHBBJ8aMqRzfjOgSUj/jvj8sN48J7kJkTHiy1w==
X-Received: by 2002:a17:906:7f97:: with SMTP id f23mr5353142ejr.74.1620315223587;
        Thu, 06 May 2021 08:33:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g9sm1562894ejo.8.2021.05.06.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:33:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 00/11] test-lib.sh: new test_commit args,
 simplification & fixes
Date:   Thu, 06 May 2021 17:32:01 +0200
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
Message-ID: <87eeejvpuy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Changes since v4: Only a commit message change/re-wording per
> <87v98e1oj7.fsf@evledraar.gmail.com>.

SZEDER, Eric, =C4=90o=C3=A0n et al: does this v5 look good to you? Junio's
suggested in [1] that this needs some final review feedback before
advancing to 'next'. If you could take a look that would be great!

1. https://lore.kernel.org/git/xmqqsg30zdql.fsf@gitster.g/

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (11):
>   test-lib: bring $remove_trash out of retirement
>   test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>   test-lib-functions: reword "test_commit --append" docs
>   test-lib-functions: document test_commit --no-tag
>   test-lib functions: add an --annotated option to "test_commit"
>   describe tests: convert setup to use test_commit
>   test-lib functions: add --printf option to test_commit
>   submodule tests: use symbolic-ref --short to discover branch name
>   test-lib: reformat argument list in test_create_repo()
>   test-lib: do not show advice about init.defaultBranch under --verbose
>   test-lib: split up and deprecate test_create_repo()
>
>  t/lib-submodule-update.sh           |  3 +-
>  t/t0000-basic.sh                    |  4 --
>  t/t1307-config-blob.sh              |  4 +-
>  t/t1403-show-ref.sh                 |  6 +--
>  t/t2030-unresolve-info.sh           |  3 +-
>  t/t4006-diff-mode.sh                |  6 +--
>  t/t4030-diff-textconv.sh            |  8 +---
>  t/t5406-remote-rejects.sh           |  1 -
>  t/t5407-post-rewrite-hook.sh        |  2 -
>  t/t5409-colorize-remote-messages.sh |  1 -
>  t/t5520-pull.sh                     | 10 +----
>  t/t6120-describe.sh                 | 58 +++++++---------------------
>  t/test-lib-functions.sh             | 60 ++++++++++++++++++-----------
>  t/test-lib.sh                       | 40 +++++++++++--------
>  14 files changed, 87 insertions(+), 119 deletions(-)
>
> Range-diff against v4:
>  1:  a76ea749bb6 =3D  1:  75667f98f3a test-lib: bring $remove_trash out o=
f retirement
>  2:  de7be7844ea =3D  2:  55c9413f9cd test-lib tests: remove dead GIT_TES=
T_FRAMEWORK_SELFTEST variable
>  3:  709bc773fb0 =3D  3:  361e34654e9 test-lib-functions: reword "test_co=
mmit --append" docs
>  4:  b67654334e6 =3D  4:  2db68a4ac7c test-lib-functions: document test_c=
ommit --no-tag
>  5:  3a166c92063 =3D  5:  4ceba3d404b test-lib functions: add an --annota=
ted option to "test_commit"
>  6:  981fc43ee69 =3D  6:  589eaf7a078 describe tests: convert setup to us=
e test_commit
>  7:  15057cdecfe =3D  7:  a0fe0640148 test-lib functions: add --printf op=
tion to test_commit
>  8:  5d437f53ec8 =3D  8:  7fb8849ce66 submodule tests: use symbolic-ref -=
-short to discover branch name
>  9:  9ee13ee71bc =3D  9:  f67245ba40d test-lib: reformat argument list in=
 test_create_repo()
> 10:  6ba568df9f4 =3D 10:  37338c88300 test-lib: do not show advice about =
init.defaultBranch under --verbose
> 11:  311a9dba36b ! 11:  7793311e5f1 test-lib: split up and deprecate test=
_create_repo()
>     @@ Commit message
>              from "mkdir .git/hooks" changes various tests needed to re-s=
etup
>              that directory. Now they no longer do.
>=20=20=20=20=20=20
>     -     5. Since we don't need to move the .git/hooks directory we don'=
t need
>     -        the subshell here either.
>     -
>     -        See 0d314ce834 for when the subshell use got introduced for =
the
>     -        convenience of not having to "cd" back and forth while setti=
ng up
>     -        the hooks.
>     +        This makes us implicitly depend on the default hooks being
>     +        disabled, which is a good thing. If and when we'd have any
>     +        on-by-default hooks (I see no reason we ever would) we'd wan=
t to
>     +        see the subtle and not so subtle ways that would break the t=
est
>     +        suite.
>     +
>     +     5. We don't need to "cd" to the "$repo" directory at all anymor=
e.
>     +
>     +        In the code being removed here we both "cd"'d to the reposit=
ory
>     +        before calling "init", and did so in a subshell.
>     +
>     +        It's not important to do either, so both of those can be
>     +        removed. We cd'd because this code grew from test-lib.sh code
>     +        where we'd have done so already, see eedf8f97e58 (Abstract
>     +        test_create_repo out for use in tests., 2006-02-17), and lat=
er
>     +        "cd"'d inside a subshell since 0d314ce834d to avoid having t=
o keep
>     +        track of an "old pwd" variable to cd back after the setup.
>     +
>     +        Being in the repository directory made moving the hooks arou=
nd
>     +        easier (we wouldn't have to fully qualify the path). Since w=
e're
>     +        not moving the hooks per #4 above we don't need to "cd" for =
that
>     +        reason either.
>=20=20=20=20=20=20
>           6. We can drop the --template argument and instead rely on the
>              GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh=
. See

