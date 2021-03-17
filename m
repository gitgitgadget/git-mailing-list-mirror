Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1CC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24BD64F67
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCQNWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhCQNVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:21:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B7C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:21:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id si25so2586421ejb.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Xd4er6TnrTLOM7t80wOHxho80NxEMqYZ4OY7bjpsQ/Y=;
        b=dDWzoC2NsEhlccAqjMX8jsRX8crrX6g7+h3Ju2eL90Hj9r+cP1oTJP5GF7jhyMFOfS
         tWIgsQWg5+tZ9hycs/JY066EbP52WfoCiKINMYxIctcP1Ir6w63NA4nS7eByF3LAxvmU
         Z8rNCjwB6hoFFo2H+ALuxPKSiAmw6QGJ1d9iNrCCyTtaDuYVoqssgUWkYNi+wcIMk9EK
         DYnHR2AqjLU919hkbitbtxnPKOnSBiT+Vic/1mXBLCTJ0brea4UZozVi69wq//WX//Y1
         iEuEoDT23c2ssHDROdu99EwaN1vHBd+pNKiZiwAJJMUKhBqF8Bg6ewvcZW0OXLS9Oo1S
         hLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Xd4er6TnrTLOM7t80wOHxho80NxEMqYZ4OY7bjpsQ/Y=;
        b=sENNwP2rnIDsuWnhz/Spr47TjQMGPdbhSCtCFjC99otisHYy4LJkKCDKPMa8/7qtYl
         G//X5ya3wmNqgcBE4VfW6jPjd6k1u5QwhtdXx5dIy/UbkxyG2YasVtiod73hHo8tnWGB
         zIQvDEAasR2F06M5GYK207FIU+6mDAH2OALwfUhNwbkokGPB3aJhjiU7F2yAoAvXz0Za
         s9r9XywacI1OcYapb/9b87LkuSR9YTT3N3wwnf2UbiSOGwmMRHYO66eGGLKXl4BZ7hjH
         DepXX21ZKpV0v5FP03DWMQVetGhG6plyCE1DTsU8V3P5POL3jguifbFXvlchB1zZAeUx
         sppA==
X-Gm-Message-State: AOAM533B5fYyaX3Pnla9V21Dwh00jyvIUj9nEp3O5trhdY+pv6JqCU0t
        siKvd1Ys8RVSssZiboW64DkbllevrVF5kQ==
X-Google-Smtp-Source: ABdhPJwsAR2PvU5g+iU7lXSrgmSVhkqEuaKQJvo8TOmqB8F89kfLFCTLNWGWlcsIOW7AnF4fHqbeWA==
X-Received: by 2002:a17:907:10ce:: with SMTP id rv14mr35879442ejb.56.1615987299603;
        Wed, 17 Mar 2021 06:21:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u13sm11758270ejn.59.2021.03.17.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:21:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 02/20] t/perf: add performance test for sparse
 operations
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
 <87tupadve8.fsf@evledraar.gmail.com>
 <792a1249-166b-56f4-1e7d-0c5d7a1ba0e5@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <792a1249-166b-56f4-1e7d-0c5d7a1ba0e5@gmail.com>
Date:   Wed, 17 Mar 2021 14:21:38 +0100
Message-ID: <875z1p29wd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Derrick Stolee wrote:

> On 3/17/2021 4:41 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:
>>> +test_expect_success 'setup repo and indexes' '
>>> +	git reset --hard HEAD &&
>>> +	# Remove submodules from the example repo, because our
>>> +	# duplication of the entire repo creates an unlikly data shape.
>>> +	git config --file .gitmodules --get-regexp "submodule.*.path" >module=
s &&
>>> +	git rm -f .gitmodules &&
>>> +	for module in $(awk "{print \$2}" modules)
>>> +	do
>>> +		git rm $module || return 1
>>> +	done &&
>>> +	git commit -m "remove submodules" &&
>>=20
>> Paradoxically with this you can no longer use a repo that's not git.git
>> or another repo that has submodules, since we'll die in trying to remove
>> them.
>
> Good point.
>
>> Also you don't have to "git rm .gitmodules", the "git rm" command
>> removes submodule entries.
>
> Sure.
>
>> Perhaps just:
>>=20
>>     for module in $(git ls-files --stage | grep ^160000 | awk -F '\t' '{=
 print $2 }')
