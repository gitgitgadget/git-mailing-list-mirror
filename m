Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF79C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73BA619B3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhCXAxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 20:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhCXAwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 20:52:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C8C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:52:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so30102147ejc.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xuX1F/0blj4GaNonLTkynmCTmxVYk7J6/Wv8N935Rxw=;
        b=Lk+mAcaY3CD2hfOHVTjiwZjGlMThQ6B45CXadtT82q2Cu043x8luaVMXzHH1dGm42l
         MaFPdJJv+l0G2KvMbUMEtOsMu78LScsgrUVebkNZqaql8g/Y65Ces4sYwlSEmgliwis5
         ikKF7sByFAfNDlVgUWsRLjMI4X1XkFstzySowmb2uZQfRJgyMbaZIiJ8FRn8NTpv/7QL
         HKF8JmTNXuajEnJFDOspgqeckvSl28K8VavoIYM96Tn4OoRM0gUW3VhvqJcPci6l1mdx
         8+PbQnEwBkP/Yoki4slKjcmrQhcHHWYuU76fNdHpfBbe5JL/lc9fwCA0Cc51B6Pxs0jD
         lAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xuX1F/0blj4GaNonLTkynmCTmxVYk7J6/Wv8N935Rxw=;
        b=UwIc+TdB9dg1EPerkg2TyTWFUJlY6gT42B6GZdcy6vNV/rS8+nEKQ8dnd7edrX43yO
         dxNBPwur/sXMtZvHuNx4XiBhGAyfQleyEryhqXsQyz+YvuxcbUrXROdeyGP7dtK3tQzN
         DK07YqTz7C7NnWri+WG6DCIV47Xdk400BIocwRJeXolxwyp+P0i/TsOPthDAMX1Q25jv
         HfEQmJZ74wqehwJO6amryG1VTTndsxngiEsTSxVOmq7drdWoubwMike0/AVLkK0cjP7D
         gVZjLtmeo1paw6vgM9hVxJOb3i1N1leEKoYZlSfVEtbtE7if+/vBRy5Yk3L3kAgg+rpG
         RLEw==
X-Gm-Message-State: AOAM530ggcTAoHcu7pCfxFjrqXxP0nLDhDJB4WJlQbOt003eR2ukfyWJ
        7r1jb+awCcoCFOOec2cqKEzgMXB5mIFl7g==
X-Google-Smtp-Source: ABdhPJxDjGtpOWeTL72lPisAl85s9/n5XFiyY92YxUYio1AIkqe5uMr5rj7PjQDWivmxULz7vVe8eA==
X-Received: by 2002:a17:906:8583:: with SMTP id v3mr898116ejx.361.1616547164045;
        Tue, 23 Mar 2021 17:52:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g12sm155001eje.120.2021.03.23.17.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 17:52:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: Re: [RFC/PATCH 3/5] ls-files: add and use a new --sparse option
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-4-avarab@gmail.com>
 <028fb838-f012-e8c7-eb8b-53c810802243@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <028fb838-f012-e8c7-eb8b-53c810802243@gmail.com>
Date:   Wed, 24 Mar 2021 01:52:43 +0100
Message-ID: <87tup1pe3o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Derrick Stolee wrote:

> On 3/17/2021 9:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
>
> I want to learn from your suggested changes to the test, here,
> so forgive my questions here:
>=20=20=20
>> +test_index_entry_like () {
>> +	dir=3D$1
>> +	shift
>> +	fmt=3D$1
>> +	shift
>> +	rev=3D$1
>> +	shift
>> +	entry=3D$1
>> +	shift
>> +	file=3D$1
>> +	shift
>
> Why all the shifts? Why not just use $1, $2, $3,...? My
> guess is that you want to be able to insert a new parameter
> in the middle in the future without changing the later
> numbers, but that seems unlikely, and we could just add
> the parameter at the end.

It's just crappy RFC-quality code. I probably copied some other function
and went with it. No good reason. Yeah it's ugly.

>> +	hash=3D$(git -C "$dir" rev-parse "$rev") &&
>> +	printf "$fmt\n" "$hash" "$entry" >expected &&
>> +	if grep "$entry" "$file" >line
>> +	then
>> +		test_cmp expected line
>> +	else
>> +		cat cache &&
>> +		false
>> +	fi
>> +}
>> +
>>  test_expect_success 'sparse-index contents' '
>>  	init_repos &&
>>=20=20
>> -	test-tool -C sparse-index read-cache --table >cache &&
>> +	git -C sparse-index ls-files --sparse >cache &&
>>  	for dir in folder1 folder2 x
>>  	do
>> -		TREE=3D$(git -C sparse-index rev-parse HEAD:$dir) &&
>> -		grep "040000 tree $TREE	$dir/" cache \
>> -			|| return 1
>> +		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$di=
r/" cache || return 1
>
> I see how this uses only one line, but it seems like the
> test_index_entry_like is too generic to make it not a
> complicated mess of format strings that need to copy
> over and over again.
>
> Perhaps instead it could be a "test_entry_is_tree"
> and it only passes "$dir" and "cache"? Then we could drop the loop and
> just have
>
> 	test_entry_is_tree cache folder1 &&
> 	test_entry_is_tree cache folder2 &&
> 	test_entry_is_tree cache x &&
>
> or we could still use the loop, especially when we test for four trees.

Yeah that sounds good. Personally I don't mind 4x similar lines
copy/pasted over a for-loop in the tests. You don't need to worry about
the || return doing the right thing, and just setting up the for-loop is
already 3 lines...

>> -	test-tool -C sparse-index read-cache --table >cache &&
>> +	git -C sparse-index ls-files --sparse >cache &&
>>  	for dir in deep/deeper2 folder1 folder2 x
>>  	do
>> -		TREE=3D$(git -C sparse-index rev-parse HEAD:$dir) &&
>> -		grep "040000 tree $TREE	$dir/" cache \
>> -			|| return 1
>> +		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$di=
r/" cache || return 1
>>  	done &&
>>=20=20
>> +	grep 040000 cache >lines &&
>> +	test_line_count =3D 4 lines &&
>> +
>
> The point here is to check that no other entries are trees? We know
> that this number will be _at least_ 4 based on the loop above.

It's exactly 4 because we have 4 folders we're checking. But you tell
me. I was just trying to refactor this dependence on the ls-tree format
while moving it over to ls-files without spending too much time on
understanding all the specifics.
