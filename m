Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03015D0
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="e/LKWLS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703410232; x=1704015032; i=l.s.r@web.de;
	bh=oWE+EzUCpnuelpYl//Q9WEXRm0/zW6iz1r5OSqBekM4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=e/LKWLS7pyy6RSDDO9eAj8OUSSCIIIW36pFs881hAiMpx3VZSj8DKKJtu7AlUykr
	 LzVrxkSNbCHp9qrKpg6ZFTzNcJScyes2HTkUdZGXnvDcsS5/YQakxPqhqnEkW0sgh
	 9nrkI/NpIFPgWzVOXlNZT+itIno8NzBdT4mUv+oSJVmda/a4Q6IPHYxlzgvDPPkqe
	 YJ8tODp6iUMTL8VwWFPSExyicGp+7gGkCPM65J2uKd1bnWjL+JGVv3Ai4/iNNRMku
	 0Bv1Z5sWD0CjN9+nyLZWEUf7ySDTtchH5sn0iEe5HyrMuu+4cci60JJRLPiu4PZfb
	 GUj/0ulKW303oXhQ8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1qvgtq3PlG-00qKfk; Sun, 24
 Dec 2023 10:30:32 +0100
Message-ID: <459f63b9-8246-4216-9163-fe69d5ceee83@web.de>
Date: Sun, 24 Dec 2023 10:30:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: fix big allocations
To: Elijah Newren <newren@gmail.com>
Cc: Git List <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <CABPp-BFiK9A6426d7CFeMZvaBcvmShaY9O0krtCe7jeV9wW7nQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BFiK9A6426d7CFeMZvaBcvmShaY9O0krtCe7jeV9wW7nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wx4ksXivXO9eJCTKM0aLdYRWgkVUaO5cnakwucGPEhGgi5VhrCv
 ux+lx/zF/C1SyETAGTMC2PP9DvTtS+B5qL9KOjA5/iGy2mqnKk1nCAldAVMlE/azWIfGK7+
 XlLTy7b837dlc3BYdUAm3kyXO4YevMmHmBKYbxp1XocEEQwNAOaKjfdh3/wo1J9y5tIDFPN
 7U+pkq1AHrEapGG2uDMow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iUzOEOpHo0M=;aQgcwbsdcbiYEyXNsvPfU5VSSzh
 GvjVga1kKHZjZuz+2ffxtD5/4sy5Og2of/OcDOLyd86dbVhs+DVpewMdFuIIKf/q6uj5ad1PK
 1NVVw5iBCHDmd21KeTAVEhU+4uLMQ6Lo4mYa6000DibPLKvP2BH9QW5lFbqTFQAVf1BByqcGN
 nXwVWEBnH4Tjfo3BojYHQzCPLqPH/gz5E0J0POTeSzaRGtGf03IeEao+1M1gqrKOP4M0jYZe6
 XoFD2eiXC/CZhvvPJAigDcZNlUSNSOzLPRWiAAJSg+TvrNXalxreQFaUTAf6D2Ij83Yclpm4W
 qzX/qhA9deIRHLWft322km2T0Gn96CkitQyv1kvf29oO/KvXa3XYgcFnHI78wurDM2Cp95OD1
 b402Cv6DEKGeANTyghHza1oyRvf15miE1xIOotpiljKM+O85RnSGQ5ugYvZEGfYs1fDLIw2S/
 sE+6F3D6QQvaSc0QUC5GRyiCP12JYve4SYDjAU6CyZk+GuI8lf6aitRTTYfnXoVwN4XBXUHzp
 tBRKMyyFRP+J0thfbiM2R618pnX3e5cDQ23KDe5jn3B817S9ijl2ixOV19teQH0UWGpp14drz
 O9/JvWQFECiW4LpO4RrdPRKaBpRzTJgK3fgpe1hV5CpeZAibevpczVEKUjZSaZzgKQ94NS7EQ
 X3f7d3WQnVj4iy6TCuZC5+he9a8pegusWyFVtBR8MN8ZyNvY+k0GR+okciAz5gXXCr2GHrcPF
 iWxBYdWPBXYklV5VIYy38fymWcA3V7zsJHmma7BIxG8V7qsTZCBYKrg7HNb25k6OAtgY7vh0f
 KbmxhHZt+c/mBGn6xhzKCygw1e06d1KwH4oq9stYpPrLYlT0G/M7wDsCjRsYvmGF4VACMnXx7
 z3FeLfSZ46hg2G7A4ytTQAODXHvcKWSGZUFqPB6h827fnGtsPyitlQkmtFSMQO2TJ8gp/HQ5K
 CWIm8wDPy/ZpOYxUMOyVCyRX4k8=

Am 24.12.23 um 04:11 schrieb Elijah Newren:
> On Thu, Dec 21, 2023 at 3:13=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>> Add a basic unit test to demonstate the issue by using mem_pool_calloc(=
)
>
> demonstrate (missing 'r')?

Yes.  I didn't intend to mention any demons or states, let alone a
demon state. *facepalm*

> Nice catch; looks good to me.  Out of curiosity, how'd you find the issu=
e?

I was working on using a memory pool for name-rev.  I played with
different values for block_alloc, not fully sure why anymore -- either
for checking the performance impact or testing robustness.

Ren=C3=A9
