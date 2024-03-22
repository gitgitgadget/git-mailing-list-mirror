Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C41CD00
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147431; cv=none; b=nzphQ5t1CqwbJoUxtqPuzJby9Pq/E/p9O74v4Te9DNyo9FEkdpLKA6Tkv3OHwude6AcfcoHgeHVWHMm/Y/Hpu4YHQkmPrYlVQyxNC915McZnR5MjGfVvMAGP12Mz5K+lWQG+6nXU+U8Sh4KpRlsGwQfBdfayIFatAN6XNEC1bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147431; c=relaxed/simple;
	bh=TU/COGqDX4JrKhI1mwwd64ccC1c6yQo1U3/4GKgv5m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZemRAGLSbWgIQhgNFUlXAc2XjUNUwDB7ZeM7YAVUuGh+mEvrfF9zks0QwTHdCeMnP2rk+rmMY3RScIEIi7RdJ88oR2zXledMroh27DZOxwKWOrTFLfqIh6PJ+2LyINjl8Q1/LrdfSp7ijEqrsWnvjh4wk3dSImmMFt1wwTKUg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CeCcOBK+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CeCcOBK+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3A831CCCE9;
	Fri, 22 Mar 2024 18:43:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TU/COGqDX4Jr
	KhI1mwwd64ccC1c6yQo1U3/4GKgv5m4=; b=CeCcOBK+SwKx32FkQhImsNhNk3sF
	rYnrjOmERpAN795NTX6Ds1g7dDbTTJs4knERavPZiN3K5W4sZZBq7Xb1LzyF2TPU
	h5R42Yfd05r/eBKHQsToSNQK0YKaIOVnPRIcHP7lF4GMCA3u2/wg/DSRNi90Z4FV
	bujcEeUPpNTZiRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A1D1CCCE6;
	Fri, 22 Mar 2024 18:43:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D9CE1CCCE5;
	Fri, 22 Mar 2024 18:43:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Max Gautier" <mg@max.gautier.name>,  =?utf-8?B?TMOpbmHDr2M=?= Huard
 <lenaic@lhuard.fr>,
  "Derrick Stolee" <stolee@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>,
  "Jeff King" <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
In-Reply-To: <5b9dc977-e8f9-472f-8476-1b13fa6e6d93@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 22 Mar 2024 23:38:09 +0100")
References: <20240322221327.12204-1-mg@max.gautier.name>
	<20240322221327.12204-5-mg@max.gautier.name>
	<5b9dc977-e8f9-472f-8476-1b13fa6e6d93@app.fastmail.com>
Date: Fri, 22 Mar 2024 15:43:47 -0700
Message-ID: <xmqqjzltzy3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A5C913D4-E89D-11EE-82FF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Mar 22, 2024, at 23:11, Max Gautier wrote:
>> Notes:
>>     How should I refer to a commit which is part of the same patch ser=
ies ?
>>     The commit id will change so the message won't be correct anymore,=
 right
>>     ?
>
> It looks like a fair few say =E2=80=9Cin the previous commit=E2=80=9D f=
or the one just
> before this one and =E2=80=9Cin a previous commit=E2=80=9D for some com=
mit that was
> before this in the series but not the immediate previous one. I guess
> that=E2=80=99s okay, no?

I saw some series say "Earlier in the series, X has learned to do Y,
so now we take advantage of that new feature", and found it quite
readable.
