Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C331E48B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704378; cv=none; b=XiuE9TzIRL8V3CV98K/XwCnPYRawx//cUwRpaqQlkbnyHT9LU1VAqek1KCCquiVAZZChEOiGeytn2xfNH8d7lH3eieSXINb+OgtGsjL/FT1mm0FZyxSaDdxhGpWeneTIMJnN38jLD02gxH4MRjkCIHAXxiRNCQNy3MM2oYwbUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704378; c=relaxed/simple;
	bh=s8Xv3F0ZJLu6X25OPzEcWOB8t2NsBSKSLm4tMleDoxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDpsd1sXi9FxPDMTR0Wu4K8L7AQuDhVgSbmeS4UsFC+f6pLsjOh0S8byoU080UwTXbvYu9bDixRcZKcOzfseSxL+7i90EVTn4+vPpYD4qnSBKhJxXWbexVKIipeKJjPx+96rVHuQlsj5dJXqoF5+B9m18DQy400yngF5m5RivQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rxJmt4sD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxJmt4sD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AFCD433986;
	Fri, 19 Jan 2024 17:46:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s8Xv3F0ZJLu6X25OPzEcWOB8t2NsBSKSLm4tMl
	eDoxo=; b=rxJmt4sDzmy4KUyi/nh3OjJV70tjqLMwI72fmYFsoYLqdRHlkH/dR6
	YXvNt0rMlezsravmqr/3PPqIacUdA5FkJasu6FOBC4vFlzDmB77jf/hbeWoT03G4
	xvJ+yyvSJLwO8zwqC3ji/fAuRzjxbj//PeAnY8ThgFBkuOIzK7ghw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A8A0733985;
	Fri, 19 Jan 2024 17:46:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3922133984;
	Fri, 19 Jan 2024 17:46:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] fuzz: fix fuzz test build rules
In-Reply-To: <9332e225e44b29be25d10229b05f0b9775b85568.1705700054.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 19 Jan 2024 13:38:12 -0800")
References: <cover.1705700054.git.steadmon@google.com>
	<9332e225e44b29be25d10229b05f0b9775b85568.1705700054.git.steadmon@google.com>
Date: Fri, 19 Jan 2024 14:46:11 -0800
Message-ID: <xmqqcytxhrgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C191BF8-B71C-11EE-A776-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> @@ -762,7 +763,7 @@ fuzz-objs: $(FUZZ_OBJS)
>  # Always build fuzz objects even if not testing, to prevent bit-rot.
>  all:: $(FUZZ_OBJS)

So, this is what you referred to in your proposed log message.  We
do build objects to prevent bit-rot, but we do not link, so it is
merely half a protection.

> ...
>  fuzz-all: $(FUZZ_PROGRAMS)

But there is this target.  I wonder if it makes it even better to
update the "always build fuzz objects" one?  Given that some folks
may not have the necessary clang toochain for linking, it may
probably be a bit too much, perhaps?

It definitely is an improvement to build them in the CI environment,
like you have in [2/2].

Thanks.  Will queue.


