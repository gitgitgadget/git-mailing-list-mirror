Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238881ACE
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325800; cv=none; b=lEZHLbFAIdm6tViQzuhq7a8yBnghX6yFLuhBUZSqzlxlbXDDQjYyICw6ThjMJJ1cEoPgA+9qyHgooS1ZbVWFHY1Wl3K0EddXG4wF7ZHuVwR4JSZexSz7DlDXyKBqNT5CLs37+KZKlomQsWiIJruWixkJ0fuavAzCKVNqZUY87uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325800; c=relaxed/simple;
	bh=SNP0fJQN9/sV2qp9pYpMJt7beo2009D5YIgXICt7JZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRVridcMYe73bk+/9KcPZdW8MhhfLjCTwgtxUqCAh7zwcI1lJ4Vk2YqZ2yNP5j1uKUlDiIVmQk2Cv8QIvCamepDokL9ZuNeoIMObVWbzr4og5XR2+/10HTOX1Ashu1xpGXEDe/+hbC9CChQQJpGn3Et0CeMiFNoMySjnm//B9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=kOHuCBi9; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kOHuCBi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707325794; x=1707930594; i=l.s.r@web.de;
	bh=SNP0fJQN9/sV2qp9pYpMJt7beo2009D5YIgXICt7JZ4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kOHuCBi9F8ZOsBHKFzPWbrMVMfS3FovxAVFMoElOyTLssqQaAVsch8BfcsT8oTlU
	 tOmihjZAXGHV1Vh79hGjbsI8Izu7BeC+UFCSVokH17roj85dvdWv4VnkkK9fUY9OV
	 uErUlHxGPWSyiotg3FS/WHm3wYzq0JI8NgmUZ3/zi1vZoHw5bLy0Gxhd50gYrOAHH
	 Lh3ABgx7Ru/F9NnjAWDDy8/4x18czhPJ0ATWczH5gP/UTMRUgKhmm8YwsZJFtVDD4
	 k7e0Tgdl56d6VejGg9HHWp7goMnzrvDAY4SthIAFIHALECKzmp67RsSjgEJSt9fbB
	 dlQ25iDIoqm/OG6HtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.60]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1rZPKK2ehG-002oMc; Wed, 07
 Feb 2024 18:09:54 +0100
Message-ID: <e7b269ea-6a10-4f3c-ae97-a58eb7ccc6ef@web.de>
Date: Wed, 7 Feb 2024 18:09:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit.c: ensure find_header_mem() doesn't scan beyond
 given range
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
 Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
 <pull.1652.v2.git.1707314246530.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1652.v2.git.1707314246530.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yghSriA8qMhDf2ZzJK9f5AdP8P/2UDpao0j6f3kgUxtrOfifeia
 EL6ys/sm1t1Glxs4ZDrGaBTUBoMyiS0PGJEiyfX5P+vfgaG2g7SGOPrF0XfkZ3MBSCK8vhS
 e7jSvr/JFL5EuPjpScQ5kKWJJnQisqxifLe8u0evnrtmUSjeAsnb3NmKW5OkEtAkN9ThAjY
 PTdJvtKMK5jH8NOq0scKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aYNwjG+FMio=;54CaN1YJ31HDQKy8H0ajHXm7cg3
 nTGDdlmyYN6HTWHW4blBF18szDgD6tO5/+WkJcp3SkTVMgIxJWzXjNiItl7Nc41c91OjT5FEe
 +P9VREkrXrQx+VtU/xQzbybkjLx37tJMdpDUNzHnbwmVLF9DRz+PgX198G9addMxWbRUC0BwC
 UOhKfYZfSqmq8hZRcY3xbTxFGVDuFTCbaSVESUmN6kgL8m3uxByNEvuCujm7VeJT/T/21vG0B
 zclpO0Dw0pyt6i4N/eW5mQXLOwphiTXkfJviX7ELJ3vDx7yVajgj9NqkK+iIZTnEBYosbPHGe
 ISzjmbdbZpLfDa5uiHuw4Rj6zAuQ8rP+Ya50eYHLzXcPxC53x/SbEIBwnNibmEJqHgGBoLNjh
 Y/AuDkgWnJM3RcOX9BB3/HzoFaWtF5r8cmMOdMQM/9MSb7d6c9A0nVT7nEfEWiKPcg545gt4L
 q/vNgDxyrXNgnUt3wUxVynXBhyNVnuMwnSl75VXVhbCnPsRUOzXyJ1hpoghzvmgEowX0KrIv1
 iK4wOx/CX6is7K+MeD+wFXstL4phAtPT+yclStMqyuccmromGDNbpLwa3348zrve1uJn4soiU
 x9GeyIcpRdbbR5t4xQeBBpQbxm5amA8k9o7rEChAxh1UCc+pl0Nt3lD3t/1Md2GX/nPlV15HU
 aIYL8fTsXNcTlme5Z2XLHQfsQPv0NHQfQuvbWLz06p1RHpZSLmk7X5NFoawoJuS48y4aKrDJM
 I1qRZvQiyjgT+VaE09lOIuAuydIjSXVa4RBEPe21Mckj9WjTDn4P1pquQE+6VEDPEwx8eEtrA
 xpFnSZO0qKkkN2XVizuLtR6RzN7kAWSOArlRj/LWDLaig=

