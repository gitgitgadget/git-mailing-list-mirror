Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F1C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhL0Xw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhL0Xw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:52:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E3C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:52:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so67096508eds.10
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8szD6iVM0ruJBXq2nixz7h0WOCBUM4iC0xolYtGl2Ck=;
        b=FpJny/DYj0fDxgHpLvAv9xhBEfuEKiDx223Up6DIZoL2rp6p28vJ+vA5x1hsS0PY9q
         Ior3tqfQBeNUELB0krmrhcqhiHY8VuYlf8+TR61HNjOCN8ZN50IwYfAkOWG5MakTgaHj
         R3ZL5sVpqUjn1Z4rstIJT5x1GM1u0zkP3ZGlLZYA3kRxxA58AJzIrda/WIlSNy5gYvoZ
         2VYAmowcKNkpXWMoaT0S3TE2BgNyUAts/Wxgsp1Mbu3kG2641ME6uDHCOKY2D8cO83dm
         Jqzs17C9UcpPt9XM6YFek8L5hxfDXV/mPjK9mVdZp3PNouuuoa/UOiO4gwp1Dhvnp1Ix
         ABKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8szD6iVM0ruJBXq2nixz7h0WOCBUM4iC0xolYtGl2Ck=;
        b=R0a31OThPlhgtolfdBgJVS2jYvc4VDGIy/Tdmcag6S5vi7z0F3hpYrMijvdSFA10Cx
         W1Jdu6+yhpZMOiTdkN8qYkVSWkF53DyQ1Gwpb9Egj853Rj6s6GXzEkLnUpiYdhmouKK3
         kjNxmEKiLePHSOqb6EeMUNSHDq0uLkIisVyKNrAcAEaGRI5ieHoiyFEQw01roOeVx2tB
         XY+3UyVgw4lwWWRTDljWTqTnARPjQLD37ZVglA7VQekb3tdXq7foOdu5yRXAOecfzm40
         UqRPeEUA/+tBn4JT6nw3tQ+moWS3frlnvSIDmXAfLvKl7EyNLc29Duv8zTEJS9gJpL7y
         MBpA==
X-Gm-Message-State: AOAM530nOZ2B8F3LN7wRmNpFEPSdQzeEzn0UoIgWefdhP3bw5PMwdUGE
        uomoyjth8QNbvOd2ZIsb+PABWB9HIDY1FA==
X-Google-Smtp-Source: ABdhPJzezCqnfvXZgPsXy77ABFBU27fRwvMY2WkpSwhd+vj21RiHln5Jp4olgTJPvBs/bwzQtfSY8w==
X-Received: by 2002:a17:907:3e0f:: with SMTP id hp15mr15517529ejc.432.1640649146384;
        Mon, 27 Dec 2021 15:52:26 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id dd5sm5581596ejc.99.2021.12.27.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:52:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1zmz-0006lp-DW;
        Tue, 28 Dec 2021 00:52:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 05/11] i18n: tag.c factorize i18n strings
Date:   Tue, 28 Dec 2021 00:45:16 +0100
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
 <6d89c23a248d1c11db0e92c4f06392272f00c3a2.1640647438.git.gitgitgadget@gmail.com>
 <xmqqpmphvclf.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqpmphvclf.fsf@gitster.g>
Message-ID: <211228.86wnjpip1i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Junio C Hamano wrote:

> "Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>
>> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>>
>> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>> ---
>>  builtin/tag.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 6f7cd0e3ef5..a2ab2b15304 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>>  		OPT_END()
>>  	};
>>  	int ret =3D 0;
>> +	const char *only_in_list =3D NULL;
>>=20=20
>>  	setup_ref_filter_porcelain_msg();
>>=20=20
>> @@ -542,13 +543,15 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>>  		goto cleanup;
>>  	}
>>  	if (filter.lines !=3D -1)
>> -		die(_("-n option is only allowed in list mode"));
>> +		only_in_list =3D "-n";
>>  	if (filter.with_commit)
>> -		die(_("--contains option is only allowed in list mode"));
>> +		only_in_list =3D "--contains";
>>  	if (filter.no_commit)
>> -		die(_("--no-contains option is only allowed in list mode"));
>> +		only_in_list =3D "--no-contains";
>>  	if (filter.points_at.nr)
>> -		die(_("--points-at option is only allowed in list mode"));
>> +		only_in_list =3D "--points-at";
>> +	if (only_in_list)
>> +		die("the '%s' option is only allowed in list mode", only_in_list);
>>  	if (filter.reachable_from || filter.unreachable_from)
>>  		die(_("--merged and --no-merged options are only allowed in list mode=
"));
>>  	if (cmdmode =3D=3D 'd') {
>
> The original died with the first problematic condition that was
> detected, so it was possible to detect a condition and die, and
> check a different condition in a way that may segfault when the
> first condition was true, because we would have called die() before
> making such a risky check for the second condition.  In the above
> cascade, however, there is luckily no such dependency, so the above
> change is safe.
>
> But it still changes the semantics.  Given "tag -d -n 4 --with master",
> we would have complained about "-n", but now we will complain about
> the "--contains", no?
>
> We can fix both of the above issues by making these into an if/else
> if/ cascade, i.e.
>
> 	if (filter.lines !=3D -1)
> 		only_in_list =3D "-n";
> 	else if (filter.with_commit)
> 		only_in_list =3D "--contains";
> 	...
> 	if (only_in_list)
> 		die(_("the '%s' option is only allowed..."), only_in_list);
>
> And I think you forgot to mark the message that was factored out for
> translation.

Does it really matter? I.e. we've got plenty of options parsing code in
various places that might complain about issues A and B with your
command-line, but will only emit one of those at a time.

So if you've got A and B you'll need to play the whack-a-mole game of
fixing A, only to then run into B.

It really doesn't change things from a practical POV that we'll now
complain about B first, only to complain about A later.

Ideally we'd spot and emit all of the issues, as e.g. my [1] does for
some unrelated code.

But until such an improvement something as trivial as minimizing the
diff size (i.e. not needing "if" -> "else if") seems preferrable to
slavishly maintaining compatibility with the exact sequence of errors
we'd emit before.

1. https://lore.kernel.org/git/RFC-patch-09.21-9c6af87c6c9-20211115T220831Z=
-avarab@gmail.com/
