Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F792125D5
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651170; cv=none; b=DA6pVcmPhPz9lR4i0nJDnVkhcLM0qrS0QzthL5vzERdkkae7UTV8yrt5ddML+LavdmL6xLKg5wAWKBCf52l+l8KcR4KHaNYMV0h4ut4W5CRMdCGgY1pIcA7gFvKLi8hveyDNKpuhSZ6P0ISYp9GCduS+6X5rfRhsFx/7plAnU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651170; c=relaxed/simple;
	bh=U/p8zOB81RiklnBiyiznvK9RvPmhFmsiuhHZWUn6qD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUf3wMOsD+U4siDAHVYbuaqLsuWtsLRx+AYmgKwToQYSf6INWRfxfeXpnNJXyFeWpjk5lAEH5fMsok39RbbN+WeX9C1TtQIp1QErS19djIdpHxYiySEZBsjM1Ao4xjUCCHRk7R3L6S/VJGJwc8xZwbxOGHW4ibm9QbRjgwGlcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QiLSxmKS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QiLSxmKS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63E761E2421;
	Tue, 30 Jan 2024 16:46:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U/p8zOB81Rik
	lnBiyiznvK9RvPmhFmsiuhHZWUn6qD4=; b=QiLSxmKS3gjBMYUAFypMtOFjE30O
	h91Um6HFk6ntv17/Do8m0bbYCB+ZIraiWGhY7JgNPc2IJM8zUzo2uc6s5OINmtHm
	KaBQCI3MHnsPXKjpRG3wF2TJetRM4uH3EKs19j3VYfjLLqT7JiBnM04blWhI1SIE
	/43Zsi+v+1KX1nI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B5221E2420;
	Tue, 30 Jan 2024 16:46:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEDCF1E241F;
	Tue, 30 Jan 2024 16:46:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH] t0091: allow test in a repository without tags
In-Reply-To: <CAPig+cSmSjifRXsotTrdjjFsh0N4w+BzbZXKffPyn_rpirBVUw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 30 Jan 2024 15:53:08 -0500")
References: <xmqqv87aabk3.fsf@gitster.g>
	<CAPig+cSmSjifRXsotTrdjjFsh0N4w+BzbZXKffPyn_rpirBVUw@mail.gmail.com>
Date: Tue, 30 Jan 2024 13:46:00 -0800
Message-ID: <xmqqmssma413.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F69BE222-BFB8-11EE-9211-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jan 30, 2024 at 2:03=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> The beginning of the [System Info] section, which should match the
>> "git version --build-options" output, may not identify our version
>> as "git version 2.whatever".  When build in a repository cloned
>
> s/build/built/

Thanks.
