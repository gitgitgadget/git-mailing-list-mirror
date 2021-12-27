Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD69AC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhL0Bd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhL0Bd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:33:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56CEC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:33:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w16so56147813edc.11
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fUx+utzhcwklAPGqmhvFKqo7zHqCpwb+ysW7FApM9a0=;
        b=Muhp3HvMOElXOqlgZPNfNy5XflfsjX3mSpzPhZdObYrSi7jpUPEHDxicZA8WJpFPYM
         V/cWo7Uv8QV4U5m+7/iqG6ebfbPlNyqbw7TiYFSVpemMun5G+TGjwOLXAzgQMUtPs8UE
         GsaqGt+lyCGn33BqdmlOsUy5WBa7mY4tTFaoAg5GQIV9zsNtqW8E5QZ6B6FjGMCJfJju
         ynrbdWU4sTsjISBy2Gp9ACu+WYR8auioFuYkVoIReo8SufVODXZCxDJGzus+soEacgnV
         6oWwv8C0xRM/K3VEjR8VhO+GS6aKg8+TMAE+eSpJpbfdstmRH0f+KnshFX48nzy/Zmty
         11yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fUx+utzhcwklAPGqmhvFKqo7zHqCpwb+ysW7FApM9a0=;
        b=dMEdONiz2wgj29WUH9mL/W/11WomJy7Em04myXjh7IzZDUeQX8vNew824U3llxRimg
         Fnhyuuj5N90972oE2TOFhqBdf7DBMvnEA8aDYIEtM3PISzbutPfZqv6YuwV+zrIYDGqw
         n6uk2Is7zu2qLXoD7v77VydDb5KT+OLW3MuatyXImjuftfkUGcdDXKB8G9kMLm4HeqbT
         Sv0iawPk/pgHCx48EISZI9g/PAl/55lqE5KXq6cM3obv1xwJ6Q+WvfZZg17plIUestp5
         23fsauwQ4Z1uzQHFKtD5K/oBHAKX+NNJr/7S1+M8NltkVw/HFgKksowPqNH50kNswubL
         NCYA==
X-Gm-Message-State: AOAM530kCy+ntH47S0SjPlmmq8apus6LpRkVFzVbnC8v0iU2v2o51O34
        CoLcdidCC3j5lFZ3Ago1mapXkNAuf5YQvTXd
X-Google-Smtp-Source: ABdhPJz5ET0KNncZUpFQkdXhjOnaXA/IQCgbHiM+MWWupHccmj9HNEa89XINSbE36iexADN1rhTslg==
X-Received: by 2002:a05:6402:4c4:: with SMTP id n4mr14484185edw.30.1640568804158;
        Sun, 26 Dec 2021 17:33:24 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id qa11sm298019ejc.189.2021.12.26.17.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:33:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1et9-000LSi-0x;
        Mon, 27 Dec 2021 02:33:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 3/7] progress.c tests: make start/stop commands on stdin
Date:   Mon, 27 Dec 2021 02:31:59 +0100
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-3.7-d685c248686-20211217T041945Z-avarab@gmail.com>
 <20211227011013.3ngeh57llxnknphf@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211227011013.3ngeh57llxnknphf@gmail.com>
Message-ID: <211227.864k6ug7bx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Johannes Altmanninger wrote:

[Will reply to the rest later, thanks for the review...]

> On Fri, Dec 17, 2021 at 05:24:58AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>>  int cmd__progress(int argc, const char **argv)
>>  {
>> -	int total =3D 0;
>> -	const char *title;
>> +	const char *const default_title =3D "Working hard";
>> +	struct string_list titles =3D STRING_LIST_INIT_DUP;
>>  	struct strbuf line =3D STRBUF_INIT;
>> -	struct progress *progress;
>> +	struct progress *progress =3D NULL;
>>=20=20
>>  	const char *usage[] =3D {
>> -		"test-tool progress [--total=3D<n>] <progress-title>",
>> +		"test-tool progress <stdin",
>>  		NULL
>
> (unrelated: I'd always add a trailing comma if I can, even though in this=
 case it won't ever matter)

FWIW this bit is intentional coding style in git.git, see Junio's
https://lore.kernel.org/git/xmqqk0g5656r.fsf@gitster.g/:
=20=20=20=20
    It is a good idea to leave a comma even after the last element,
    _unless_ there is a strong reason why the element that currently is
    at the last MUST stay to be last when new elements are added[...]

Well, in that case he's talking about enums, but the same applies even
more to these sorts of lists here the NULL must remain the last element.
=20=20=20=20
