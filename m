Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7C2F1FF3
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658735; cv=none; b=FampAnv2RWp/W7FDjnOY9GYA/ZcEmPZs4ml95AmzEtoA/ORhql0uG26h9afGLduMKK0FpPrtbW4RuzQS9biP9pnykSATo3VsWHMTnS3M7PqMT9TbzA5Gru3UiT33FzQBGYBPdpbc0+FUEev5BmYTWYKKk2n1YnhgdgWeBbula0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658735; c=relaxed/simple;
	bh=cAU7+OABVEjgMANYWLhqG7aF8wn/iiyZkT95bUksC2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F41RYo6xFCCAwTZRy8GOl09nkBYcUphkBZX0ju+z+PiNqtZ3OnEyJ8KGN0ooVndRCH700HXXBmFlf6EfOH90k+KfrGMtHr+jTHoO9IOOrG8gQeM1A07PafVLxiHZgf7sZLLtloFBZOkEfcBSFxpj1CzIxiBe1ktekVX6Ui1hTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tcOp6J6c; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tcOp6J6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752658724; x=1753263524; i=l.s.r@web.de;
	bh=DXkEgrGWMetQSLqBrj72jSc54KGD3fykWNtZmOKeJoQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tcOp6J6ckzDP8fAnosebJzVMgoxm2nJzG9i8lwtpPVf0NZ8C5UFtjBRx0LDQqD8m
	 muOXrPI7aHIGnTyv+doo/pfz0jnBP/AE9wptfSRtkW/esuIGnoaeiH47mJbmprjPH
	 YI3GADtuWvS7082PyTDdE7aLFRkIhBWZre/KceZROb4LAow1cyEgOUzTOjum+hIqV
	 jIk0CACZU+VdMfRd1t0liNgb5MRmIxP26iCmdd8doinHtppnn+APc/KLjZ5BqnMkm
	 nOV7IyYgB5EFIs2w0IXeZxphtzzbwwiVt3hPaIxpj+9BD4JsySdMEBhggAYdkyY8b
	 MeX/pOWCeJNp4uT7Ow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1uJTsN2rpb-00XUTk; Wed, 16
 Jul 2025 11:38:44 +0200
Message-ID: <298dd1d6-7756-4ecb-9202-d77491541253@web.de>
Date: Wed, 16 Jul 2025 11:38:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] prio-queue: add prio_queue_replace()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>
 <20250716050933.GC1396022@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250716050933.GC1396022@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nkf6Smdjrvm0ez/GnKYQEUInCtNDf1UG+/TuWJy2cRHE7CESZuG
 X1PamEyCjVIDYolTM5sJViI+1nL1EWce9nCzoJg6EF6VDKGxbzBEoYbYNyts8vCV1pmU8Zj
 bGU1ofVSUJ6uA3rVi+zMhP7jdyuO+K9X/Rm0l50xTfejfLvMc2DPULPIboG4AymzLSlSfB2
 TdHh1ga/FOuvLcsYior0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kpbib/ownsI=;56ADPsxXMvCgP10u3q/hXb0/akg
 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
 G6R6SQr/CzQ==

On 7/16/25 7:09 AM, Jeff King wrote:
> On Tue, Jul 15, 2025 at 04:51:22PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Add a function to replace the top element of the queue that basically
>> does the same as prio_queue_get() followed by prio_queue_put(), but
>> without the work by prio_queue_get() to rebalance the heap.  It can be
>> used to optimize loops that get one element and then immediately add
>> another one.  That's common e.g., with commit history traversal, where
>> we get out a commit and then put in its parents.
>=20
> Hmm. But surely we still need to rebalance the heap after adding an
> element? And indeed, we still call the new sift_down_root() function.

Yes.

> But I guess we are getting away without the "bubble up" operation that
> put would do? So we are doing half as much work (but still big-O the
> same)?

Yes.

I thought about building this optimization into prio_queue_get(), but
that would require prio_queue_peek() and prio_queue_put() to be adjusted
as well and all prio_queue users would have to be either made aware of
the not-fully-heapified state, or prevented from accessing prio_queue
properties like .nr and .array.  Adding a new function seemed like the
simplest and safest way for now.

Ren=C3=A9

