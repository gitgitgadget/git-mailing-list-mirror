Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F627FB39
	for <git@vger.kernel.org>; Tue, 13 May 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158795; cv=none; b=QKZNSQ8QbvxzCMmm23YHujh0dSwoWP/cH3gMY2tWBri1f7I0wwJTAPc3qINA6fqUy3ocX6CwFk03YaPWkXSEg97J7mTLKnNDRpa+D6B6VTp45g6aLs7G86cB82oPl5qn3UJ7S8hfkq/JP1eg9UhPMqPuz8uFDXeHNUywlVlFqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158795; c=relaxed/simple;
	bh=gOmTw3b+1miVRdm+2Gc9pu6BiJA3C/ZhVWOo6PyC2FA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cg5KA0/zPwBVN1ZtJQhNUuPuilX1Tana94O5tTzZcuT/ypnP6nXZ4bzyMo9TEFkuslVaZ0+2pR9mfTTq79fIN9AtZDBXG3d7L9OqtWpqEdqr5YmR7Eb/dvBuU5aBNbxnCED84csUTScH5X6clUOXvofpAN/unUvZxEdo26pU7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K6alwJF/; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K6alwJF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1747158786; x=1747417986;
	bh=gOmTw3b+1miVRdm+2Gc9pu6BiJA3C/ZhVWOo6PyC2FA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=K6alwJF/kLurF9PHj8ae0p12SgF3xuJTOBpvilOGfYM0yT5y/OzomzKo5nJfQ1bNm
	 qYc2bPm9rN3+DM1C6eTz8ATv+mUgW2yc+zSPMAHfQreQ//YAG99fzlbJQFDxtEPtmH
	 niikG1IiJNFRJh9XXKxeGx6R1WyFpsA4GvMFkvl3+SPDx8H2kLozY+/3NkiG201cbr
	 8mZM2wB5LmiYp1P7/g5soRRio94Z+cznPf+9jOlYu4bnsIH18ehDPvk9nq2Un0lW5y
	 0Qj0v9wvK0OqvZh9m3HTWI3FxLkfBqFBHrXbPcwZ8+VF4QpVC3QrbvfvmVRtw4rBuw
	 2ItCY9pFaFVPQ==
Date: Tue, 13 May 2025 17:52:58 +0000
To: "Raymond E. Pasco" <ray@ameretat.dev>
From: Jason Cho <jason11choca@proton.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "aclopte@gmail.com" <aclopte@gmail.com>, Ryan Hodges <rhodges@cisco.com>
Subject: Re: [PATCH 2/5] apply: read in the index in --intent-to-add mode
Message-ID: <pHu_JjAnK8kIuq7d3kCledkNo-FNQo-lHtHLQ6sbVvgp_Q2XGSpuyjcSm4XJy_iH4RABVwEzFjupGxvh059y1cYOo4hTpK5ZFNbAMwkJv-s=@proton.me>
In-Reply-To: <gz4sl3e3nqmkamkfmoktlqaefxteamj6v3fcs7dbavgys7ubng@utz2i5ahl77f>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt> <20250511003955.242889-1-ray@ameretat.dev> <20250511003955.242889-3-ray@ameretat.dev> <gz4sl3e3nqmkamkfmoktlqaefxteamj6v3fcs7dbavgys7ubng@utz2i5ahl77f>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: f8e20153779f7d74a902678728f5da22f21a65c6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Raymond, thank you for getting on top of my initial query. Although your cu=
rrent patch has bugs, I'm confident that you are able to fix it.

I'm looking forward to see the option --intent-to-add works correctly.

I appreciate the effort of you and code reviewers.