Am 07.02.24 um 14:57 schrieb Chandra Pratap via GitGitGadget:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     commit.c: ensure find_header_mem() doesn't scan beyond given range
>
>     Thanks for the feedback, Kyle and Ren=C3=A9! I have update the patch=
 to
>     actually solve the problem at hand but I am not very sure about the
>     resulting dropping of const-ness of 'eol' from this and how big of a
>     problem it might create (if any). I wonder if a custom strchrnul() i=
s
>     the best solution to this after all.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1652%2=
FChand-ra%2Fstrchrnul-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1652/Chan=
d-ra/strchrnul-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1652
>
> Range-diff vs v1:
>
>  1:  1c62f6ee353 ! 1:  dcb2de3faea commit.c: ensure strchrnul() doesn't =
scan beyond range
>      @@ Metadata
>       Author: Chandra Pratap <chandrapratap3519@gmail.com>
>
>        ## Commit message ##
>      -    commit.c: ensure strchrnul() doesn't scan beyond range
>      +    commit.c: ensure find_header_mem() doesn't scan beyond given r=
ange
>
>           Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>      @@ commit.c: const char *find_header_mem(const char *msg, size_t le=
n,
>       -	 * at msg beyond the len provided by the caller.
>       -	 */
>        	while (line && line < msg + len) {
>      - 		const char *eol =3D strchrnul(line, '\n');
>      -+		assert(eol - line <=3D len);
>      +-		const char *eol =3D strchrnul(line, '\n');
>      ++		char *eol =3D (char *) line;
>      ++		for (size_t i =3D 0; i < len && *eol && *eol !=3D '\n'; i++) {
>      ++			eol++;
>      ++		}
>
>        		if (line =3D=3D eol)
>        			return NULL;
>
>
>  commit.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index ef679a0b939..9a460b2fd6f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1743,15 +1743,11 @@ const char *find_header_mem(const char *msg, siz=
e_t len,
>  	int key_len =3D strlen(key);
>  	const char *line =3D msg;
>
> -	/*
> -	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
> -	 * given by len. However, current callers are safe because they comput=
e
> -	 * len by scanning a NUL-terminated block of memory starting at msg.
> -	 * Nonetheless, it would be better to ensure the function does not loo=
k
> -	 * at msg beyond the len provided by the caller.
> -	 */
>  	while (line && line < msg + len) {
> -		const char *eol =3D strchrnul(line, '\n');
> +		char *eol =3D (char *) line;
> +		for (size_t i =3D 0; i < len && *eol && *eol !=3D '\n'; i++) {
> +			eol++;
> +		}

This uses the pointer eol only for reading, so you can keep it const.

The loop starts counting from 0 to len for each line, which cannot be
right.  find_header_mem("headers\nfoo bar", 9, "foo", &len) would still
return "bar" instead of NULL.

You could initialize i to the offset of line within msg instead (i.e.
i =3D line - msg).  Or check eol < msg + len instead of i < len -- then
you don't even need to introduce that separate counter.

Style nit: We tend to omit curly braces if they contain only a single
statement.

>  		if (line =3D=3D eol)
>  			return NULL;
>
> base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
