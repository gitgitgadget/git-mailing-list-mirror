Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F7EBE
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726956158; cv=none; b=aInvjdZdPjK/Oy2HbCjAz+1DOAkbTMnbKBaAnULyZYQXSA2GwtS2jwt9q0+oLc3JLvmZONfeU+jSISlIi6CER24JezWuFRqP4oFf7lsFcTF36CIByptNJVxAIdwAIHLP3s4UPYxfmU9+2FElxTn/FIL+V2xUDDU6ejhDa4PMMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726956158; c=relaxed/simple;
	bh=al/ZEUUqkUTR8PeBXGzhcqc4pVlcBYrMZ98uQo0e250=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEUVqHHqjrz0nQHobBj1l2o8YlOGucqyyyi5G7dfeIDaKHkr2hGS3jneh8R660CMrtJbVXqX7fS2229jET6uIIsIA4w0jieIuiv6Y1q5TsmlypNbL/8AjDv9qw0244fzjmp/SRv0j/edB8Xa+StIQmfsSA5Es2U0TeYvg74LtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZYAGBWub; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZYAGBWub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726956151; x=1727560951; i=l.s.r@web.de;
	bh=al/ZEUUqkUTR8PeBXGzhcqc4pVlcBYrMZ98uQo0e250=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZYAGBWubP6AM6mpknP/6r2clt136CsT4GKnEKLY/swnt/cZo9RGG479rdoYnjQNe
	 +ruEAHm8XwZnVQH748FIqse8MzZzRJ6jTT+VeV3Rj3XkYxMMoYTBsx3wqALQk6fIl
	 FzO76nl+XdbaWJGilXfz8IDHCjg+HUw2tl6G6jWSaNX2iL4iRIt7Hi3sjASboaOJr
	 60ECAbfi8QHhoSTpCpsQaudgYJh6BVVk8hGJn4xWj177QMqcUcRyZCdNBdsbHLtLz
	 TL84tH6INHl50+5M0gbM2wIhlmPlwJhskQJkS53poRHUjbpNAjcZcNn+TEhMdaCT6
	 fqflPPKhLtMQ/+wp+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.77]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Tu-1sV1FL0rhs-00I2Tt; Sun, 22
 Sep 2024 00:02:31 +0200
Message-ID: <fa8c473f-8941-4749-8561-3444ce7ce113@web.de>
Date: Sun, 22 Sep 2024 00:02:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive: load index before pathspec checks
To: Ronan Pigott <ronan@rjp.ie>
Cc: git@vger.kernel.org
References: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
 <66c3e9fa-ecfe-4af2-a970-c1afdbc2b7f2@web.de>
 <f8e0ad836366480e32ec5b40b753cb533dd41cb6@rjp.ie>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <f8e0ad836366480e32ec5b40b753cb533dd41cb6@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B0VX+0BH9Ns0vn9A9CLPTv1gOZ48RYOvMRkEe49+RkGoGVL+2nf
 AEoVRHXii+p+ebAvsJdcsCYJ6aPTHnGMLFKycMSFRqjbaYj001ULpw0ajd2j4SUZ08pNUYW
 G+TZWVdozdQ+LDDw6yqdcFLxE5ieOaDiyAYSWjVXgCy9ai41zqfuyR0sw01Gzj6c/d44t/e
 qcfetQ08nAcBUF8EmZ92g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j+8HZbsspEw=;+QEuh1UZq6377AC4btwINcuU92q
 Q2e6T8uH8XPyxPKnxwtm1MVCoZXXsDnGtWP352NUEE6iJsiAjt7CgMBAvTlA+XpUUGU2gqBnp
 qp2u76SSggMER4RcKAXCEPWeUGrcv2p8OtVNhy5+qOrBDjjzf75KXTBQ0OZjyR80po0RGJk7X
 lc2BAJspVsLmUQUSuqyAB0fauXg3kNrm546bwkBWvKuhYNFpBZaivAZtNfYB8NDJEiDzJccEy
 LsmCipark7NpgiqaIf/J+ciKaC8rxkRT2v0Ux10OM64szxMBrQ5mk1+RpUKlMmsmtdADSkURH
 eRQNo7VpxKk+ksb1+nQMtZT9g1Qa6puMRdU7sTvK8L0Z5ahhPpy5wK3XoPZbrVLKB9iqgh8bO
 jhOR9aDoNwFfNq5Zarl/GCN0LGIlQewDIYZVAQSkKDqczJw1VgyagZJmqecFCUTfQRpqp5VRW
 gkjh3aVQYQ2Y9YtFtPOKfG0qHiULtcQxYH5ddFkGE7gQ7jqxArd9URquUYESyVIog9omJnXqy
 BxR9T3lyib2fDvC4KBIX7oe00aGXj2KqfJPvsI0NFYSOH2FCI6ajkgRTap7T4/c3omyvsk3gA
 okxnzAF88M9eIdKsYOIRXETwhPkYgJCKXOeCepUDbgeAnDNXVa4Ux1vBbE8BI+eTWuCJwElSt
 Jlf8tnOi+wMWr02BDWI2fyJ52MwGB2GLr3MzA02GadAiGeYECmZe6a2qxMSZB98NvmtQ/7pv0
 90Dfxy4WjpIN0s9A9ELwbnELnmnoKoJD0D2fh++LT0bNk8UCYChQqlOSXeiTjXS49DuuDsoTt
 5jhqjruFcn7z55mCZz+lGZoA==

Hello Ronan,

Am 21.09.24 um 23:23 schrieb Ronan Pigott:
> Thanks for the patch. I tried it applied to 2.46.1 and it works as expec=
ted.

thank you for testing, and for the original report!

Ren=C3=A9

