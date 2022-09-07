Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2DCC6FA82
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 12:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIGMaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGMaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 08:30:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500517332F
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 05:30:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so30032761ejy.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=sP2fy/gdbVq2zEnIzomFn/mXo9T6/HLocvDnSGQsdVg=;
        b=Rn53Venld0yrWaQTNeqAoPlBqfsdctbFNTUPtuGSmQkiWJ0UoO0STHJIFnv1C5CQJt
         jOQmFqmxtQpPLbWCpip2oavETYnEJVSmmJnvHnXkn/axUoxk6X4fUplkP/bmNOHXuXhb
         o3j0uS4rU6jtu/v62o9Qh0hGEahapqRLiQiDJzpWWD2421yfsnotZlws59wWgg04qZlj
         /rjJuUeLaPRmopihAWaLzExHWj5Dxphol9kAczGQhdPZA7DXVxqA+67ZuMufXk7PBIpY
         xhREfpy8Di9EepF9Butugfu4IOsT2MJX8GlOsnPUWK1qZc9J+bXlyL1iLR2F36UVuzDV
         spqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=sP2fy/gdbVq2zEnIzomFn/mXo9T6/HLocvDnSGQsdVg=;
        b=1b2E92Xiq2pMyowCquFSrMcE5yKBXGIMPzsZ9tOYlHPQntVL11+zz3eNUr28i2GaXF
         NMFQ9b1b/1cMV808DUyFj/xHBKHJomJmtwArxXLOSiB/q9Tr8KLUjc5Wo0Rb46O+sDtP
         0FlTVwkz/9FKV45iy6XmIVmmRoSlFsLtzAiYMrpDxzsOF5Gq1jchEj948mzXfNmuerBm
         7R40WAj8wOvkgeqefJsILgk343rdTNCbZjlnejBnf7xjuy9VKm61s0t8HEUlyzzro9oq
         z5s3y2fCUBet6PKjdafhZRF+QvBD8G7mglYVcNBXZs3IxgGVq7xY2H3+sWMJDPwF6Ywg
         TSkg==
X-Gm-Message-State: ACgBeo2d7H6WS2Og9ZFrJ4mmOJRJv7j11J+syAdANyrW5m9CTug5ehbb
        Lgr5WhORy1eQgIDyjmF/lncJc5TWvmovUw==
X-Google-Smtp-Source: AA6agR5hLzriNXd6x0+U7oVI/tQ/qg/vUa70OtUTZaWfkpE+9O5ZAHKp0YIRd//7RGNnn9sV/CteIw==
X-Received: by 2002:a17:907:9812:b0:741:973d:fe78 with SMTP id ji18-20020a170907981200b00741973dfe78mr2094218ejc.490.1662553816699;
        Wed, 07 Sep 2022 05:30:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f10-20020aa7d84a000000b0043d1eff72b3sm4866318eds.74.2022.09.07.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:30:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oVuC7-000lmy-0O;
        Wed, 07 Sep 2022 14:30:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] tests: replace mingw_test_cmp with a helper in C
Date:   Wed, 07 Sep 2022 14:24:26 +0200
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <1f5366f137967cbec30041b40eedd86ce5f6e953.1662469859.git.gitgitgadget@gmail.com>
 <220907.86v8pzl6jz.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220907.86v8pzl6jz.gmgdl@evledraar.gmail.com>