>>     do
>>         git rm "$module"
>>     done
>>=20
>> Or another way of guarding against rm getting the empty list && commit?
>>=20
>> But it seems odd to be doing this at all, the point of the perf
>> framework is that you can point it at any repo, and some repos you want
>> to test will have submodules.
>
> You're right that it should handle all repos. However, the point of
> the test is to have many copies of the repo, but most of them are
> excluded by sparse-directory entries. We don't collapse sparse-directory
> entries if there is a submodule inside, so the data shape is wrong after
> making all the copies.
>
> So, I disagree with your approach in your suggested diff, and instead
> offer this one. I've tested this with git.git and another local repo
> without submodules and checked that everything works as expected.

What's got me confused here is that there's two uses for the perf
framework in this context.

It's to use an empty/git.git as a test repo to demonstrate something,
but then also that you can run it in your arbitrary repo, and e.g. see
how much a given feature might benefit you.

Hence suggesting that maybe test_perf_fresh_repois better here, because
by using test_perf_default_repo you're creating the expectation that you
can run the perf test, observe an %X difference, and that'll be
give-or-take what you'll get for that use case if you enable the feature.

Except it won't because the repo has submodules, which we deleted for
the perf test...

> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-oper=
ations.sh
> index e527316e66d..5c0d78eeeea 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -10,15 +10,17 @@ SPARSE_CONE=3Df2/f4/f1
>=20=20
>  test_expect_success 'setup repo and indexes' '
>  	git reset --hard HEAD &&
> +
>  	# Remove submodules from the example repo, because our
> -	# duplication of the entire repo creates an unlikly data shape.
> -	git config --file .gitmodules --get-regexp "submodule.*.path" >modules =
&&
> -	git rm -f .gitmodules &&
> -	for module in $(awk "{print \$2}" modules)
> -	do
> -		git rm $module || return 1
> -	done &&
> -	git commit -m "remove submodules" &&
> +	# duplication of the entire repo creates an unlikely data shape.
> +	if (git config --file .gitmodules --get-regexp "submodule.*.path" >modu=
les)

A subshell isn't needed here.

FWIW the reason I got this out of ls-files is because you can have
submodules without .gitmodules entries, rare and broken, but seemed more
direct to grep the mode bits.

> +	then
> +		for module in $(awk "{print \$2}" modules)
> +		do
> +			git rm $module || return 1
> +		done &&

Once we know we have submodules we can just do this without the loop.

    git rm $(awk "{print \$2}" modules)



> +		git commit -m "remove submodules" || return 1
> +	fi &&
>=20=20
>  	echo bogus >a &&
>  	cp a b &&
>
>> Seems like something like the WIP patch at the end on top would be
>> better.
>>=20
>>> +	echo bogus >a &&
>>> +	cp a b &&
>>> +	git add a b &&
>>> +	git commit -m "level 0" &&
>>> +	BLOB=3D$(git rev-parse HEAD:a) &&
>>=20
>> Isn't the way we're getting this $BLOB equivalent to just 'echo bogus |
>> git hash-object --stdin -w' why commit it?
>
> We are committing it so we can add commits that deepen the copies,
> but within those copies we have these known file paths.
>
>> This whole thing makes me think you just wanted a test_perf_fresh_repo
>> all along, but I think this would be much more useful if you took the
>> default repo and multiplied the size in its tree by some multiple.
>>=20
>> E.g. take the files we have in git.git, write a copy at prefix-1/,
>> prefix-2/ etc.
>
> That is essentially what is happening here, but using multiple levels
> of directories. Using these multiple levels presents extra tree
> lookups and parsing in the event of expanding a sparse index to a
> full one.

*nod*

Anyway, this thread's a bit of a bikeshed on my part, I was just
wondering if & what part of the test relied on the existing repo if it
was mostly setting up its own test data.
