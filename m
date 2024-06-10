Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDB1411DE
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036117; cv=none; b=VRczlGa30sOlf+4lnsQsVA9bsqEWOXspcVVMQNzBo0jz07yYsE5UarrUBuWmxN/ufF8H6ZvVtjKMpBTMXRDSyR9ft0sXVt1rTK98vS4H6Xl4VM0p1KKiS5mocf98BNYX+SGCy6olQfpS03reDKJuOZx0/rLJiyrswMfj0m3tfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036117; c=relaxed/simple;
	bh=jZidZgASxe9DL2hmIdPgc0wlRL61gr0pupBy3osJeIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sxq9ydynriCZk7lc2CjjClYj/MelBGWnProFClUYoeL5Qxq5EQ4U3B9ZUffxbTeM5NHV/kk9ep7gr3xYgEBBY586lg4UsL14Te/uq8Z7zm7EF1cFoUCo/ez0DaEavGCsLMWeBtXzGuAFv1llGZ52T9HAajvGVCkLh9M9kAxM8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H9CEJiCP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H9CEJiCP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 63EE11E120;
	Mon, 10 Jun 2024 12:15:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jZidZgASxe9DL2hmIdPgc0wlRL61gr0pupBy3o
	sJeIs=; b=H9CEJiCP07e+RhbxJX6q6HOTnIIz9dExJil+OR8ANWaesuParBUPxA
	/2N0cpEinRVT1vRdRRrBQgs9k1uYezm9NC8kGF0EjuDRO2wBhlNm2eTsz98VqMgg
	IzVyol0SE2bbZRbB3bR5gZiFFTzoXAqbbQ+1iFRk9KU9TPCQ0CQMI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CA181E11F;
	Mon, 10 Jun 2024 12:15:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 122441E11D;
	Mon, 10 Jun 2024 12:15:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] __attribute__: trace2_region_enter_printf() is like
 "printf"
In-Reply-To: <ZmakwSVBXbjfRpUi@tanuki> (Patrick Steinhardt's message of "Mon,
	10 Jun 2024 09:01:21 +0200")
References: <20240608183747.2084294-1-gitster@pobox.com>
	<20240608183747.2084294-2-gitster@pobox.com> <ZmakwSVBXbjfRpUi@tanuki>
Date: Mon, 10 Jun 2024 09:15:04 -0700
Message-ID: <xmqqy17c4vw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99A6FA4A-2744-11EF-A5E0-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Jun 08, 2024 at 11:37:44AM -0700, Junio C Hamano wrote:
>> The last part of the parameter list the function takes is like
>> parameters to printf. mark it as such.
>
> s/mark/Mark, or convert the dot to a semicolon.
>
>> An existing call that formats a value of type size_t using "%d" was
>> found by the compiler with the help with this annotation; fix it.
>
> Makes sense, as do all the other patches in this series.

Thanks, will amend.
