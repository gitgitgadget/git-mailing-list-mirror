Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD612DDAB
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971027; cv=none; b=KPdZE6wGRiyihyfgY5SCHe1Xt0HvQl870qaFgAWSH86gfKweqGWEbhA6t+BUBq5QeyYnZUhd8OeccsxkeTeI6567OQgIPPkuSV0WW6k4PQ6K9w9x3+1105W/SluLuOrYtV3+yPPqMkzuiiXZdYEtQzOklZ2yth2IVVpL3zuCpQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971027; c=relaxed/simple;
	bh=g5tOOV4XnElrShRRyfjbpLLwU7z3/I7swhqNSSXLnDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+MH8ngD56peF00Bq5RDy+cSsmc9NoQO0+53+BtQlGwGyhm6v8Kc4Pcd66kOpCZwVQDlKZA1/9r0aEnaFCnFdT8TnSG2aWWJpSm2jF3t24psTRyAETV6KznoPb+CBF0b9GBzBpyD18WsOCYLbehA/KYozXskrvAH1WSM703b+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aC6psiQ7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aC6psiQ7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F69A1D2D1B;
	Mon, 26 Feb 2024 13:10:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g5tOOV4XnElrShRRyfjbpLLwU7z3/I7swhqNSS
	XLnDM=; b=aC6psiQ7XCWXiWvXUcvH5IuE/l3QzmNk9tcc6t9FL1gghs52BiUlQd
	jc9bV5l4H2WuEqiFBjrYiC2rvqTN/qG8H1OLhsv5MGcCgpJlL/lv/ngA1VqdstKM
	w3dWVGdROm8B3MovKwpoORK4K4UNBgf6yDRBTUHmINPLpdPv8uPTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65CA91D2D1A;
	Mon, 26 Feb 2024 13:10:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC5801D2D19;
	Mon, 26 Feb 2024 13:10:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH 1/2] strbuf: introduce strbuf_addstrings() to
 repeatedly add a string
In-Reply-To: <CAP8UFD0Qhy78=v9+hCekMJPkcH2KmeZeQ0xUx8kqrByQ4PO3Xg@mail.gmail.com>
	(Christian Couder's message of "Mon, 26 Feb 2024 18:15:25 +0100")
References: <20240226143350.3596-1-ach.lumap@gmail.com>
	<xmqqil2bdvsy.fsf@gitster.g>
	<CAP8UFD0Qhy78=v9+hCekMJPkcH2KmeZeQ0xUx8kqrByQ4PO3Xg@mail.gmail.com>
Date: Mon, 26 Feb 2024 10:10:23 -0800
Message-ID: <xmqq7cirnlkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5024CF42-D4D2-11EE-B7BD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Unfortunately strbuf_add() calls strbuf_grow() itself which is not
> needed as we have already called strbuf_grow() to avoid repeated
> reallocation.

Why is it unfortunate?  If the current allocation is sufficient, it
is a cheap no-op, isn't it (if not, we should make it so)?