Message-ID: <220907.86r10nl63s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 07 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Sep 06 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> +++ b/t/helper/test-text-cmp.c
>> @@ -0,0 +1,78 @@
>> +#include "test-tool.h"
>> +#include "git-compat-util.h"
>> +#include "strbuf.h"
>> +#include "gettext.h"
>
> Superflous header? Compiles without gettext.h for me (and we shouldn't
> use i18n in test helpers).
>
>> [...]
>> +int cmd__text_cmp(int argc, const char **argv)
>> +{
>> +	FILE *f0, *f1;
>> +	struct strbuf b0 =3D STRBUF_INIT, b1 =3D STRBUF_INIT;
>> +
>> +	if (argc !=3D 3)
>> +		die("Require exactly 2 arguments, got %d", argc);
>
> Here you conflate the argc v.s. arguments minus the "text-cmp",
> resulting in:
>
> 	helper/test-tool text-cmp 2
>         fatal: Require exactly 2 arguments, got 2
>
> An argc-- argv++ at the beginning seems like the easiest way out of
> this. Also s/Require/require/ per CodingGuidelines.
>
>> +	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-"))
>> +		die("only one parameter can refer to `stdin` but not both");
>> +
>> +	if (!(f0 =3D !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
>> +		return error_errno("could not open '%s'", argv[1]);
>> +	if (!(f1 =3D !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
>> +		fclose(f0);
>> +		return error_errno("could not open '%s'", argv[2]);
>> +	}
>
> Faithfully emulating the old version. I do wonder if we couldn't simply
> adjust the handful of tests that actually make use of the "-" diff(1)
> feature. AFAICT there's around 10 of those at most, and they all seem
> like cases where it would be easy to change:
>
> 	(echo foo) | test_cmp - actual
>
> Or whatever, to:
>
> 	echo foo >expected &&
> 	test_cmp expected actual
>
> ...
>
>> +			if (!strcmp(argv[1], "-") || !strcmp(argv[2], "-"))
>> +				warning("cannot show diff because `stdin` was already consumed");
>
> ...
>
> Which means we wouldn't need to punt on this.
>
>> +			else if (!run_diff(argv[1], argv[2]))
>> +				die("Huh? 'diff --no-index %s %s' succeeded",
>> +				    argv[1], argv[2]);
>
> I tried manually testing this with:
>
> 	GIT_TRACE=3D1 GIT_TEST_CMP=3D"/home/avar/g/git/git diff --no-index --" .=
/t0021-conversion.sh  -vixd
>
> v.s.:
>
> 	GIT_TRACE=3D1 GIT_TEST_CMP=3D"$PWD/helper/test-tool text-cmp" ./t0021-co=
nversion.sh  -vixd
>
> Your version doesn't get confused by the same, but AFAICT this is by
> fragile accident.
>
> I.e. you run your own equivalent of "cmp", so because the files are the
> same in that case we don't run the "diff --no-index".
>
> But the "diff --no-index" in that t0021*.sh case *would* report
> differences, even though the files are byte-for-byte identical.
>
> So the "cmp"-a-like here isn't just an optimization to avoid forking the
> "git diff" process, it's an entirely different comparison method in
> cases where we have a "filter".
>
> It just so happens that our test suite doesn't currently combine them in
> a way that causes a current failure.

Ah (partially?) I spoke too soon on this part. I.e. the
GIT_DIR=3D/dev/null precludes reading the filter/repo in this case. So I
*think* we're out of the woods as far as this is concerned.

Still, it would be nice to document in a code comment or commit message
that the "not read the local repo's filter" is absolutely critical here.

But I think that re-raises the point Ren=C3=A9 had in:
https://lore.kernel.org/git/b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de/

I ran the full test suite with:

	GIT_TEST_CMP=3D'GIT_DIR=3D/dev/null HOME=3D/dev/null /usr/bin/git diff --n=
o-index --ignore-cr-at-eol --'

And all of it passes, except for a test in t0001-init.sh which we could
fix up as:
=09
	diff --git a/t/t0001-init.sh b/t/t0001-init.sh
	index d479303efa0..d65afe7cceb 100755
	--- a/t/t0001-init.sh
	+++ b/t/t0001-init.sh
	@@ -426,7 +426,7 @@ test_expect_success SYMLINKS 're-init to move gitdir s=
ymlink' '
	 	git init --separate-git-dir ../realgitdir
	 	) &&
	 	echo "gitdir: $(pwd)/realgitdir" >expected &&
	-	test_cmp expected newdir/.git &&
	+	test "$(test_readlink newdir/.git)" =3D here &&
	 	test_cmp expected newdir/here &&
	 	test_path_is_dir realgitdir/refs
	 '

Which without this series is more correct, as all we're re-testing there
is whether the symlink is pointing to what we expect. A hypothetical
"--dereference" to "git diff" would also take care of it (the equivalent
of "--no-dereference" being the default).

But with that all tests pass for me, so I'm puzzled as to the need for
the new helper, as opposed to just constructing the command above and
sticking it in GIT_TEST_CMP ...
=09
