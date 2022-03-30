Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FBEC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiC3Tmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiC3Tmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:42:39 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396A7AE77
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1648669244;
        bh=rUnletbAdGEbdEHbTQyjhrGPTLxuvoLqY8A8TudjXdQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lHVvbjb/vNFvgVbQwH991ks8JOImQ/FMS8E26+/sq7G9Y6UVAc5dsktYn9TbFAI4D
         R9iAvvef09KSFInOq6ziVYOr5t/OQCRsYjbef9Bg7TU1dba5RbsaAEQ/p6+Om5E/fv
         Fa3Cs1NYTDhp4qe56H7MiXb9k6EgPiOSu6rdFK2c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1oAMuQ0jFu-00d8kh; Wed, 30
 Mar 2022 21:40:44 +0200
Message-ID: <2f98c63d-f2c9-26fe-cfd3-9eed6b79047a@web.de>
Date:   Wed, 30 Mar 2022 21:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v12 7/8] unpack-objects: refactor away
 unpack_non_delta_entry()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
 <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <patch-v12-7.8-11f7aa026b4-20220329T135446Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v12-7.8-11f7aa026b4-20220329T135446Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1d3zeuqppMw3cdtl95Wpj6wgTA1DUqoy6Ydmx/YSsHpcsQSZ9y
 rkvX7R8ykfNMRfqgexY78+8dAA7ypz9eDGUry9z42jKu1vBp0QGAAWppy6oTmNXdnskn8Xr
 OEPZNx8Ix45E5Y8jG5siPW+9qBxpAvJtaKdIs/FuPiyrghJIdjHVh8NYXZ1RvYy6mhQLmFo
 7GItTKzG3AF9e0KxoPk1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y+T4yki9XdY=:3um1A2s/vYMhs0FtIoG7wf
 +kdIZgJhSA9ledVUcz0e+JcLVgv6QCVNtLpU2praVni62utk86JtGHi0MMVsyr2gyic1z8PTU
 CsFYeEVruUBKX1tXiLe42WCn7XMh/Ed4+ppDCOmCKOqes3PvVHcxFPdSTvzwJU4am+sq5sZF+
 F0fY25avRJBpiOcQ21dxdpt9Xbl3lFEZUmq2E7RIcD3nUsL47+suUN9zGZxnqVrL/z/gVe8wl
 5Vcybe6djeqmTz7NniH+rx4k4FCfOr5Axc+M07ycrTmg3r+BfFlQqqYYDqYJPv128YFpfr445
 JuO/oiljBjLd1AfWo679NAhxd9anp8YQ+ekqTFJE1eGGYDuKpUNVZ3OJor0jFzVUI/1XurCux
 O3Nhh55GO41JLwx4n6pbaQG+wQolYyY34wHyN5+0OwV+AFCknDedr4bRObH7FgpeUaQlzJRMr
 MbosylGqGdU1stlulTIHVkuOG8J9uVsU+JLbfsj5IowGTkamEJtzyxr8sHdBxYdn1Cyr8Ux+0
 D8RZPJkAQYcUCTQplTTdNF75iINdMD1mlzBXDgP5uRqORVP7v1UMfjiAGUCPQm5sq3jaIAH0R
 hPEvi8yIy19B4TlPTQUfCZHAIJBS990hKC/TnQnssrclgSsZ8nzjn8X9JdOxQo3Xb9rBdpsea
 1FsHubnSnlqtBxviNPkLONwbewdmye0lRY68NiYun9dtQ6cjsejPG4/ZQ5r1TkcNg2slFqFMT
 Pi1KKGRbZGAqxbQAFXpPaGjF+cChBPBXv9zy9Jw43rrR7xoCAde346kOA9fguJj4/zcLcjXrY
 38Dqg6PdhV83wx3d44g17IVMWmlUpoLdGnT6hi0Tlr+t1D01DTOtZjgDsoCdr5eZcD8DRFb9d
 oKQVUzlwitXSNPcNSAtadIgx3iJ6egQxZ5YGKk1KEhamn4AJRIBc0jhVfEOY8O7XduaYBsojI
 L751ndLbfJUsU1fVP92TohIW8iK9hgTL6fruggG44YDeKoX1YqjcDym10abMoYzemK+CFoZ9S
 HUP3pPYVBUfuHR9Gf+t88+JNovLidEp5K8q5gXoYvHUJo1TV2V9qUbkVm+72KmjC8g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.03.22 um 15:56 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> The unpack_one() function will call either a non-trivial
> unpack_delta_entry() or a trivial unpack_non_delta_entry(). Let's
> inline the latter in the only caller.
>
> Since 21666f1aae4 (convert object type handling from a string to a
> number, 2007-02-26) the unpack_non_delta_entry() function has been
> rather trivial, and in a preceding commit the "dry_run" condition it
> was handling went away.
>
> This is not done as an optimization, as the compiler will easily
> discover that it can do the same, rather this makes a subsequent
> commit easier to reason about.

How exactly does inlining the function make the next patch easier to
understand or discuss?  Plugging in the stream_blob() call to handle the
big blobs looks the same with or without the unpack_non_delta_entry()
call to me.

> As it'll be handling "OBJ_BLOB" in a
> special manner let's re-arrange that "case" in preparation for that
> change.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/unpack-objects.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Reducing the number of lines can be an advantage. *shrug*

>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index e3d30025979..d374599d544 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -338,15 +338,6 @@ static void added_object(unsigned nr, enum object_t=
ype type,
>  	}
>  }
>
> -static void unpack_non_delta_entry(enum object_type type, unsigned long=
 size,
> -				   unsigned nr)
> -{
> -	void *buf =3D get_data(size);
> -
> -	if (buf)
> -		write_object(nr, type, buf, size);
> -}
> -
>  static int resolve_against_held(unsigned nr, const struct object_id *ba=
se,
>  				void *delta_data, unsigned long delta_size)
>  {
> @@ -479,12 +470,17 @@ static void unpack_one(unsigned nr)
>  	}
>
>  	switch (type) {
> +	case OBJ_BLOB:
>  	case OBJ_COMMIT:
>  	case OBJ_TREE:
> -	case OBJ_BLOB:
>  	case OBJ_TAG:
> -		unpack_non_delta_entry(type, size, nr);
> +	{
> +		void *buf =3D get_data(size);
> +
> +		if (buf)
> +			write_object(nr, type, buf, size);
>  		return;
> +	}
>  	case OBJ_REF_DELTA:
>  	case OBJ_OFS_DELTA:
>  		unpack_delta_entry(type, size, nr);
