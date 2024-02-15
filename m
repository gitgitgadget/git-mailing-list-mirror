Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6F131E54
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022946; cv=none; b=AqmoV5AtBXnw7FVi7PFi+AxU/9v0PIcnzEPb83RjSsg7d3Rb6RsxA/Uw1sRu4P2oxiGkcm3C6EtI3VORh7pragEkASvBep528FjavzDtKN9WME/I+i1KgrtHtHHCUiX1M+JQ9FtMBlJ8axrgBbDO0pklgfq+bjB1AGK04g00kTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022946; c=relaxed/simple;
	bh=dptC4lfb9av2JJGMpDKcpW8gbj0BBYW+XdGI2XuamHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PnPpKt4Cl+Jnb6BL+JYFr67IHGjEEwUGny4P97t4weThhkPuReYNVHnxt7nOo46VC3mdeLbCJW+FFIxiq1Ir3jvWOvX30RI02Ip/fxIfFyAZJBee+akf84P5BF9g4aeKypi+P5UTG4CnNVE8qZv/op/GdCaAB62+ybx6INJE80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hiNAUP9T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hiNAUP9T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DA0E1DEA8F;
	Thu, 15 Feb 2024 13:49:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dptC4lfb9av2JJGMpDKcpW8gbj0BBYW+XdGI2X
	uamHw=; b=hiNAUP9Tpdniq+LQim8PZ+k+gP/tZh0Qxj9OqO+1A76gxDa5tlxA3A
	5bltVZY/3Qr5oC9Crga4j+9St/RF5cn+ngJoZbqwAvGhWF2h7rC7OyNX291wgQKk
	Tar687IvCeTLw3AChBEIy2R9qrabVUCrCl/7ows/oqWhqyKv5Mt0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F9811DEA8E;
	Thu, 15 Feb 2024 13:49:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 904191DEA8D;
	Thu, 15 Feb 2024 13:49:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
In-Reply-To: <CAP8UFD2hHYeUxtXm1tNDe3tpBAif7amLbkTQpurp3w1n7uO+HQ@mail.gmail.com>
	(Christian Couder's message of "Thu, 15 Feb 2024 19:17:13 +0100")
References: <20240215094243.147057-1-gitter.spiros@gmail.com>
	<xmqqcysxskd9.fsf@gitster.g>
	<CAP8UFD2hHYeUxtXm1tNDe3tpBAif7amLbkTQpurp3w1n7uO+HQ@mail.gmail.com>
Date: Thu, 15 Feb 2024 10:49:01 -0800
Message-ID: <xmqqv86ppnqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E32124A6-CC32-11EE-9ED6-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Perhaps such changes could be accepted when they are made in only one
> file as part of a microproject though?

Yes, a microproject is not about helping this project, but is about
us investing our cycles in helping aspiring developers with small
practice material.  Even though we may not want to see massive code
churn, we can view the cost of reviewing and accepting small changes
as a part of the cost to onboard new folks.


