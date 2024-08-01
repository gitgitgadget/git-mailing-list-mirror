Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A716C695
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527679; cv=none; b=ueI409Jty/dtDLWklg4elsF2ZY1T9RvQamBUIjKsZHdTphSoVEA2z8C283F1bRRCRTE0Jq1phDycxgKkwOUmrjctLtHZYZp6PLaeuGkJoa1f6efu498Rv+CVUme9URjdmSqXn6WVryY6oUzzmmhmfD+M1gFhVg9Gm+6742KcinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527679; c=relaxed/simple;
	bh=To9tgdxzK4Bv5H36P1v0B1oFB7AMlsu6iXX0QduSUsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QALt4ttYn4qNeh6BC76/Y7Xp0HpUyBSWuOk1vV2pwGc8/kYe2LTspZnpPDlsLdanqCQC8//4a7U9J1Wyqbe5cB9QVLyp8ea/kZzEW7qXewwbTdz6ovLX5MJ3JY7Zf6Hss4rghIVM12Lla2GOywRmCksOoVBMAPlO7KXQt/EARYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dDydQTo0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDydQTo0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CC5862FAD3;
	Thu,  1 Aug 2024 11:54:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=To9tgdxzK4Bv
	5H36P1v0B1oFB7AMlsu6iXX0QduSUsc=; b=dDydQTo0i1IC77ZZpOETxvmLJcrk
	KVm4fm12Ec1B7DFbNX/zVvpgQ3FlzJc7GN+fK7spGC/QNakTPJxJvqofoIVdDDHP
	dsSWwXQdYgjyOrq2u+xCDH6dLIyA/sMCeZz0s0PsSsjLPSc4Pj+wxWhBbphQd9N4
	rh9rlPVXLJmIWrI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C47CA2FAD2;
	Thu,  1 Aug 2024 11:54:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4BFE2FAD1;
	Thu,  1 Aug 2024 11:54:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Hong Jiang <ilford@gmail.com>
Cc: Jeff King <peff@peff.net>,  Bo Anderson <mail@boanderson.me>,
  git@vger.kernel.org
Subject: Re: [PATCH] credential/osxkeychain: respect NUL terminator in username
In-Reply-To: <CAEcKSiyf7JPypM93XLFJLjC1T-k9h6kushM7GqTyCBe8rico=g@mail.gmail.com>
	(Hong Jiang's message of "Thu, 1 Aug 2024 18:57:31 +0800")
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
	<20240731074228.GC595974@coredump.intra.peff.net>
	<9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>
	<20240801082556.GA640360@coredump.intra.peff.net>
	<CAEcKSiyf7JPypM93XLFJLjC1T-k9h6kushM7GqTyCBe8rico=g@mail.gmail.com>
Date: Thu, 01 Aug 2024 08:54:31 -0700
Message-ID: <xmqq7cd0xmq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5890D4F6-501E-11EF-9543-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Hong Jiang <ilford@gmail.com> writes:

> On Thu, Aug 1, 2024 at 4:25=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> ...
>> ---
>> This is not even compile tested by me! It looks like an obvious enough
>> fix, and I wanted to make sure we don't forget about it. But anybody w=
ho
>> can reproduce or test would be greatly appreciated.

> I confirm the patch works on my system.

Thanks, both.  Will queue.

