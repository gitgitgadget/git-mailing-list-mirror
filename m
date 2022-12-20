Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F31C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLTKeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 05:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiLTKeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 05:34:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F515829
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 02:34:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i15so16896964edf.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XR8TgvI4iteBtRIHUwKsIBPSQ4SVVlONc3hLjYoamXg=;
        b=NiJHlfkvip8Xxtpp62jhPp2eAqmN56y4QWnmhfB1Xp3W0YA11WQkLkNcRc69h5E6W6
         Stx7BLE+ElB/iqRFB/KhZ80CzqRQA3ZNdUXTJdInR8J7gAuw8tTWL9xp1dJXjFE3OmAL
         IIRcsZmYBV8ocA1i9FkAZ63uNe8G1CucOfz7pcIWu+7BVLlUBruuIsRB/wC5q6AGR70p
         5xw8ZFIS397Ne4Bfuq1pu9ogRxZ2GnpxqJzF3Tp00ZNBlQuGGsefVvP88EgT4Zimulru
         DQmhiSO7tehC2kmq9l5sN6FVtJzYqaQgOwXEPtVXwMGWOgWc1YCx/lO5po4Pg7la5LxX
         MKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XR8TgvI4iteBtRIHUwKsIBPSQ4SVVlONc3hLjYoamXg=;
        b=68Ua5RttC2G5HLldYT5tlsgIaxQ5VgTbqqbIIGS5aK/m/i+5JNzA8hvktJXGAPkEnO
         evCjX6qU859zn7NjPQlzH+1tz7ZtY6o2cJB7PDZsjoROWtKlD2moXMGP2rY/12IsnE72
         uWkuJVOkCi9kDba6fTGkwt2Iuyh5XWbPS+rjANxHMsz7WdVhSXAR6Vi0s1ln7x0NdNgZ
         yM2ODqFwmW7a2eNqdGue56LocEXbMyXQJz5nmwuHPlHJQfgtMnXKvBE3uLXE9RdZ7DDy
         gISDN6KBdB5zgh5AShftUiGoWKynUhKKPb899XwgkpkfRVPe+jw9TJcWci+CkF/RnxIX
         3tvg==
X-Gm-Message-State: AFqh2kpb3xzyAHLpFVXOsyZaVgMYEF6s4tzAmozrTyA4pxvXq5bsDtZw
        YC6c08X34oPJQm7xfoLy30LvrQUQaopqqw==
X-Google-Smtp-Source: AMrXdXu1JNJwOMe5HRvETps3HRByMNX971JamN58zixbx0h9XvasOre4aELavwSlXUyPSUmKLVFbNg==
X-Received: by 2002:a05:6402:408:b0:477:f0d8:9e8b with SMTP id q8-20020a056402040800b00477f0d89e8bmr10310080edv.33.1671532452700;
        Tue, 20 Dec 2022 02:34:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f9-20020a50fc89000000b0046dc763479bsm5522373edq.35.2022.12.20.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:34:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Zwp-007E89-21;
        Tue, 20 Dec 2022 11:34:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 1/9] submodule absorbgitdirs tests: add missing
 "Migrating git..." tests
Date:   Tue, 20 Dec 2022 11:32:46 +0100
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
 <patch-v4-1.9-f479003941b-20221215T083502Z-avarab@gmail.com>
 <kl6l7cyse6bi.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6l7cyse6bi.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221220.86a63ixt24.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 15 2022, Glen Choo wrote:

> No comment on the structure of the tests themselves; those look good to
> me.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-abso=
rbgitdirs.sh
>> index 2859695c6d2..d556342ea57 100755
>> --- a/t/t7412-submodule-absorbgitdirs.sh
>> +++ b/t/t7412-submodule-absorbgitdirs.sh
>> @@ -10,6 +10,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>  . ./test-lib.sh
>>=20=20
>>  test_expect_success 'setup a real submodule' '
>> +	cwd=3D"$(pwd)" &&
>>  	git init sub1 &&
>>  	test_commit -C sub1 first &&
>>  	git submodule add ./sub1 &&
>
> [...]
>=20=20
>> @@ -18,13 +19,21 @@ test_expect_success 'setup a real submodule' '
>>  '
>>=20=20
>>  test_expect_success 'absorb the git dir' '
>> +	>expect &&
>> +	>actual &&
>>  	>expect.1 &&
>>  	>expect.2 &&
>>  	>actual.1 &&
>>  	>actual.2 &&
>>  	git status >expect.1 &&
>>  	git -C sub1 rev-parse HEAD >expect.2 &&
>> -	git submodule absorbgitdirs &&
>> +	cat >expect <<-EOF &&
>> +	Migrating git directory of '\''sub1'\'' from
>> +	'\''$cwd/sub1/.git'\'' to
>> +	'\''$cwd/.git/modules/sub1'\''
>> +	EOF
>> +	git submodule absorbgitdirs 2>actual &&
>> +	test_cmp expect actual &&
>>  	git fsck &&
>>  	test -f sub1/.git &&
>>  	test -d .git/modules/sub1 &&
>
> I thought that we typically avoid setting environment variables in the
> test cases themselves, so when we set environment variables to be read
> in later tests, we typically set them outside of the test case (e.g.
> t/t5526-fetch-submodules.sh).

We could do it either way, but no, I think the preferred style is to do
such setup/assignment in a test_expect_success, we don't run our tests
as "set -e", so we'd miss any errors (however unlikely in this case)
from the commands outside test bodies.

See e.g. t0002-gitfile.sh for the same pattern, i.e. setting the "$REAL"
variable in the setup "test_expect_success", then using it later.

>> @@ -97,6 +119,27 @@ test_expect_success 'absorb the git dir in a nested =
submodule' '
>>  	test_cmp expect.2 actual.2
>>  '
>>=20=20
>> +test_expect_success 'absorb the git dir outside of primary worktree' '
>> +	test_when_finished "rm -rf repo-bare.git" &&
>> +	git clone --bare . repo-bare.git &&
>> +	test_when_finished "rm -rf repo-wt" &&
>> +	git -C repo-bare.git worktree add ../repo-wt &&
>> +
>> +	test_when_finished "rm -f .gitconfig" &&
>> +	test_config_global protocol.file.allow always &&
>> +	git -C repo-wt submodule update --init &&
>> +	git init repo-wt/sub2 &&
>> +	test_commit -C repo-wt/sub2 A &&
>> +	git -C repo-wt submodule add ./sub2 sub2 &&
>> +	cat >expect <<-EOF &&
>> +	Migrating git directory of '\''sub2'\'' from
>> +	'\''$cwd/repo-wt/sub2/.git'\'' to
>> +	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
>> +	EOF
>> +	DO_IT=3D1 git -C repo-wt submodule absorbgitdirs 2>actual &&
>
> DO_IT is a leftover from dev?
>
> (I'm also curious as to what it does :)).

Oops, will fix! It was just something for ad-hoc getenv()-debugging that
escaped the lab.
