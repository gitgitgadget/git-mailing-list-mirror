Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28B1F934
	for <git@vger.kernel.org>; Mon, 13 May 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644596; cv=none; b=a7Kpifc4F+BVwImXRFu594XeuY5A+THWQxQRT3PzCqKIXCwCFklUwhWqLGP4CPjuSWJklsmf/gXI75SJqMeP9xbW2C6s5T+WkKZBiJwEDn3nPfUS+xA3TLlX5OuRJQG5eppKVwaNmIeGjAx0WTaqxgZ4J7A9CImzky0eN+eBGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644596; c=relaxed/simple;
	bh=TLnpZsbAlQc5PqHeY4LSYaOL+H4+kCfZziFkHksbJ9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKnKaH5ej8jCc9V2HQ99E0ZaeVI2abZH2BvviJuRDz8F/+NNeS3vSIPG1Heabdnh8iHuhHCHkU+N8/3ERBQUnZkMnB+vUfDfIF5lcdiqLBOwjXoceE+epvTg8ew7IG3lelqeGxdoXgD6rnH8ckPUFSsu/N8K36ALMWJYpRbHmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dFNyzYjM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dFNyzYjM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 32BA3380D3;
	Mon, 13 May 2024 19:56:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TLnpZsbAlQc5PqHeY4LSYaOL+H4+kCfZziFkHk
	sbJ9U=; b=dFNyzYjMuVfjPgvhOJCqrr0kviaclKVLiuqiprYHQf+CzabS3dKAhJ
	cBkFZpMeWZ37wsPHQLvJxdW+uwcTzm9Kwn6LqNgfnkkp1dTan1WCmde0qFPSv6os
	HqxsiFFHPD3FhMeVv4gMgjLx+gtENbbVqIgcxddM0Q3e2DMIVp7kw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B675380D2;
	Mon, 13 May 2024 19:56:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1574A380D1;
	Mon, 13 May 2024 19:56:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  git@vger.kernel.org,
  jonathantanmy@google.com
Subject: Re: [PATCH] fetch-pack: Remove unused struct 'loose_object_iter'
In-Reply-To: <ZkHlUkKtqbXSvVNS@tanuki> (Patrick Steinhardt's message of "Mon,
	13 May 2024 12:02:58 +0200")
References: <20240512005913.342287-1-dave@treblig.org>
	<ZkHlUkKtqbXSvVNS@tanuki>
Date: Mon, 13 May 2024 16:56:27 -0700
Message-ID: <xmqq34qlcllg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A72C5B8-1184-11EF-8478-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, May 12, 2024 at 01:59:13AM +0100, Dr. David Alan Gilbert wrote:
>
> Tiny nit: we don't capitalize the first letter after the colon in the
> subject. I don't think this warrants a reroll of this patch though.
>
>> 'loose_object_iter' in fetch-pack.c is unused since
>> commit 97b2fa08b6b9ee3e ("fetch-pack: drop custom loose object cache")
>> Remove it.
>
> Good catch, and thanks for providing historical context. The patch looks
> obviously good to me.

Thanks, both.  Will queue with a slight copy-editing of the proposed
log message.
