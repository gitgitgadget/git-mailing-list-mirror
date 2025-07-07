Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA052BEC31
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897721; cv=none; b=Rram1tgv8aL+NY7Kn5Y36r3oZnR3b7u8dTSbwjsc5FbrSEDHT6a+jJRXMM3Ct02VaZqUzhpLk7m6b9N0UhR64Q7z24pss2gJADaHKnwb4UhghGNFp0HaFpOMfPWCUfPQlZXPmZB9H9Lo4GwgKcmfvz1MO4ekGLu87KsAXoL56Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897721; c=relaxed/simple;
	bh=r+rK5OH3lxOcViCUhl0C1PdVObst7/JPBz1/9E9wjk8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fmxc+p7NrFI/WlWNRM/MQnXm4E+J+GdbUhs2GPsrDebQCV0Rn44rJeEpjJhSCk2mNQ3qGdsf2f912IRmHm6r+wwWTxyJlT/V8MtU2RDLMZHtP6tgDbM9+VL/37FANaXommkKiJ/9NF1CtJL6HLMjNkbR8UjlAD6P0QtCkGNxEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz8t1751897674tc74cf793
X-QQ-Originating-IP: bzzW6hDuDTPbCSjupDvX8SpEjcB458G+fRgEX6gNtCU=
Received: from smtpclient.apple ( [202.119.43.124])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 22:14:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12594746258158291414
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 3/4] bloom: replace struct bloom_key * with struct
 bloom_keyvec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <65dc80f9-a91c-463b-9c6b-cb20d293432b@gmail.com>
Date: Mon, 7 Jul 2025 22:14:22 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DB7714D-4009-47C4-A8F7-1C375C6D29AF@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-4-502024330056@smail.nju.edu.cn>
 <65dc80f9-a91c-463b-9c6b-cb20d293432b@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mn6sU2dhbGGPfL4ohwsaSDaFedBwYdF4q0rPFsCHBftrUUycaHuEO8JF
	7jhXrb25EYkOjs2IN4QcvVlrVYTC/AqHC4m+CQ9n+9mLxc6UHQvT6jbhCVqs7+DBz7zu8nJ
	nU6AdzDfNn0G6AUVkFd31SnDEZaCjR4Vd96aEJlV7NU0Ryiw65i5oEZEk2NQLJPBZgKxFoK
	P8AvQcSrz0fbVTxHciPgvh9rAMFrJwLz6cPLSXJcWkmgKnfYq0BYbxh9dUo3TN0b8+Aj1b9
	H5M37QTDskCcIoFMqX/4AnE5/P2DndAaP8XblDEHamT0DK86ekIneihTud7EqCl7HZS1VeI
	wQcCdUkLx9uM5Whc0OMQQuqMzGpdA30EfZG2D8aaqVAPU5rtkRX3lUKDtIE8NzW29L83hRu
	qhmOgt6WbbF6AZWGOIFASpgeBIO8A+0oMKnx8iYaBGeLxP/VEvEF3FHe/vaymt8TXtxE71y
	2jTN8/QJvZ/qrCuX6Wk4Lu4n9RQkP01ZvMMtqasu9+1jRRbiCjVB7K6yZrBK33o+dzihvwk
	zoF13fg/Vf4QYZ37N19k7QvKQjw0k1jUxyT0P+9oe0A+w5bUh4enZJ3sgKI5XE4OOAvKt22
	hZN/SgQyCKKt9Bns4NntdpmrnkIsrNv84Rt1eL2psQPVsKjmoZnwa9YM0o/ODw5Xu3/zC6D
	3sb9IRMM2Y7PZPQelBE3w+rUUnB+HZa9HOVtYkuIMz+WX/FFirXp62rMGmkNPZCBqT4w+kj
	2GTO3Gkq9ugYRFDcn9eEHyYyX5SC5IbIxSljndvYcGG3+c/gSEaBoQKNHxlt2iM7QGegu67
	aypChHSTjTSdWWaXDCyzeuYBEtXOOqbzf/4VRPim48z6Eilcly2yOivB9NfgE9KCwPEwxoh
	XM8BsQOBQbbhb3hJ+Hf6JsEgRnimALv1DE6YOVFSRw+fYqPQXjqGtVfKHiG/mTwlDkYxBru
	N6tUonc7DWrDTkKNixukFvtlV1+Qy14PcAzH2fSqK3Bf7YagRoUcP1Zd8FejhBOD31vAfAx
	pjgh3DywvFe3qgUHjJ
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Derrick Stolee <stolee@gmail.com> wrote:
>=20
> BEFORE: "NOT TREESAME if there EXISTS a bloom key that reports NO"
>=20
> AFTER: "NOT TREESAME if FOR EVERY pathspec there EXISTS a bloom key
>        that reports NO."
>=20
> This "FOR EVERY" condition makes it impossible to use a flat array
> of bloom keys for multiple pathspecs, justifying this change.
>=20
> What is further confusing here is that we already have logic that
> deals with arrays of bloom keys, so I expected that the vector was
> the single structure storing a list of those arrays. Instead, the
> vector is replacing the array itself. This is made clear by using
> the vector immediately in the existing implementation.

