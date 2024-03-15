Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E05786B
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541769; cv=none; b=G7ybtQUTlBdVAr273YDw1bs9iotAvufjFPnC6gald/juyNVx0J3IP05PD6WNRotC1V3MrYG6SAkO3gka7TM1MDtLu5+F3dyrQjJRJir0Vzg+D+6HrDh0gtjfLwaf1wZI3OyOuxz9E2mMndmq0ZFZhCkbAlTzSPQ4Y83EAO8J488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541769; c=relaxed/simple;
	bh=MUs0WLiR9zOxcnQCgmjcAIsWLxJ9mio4S3ds++AEEdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D89es1J7V2BLs5iSthTbMgshKcxNVxqwbKRB1wHg2sTGrWzsCz8QdcTVc7q/M0tstXboUnRA/fH3c7Y1H+RSuB+P14OeMsT/XjdMK/DigXyvSjAVr/UvThgNtgrOeOzfS8yYFEszZICxmJxy5t7zGQ/NcCGVBWaKVIS4bPPg6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wUpExoaa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wUpExoaa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDF4B1EB5C0;
	Fri, 15 Mar 2024 18:29:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MUs0WLiR9zOxcnQCgmjcAIsWLxJ9mio4S3ds++
	AEEdg=; b=wUpExoaaU/22JSIG+LTMk7wHkZg9/9fUSYr72WQzZiMSv78i9+9Pwt
	UtUrwSZNNGssE5n1V06+Wy4vr0cEkyQQa25qLXb3egTMwpx9epZfI1P3kBs9G12M
	gxfB9LkTFqcu7mrA9L94qfb4W53yC4g6TaCnJ9elWKilDfjq44CDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E490F1EB5BC;
	Fri, 15 Mar 2024 18:29:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 591951EB5BB;
	Fri, 15 Mar 2024 18:29:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Kai <k.vongrambusch@googlemail.com>,  git@vger.kernel.org
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
In-Reply-To: <ebd073ef-4ba4-44df-919a-2adefb40e3e7@kdbg.org> (Johannes Sixt's
	message of "Fri, 15 Mar 2024 23:19:16 +0100")
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
	<606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
	<CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
	<ebd073ef-4ba4-44df-919a-2adefb40e3e7@kdbg.org>
Date: Fri, 15 Mar 2024 15:29:23 -0700
Message-ID: <xmqqzfuznn7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79E65FC4-E31B-11EE-95EC-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> That's the responsibility of the person doing the merge, who at best
> understands both branches being merged.[*] It is of utmost importance
> that a merge result produced by Git is not taken without thinking. It is
> never a no-brainer.
>
> [*] That is where good commit messages shine.

I am glad that some folks appreciate what I do every day ;-)
