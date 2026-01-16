Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935F22256F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569112; cv=none; b=f+3rjLtan0cvU1MouTqmbOxcgqFpqOHJk6pWpT+9kflzfaIWafr2Uu5ZqTv61SbUmDCZiV8l2Cmuv7PBm4DgCIBPVRdh2ABY6NHzFz7fFHXsC0Cq3Yu1WztkZI+X7wnBXGcTEFXWTrOZki52WggFT9o+mf0v5CLlN0s0V99WYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569112; c=relaxed/simple;
	bh=TsuTYPinNJvT+1/7fmGBb/dDm7+dG7XN+dTkytfWr7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fn4f0WfpY2PdFpIFD567lfo3Bat5V4HTxUt4iBLa17GmykNUKViC8S3ReSGMmndau3lK/KNiYAqLOuvQUr6tDyyfmlVSDW5CCybxuVcYB5s4qd3pWxJES9Tb6nVuCaFnwMfZqKmdGDGLORtpcwmORxFKWXO9ZWxReNdm6tiXoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wjmHGlIR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wjmHGlIR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgtTB5RBUi0XewiQ9tjHOv6dnvBBVeI0PaNniwaTXNw=;
	b=wjmHGlIRivmPMBraKUHumw7yP7T5s4Qe6uOCf2AKcDQ5m8mIJSX4HtOG2ARlLFxla+zmpk
	DydEf7Yis2K5aatqxzeEWl1XKMB+JkaPXKvsurc7FkNYlbUosiF45Utjxc6h3DDWY9phm5
	MvgOecJtmdPZUgPtbPUAY23A4A+6Qq0=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 3/3] last-modified: verify revision argument is a
 commit-ish
In-Reply-To: <bc0db8d5-3c5f-4dd4-9c35-ccb02a6bf5c9@app.fastmail.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
 <bc0db8d5-3c5f-4dd4-9c35-ccb02a6bf5c9@app.fastmail.com>
Date: Fri, 16 Jan 2026 14:11:39 +0100
Message-ID: <87a4ydk8hg.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Jan 14, 2026, at 11:24, Toon Claes wrote:
>> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>>
>>     git last-modified HEAD^{tree}
>>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary
>> in last-modified
>>
>> Fix this error by verifying the parsed revision peels to a commit-ish.
>
> Nitpick: =E2=80=9Cpeels to commit-ish=E2=80=9D =3D commit-ish so this is =
a bit
> redundant. Either just =E2=80=9Ccommit-ish=E2=80=9D or =E2=80=9Cpeels to =
commit=E2=80=9D would be
> enough.
>
> s/verifying the parsed revision peels to a commit-ish./verifying that
> the parsed revision is a commit-ish./

Thanks! I've addressed this in v3.

>> While at it, also fix a memory leak in populate_paths_from_revs().
>
> (Whether or not this is a stale sentence (see Patricks=E2=80=99)) Why not=
 a
> separate commit for fixing a memory leak?

Yeah, it's better to do that separately, so I've done so now.

--=20
Cheers,
Toon
