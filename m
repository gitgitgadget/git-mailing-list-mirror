Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD97C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 12:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiAMMQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiAMMQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 07:16:46 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B9C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:16:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o6so22357797edc.4
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ke3b3VENKAR4ksWOrnggzaY5r03zh9It+ysPVespYrM=;
        b=DUbMyLvndB9DzLCoQtYmyqZIQCaj6SevIKoQQXTfLcVdzPIAFYK4Mh3RKVQka2Xa/q
         wUb39zhc6WdPsTGX6C5xPoUoytjfpsYj5N00r4+VFQRSWnCVsRk/1bRGEpCo0HkBIW4b
         m3NEmf70xG8M11juOA+kgAzPfYF4YVgR8TPBRuHa2kSmSTM6yjnO3uWHcmURdGcIpB1I
         QyG9Qcz7BYSqmWTfPsyCDa8HqycdM4wkUDpb304suw7sFcYkgUh+OjPOiEyaIfyQGibx
         QPlrAErLuoJlMS/OeTTMOSpHv8cfkfWmwSByxsK//cmRsuDXH88z2FSs0LP+qUelP5gC
         DgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ke3b3VENKAR4ksWOrnggzaY5r03zh9It+ysPVespYrM=;
        b=Gl/7pjXa3B61rcFu+NikyTTtkHt724jQiVzNvwRaLiL5aDEigSiB3RsriAH+pBrCu5
         VezL6uI/3oicxPmN6hr+ggLxHc3OjCw3zHP5nCGbFgADxCRLLpmzT4PfQV237hCswajQ
         tbDcoW4RbooBvIOVabPbQhaFndPSdJTz1qGbRZ714XxVjIBVLmTNmbmIp5p40fa4ZSx/
         KyUsALDa/J/4BI2WSaroDsXBYyuJG8RqC0XTe1GG9qex4BYfByc7bFjzTL49q8jM6Po5
         NzDqhI7LTliTlSnupOcv4riFkOpBR8UURrCFkJmJX0mcoArqSNC5eAr1fN0P2RSusOPN
         KSpg==
X-Gm-Message-State: AOAM533SrWrBj0Ca3ZMX+C9OSuLBlyHOalZQpYd5lMQRnb5Q4iU0FCB+
        F44oBKgGqpnxzvEz36i6xSs=
X-Google-Smtp-Source: ABdhPJzPGu5ER+rqlbUSOI3l5TbmBOhvwkOTwTp+Y28NyfAOofFVvHWpwfouzAeM/LgrgmA0JNXwbQ==
X-Received: by 2002:a17:907:7f1d:: with SMTP id qf29mr3284201ejc.388.1642076204424;
        Thu, 13 Jan 2022 04:16:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12sm815533ejk.188.2022.01.13.04.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:16:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7z23-000uKU-BA;
        Thu, 13 Jan 2022 13:16:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 1/3] refs API: use "failure_errno", not "errno"
Date:   Thu, 13 Jan 2022 13:14:59 +0100
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
 <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
 <patch-v3-1.3-a45268ac24b-20220112T123117Z-avarab@gmail.com>
 <xmqqh7a8u3my.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqh7a8u3my.fsf@gitster.g>
Message-ID: <220113.86pmovvnis.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> @@ -1722,8 +1722,6 @@ const char *refs_resolve_ref_unsafe(struct ref_sto=
re *refs,
>>  		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
>>  				      &read_flags, failure_errno)) {
>>  			*flags |=3D read_flags;
>> -			if (errno)
>> -				*failure_errno =3D errno;
>
> Looks good.=20=20
>
> The whole point of passing failure_errno down to refs_read_raw_ref()
> is that we capture the reason of the failure there without having to
> rely on errno at this point in the flow.  Removal of this assignment
> makes perfect sense.
>
> But ...
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index b529fdf237e..43a3b882d7c 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -382,7 +382,6 @@ static int files_read_raw_ref(struct ref_store *ref_=
store, const char *refname,
>>  	if (lstat(path, &st) < 0) {
>>  		int ignore_errno;
>>  		myerr =3D errno;
>> -		errno =3D 0;
>>  		if (myerr !=3D ENOENT)
>>  			goto out;
>>  		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
>> @@ -399,7 +398,6 @@ static int files_read_raw_ref(struct ref_store *ref_=
store, const char *refname,
>>  		strbuf_reset(&sb_contents);
>>  		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
>>  			myerr =3D errno;
>> -			errno =3D 0;
>>  			if (myerr =3D=3D ENOENT || myerr =3D=3D EINVAL)
>>  				/* inconsistent with lstat; retry */
>>  				goto stat_ref;
>> @@ -469,6 +467,7 @@ static int files_read_raw_ref(struct ref_store *ref_=
store, const char *refname,
>>=20=20
>>  	strbuf_release(&sb_path);
>>  	strbuf_release(&sb_contents);
>> +	errno =3D 0;
>>  	return ret;
>>  }
>
> ... it is not clear to me if this part makes sense.  If everybody
> above the callstack uses failure_errno as the source of truth,
> clearing errno here in this function should not be necessary and is
> misleading to readers of the code, no?

It's consistent with various other existing refs* code as we made this
transition, see:

    git grep -W 'errno =3D 0' -- 'refs*'

I.e. we'd like to not only transition existing users away from errno,
but to ensure that the file backend errno semantics don't inadvertently
leak outside the API.

Doing so is a bit pedantic for sure, but ensures that we won't need to
deal with any subtle bugs in that are with the reftable backend.
