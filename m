Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221D816
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468432; cv=none; b=aalJewCgwGOlx72hiahYwZuVy121ttYNRni+Dg5H7PfE8yJbJZm2mGwIYo1d4ANQOPwj7O4y+OvbnhCtdCjQkKOYdUqBidSHYw9/fTWSnbNEqDAbHXvYIZQRJRrG18YTfkQY4Rbhk6J+yPyeWx4uNKFxrzdAES8eU+DmKkuQcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468432; c=relaxed/simple;
	bh=z6SCF72GKnytrOQad9MNdf/oUaQW96RvNieFyex+jc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZzw2kulvKDNK6lxmcq3EDzNUmWBMIKMN6ENCHRvmOY5FbHqT8gfg+JG68G6p2MwX3Zir4GUiFdcNwffpb6Uzbu1gHxotvgsbZGuB6mvpGAj7biATewHMIQIWjMN4WPXBQU6VcXcn80ptSWqWAk6AVETX2PMbRX/KKA0ORjkPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jWKkU/qb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jWKkU/qb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B2282D9A3;
	Sun,  7 Apr 2024 01:40:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z6SCF72GKnytrOQad9MNdf/oUaQW96RvNieFye
	x+jc0=; b=jWKkU/qb8CZzUObU24nDu1NaoMAvB5+04OzrwgLfMwFP3GJs0u+SIY
	WG7a7WbK89DCZWaZlTBY2WzjBFTIMlb9fQ6w6rx5Oq0Sk1iv7l/Qn3txNBC6N5px
	J5YxBdkBZP6wcIBLFzfa4zInQBY9ljQndWc2jsvBhZR8OA5ZoDgGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4365F2D9A2;
	Sun,  7 Apr 2024 01:40:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C80312D9A0;
	Sun,  7 Apr 2024 01:40:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Dragan Simic <dsimic@manjaro.org>,  prpr 19xx <prpr19xx@gmail.com>,
  git@vger.kernel.org
Subject: Re: Warning message in remote.c when compiling
In-Reply-To: <20240407013843.GE1085004@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Apr 2024 21:38:43 -0400")
References: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
	<7f0da057773d39add4ede71667e9ff70@manjaro.org>
	<20240407013843.GE1085004@coredump.intra.peff.net>
Date: Sat, 06 Apr 2024 22:40:25 -0700
Message-ID: <xmqqzfu5hgs6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5635FBF6-F4A1-11EE-B9D5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> I don't really see any need to mark the wrapper as inline. It's one
> basic function call (on top of an interface which requires a callback
> anyway!), and I suspect many compilers would consider inlining anyway,
> since it's a static function.
>
> Ditto for remotes_pushremote_get(), though it doesn't have a forward
> declaration.

Yup.  I presonally feel that we should get rid of "static inline"
unless they appear in header files.  The compilers should in general
be able to do good enough job finding what to inline than we can (1)
initially mark what to inline, and (2) update by dropping "inline"
that is no longer appropriate as the code evolves.

Thanks.
