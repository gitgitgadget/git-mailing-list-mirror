Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673817164E
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336865; cv=none; b=ExhgOFeDkQOf6iL4MvecZSPSxLH3orIa6DgaTDfMmPpK9UzYPIqqCD5WddZNQgev4N++JfiPg0s7rBsHQNUJcFYuBVRbEf49qCD/EQpyqi5MUu3D17YdvWMEK4enf19aM7FcRsIBVDnO0kiMuwbnU/ifutZkNcyZbZ2sKaGa3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336865; c=relaxed/simple;
	bh=hepuNYgKH8EVx1bF/AFhAVIC64r0h0ZX+FBvD8w5TDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1+4QPXkWxhyKdgbU6X+hDfbiM7nhQoR3pqIEa8wDBNeU9MRZJN9iqMa8B/ndYmDTbJkRqWkCljbRuIN0haAs3iAgpIt/WgFr7ZxkPpfJWrf7YkVeF0GeDb921FcR70uTKzvMlvWGWWHmd5l81SW19CvpuxYvFTAXWgwqaTuijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V+7MDZBS; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+7MDZBS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D59D621736;
	Fri,  5 Apr 2024 13:07:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hepuNYgKH8EVx1bF/AFhAVIC64r0h0ZX+FBvD8
	w5TDo=; b=V+7MDZBSxcJ3j/4WtEP3FSpZ84pBgGFqx86iQVvBirBJJ2ZuiJfwCJ
	goyXsbLJAU2XETVLjUvWCFsF9ZZMVX5eUzYnTqdS3ayxxchSHdOii1wHQU3TUSD2
	XviMQxnHpM2nLHjwXUSs/iXjopQzype0IUHBMp2MAI6tcSaZY62NA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CDCCA21735;
	Fri,  5 Apr 2024 13:07:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C22521734;
	Fri,  5 Apr 2024 13:07:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] checkout: do not bother "tracking" report on detached HEAD
In-Reply-To: <CAGJzqsmE9FDEBn=u3ge4LA3ha4fDbm4OWiuUbMaztwjELBd7ug@mail.gmail.com>
	(M. Hickford's message of "Fri, 5 Apr 2024 08:00:00 +0100")
References: <CAKcCxfAVGr2QoaXiT81gVZ0mfq3zJs7TywRhJzevwKX7wChJ4w@mail.gmail.com>
	<xmqqa5mfl7ud.fsf@gitster.g>
	<CAGJzqsmE9FDEBn=u3ge4LA3ha4fDbm4OWiuUbMaztwjELBd7ug@mail.gmail.com>
Date: Fri, 05 Apr 2024 10:07:38 -0700
Message-ID: <xmqqzfu7viud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 027FAD78-F36F-11EE-88FD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

M Hickford <mirth.hickford@gmail.com> writes:

> Thanks Junio for the fix. It works for me.
>
> Tested-by: M Hickford <mirth.hickford@gmail.com>

Thanks.  It is already on 'next' and will be on 'master' sometime
next week, hopefully.
