Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763F432BDB
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511740; cv=none; b=dyY7EenoQlcNbZPAyeTfNbpeH8NrAoXGGd8isz6eYjoAycsUXUbQ95faIznyFlRVDbPzcZwH2UVsgPe1Mh4+J5GgW03EfLIl9t8m2mKUP0DCL2IuXB6fPOickbsqZZZLBniIY/qIEkaAyqr3sJOCHXLdixQyVSVwB4UHIbB49Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511740; c=relaxed/simple;
	bh=cZ2+DHXrPbjueQuqqNHCpXuvX0qo0PfuudKUHwHshfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2hl171cAdZQimDdlrJgtv1cQLezuIJ7cmCi67hkRYgiQQRnO/9gj/YUCOrIAr4UAjZQEhAyJOOgZOEyO98Wb8zeqiRsUWMgo55iHJrTG2z/Uv/sq0IAPlOPhsHSRstraH4RW6GTr/Aqe4Xu6mJJX/o8bXkxHMb4sYhme0H10u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=STFQ5pm+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="STFQ5pm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783511736; x=1784116536; i=l.s.r@web.de;
	bh=j2cr5Qw94jNtLPb65TB/IwPgQJn086pjV0JZAKFD2iw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=STFQ5pm+BcxAuxP0E6WTzkuso2fApgN4I19WF0hyNdxAi+kqglYnz85oK9eRfK0N
	 ApkCKWZYYow9Y/3JlyNb9+8/DfPalDdd58Ap8so4S8y2jwwTPjy6Rv4OXPzEXyM7a
	 FAFmLIljm+E/EDm1/vNg6VI3hB4R3UthDokF2E/fmOKAVqmxamsqJnAVRskA7ieBj
	 SFsJaeVA3lcZOVqU7gF9exFhdWpH4JVWK/zfX/Ioe7JgBIEGJLgvYsfGPyVU+dEQB
	 01JMuR+bD7VegJrqn+0sU1trXphSf2t3s5qFQNw9TQqU+Wd4xuOWdh3sBE6q1X6jx
	 DABvMkJxMUvAgtGkiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCogs-1wqCIh3sDw-00AA5u; Wed, 08
 Jul 2026 13:55:35 +0200
Message-ID: <15fa1b16-b911-47b1-a843-400e320d7e4f@web.de>
Date: Wed, 8 Jul 2026 13:55:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: Kristofer Karlsson <krka@spotify.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
 <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
 <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
 <57bb0e9e-221d-4234-b5bc-a87610e8263c@web.de>
 <CAL71e4NiSSRgxO_L7vb5=ohnchOCvuhEZwMc0Ls+Xu-Q+YytDg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAL71e4NiSSRgxO_L7vb5=ohnchOCvuhEZwMc0Ls+Xu-Q+YytDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tc7os6igkIe8g0MvnKj7bxTrWEyC1terb7r9FGzm1ROyti+5jGz
 tEAYAgMDdvjW7aJBYlpTZq9e6qKKTpnDrhSBFCC1DGR47RxHWuInZb+JBUXCdYn1ECd0NeE
 2p3/lz7OkJxUUST2lg+S5GuHdzqxDh15zBAWnsXXOxBTcPWAZ3ZumsnMLf6/oWzzSzfOi9D
 uckeLckW/JTcda1CCCRcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nNCgpfTIrYg=;We1qLrpNNm26fIvH6VHK7A40jFp
 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

On 7/8/26 12:59 PM, Kristofer Karlsson wrote:
> On Wed, 8 Jul 2026 at 12:44, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> I didn't
>> find this method used anywhere else, which is a warning sign, but I
>> can't find any catch.
>=20
> I am not sure why it's a warning sign to have no other usages,
> especially when it's a file local static function.
I meant that I didn't find this optimization in other priority queue
implementations or papers, but admittedly I didn't do an exhaustive
search.  Given it's benefits I would have expected to find prior art
on it pretty easily, though.

Ren=C3=A9

