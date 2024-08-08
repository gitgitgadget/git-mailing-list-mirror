Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B81F19A
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137981; cv=none; b=D3tLUuB8zXf3blEvgt3gJiSdjxsFWeBxrp/Rz5ZZTsOQfZU7kKIew010tShHoNKRu1YmVkgTIQmF65rjsTqDziL/JAqCUpHRp3AUq8nqwGmKBiJvYezlpR5r19zwKTnKmTxnr+qIm+dCkWGaKY66suWc9ovBtaGilV81qpXloy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137981; c=relaxed/simple;
	bh=eNkq/TpuI9iUoHIHYG/1wZ8Awt8iCq78ZyfJiglX1T0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FuB2LvBVNmx7MYSXON5dlhWnTukPCsLkVSiQ4xG/NafEacX8gX/shEkLb8CAqEgyOJX1CpRK4WgSWNFqRpYTtWamHpEAvYoG6rwxj7ZLxAHaRqcGAUvhLP+MN6W1qmGnQruY9C1m5CDRGnjecY4WPnMtm2/1NHFhplhAuN/HWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CPwd2Au6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPwd2Au6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E4FB823B33;
	Thu,  8 Aug 2024 13:26:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eNkq/TpuI9iUoHIHYG/1wZ8Awt8iCq78ZyfJig
	lX1T0=; b=CPwd2Au69QJPnOxxHca4z5tYSW2NK+DEvOQ9RPC078XJkLZ3VvX/N5
	duimkGLNYOYIOWqM1hZ/dQc7Ut058PAbA/gZoqviewP2aRypLFB9i52PyZSvOQuy
	hI7VK05TDz8Pd82bxhyexDBUeUvfmNPXnmbep5qLgq0gmH1gba7N8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DCDF923B32;
	Thu,  8 Aug 2024 13:26:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5E7823B31;
	Thu,  8 Aug 2024 13:26:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH 1/6] builtin/submodule: allow cloning with different ref
 storage format
In-Reply-To: <E664DE72-49F5-4AFC-ACDB-0BB60A6C34C2@pks.im> (Patrick
	Steinhardt's message of "Thu, 08 Aug 2024 18:19:01 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723032100.git.ps@pks.im>
	<a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
	<xmqqwmkslz7m.fsf@gitster.g> <ZrRtB46vu9rC000y@tanuki>
	<xmqqsevfj8v2.fsf@gitster.g>
	<E664DE72-49F5-4AFC-ACDB-0BB60A6C34C2@pks.im>
Date: Thu, 08 Aug 2024 10:26:13 -0700
Message-ID: <xmqqmslngc3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5077E4C0-55AB-11EF-A599-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The documentation already points this out, as we explicitly say that it
> only has an impact on newly cloned submodules:

Perfect.  Thanks.
