Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA99C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1051610CF
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhDHXME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHXME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:12:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA0C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:11:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bx20so3177667edb.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AeoQvNa6iPWLNDMYcbmNI5cJkvbVnzAVlD/P8JjGQ8A=;
        b=XW6skPA48NVIH/7eLfrTlePA6Osz7e0b3/KBRVd8L2ai68xBTJOJl/GoiyL502JVeL
         IR9wVtfeR+w2GBW2Jua/SObZEZePAScFcvrpuYHO4dh6+MAZ/VlCs+VMZ64xSL3xuY8M
         HBJdCg+t8bPxTKT0AP9X19iMNXB0aJ9WM00OaAzjihyJTc/ktWvzt3eupmVM4A0gbdtn
         qLW4LooylaCdXIdlmmssm+boZfo9CuswXu6lWMrbD4x3lonstdP0WgSkTmkE9YCTzOWB
         WIqWsigeJ6Omk/p7Nr6r9B3VGuU1zv3uAso4rwCxeHIKmiBY+A/8Mt1mJjSbnQv27ZCA
         C5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AeoQvNa6iPWLNDMYcbmNI5cJkvbVnzAVlD/P8JjGQ8A=;
        b=GdZGmDf6gRJR+/IdfA5THe+adoRwrKtQLgn0Nyp+YFJIlbhf7fBwNIHpGkIkKmYcfJ
         AAwSTyV61C0wEis0HFcXLiDm9D3WulYszxGYWq7vZ5/Gt3EuShtbkLnOPZ2YbQkBXLW9
         WUgiCxa/YjhdbyJPlKDwp6KAMzeJjryuG7P/pjGjJs6AR4IM0Wp4W2e8m4IZ/iAa089F
         gQUKG+ioetCSASM7FAhpk5mbl+Ow50VhNL/hAfJbIf/E1v4Mls4YF3D0ww/XKftAoNDi
         QM1lH07t4evkvMV4IMQW5khUESq9PK43d1N+/DKPTa8ktKjHORYj6TO8HDdj2voKiWYW
         8niQ==
X-Gm-Message-State: AOAM5322vBiVhGf3+5C5DIK6/MTS7c1lApJW1IJ0IdnbwF4wdKUKy4Vp
        32G3afUmu6yxN/Z89My5QjY=
X-Google-Smtp-Source: ABdhPJyt+kf/+zn16DfgNKjhXCXyzL64eBR5GxfTYXnJvL0oAxeLR3snmrxV6BV6MjoiU/oVQVm/BA==
X-Received: by 2002:a50:b286:: with SMTP id p6mr14928214edd.282.1617923511004;
        Thu, 08 Apr 2021 16:11:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ly21sm350210ejb.116.2021.04.08.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:11:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy?= =?utf-8?B?4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/5] config tests: test for --bool-or-str
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
 <patch-2.6-2f6c2de050-20210408T133125Z-avarab@gmail.com>
 <xmqqim4wtz5k.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqim4wtz5k.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 01:11:50 +0200
Message-ID: <878s5sid6x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add the missing tests for the --bool-or-str code added in
>> dbd8c09bfe (mergetool: allow auto-merge for meld to follow the
>> vim-diff behavior, 2020-05-07).
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t1300-config.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index e0dd5d65ce..a002ec5644 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -802,6 +802,78 @@ test_expect_success 'get --bool-or-int' '
>>  	test_cmp expect actual
>>  '
>>=20=20
>> +test_expect_success 'get --bool-or-str' '
>> +	cat >.git/config <<-\EOF &&
>> +	[bool]
>> +	true1
>> +	true2 =3D true
>> +	true3 =3D TRUE
>> +	true4 =3D yes
>> +	true5 =3D YES
>> +	true6 =3D on
>> +	true7 =3D ON
>> +	false1 =3D
>> +	false2 =3D false
>> +	false3 =3D FALSE
>> +	false4 =3D no
>> +	false5 =3D NO
>> +	false6 =3D off
>> +	false7 =3D OFF
>> +	[int]
>> +	int1 =3D 0
>> +	int2 =3D 1
>> +	int3 =3D -1
>> +	[string]
>> +	string1 =3D hello
>> +	string2 =3D there you
>> +	EOF
>
> That's fairly complete set (but misses common permutations like
> "Yes").  I am not sure, if we try "true" and "TRUE", if it is worth
> to check yes/YES and others, but at the same time, I do not know if
> reducing the permutations tested would improve the readability,
> runtime and/or maintainability of the test.

Sure, I was trying to do just enough to cover strcasecmp(). I don't
think we need to do black-box testing here.

>> +	cat >expect <<-\EOF &&
>> +	true
>> +	true
>> +	true
>> +	true
>> +	true
>> +	true
>> +	true
>> +	false
>> +	false
>> +	false
>> +	false
>> +	false
>> +	false
>> +	false
>> +	false
>> +	false
>> +	true
>> +	true
>> +	hello
>> +	there you
>> +	EOF
>
> The "right answer" is hard to read and maintain.  Can we immediately
> spot what happened to int.int3 in this output, for example?
>
> Perhaps with something like
>
> 	inspect_config () {
> 		name=3D$1
> 		shift
> 		printf "%s %s\n" $(git config "$@" "$name") "$name"
> 	}
>
> we can make these lines to say
>
> 	int.int1 false
> 	int.int2 true
> 	int.int3 true
> 	string.string1 hello
> 	string.string2 there you
>
> to make them easier to follow?  Without such a hint, I would expect
> that a failure output from test_cmp at the end would be very hard to
> grok, especially with so many permutations tested that produces runs
> of "true" and "false".

It's a general established pattern in t1300-config.sh used by several
other existing tests, e.g. the one for bool, path etc. I'd rather not
get into a general refactoring of that file.

>> +	{
>> +		git config --type=3Dbool-or-str bool.true1 &&
>> +		git config --bool-or-str bool.true2 &&
>
> This is a bit curious.  We do not do full permutation between
> --type=3Dbool-or-str and --bool-or-str here.  We just check both
> would work only once.  Feels a bit inconsistent.

Yeah, I was just trying to stick a --type=3DX v.s. --X test somewhere. I
can add it to another test_expect_success or something.

> My gut-feeling vote is to just try true/TRUE for case insensitivity
> and try all the other variants in lowercase, but I can go with the
> full permutation if you strongly prefer it.
>
>> ...
>> +		git config --bool-or-str int.int1 &&
>> +		git config --bool-or-str int.int2 &&
>> +		git config --bool-or-str int.int3 &&
>> +		git config --bool-or-str string.string1 &&
>> +		git config --bool-or-str string.string2
>> +	} >actual &&
>> +	test_cmp expect actual
>> +'
>
> Thanks.

