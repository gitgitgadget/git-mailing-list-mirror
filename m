Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130525;
	b=whOURg/2Zw7OtfgHOGHlsggSq67HTZSt0NOK4DHzHkAK41Bm/FpX8SRvKYDafYuxpu35
	 fhk3xNIre4VDP8j2E6eN88azTRXUbQrbpovocgXV2XI8X0KvaBsBEzg3LubXEHJmnj0pb
	 ++M4VpgNUOgR5+Q7U0/xatFVAJQzg830rgAMRDgdM7AbtTs/LAib6Osk4WlhJnmNNgYqm
	 tQw/2V+s5jkbI6rQkCTlxLAxzZRfYwY8DAIT7AixqRCT7FKi/VRtT0M1KTZrce1Du+Hha
	 vefd1TQ8zjC+PKTuJrgeoUKYCdiDdUVDHOrs46w/aMpwnEY0A7rHwrtF+TkxAIRX24g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130525;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XREdQlf2wSZlD8z9ac53SB+AamIf7hLleVc/xrt3n0E=;
	b=0kOLI0GwR9i5yT3tE07F8AJUp5y1Hlcnm/ZsVN9JmqONZ9gK/yHfcS1++7LFhpnOxC1W
	 5cfJxB2SrUm9yNYu0d+06cIao/3oK97Jg0bLdK+TNmnDJQDfwU+SxnJOeghF4apmnWDsR
	 DZho9CZ6nAsICaV9HpRm3z+NMHYEY3iPBj1oid5+kw5wXXitSJcVlhZaxdOXwoO8lB2vj
	 vftvbSoo916RndLpSVW2usCL+tRGagvLbnSHoAvikQHhzijkRagRtvad9Qv155UHIP8wC
	 SR+JQRcwrEaE0lg/d3C63UvZ8XEz08fAV6ve8pLDMQqDFMbym/30QFPxHS4chYv0f0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.15
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B6606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 09:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4jMnnv3sZ5zRnlW;
	Sun,  8 Nov 2026 10:35:15 +0100 (CET)
Message-ID: <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
Date: Sun, 8 Nov 2026 10:35:15 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
Content-Language: en-US
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
 <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.11.26 um 10:18 schrieb Kristofer Karlsson:
> On Sun, 8 Nov 2026 at 09:54, Johannes Sixt <j6t@kdbg.org> wrote:
>>         printf 000000000%0.2147483640d 0
> 
> It is definitely fast enough (on the variants I tested).
> The annoying thing (but not a real blocker) is the extra memory
> usage required and I am not sure I fully trust that all
> implementations will behave the same for absurdly large padding.
> 
> (Particularly for paddings larger than 2^31, as you noted too.)

I don't know how to measure memory requirements, but if it helps,

	printf 000000000%02147483640d 0

(without the fullstop) works, too.

> It feels a bit like a hack, and tweaking the existing test-tool
> feels like a more sane option that is easier to reason about.
> 
> A gotcha here is that the printf hack only works for producing
> "0", so for the cases we truly need NUL characters it does not
> help us, and I think that is also a point in favor of
> simply generalizing test-tool genzeros instead.
On the other hand, the only case you really care about is the one that
takes an insane amount of time. If you convert only that case to printf,
then we do not need all this churn in the first place.

-- Hannes

