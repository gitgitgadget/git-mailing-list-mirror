Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B17158875
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659461; cv=none; b=HSoRX6ZM2aUq3hF+q4MfMCLwOv9+PX811elzZz9rc79wBULHF508dRgSiv614ztIuw3ec1NdBLDEk/po9bU79cCQHQU8BBPkputPQi8JMdZmoZI2yxB+Z789KPiUBTRGGSrVGLdPY1PC1uzhiGQbuu+C2qDzf33Cdvv79ofDM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659461; c=relaxed/simple;
	bh=lR+d+DoyY+kq1WoMFy1FogPggJprYL6TpeZybVlNpZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbgTDZpHMStbvX/YxZfeFjykvHz35fefBwNYeMfUu0ModEiCg4m1dQuMfKcxjFoIh4yAu3uTQciSVUR85VocFHrIrSCq5lKWFC+X3Ap2bYLB2HE92i1klIjrOBfODlaWvC7OdC0CtjM7vsG0Kh82DgVM6IR1+sNux2R5XG80fRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dmpL1ZEk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dmpL1ZEk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E4EF1F2DF;
	Fri,  6 Sep 2024 17:50:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lR+d+DoyY+kq1WoMFy1FogPggJprYL6TpeZybV
	lNpZA=; b=dmpL1ZEkzrnSiU0KKFPZVKgiV+nXvVS4ONaKNIrWBqfO2ENtlc4o1Z
	iaL1b4eOi1m8l4QJXqXv2rUk0fKFLE7phMWpp/YVVHHxrdqUilN1KuRVm+j9DXfZ
	JZA0VBUHIzIVloX2wBfEZS9OEVa4LhH7vawbOr2DzJlTE+Lbz1Jaw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 972671F2DE;
	Fri,  6 Sep 2024 17:50:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D1421F2DD;
	Fri,  6 Sep 2024 17:50:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/9] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com> (Taylor Blau's message of
	"Fri, 6 Sep 2024 15:46:00 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
Date: Fri, 06 Sep 2024 14:50:56 -0700
Message-ID: <xmqqcylgv4cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1985E1FA-6C9A-11EF-8049-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Peff and I wrote the first four (new) patches together, and I feel
> confident now that we're in a good spot to address the concerns raised
> in [1].

I just read the first four and they made sense.

With "fast" -> "insecure", the latter half of the series would also
cover the review comments on earlier rounds, I would imagine?

Thanks.
