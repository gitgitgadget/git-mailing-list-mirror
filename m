Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3BC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKVAvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKVAvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:51:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41EC75AB
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:51:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ft34so32218712ejc.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZyVEZ2RFNp3kJDzjcEyV89M0N9Q4/0JTuStdDQ/t/hU=;
        b=GjArb4XOaRHRDfu+78vyGCqSlGrrDl0FEY9bDq4qnIvxhBgKiwwdz8Y6cZosHByfri
         bCCsNtKAgBrWd9OnQ4tqZh0L0tmyC3nWLAzIcOFcbUBlwuTlY1GZ/qpW+m4JTH43lREt
         44Z7bi6ZsJfzRTRUqrUnz7ZgzcYzNxrxKYWAPjA3+QoWC2UU0RSEkL3UCGU7AnNtOmLt
         xQEYSoedMA6nckfaElUGi1LE925hHhneEsX8oN9iG0N5LEdW4VzcmVblehrOcWpBV7q0
         oBu8xPnLdPgIcl1aiUCjVDqPM7bsH6zruh9Wdld0L28FEiXzItrIezxaU0nT5qKIbfuM
         +UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyVEZ2RFNp3kJDzjcEyV89M0N9Q4/0JTuStdDQ/t/hU=;
        b=gWJkI6YbpD7TObXBXJtrJShruh8pW1rHwmtSzGjs6h6rj5N7Jwzj9FJPCatlrt5lQc
         JzHv+cWbRN8+8jnLVxmiocj+Rj5mgM4vteLzIIWkp2ahDW6N1YIKiuLZdLOUGFx1ktWb
         Ggt641KAMkVVRtx6qT5OnI9mBVM5pqowl8UFzmR99AaYN22KG51YE+N8thiP60KlbLjo
         oP8D2b7gpaJ5fEEKA3e358gT6Cps7P2xkZ0IShk11MsKhyzh1Vo39wk4qjFNLNOFewE1
         jC29Ozty8xjm9LA2wbQn7p21wMzeZdn/wdBvJ+2jwWy2+PEBxd4QA2FbX21/Udcvl9du
         tmJA==
X-Gm-Message-State: ANoB5plURtVvl7FolQ1MgsOj669/MlOcSwy5Qmae9CdMNnDx2If8a9Wy
        LNNWC7uERp18outp4THHdjSfH3fdLGjuhg==
X-Google-Smtp-Source: AA0mqf7hu5fbovbFK7st6g/WmkkHLrmpVKE8jWAUrk8cd4HAN5zTbzvnldFYOJCSLbfucUCePlhmpg==
X-Received: by 2002:a17:906:328e:b0:78d:7f22:2c53 with SMTP id 14-20020a170906328e00b0078d7f222c53mr806949ejw.420.1669078293911;
        Mon, 21 Nov 2022 16:51:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906c18e00b0078c468bd604sm5538256ejz.57.2022.11.21.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:51:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxHVc-000VF4-34;
        Tue, 22 Nov 2022 01:51:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Date:   Tue, 22 Nov 2022 01:11:39 +0100
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
 <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net>
 <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
 <Y3vI99ZiNdXddX8C@coredump.intra.peff.net>
 <CAPig+cQEdidB4YHm9OiyOUe8mbTPBajjX5t-_6ZJVwRykXkqmg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cQEdidB4YHm9OiyOUe8mbTPBajjX5t-_6ZJVwRykXkqmg@mail.gmail.com>
Message-ID: <221122.86cz9fbyln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Eric Sunshine wrote:

> On Mon, Nov 21, 2022 at 1:52 PM Jeff King <peff@peff.net> wrote:
>> On Mon, Nov 21, 2022 at 01:47:42PM -0500, Eric Sunshine wrote:
>> > I think =C3=86var's use-case for `make` parallelization was to speed up
>> > git-bisect runs. But thinking about it now, the likelihood of "lint"
>> > problems cropping up during a git-bisect run is effectively nil, in
>> > which case setting GIT_TEST_CHAIN_LINT=3D1 should be a perfectly
>> > appropriate way to take linting out of the equation when bisecting.
>>
>> Yes. It's also dumb to run a straight "make test" while bisecting in the
>> first place, because you are going to run a zillion tests that aren't
>> relevant to your bisection. Bisecting on "cd t && ./test-that-fails" is
>> faster, at which point you're only running the one lint process (and if
>> it really bothers you, you can disable chain lint as you suggest).
>
> I think I misspoke. Dredging up old memories, I think =C3=86var's use-case
> is that he now runs:
>
>     git rebase -i --exec 'make test' ...
>
> in order to ensure that the entire test suite passes for _every_ patch
> in a series. (This is due to him having missed a runtime breakage by
> only running "make test" after the final patch in a series was
> applied, when the breakage was only temporary -- added by one patch,
> but resolved by some other later patch.)
>
> Even so, GIT_TEST_CHAIN_LINT=3D0 should be appropriate here too.

I'd like to make "make" fast in terms of avoiding its own overhead
before it gets to actual work mainly because of that use-case, but it
helps in general. E.g. if you switch branches we don't compile a file we
don't need to, we shouldn't re-run test checks we don't need either.

For t/ this is:

 - Running chainlint.pl on the file, even if it didn't change
 - Ditto check-non-portable-shell.pl
 - Ditto "non-portable file name(s)" check
 - Ditto "test -x" on all test files

I have a branch where these are all checked using dependencies instead,
e.g. we run a "test -x" on t0071-sort.sh and create a
".build/check-executable/t0071-sort.sh.ok" if that passed, we don't need
to shell out in the common case.

The results of that are, and this is a best case in picking one where
the test itself is cheap:
=09
	$ git hyperfine -L rev @{u},HEAD~,HEAD -s 'make CFLAGS=3D-O3' 'make test T=
=3Dt0071-sort.sh' -w 1
	Benchmark 1: make test T=3Dt0071-sort.sh' in '@{u}
	  Time (mean =C2=B1 =CF=83):      1.168 s =C2=B1  0.074 s    [User: 1.534 =
s, System: 0.082 s]
	  Range (min =E2=80=A6 max):    1.096 s =E2=80=A6  1.316 s    10 runs
=09
	Benchmark 2: make test T=3Dt0071-sort.sh' in 'HEAD~
	  Time (mean =C2=B1 =CF=83):     719.1 ms =C2=B1  46.1 ms    [User: 910.6 =
ms, System: 79.7 ms]
	  Range (min =E2=80=A6 max):   682.0 ms =E2=80=A6 828.2 ms    10 runs
=09
	Benchmark 3: make test T=3Dt0071-sort.sh' in 'HEAD
	  Time (mean =C2=B1 =CF=83):     685.0 ms =C2=B1  34.2 ms    [User: 645.0 =
ms, System: 56.8 ms]
	  Range (min =E2=80=A6 max):   657.6 ms =E2=80=A6 773.6 ms    10 runs
=09
	Summary
	  'make test T=3Dt0071-sort.sh' in 'HEAD' ran
	    1.05 =C2=B1 0.09 times faster than 'make test T=3Dt0071-sort.sh' in 'H=
EAD~'
	    1.71 =C2=B1 0.14 times faster than 'make test T=3Dt0071-sort.sh' in '@=
{u}'

The @{u} being "master", HEAD~ is "incremant without chainlint.pl", and
"HEAD" is where it's all incremental.

It's very WIP-quality, but I pushed the chainlint.pl part of it as a POC
just now, I did the others a while ago:
https://github.com/avar/git/tree/avar/t-Makefile-break-T-to-file-association

