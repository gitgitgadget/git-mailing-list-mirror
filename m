Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9B14A87
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245070; cv=none; b=LFZZAITrr8du5g0QSFjcu7yxEWuJ+MIEAaTPs+CrHj34k2veeMZa77zuc/WIrTyhdvnrMC6pN5qffikgBbPrh/zaWNUGboZoiEqv1yvHPVQptOJGrYXut1GkHtho8SES0faNQIZa26KD8m0jq53ERwRjlsKKWsN9bacvcBlH0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245070; c=relaxed/simple;
	bh=e6vT8s3jtbI7s850nbp/JHj/yjPxTn4H703pxzK479M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VT9hUkwHDGrI97tc/WTY4c8LQQNhO4ILL7suN6dtpNYwOKkCF58VMkh7Up5XtiUPpgcIVrkd7PEhJ5BkR/zMVb8eloDKz1/VDBCNLIozfyLzXqDgT23QumAJh9uIvz5zmk3kSvdUDPnajeSr0Bm4ctrLCMI4K2gq8JuwJ3DjvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QnBLBSMj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QnBLBSMj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B9E22462F;
	Tue,  6 Feb 2024 13:44:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e6vT8s3jtbI7
	s850nbp/JHj/yjPxTn4H703pxzK479M=; b=QnBLBSMjJalPIFGcEDJmThYxq6bh
	wyq7E/aLfB5gLbi9xE6blVWeWG0AJ18rj7bRKYDG/aYgvaouhj7kJPY3Ui284DjZ
	GFfd2ng/89UFDN06Z6ERr74zd43DppTLqvmltP9u068iJsrkxnk9I5fWAPh5XkYU
	WXlm0F+UrJ6i7GQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 93AC32462E;
	Tue,  6 Feb 2024 13:44:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 860AC24629;
	Tue,  6 Feb 2024 13:44:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
In-Reply-To: <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 5 Feb 2024 20:57:46 +0100")
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
	<ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
Date: Tue, 06 Feb 2024 10:44:21 -0800
Message-ID: <xmqqwmrhh1q2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BF1688A4-C51F-11EE-82AF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>  	while (line && line < msg + len) {
>>  		const char *eol =3D strchrnul(line, '\n');
>> +		assert(eol - line <=3D len);
>
> Something like this might work in Verse, but C is more simple-minded.
> You can't undo an out-of-bounds access after the fact, and assert()
> would be compiled out if the code is built with NDEBUG anyway.

Good comments.  Thanks.
