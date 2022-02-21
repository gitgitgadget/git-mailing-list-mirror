Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EC4C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiBUSyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:54:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiBUSxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:53:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95623C7F
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:52:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vz16so35662552ejb.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dSrPuil2keIk9EUkO/5DKP/gOcCQYPigjn/dsJZGYc8=;
        b=T6DtIF6knG6LUH3PtfN56gQSnKSrT/bbpH9WkDArvDIABFoLv42My48XXKxcExjyPS
         I4zIwXul567Dp/T3kOUJapLGRonMEbpcRPwedxbsMlmskp/cCClLeI3oKaY/7iWiPj/2
         pBesRqdwIC7fYYHsYUk53qu445VgOAsfdcYxxt5vVWYFkrbihYxoZnVQ94h1kWvUexol
         uApkHbJM8maXOsNuy4/ufHNmQbn4JMX02OfqheyhAOOzNPS7hurArXyWXTtG6PxXrjIO
         PFCoFb1QIPH4cRdjrKYsxELorWi8pMtX+HgB6U1zrt7cWEtEoTPcwQWDxkyF2LnL7D/N
         cf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dSrPuil2keIk9EUkO/5DKP/gOcCQYPigjn/dsJZGYc8=;
        b=m91gqMkZ8s1a3Y1toLnvjp3wevnhiCEGgObocFIGxe75Fj9KWdH4Zw/GMTLA0xK/gX
         O/2twfPUtQTuqn4VgAZQU99vjsfpBIjvabhOayiZzq0FHCIDkpaXBM/WcXDcdOb0pSs6
         X2/0dOcgs2pT5BIt8QUN0aG3pODdqfJSVGNCaucKGWXq5sars2vkDVYeikP30BWK4jvb
         fM+QCWU8ZwQC8J2izMpUJjdw2Wwy7V/E6Nwo2zib+e7JTC1b2pMbNQiWTqyK7NrL+wTr
         92fLDtIrzed62ueso/UDl+cKi1rYMaxISvp3cSR7kT99a7AEBCEvfSt8dPLuEMuGgwbY
         4I4Q==
X-Gm-Message-State: AOAM532Wft8PFPeEFuXeMDEnLif/23bjgcD37o0YSKVA1q4M1p517iMD
        ZKgqt35DhTO5mzm//gknmxo=
X-Google-Smtp-Source: ABdhPJzQ+DkzJK66ldEmzWl8pq7jCvGU+kOpoLn7MAQDOMsqrquD9UNEYernQB4qfu1KrQ4gEyq9Hw==
X-Received: by 2002:a17:906:194f:b0:6ce:3670:92b with SMTP id b15-20020a170906194f00b006ce3670092bmr16418336eje.737.1645469529911;
        Mon, 21 Feb 2022 10:52:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j5sm5422719ejs.69.2022.02.21.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:52:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMDn5-005kiS-V4;
        Mon, 21 Feb 2022 19:52:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
Date:   Mon, 21 Feb 2022 19:51:47 +0100
References: <20220218223212.1139366-1-jonathantanmy@google.com>
 <220219.868ru7fsad.gmgdl@evledraar.gmail.com> <xmqqk0dot74j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0dot74j.fsf@gitster.g>
Message-ID: <220221.86ley4aw88.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This test though will break, as you can see with:
>>
>>     GIT_TEST_DEFAULT_HASH=3Dsha256 ./t3007-ls-files-recurse-submodules.sh
>>
>> So you'll need at least something like:
>>
>> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-r=
ecurse-submodules.sh
>> index 3d2da360d17..0fe69da8dcf 100755
>> --- a/t/t3007-ls-files-recurse-submodules.sh
>> +++ b/t/t3007-ls-files-recurse-submodules.sh
>> @@ -42,10 +42,10 @@ test_expect_success '--stage' '
>>  	echo brigddsv >submodule/c &&
>>  	git -C submodule commit -am "update c again" &&
>>=20=20
>> -	cat >expect <<-\EOF &&
>> -	100644 6da7 0	.gitmodules
>> -	100644 7898 0	a
>> -	100644 6178 0	b/b
>> +	cat >expect <<-EOF &&
>> +	100644 $(git rev-parse --short=3D4 HEAD:.gitmodules) 0	.gitmodules
>> +	100644 $(git rev-parse --short=3D4 HEAD:a) 0	a
>> +	100644 $(git rev-parse --short=3D4 HEAD:b/b) 0	b/b
>>  	100644 dead9 0	submodule/c
>>  	EOF
>>=20=20
>> But then the problem is that one is dead9 and the other dead6, I was
>> just trying to find 4-char prefixes.
>>
>> But having indulged in all that, I'm now entirely confused about why any
>> of this needs to be tested here.
>>
>> You're adding --stage, which will give us --stage-y output, and it was
>> previously incompatible with --recurse-submodules. Having the two
>> combine is good!
>
> I think what this is trying to make sure is that it (1) enabled the
> combination and (2) uses the object store of the submodule when
> disambiguating names of the objects from the submodule, because the
> author suspects that the reason why these two options were made
> incompatible in the first place was because long time ago there
> wasn't a way to ask "here is an object name---please uniquify in the
> context of _that_ repository".  So it is understandable to prepare
> an object X in a submodule and another object Y in the superproject,
> such that the abbreviated name of X in the context of the submodule
> is different from the abbreviated name of X in the context of the
> superproject (i.e. if X were in the superproject's object store,
> because the object names of X and Y share the prefix, it may require
> longer prefix to disambiguate from Y), and make sure that the uniquify
> is indeed happening in the context of the submodule.
>
> So, you are only concentrating on (1) but forgetting why the author
> wants (2).

Indeed. That makes sense, but it would really help to e.g. have the test
description make that goal explicit.