I think the problem here is that it clearly enough in my comments.
When writing the code, I thought about converting the original
one-dimensional array struct bloom_key *keys into a two-dimensional
array struct bloom_key **. Then I came up with the idea that this
two-dimensional array could be designed as struct bloom_keyvec *keyvecs,
which might be clearer. Each struct bloom_keyvec would represent all the
bloom_key elements for a single pathspec item.

>> +struct bloom_keyvec *bloom_keyvec_new(size_t count)
>> +{
>> + struct bloom_keyvec *vec;
>> + size_t sz =3D sizeof(struct bloom_keyvec);
>> + sz +=3D count * sizeof(struct bloom_key);
>> + vec =3D (struct bloom_keyvec *)xcalloc(1, sz);
> You could use CALLOC_ARRAY() to simplify this and drop
> the 'sz' variable.

You are right. I think you suggest to write struct bloom_keyvec like:

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94-
|        count        |
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
|         *keys       |  =E2=80=94=E2=80=94>     key0 | key1 | key2 | =
=E2=80=A6 |
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

And I am doing here makes struct bloom_keyvec looks like

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
|       count        |
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
|        key[0]      |
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
|        key[1]      |
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
|        =E2=80=A6            |

Although bloom_keyvec_new() appears more complex, the advantage
is that bloom_keyvec_destroy() no longer needs to free keys manually.
And if I understand correctly, junio had suggested to use the second way
[here](https://lore.kernel.org/git/xmqqtt43u36t.fsf@gitster.g/).

>=20
>> + vec->count =3D count;
>> + return vec;
>> +}
>> +
>> +void bloom_keyvec_free(struct bloom_keyvec *vec)
>> +{
>> + if (!vec)
>> + return;
>> + for (size_t nr =3D 0; nr < vec->count; nr++)
>> + bloom_key_clear(&vec->key[nr]);
>> + free(vec);
>> +}
>> +
>> static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
>>       const struct hashmap_entry *eptr,
>>       const struct hashmap_entry *entry_or_key,
>> @@ -541,6 +560,18 @@ int bloom_filter_contains(const struct =
bloom_filter *filter,
>> return 1;
>> }
>>=20
>> +int bloom_filter_contains_vec(const struct bloom_filter *filter,
>> +      const struct bloom_keyvec *vec,
>> +      const struct bloom_filter_settings *settings)
>> +{
>> + int ret =3D 1;
>> +
>> + for (size_t nr =3D 0; ret > 0 && nr < vec->count; nr++)
>> + ret =3D bloom_filter_contains(filter, &vec->key[nr], settings);
>> +
>> + return ret;
>> +}
>=20
> This implementation is where the subtle detail comes in. Might be =
worth
> a comment to say "if any key in this list is not contained in the =
filter,
> then the filter doesn't match this vector."

I will add comment in the next version

Thank you for your review,
Lidong

