Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6973A4AD6
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594748; cv=none; b=nENPHTpg7Lyy3sFZBePEzDllZ6bLv3SN6A8n7cOGxwM41Kx74O6jaQDMW3i2mYWHo4i2EispoBvhCzjmO/TrlHx8nt4N9aUgcxa3sAZvw2ndxTMbwDktibaFZl7I2El79MQU82U9KfqQsly1rpOmOrSkW60gJtkb1T+XOXk7X60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594748; c=relaxed/simple;
	bh=tVHPooSJPqeIflUSbN8iTKKGhy0Gugrwd+TvpyoSVkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glIOZVjQCjSYauV72/IzVM9Iv1W6iWuF7WfAKK9ifeZ9lBrdMz0VpB15SUsDYPnlMiOR5UJWDQuyMGwpPJyU7qN6+ZW/R7ksth+DCp6O+9kFh3c/v2ZfO2KMK3q4B9v1BWXV1aQT8kH2MFlqhg4XhsEPCTiOb5om8qOVU8FsZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=iRiZ4FdA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="iRiZ4FdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768594742; x=1769199542; i=l.s.r@web.de;
	bh=WMddSBMrL6Qz6P74shvtFAlhlGh/hUn7rvPDPAQljF8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iRiZ4FdAbIkhfCdiTLEJWlo9/131n9RlWjTTQJlzBw5B/WG0KzSD/SQSCL57UVjO
	 1CE8DiCrunH6PMXvNs0ZanpzCkg15W2P/IsjAujqg0Sr8VTUYanJ9lSbCAcKocBMM
	 8b7DUsy3IKy0C92W/j8uo3mCaVg7kkR5V2uuChpVndKqJOs8zoP3cT89CipbuSP1D
	 H5LjbZhJ4IeVZc6Ps8EoByVySqwWN/uv2gtowsTatkLRxq4IFf3ZoM9fdJ/DlVfNW
	 abmG8t1GfYwyapUgouDrHNU7psUiSAmml/xSLY02iE5xtVdhrrwCQpyuQFUFROZ9m
	 /uVezAVi0kGy2n4Ywg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1vanay29k6-00H663; Fri, 16
 Jan 2026 21:19:02 +0100
Message-ID: <0a306227-5db8-4d12-865c-fa0efe5c6beb@web.de>
Date: Fri, 16 Jan 2026 21:19:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pVzmWKSVDF1ErVH3zjk6h/WKAYqzEKMUZeauCS6C4IMmBovacgm
 osp891XmoT9oUQj5aOzUTEwzhYwCuVN29NqwOWCw++cgTW+2kIdKBNMsydx1tZeja1BZluy
 hk9jKzCi+nkcnlF4cFhvfdgmOTltzJOSkU39WTplIpMvIGjswSy146SeLsihwnXX5NiZKoq
 kfrO09PQAxhY9cuCH9ZpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MgRpku4YfiQ=;9R+DD6FBA3Yx9stVlkx+LHzk77G
 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

On 1/2/26 7:52 PM, Ezekiel Newren via GitGitGadget wrote:
> diff --git a/compat/ivec.c b/compat/ivec.c
> new file mode 100644
> index 0000000000..0a777e78dc
> --- /dev/null
> +++ b/compat/ivec.c
> @@ -0,0 +1,113 @@
> +#include "ivec.h"
> +
> +struct IVec_c_void {
> +	void *ptr;
> +	size_t length;
> +	size_t capacity;
> +	size_t element_size;
> +};
> +
> +static void _set_capacity(void *self_, size_t new_capacity)
> +{
> +	struct IVec_c_void *self =3D self_;
> +
> +	if (new_capacity =3D=3D self->capacity) {
> +		return;
> +	}
> +	if (new_capacity =3D=3D 0) {
> +		free(self->ptr);
> +		self->ptr =3D NULL;
> +	} else {
> +		self->ptr =3D realloc(self->ptr, new_capacity * self->element_size);
> +	}
> +	self->capacity =3D new_capacity;
> +}
> +
> +
> +void ivec_init(void *self_, size_t element_size)
> +{
> +	struct IVec_c_void *self =3D self_;
> +
> +	self->ptr =3D NULL;
> +	self->length =3D 0;
> +	self->capacity =3D 0;
> +	self->element_size =3D element_size;
> +}
> +
> +void ivec_zero(void *self_, size_t capacity)
> +{
> +	struct IVec_c_void *self =3D self_;
> +
> +	self->ptr =3D calloc(capacity, self->element_size);
> +	self->length =3D capacity;
> +	self->capacity =3D capacity;
> +	// DO NOT MODIFY element_size!!!
> +}
> +
> +void ivec_reserve_exact(void *self_, size_t additional)
> +{
> +	struct IVec_c_void *self =3D self_;
> +
> +	_set_capacity(self, self->capacity + additional);
> +}
> +
> +void ivec_reserve(void *self_, size_t additional)
> +{
> +	struct IVec_c_void *self =3D self_;
> +
> +	size_t growby =3D 128;
> +	if (self->capacity > growby)
> +		growby =3D self->capacity;
> +	if (additional > growby)
> +		growby =3D additional;
> +
> +	_set_capacity(self, self->capacity + growby);
> +}

Constant growth steps like these cause linear growth and quadratic
complexity.  ALLOC_GROW does exponential growth with factor 1.5 to
get linear complexity.  Here's an old plea to do the same:
https://blog.mozilla.org/nnethercote/2014/11/04/please-grow-your-buffers-e=
xponentially/

Ren=C3=A9

