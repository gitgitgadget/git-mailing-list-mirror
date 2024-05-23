Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D10A0A
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480590; cv=none; b=hL5SHPO3pdngl3HNBfV05nXyM6jdAjcOQINcf0zbyOM6zr4CIjzlVrI/yBWU3UHIMLHCriWjUIw9/R+LWN/7hRkcrlcUpchFip/v8LZcpXIPV9szyhORyUIH1yTMATngVTYvh4dx2cgLv9QDPinnw6yION6bCcin6EGVeJcp41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480590; c=relaxed/simple;
	bh=XxkKfmVo/cX2V+is8bYHiQZnQfaJMXUpBoUauxaRNEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jATDrKREsYtHUl8Lfsm/DPl17I49yIjleBdYNzy6MQZuD04TWgzo1zb438xOqhAt5yznOUvGWKCiXL1WqKhf7rLYBaYaudDoNan6Lfo/O1CtJzMfd+nBM0NdrRXrc1Zeqx82Fn7gg5Em0RYmeoYU6aHRtAqOxdqrwoyOL5R5dMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N7szURy7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N7szURy7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BE9981D3FC;
	Thu, 23 May 2024 12:09:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XxkKfmVo/cX2V+is8bYHiQZnQfaJMXUpBoUaux
	aRNEE=; b=N7szURy7xVcspbtiharQT9UfRhMdka/AvS/55viHKYb0dWLhPguIH7
	kvr3YP+efET87KBwJxqfdasdwq9WowpSFpP5c/JNSkPZMYnoEka9eN3Z52jaB+AP
	mzXqLvS1+NVIZ+/2aBdj6Ba2q764p2rulcAp2Awwv7Fd6smD2J1lg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B71DE1D3FB;
	Thu, 23 May 2024 12:09:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D1401D3FA;
	Thu, 23 May 2024 12:09:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] refs: ref storage format migrations
In-Reply-To: <cover.1716451672.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 23 May 2024 10:25:13 +0200")
References: <cover.1716451672.git.ps@pks.im>
Date: Thu, 23 May 2024 09:09:41 -0700
Message-ID: <xmqqwmnkv7ay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DE79404E-191E-11EF-B944-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - It is not safe with concurrent writers. This is the limitation that
> ...
>     none at all, as it may cause users to be less mindful. That's why I
>     decided to just have no solution at all and document the limitation
>     accordingly.

Documenting the limitation is a good place to start.  For normal
users, would it be sufficient to

 (1) tell your colleagues that this repository is currently closed
     and do not push into it;

 (2) configure "git gc --auto" to never kick in;

 (3) delist the repository from "git maintenance" schedule.

before they try this feature out?
