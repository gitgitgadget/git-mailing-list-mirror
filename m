Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4A57C8E
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167472; cv=none; b=oPWWYS8ctERyYQbIkwjYB8xPcp6HW0X8M9IFKLMoVonRr71Qh6H8fNtmKyXxSjgmEeoUkxoVLo9OG1GLp0xadOH55Ou/3mht/jSY0mdYgy6mf487t2/AgxWxUUaNmx2/HiARDr0oudfcYl51V2OnT2kfiAT5cCVIKMEo+e50cyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167472; c=relaxed/simple;
	bh=q9AgETnCgsPpuYLcmHXB58QfR0wLMEgKgMjviSbQwYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cfs8oJPnEt18lF7irJcFKhvMK3lvqrfUYfptUNrieHNp04J11izvcYcnJHrFK4qgE1RRGeguY7vey2fvevRH03UG57IoM6yfm1pXAKL5lqUtWth9T/dWDOthJyWAGL80KO216ci2W+CTrI9ascuxcTK5zSZUu0Kai7dz8mRxObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qnpm6qnn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qnpm6qnn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1D651AFD4;
	Fri, 31 May 2024 10:57:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=q9AgETnCgsPpuYLcmHXB58QfR0wLMEgKgMjviS
	bQwYA=; b=Qnpm6qnnTxp9yZ6ZBS4Inw9m4oPaIzCbQoEHbmzrtboXJcfN3wu5in
	yGuzWYSQ44xQy3HUTtdqkxijn8cb/c8HHpYlQh+/scEUazXxdaBCS3lw/tTKbY64
	FACDtoyUfhhMEdM9fcZmakij6dk7clpoEEas0qP9BXdQeghq0vljM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9F201AFD2;
	Fri, 31 May 2024 10:57:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B8EE1AFD0;
	Fri, 31 May 2024 10:57:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1517: more coverage for commands that work without
 repository
In-Reply-To: <Zlmz9Edyv_gehMVr@tanuki> (Patrick Steinhardt's message of "Fri,
	31 May 2024 13:26:44 +0200")
References: <xmqqbk4np77d.fsf@gitster.g> <Zlmz9Edyv_gehMVr@tanuki>
Date: Fri, 31 May 2024 07:57:47 -0700
Message-ID: <xmqqplt2hvv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25A39D9E-1F5E-11EF-B3F1-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 30, 2024 at 09:58:46AM -0700, Junio C Hamano wrote:
> [snip]
>> +test_expect_success 'stripspace outside repository' '
>> +	nongit git stripspace -s </dev/null
>> +'
>
> I was wondering whether we also want to verify that it does the correct
> thing here as it's comparatively easy:
> ...
> For the other tests it's a bit more involved. And given that these are
> all designed as smoke tests, I think it's fine overall.

Yup, as I said in the proposed log message, we may want to update
them to actually do something useful later, but this would at least
help us catch regressions by mistake.

