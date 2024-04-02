Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE01598F6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076048; cv=none; b=BH/cHq1bfr8lupeqeT6xtUGetCTbfgJpfaGW7xUNd2mJB4/jyEAoMv224WPjNKzVXsiWE4jEhyPQwYWCYd69KLYQ5rbpWYW/beK+WJ5Rfp3TacvBu6B8hCfOz+NbkIsy8sIbkL+8rFKejmbQSYfXD32FDvPB/TR0T+H+MtDQkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076048; c=relaxed/simple;
	bh=F6D48oEbbGPDVjmKNSlTjdNC0OZYFcBA/fSdd61irlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UISXqOMRI5pwl5CzDTOxaZsdcUO2ne3gHHWnYKJe8XPR08tBlx+9ap/aD5t51oCfadGu8hllw/6qgO9Aus6+cHBBPnev4otSlKP6WwC3HN97u6eg/1sDHDtEOEwFW7n23M4OVs2g5CkD+Pkqsy+ZWMQglN59PBPudVD72vjDKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B7PrLbyw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B7PrLbyw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 44EEA26B81;
	Tue,  2 Apr 2024 12:40:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F6D48oEbbGPDVjmKNSlTjdNC0OZYFcBA/fSdd6
	1irlU=; b=B7PrLbyws46riJivrXjqLDc1k6pRCQWbmsdPKsdqyiTo5yKrnHyNYN
	FuSBDxAtIZn2z6xJXo/9LL96of3KR5uB3S3F+nH0hg+hNjnHe8E3qlAopEBftdH+
	mtRXHbLmm/5Zwhj927YlsU6S0gEGSey2j8uRMxlGPtwY0xgk1WuB0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C2FB26B80;
	Tue,  2 Apr 2024 12:40:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A564A26B7F;
	Tue,  2 Apr 2024 12:40:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chris Torek <chris.torek@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <Zgv4H66NmLZ_o1IC@tanuki> (Patrick Steinhardt's message of "Tue,
	2 Apr 2024 14:20:47 +0200")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
	<xmqqplvadmeq.fsf@gitster.g> <xmqqle5xeun1.fsf@gitster.g>
	<Zgv4H66NmLZ_o1IC@tanuki>
Date: Tue, 02 Apr 2024 09:40:41 -0700
Message-ID: <xmqqil0z7m5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF09A12C-F10F-11EE-85A8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> because they have been supported by Git all along. It simply makes our
> lifes easier when we don't have to special-case creations and deletions
> in any way.
>
> So I'd really not want those to go away or become deprecated.

That is a good input.

Do you have anything to add as a counter-proposal?  The "I do not
care what was there before" update mode does make it necessary to
have a "zero" value for symrefs that can be distinguishable from
not having a value at all.

Thanks.
