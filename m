Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A9DDA8
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837196; cv=none; b=BRXWPEUsjXmuKw6j/INRxtTNEfJpNj8usod4IEzGi8f54zg9YV/+zt1ErdejkGwY6fbCvDytvHUN6gvhj678RZzTg0QajifO+NNLxx5kB6OryIaKyzAgoYFZsW/3v2EAmlxZ0rf6rCm9IjfZsIB9nuzAUeDaNE4VI+NavEtmBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837196; c=relaxed/simple;
	bh=3ZeiWjppdkydnE3yRtXIfUYVXlvO8fcjpBnQAYqJo0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlAL/5jHd4oQIABL+jlUaU7VfVxtDJwYQkTQ8EHG1QQ9cvvsLcat7EB96q21zIJadGkqdL7vFuBjivfBY9MLzv6r0s5bXtWPD7FjlokkOv+HvbPwLL6hp/ORhrqQHaMU7jEGsyJnZyTfYLLZwCU4QTmH7c/FJuamErfdwDU20MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=D2Xu8oLc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="D2Xu8oLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731837161; x=1732441961; i=l.s.r@web.de;
	bh=AvKr9ChaRssPvBEvybuoV8c3rC3dGEf0LWTyK75Q0Ic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D2Xu8oLc0rqh3zxBnDUGCpCx+JZJMvXiV40GwrnQqTyrgykdmfyTo/4CWV5L7u1g
	 uHnLKAzY8MDzStQb2BWLaaZgFdu+S1B3Yz9p60KaRPsf5xXckGX2HKBRDUPoBSMdV
	 uEQa92U5AgNbzrmW8FLdReYTfHvBQWmO8T+C/anLAsSRnEj8+W6ZHVtzgZw/1iiEm
	 9gNvFWmwPn0dykM68yNRlzyiRBvSpDBg2pAf4/tCotqQnOAEIZYPhlNRzNOs7jjHc
	 siolOOEXgp4wi79x6ngoJYSrouqvUkQkAS6mwIHIigBbp0jIOKrVQONbOzWVbYOoI
	 VpEuSEVpR7lDyjAzIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1tQgRA1v1x-00Lez1; Sun, 17
 Nov 2024 10:52:41 +0100
Message-ID: <85d78ade-dbf4-4116-836e-a49c33324947@web.de>
Date: Sun, 17 Nov 2024 10:52:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] object-file: prefer array-of-bytes initializer for
 hash literals
To: Jeff King <peff@peff.net>, Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241117090814.GA3409496@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20241117090814.GA3409496@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EqYlJHUdDG79pcM06wkYIwIleReX2L04vyypJt+S/NddRNihCyx
 hpfdksFT7y0uK7Ut5RDzX+dEf2fSqYluFCGYVgmSs6u+k0WLGecApXh+MRpn8fE4oYfJJjF
 OkJCQxdE/Soc4KCjdzFJcLGMFf320JLDEx8gaSNZEZ2dN3vrG7zwJdq5XAEHrDY58l1B4r5
 EY6RYAjvqZS/dkHG+8sPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PG4J1vTfsNM=;Hst7ZBB30xuNf5rqS796TrqqzD4
 0g+afUzaNJHxBgsuOV5dV4xlsSljx5cxJT5ZF16W9Gm6hTaDoJmDgv57umj/3pxBje80SQ4hd
 49yUsm9niUZytEPJyTPZInnz3nSJDoB9m2vfd64IHOmdaLHbmFpTNJG+0/a5PYn6q8tW6qa+o
 tbresroYYgeQpUo+9ealT4XFq7byW358LLCfg5oYrhxlWSt2apQKbq/2zAC2SOPhTQ6Giw3Vk
 kwHerJ0eYWAAMtwoalxUmqj+RX+gFJarHKZiUnPFKy/1L4D9/H2h4ebLfqmVCT5gxvO92Biye
 U62uxE+ocW4fy+f6WTTcorHLGKluLvjYfbnjBtYLXoueYXi9sjq9E1NtpFc3ITyNcwA6esvzw
 jsJ7MnYRuOQowlZ3+gOgrEhLOW3Z0N2P9v4n83P7D+THA51ORy3+ak4YQVOs13GSVlP1zzVs9
 +6/JU6pCAMcaj4CFv/pEb4PEjfmT6WbRBG8e4XL1qPf/Pgp3g8k4z9boE28/LS1AriqmgU9Jd
 9sW4Bm3+2Dtluo07AvqrijgxsB0nvycmGll5G1EM1gV/rRM2/QMZMcXKJqQEuPG69sZuuxzDr
 a8UVuXuAcX+NV6QK6c6Yy3B2AK3zvBPqpIspmZNGkzau8HdRfW6AkGLzCoeuLuP2lhhE58va9
 Xd9KEvvqPHtg8OssQ+B+OZij0unUJmC4ZfuOX/iYW1LHhS4zvOeQYiMYjNI7DQhhEhnKoHxUz
 nJeAXHs/HkrgLJs1t8oCDxY+KzFma66AQMfRYVw7e5TFGiWORgmb84lCcV5lY7ZHn8ADpyvw4
 mG//9pIAzEw8f/Lm0vsSMhJcac1FuTW5dmo0Q5umFSPYMQ5scnan//PM1D72bR7fbuab8rdeO
 qHVrzdowNAR24kaPfdc/zBeE0bxSx2H43uJDWBqL2bY+NArZ6+k7Gs/bo

