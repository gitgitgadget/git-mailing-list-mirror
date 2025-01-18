Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139A19ABB6
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220292; cv=none; b=ca1qH+FpHyu1GlNgRtFi59pwK0PMKrs6lx491W1TmYKzu2grh+FIqmpUkLp7jQT5l5N9wHVHlxMwQnEzYUD9cn+JTvF/aCYeI1KjWqZoJTQJuvW3/MJ9joSM//HJrNixW8+WrlCMsTKfFW9FIAEY5TJDm0LlK42UtoLDTab3LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220292; c=relaxed/simple;
	bh=TUuaiSuDgPdqwMBQhnI2HUCBnujAIHEZImZeC1HiCY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6Xyt4Lf24kr9GPRKJqaaHtVHUPovCTn05X/opZjhSyvW2dQ/ZzpmKCQM4sYhCg/mdSedrcQ8G30Wr/qhy+9h/2jRcAMT+nd6o68J1KVQVLH+mQbwpLDntG6yH1ISKQG+1fwxhY5GSyb5e7m3wOZbEZlCpppz5r5Nid5G3EccgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=coR5giVA; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="coR5giVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737220282; x=1737825082; i=l.s.r@web.de;
	bh=TUuaiSuDgPdqwMBQhnI2HUCBnujAIHEZImZeC1HiCY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=coR5giVA1sOnkFone8K9JLU8weR923zkU93cBPWKf6BRp7/bnDeyYTzY/XgoGcRb
	 29lXTKexrGiiG7KKyDBjaAVAEbd7Ty7oZ+s1jZsG9dpCYkY5qVK1PkeA0Oj/Gwa8j
	 eecQdZeDHs/CqEOqEE94W/QFy1CiHjDWnhdll6azY5oU/Ml77IWAXr/7AYyL3LRQz
	 zw8s3vBrl/9DvJ3bPs/IbWvCWze8r1PPMkAA/pz82w0WPXmIYEFNoUcuwvVNgH+Do
	 c/imNhmNZR2M99q5Cr6Mu85GNImXkBBpotfvdEDhmXgx2UaE77tkcw9vb3zyjBa+7
	 Zw/uBpL9VbGbjHkIog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1thxmM1Ydk-00GPja; Sat, 18
 Jan 2025 18:11:22 +0100
Message-ID: <400bbcae-5dc8-4263-b5c4-86884c54c37c@web.de>
Date: Sat, 18 Jan 2025 18:11:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
To: Jeff King <peff@peff.net>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250116095128.GA144555@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gn0SCYy29CxZ+9mpM14laO7oB9KAc32H10yPEib7pPSTWOoWRTq
 M6vBModTO6xCQgjOf4CLH2WXIRVMbqRHg6ymJHEKDaDoSYz/Q37R38j/29JcsBvovxcKWrG
 FMpnwmOECyE7zl0gu5MVSOmbJ/WBrue0VXjg/vc1wFwXjcbocqS7DdhlVCx2Y5Kt83f/q6h
 60n3UAyr8kKn15TlA6dAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fTFBDHfx75o=;G3Ts1VEvL+tSyhTzgzIgox9YIhx
 I56h5+VBcwDbYSWv2n/wUMbZtuXksULgLoOl1/5T9WopOFCXVM5M0GgrZIjqg+5+9m2IIG6OV
 BSFmmQkZ+7p9jY8iM2xagdQhZ7nFdAv2V+2u/+gneqIe7MjgJchlPC9N3gPzTJpy278tp9mAv
 D9Y+mjSLVHGKMSnY4I+a20t9hI0IgcPUhj/WrfAZ5G2y+kNQhJy2aEZfCjUR+1aCkWTFM+Or8
 80bD7jWY5RRS81FIJNujnH+01LMIcoAkCDXthFPqnR9Z11Ptt8ylEtETHr7pXNlPCXhReqPTj
 hKRBcJoVwkXP7GmohsymQ+tg/OHipJ6qxk0R+mx8mQ7I30PQcBVzLm7ZYYLO9fcn23X1pk25N
 a9KaSlaGyFDLv8CRW8WNy6vyrRXkmzqxSrDD6BPXvYG//1tMy2WRqk26kL4qwgLO1IpV3Fn9n
 8vU7x7XExLsieK/NLeWXmzPro7MgKq+A4Z0q2rjKbWXuHVAW3xtvAA7SdR5Q43AR18R4Tz566
 qEoMfxwTQ8LHf1MR2AKEzQM2Lh5AKYV5caBCUlyWjW6UGZ4JqquZUEupU+CbLsTvtJVY9Qeoc
 wAH3YkQ4YoEOzS14g2oK+Qp22TynuPCF7L5zlJY7/kPSbVCoQMyc8j+hYPsG1ZJyMigu+gD5a
 2kXaCk7D/N0uBr3+h2SALBlbUyLwgeCVVL51EiXnsx7gmhF+mRqev9g1asRy1mBuEoMrhUEHz
 yGifYvQ/zHgmMMQnnaXYjv4z+63Z9SQ/gdScyP/r25i4lJgcG2NWo6IzrbcNetnYRCNm0Rb3M
 uq9TeGJuKf4eTSXkik8SM71M/Jvx9KysAKVIIvxVR2bMFWm8wlSXyEXsTn3XurqfFj/Xaqu3C
 9I5gPdXGpB/HeW0cQeA+JPZK06+NsGFMFgfR+xFhbYNhvkaC430j0WhwTH0gyPCPkgYfyDBp3
 MN1RPfI23VP9lKljIrXoTKC7L7CbcHWnS+OanLw5I6X1dzFQ2C+XNZ8JTZOuvADehogkkaP/c
 mfSUN7U1qYOiuvbUEArTxrTsm/wr3nTjXtdMlXW0sCaC3CaaOOoO1hDrRHxOMyoLE//1NYUSi
 L1CHf0aW69iwomskjeGon4b/v3uLEmk4qWDC+U1KLf2rio3UvLAWx6ZC0cmrH1x8xlhgWibiW
 37FLZsoUaUnSEbuQgWTOf3Hy/zWJ9HqoehVFsW8h5qg==

Am 16.01.25 um 10:51 schrieb Jeff King:
> Yet another option in the near term might be storing these ahead-behind
> bits in the individual atoms.

That makes a lot of sense.

Ren=C3=A9

