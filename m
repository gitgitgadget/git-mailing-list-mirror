Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA11DA313
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031738; cv=none; b=rotVWpRMgUYWSSfqdrehMseKDBl4dPSkDBvCY4bVmPQagfCHYTq03xwduddh+xNJpBTMJdL3FkXE0PrhvM7om5ihFhDo8JLlp3uAMQWMNnBO0CcRPyzR9JrW5MX2I/3KxWmyob1UZIJtQIudjVNxqLpZz7VQRFWXJcb35W24mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031738; c=relaxed/simple;
	bh=jmzYF/3JXHbev1Q4vBbT5A11RdQZDzM255e9K2sI8LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3UT2MD3lNEIxqQSn/eKD9iUjha0cQHkM5PyYUC/SVU9LH2XBbnhMTzMWp9b+rs1FQqseln2QF09i7PkQsQJ48HHFpTU0u/WLdVzAj10oc+kfUmSEjHDfcIGttUbv11lvZMmD6yGyiyarHliy5Jqrxz/WAN+F7itJX+Omo5MA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bvm5/rQd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bvm5/rQd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 610391B72E;
	Wed,  3 Jul 2024 14:35:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jmzYF/3JXHbev1Q4vBbT5A11RdQZDzM255e9K2
	sI8LU=; b=Bvm5/rQdkG09pev/dswqyFZG+bKkbUYTotCxRfx1Rrvr+YYqT12EtI
	5zFCKBOuO7kVhzr67x+SXp6xR1Kgv+iYtqxl1eqo5/x5maoEiQuFp0s2WyMSQ8co
	6BK4OV/4hIJX00pNcAePfXSJ3XVtuuL6yLj/8yQL6peIwz16pjni0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58CC91B72D;
	Wed,  3 Jul 2024 14:35:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C259B1B72C;
	Wed,  3 Jul 2024 14:35:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/7] merge-ort: convert more error() cases to path_msg()
In-Reply-To: <CABPp-BEkh4K1156FWUdB9wSjSQcdeUF0dcTJ3CS_b8yvz5Vffg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 3 Jul 2024 08:48:59 -0700")
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
	<500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>
	<20240702213326.GA591768@coredump.intra.peff.net>
	<CABPp-BEkh4K1156FWUdB9wSjSQcdeUF0dcTJ3CS_b8yvz5Vffg@mail.gmail.com>
Date: Wed, 03 Jul 2024 11:35:34 -0700
Message-ID: <xmqqwmm2b9xl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09A958FA-396B-11EF-B98D-965B910A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

> Oops!  That's embarrassing.  Thanks for catching; I'll send in a patch
> on top since this is already in next.

Thanks.