Am 17.11.24 um 10:08 schrieb Jeff King:
> We hard-code a few well-known hash values for empty trees and blobs in
> both sha1 and sha256 formats. We do so with string literals like this:
>
>   #define EMPTY_TREE_SHA256_BIN_LITERAL \
>          "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
>          "\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
>          "\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
>          "\x53\x21"
>
> and then use it to initialize the hash field of an object_id struct.
> That hash field is exactly 32 bytes long (the size we need for sha256).
> But the string literal above is actually 33 bytes long due to the NUL
> terminator. It's legal in C to initialize from a longer string literal;
> the extra bytes are just ignored.
>
> However, the upcoming gcc 15 will start warning about this:
>
>       CC object-file.o
>   object-file.c:52:9: warning: initializer-string for array of =E2=80=98=
unsigned char=E2=80=99 is too long [-Wunterminated-string-initialization]
>      52 |         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   object-file.c:79:17: note: in expansion of macro =E2=80=98EMPTY_TREE_S=
HA256_BIN_LITERAL=E2=80=99
>
> which is understandable. Even though this is not a bug for us, since we
> do not care about the NUL terminator (and are just using the literal as
> a convenient format), it would be easy to accidentally create an array
> that was mistakenly unterminated.
>
> We can avoid this warning by switching the initializer to an actual
> array of unsigned values. That arguably demonstrates our intent more
> clearly anyway.

OK.

> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I actually didn't find exact wording in the standard for using a
> longer literal. But C99 section 6.7.8 (Initialization), para 32 shows
> this exact case as "example 8".
>
> You can view the diff with "--color-words --word-diff-regex=3D." to more
> clearly see that the values themselves weren't changed.
>
>  object-file.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index b1a3463852..25ba54594b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -45,23 +45,27 @@
>  #define MAX_HEADER_LEN 32
>
>
> -#define EMPTY_TREE_SHA1_BIN_LITERAL \
> -	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
> -	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
> -#define EMPTY_TREE_SHA256_BIN_LITERAL \
> -	"\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
> -	"\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
> -	"\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
> -	"\x53\x21"
> -
> -#define EMPTY_BLOB_SHA1_BIN_LITERAL \
> -	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
> -	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
> -#define EMPTY_BLOB_SHA256_BIN_LITERAL \
> -	"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
> -	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
> -	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
> -	"\x18\x13"
> +#define EMPTY_TREE_SHA1_BIN_LITERAL { \
> +	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
> +	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \

The added space at the beginning looks seems unintended.

The two spaces before the backslash look odd.  One space, one tab or
lining up the backslashes with spaces would look better.

Patch 5 does away with those spaces, thankfully. :)

> +}
> +#define EMPTY_TREE_SHA256_BIN_LITERAL { \
> +	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,  \
> +	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,  \
> +	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,  \
> +	0x53, 0x21 \
> +}
> +
> +#define EMPTY_BLOB_SHA1_BIN_LITERAL { \
> +	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,  \
> +	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91  \
> +}
> +#define EMPTY_BLOB_SHA256_BIN_LITERAL { \
> +	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,  \
> +	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,  \
> +	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,  \
> +	0x18, 0x13 \
> +}
>
>  static const struct object_id empty_tree_oid =3D {
>  	.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,

