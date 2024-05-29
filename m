Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DB169ADC
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022301; cv=none; b=A1soIHgxYM8Y+icnDgp5npLnoDz51nYWMz11Y3kAQ95WCXubT35gmN9dDPaYiyABtWk8fVsk6DZySSWVXOqk5fAVcSepNl5+p5RiID7e2ZLYedTGul5QyNuT5NG0gihbibEu0TT4+1A4gEF2gtb+B+xITwpjg/NpriBeTL3SdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022301; c=relaxed/simple;
	bh=WTasOMy/XG+AMz5t38yCqgzImr/daKOGXbtCqrcmIk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N4SwE8ETBI8D3fQIYshCQeI4K5e0NZ46JbWoXg/zXJoaDzgPWVlMgQu8E03rP/cf/k/jEo2PhDc0J+PNg4bRVO5OP3DkT4lUi9GPKdhwJgNRgsyIOUQJTsuqIm+BdWCj1pJqC0eSc4uGcNxUnPONpnnkC+9CXKW6DmZLP1Ltci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JMTMqYSY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JMTMqYSY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6009259FA;
	Wed, 29 May 2024 18:38:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WTasOMy/XG+AMz5t38yCqgzImr/daKOGXbtCqr
	cmIk0=; b=JMTMqYSY4X1Ea5d9+HX1DnngvAROY6JgjheVfZVgceqa0zchykzoNn
	9b2YAGmPkOjZNIPMukKq9C5lL4mdPnzD0oDxxITiB1YWFtGzorlajHZpDEU1U3cJ
	/G7Qz05q2zJ+/Qci+1whedzedvW8IHUw4HSvx4WtZ+VBOKWkZ9Ba8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E556259F9;
	Wed, 29 May 2024 18:38:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12F89259F8;
	Wed, 29 May 2024 18:38:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2 3/4] t: move tests from reftable/record_test.c
 to the new unit test
In-Reply-To: <Zlb1m5cwhW_R5EzP@tanuki> (Patrick Steinhardt's message of "Wed,
	29 May 2024 11:30:03 +0200")
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
	<20240529070341.4248-1-chandrapratap3519@gmail.com>
	<20240529070341.4248-4-chandrapratap3519@gmail.com>
	<Zlb1m5cwhW_R5EzP@tanuki>
Date: Wed, 29 May 2024 15:38:17 -0700
Message-ID: <xmqqbk4otfae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24FF6506-1E0C-11EF-AAE7-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	strbuf_release(&a);
>> +	strbuf_release(&b);
>> +}
>
> Oh, so this test was even duplicated. It may make sense to point out
> details like this in the commit message to prepare the reader. But
> that's probably not worth a reroll.

Probably.  But if you are sending out another round anyway, then it
is a good opportunity to update the proposed log message.

;-)
