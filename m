Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706795;
	b=Gux+ILuOCersXQkoPHoAP6Ul5F1Bplg0HhEqi3PBpwHFWnwP34XQlZhc2uZ79/MYJUmo
	 /PzClTyf4r0E5q0N0sK/62PPHtCiOvbx+4SSvd7qoBa+hH5J+JOpWm2gRlLQov87kxWBq
	 Uvtc+urjUkG/mmS1xI/CmKLQmfEDJEzRJ2D88bMBh6xKxLjszaSrS8OZBSCbSMgefHEGH
	 SWmKhbBzpEtc2KvRNGFAhOryOKUb2HhTkp1s2efYQMdJPOVWt1o7kh6v+N8zav5RFseoq
	 x0d5QJRgGaJ2C5wvxkHQqOFCwEJcYvZADd1q4Vq6+S2yUBQwRbuglZwt/mZbs0Q7IuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706795;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=oeiCqOWbmy630n7iF0iTs7x24OCO0l4BW6Nha88ND4Q=;
	b=JvlzY9t3D1K5OHyAiP+4GEY9Oj8oHwdTFiZSZ6b6OjqxiX0gilddUrW+DkZzkYzU4aRj
	 kBpzXuikKXIUdpI4+wevVC38CYqEAD1MSwS1itnpRKotmLAlk1BJVXfd3R4dhaenwfa0b
	 BhIWkJiAh60mzgbW5OCpO2jh+EuJjVLIXiwNgvUIqGYRxQBIK1a42n5CikcTKYAdC0GrJ
	 pyGvCgwRzLBXUmg/miyY9catk0p2LbWrtOLOXJhik4hlz0JwLNhWNhQdD6QP5x5tuoVZE
	 VVMu1GTOo1cY7j8TwjA3SUEH8xTRTzixw6q91B/sP7xgP37O+upgfGIKqTuKfO2DVnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=FaK8owQk;
	arc=none smtp.remote-ip=91.218.175.10
Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3747606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3747606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=FaK8owQk
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BDjxWqKaWDHT343Bei+rSam0Da4YFPHolQTx+vOtZzk=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706791; v=1; x=1796311591;
 b=FaK8owQksXeZK6Ft66SG2uGIWhciuHjhLSMSk5FrS6voewxjzdXaSqX9HP2Mcf2QFNUsxFZY
 qyJzKLj2TcqWjeJ166hTTX5QXFiJoPLHu+HRzvSPu6VHGg+BsS4BiEvLDhOS6rTe05csKncnJ2c
 cGYBY9zgWl0i7xSuMMm1mf5g=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c00d546f29ce532c;
	Thu, 26 Nov 2026 15:26:31 +0000
X-Mizu-Trace-ID: c00d546f29ce532c
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] packfile: skip closing packs marked as do-not-close
In-Reply-To: <xmqqo6belyp1.fsf@gitster.g>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-6-19beb83b145f@pks.im>
 <xmqqo6belyp1.fsf@gitster.g>
Date: Thu, 26 Nov 2026 16:26:24 +0100
Message-ID: <874id3sjfj.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> When closing a packfile to maintain the maximum number of open packs we
>> completely ignore the `do_not_close` bit. That bit is only set by
>> git-fast-import(1), and as that command allocates its packs manually it
>> wouldn't add those packs to the list of all packfiles, and consequently
>> we won't ever try to close such a packfile via `close_one_pack()`. But
>> that feels like coincidence rather than proper design, and the result is
>> rather fragile.
>>
>> Skip over packfiles marked as do-not-close to reduce the fragility. This
>> should not result in a user-visible change in behaviour.
>
> Hmph.  If the only user of the bit does not care that this codepath does
> not honor the bit, perhaps a simpler alternative is to retire the bit
> that nobody else uses?  Or am I reading the above analysis incorrectly?

Before this patch, there is one user of this bit: use_pack(). This
function might open the pack to mmap() it, and close afterward, unless
do_not_close is set.

-- 
Laters,
Toon
