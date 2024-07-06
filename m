Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901DD2EE
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290118; cv=none; b=G1GEfif5rSjQlXefHifoY0cl4TkNYbCxZSsQX9xexwcEwjKrhPqgOYLpePe7L1TBPdVz4QDivAlt8A6j4BHC1qM6x2x19VRzqo9uHueuUuIu9u59otQYhlB/IOsOtkpKGJMYY0Oaew3w0gDMszLiNGEm/WFL6134Ky0aSB6ofbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290118; c=relaxed/simple;
	bh=Fu8LTVinyzjlfREShI+2eR8oonXZCahnrs8ZhaqRTvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovR7HALFrKsjfIG5nDz/52ZPSuqdb/QDlUSpGzOFr3L7iTN5RaMX8AinUXhPutWiuS04AjzMXsa9pp02YdQRAsnylpf+CGeBwE2OaBNrimdh+WcDhO0rP8v1xJ7h+AkdPjrwujr1AfoY0euYge6w5aFvzXV6aw/IZxKOvXHzjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZRk6hM7d; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRk6hM7d"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 94BA9266C3;
	Sat,  6 Jul 2024 14:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Fu8LTVinyzjlfREShI+2eR8oonXZCahnrs8Zha
	qRTvM=; b=ZRk6hM7dRfiWoiHC/rdlYoKoFFNize2u69jBtVTDUcPve07zZXbXzd
	yh5DhMyYt/ZGey0nPMFV7K8EhweREU+DM6TPWyh6BgOxxqEtBkjKX8vctMdUShke
	BPoXD7d0SBJpMT+sIJPz4Ash8koz/oyK2KSaCTsq9gsoAnVQt62SU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D474266C2;
	Sat,  6 Jul 2024 14:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9CD6266C1;
	Sat,  6 Jul 2024 14:21:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: wonda-tea-coffee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  wonda-tea-coffee <lagrange.resolvent@gmail.com>
Subject: Re: [PATCH] doc: fix the max number of git show-branches shown
In-Reply-To: <20240706062701.GC700645@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Jul 2024 02:27:01 -0400")
References: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
	<20240706062701.GC700645@coredump.intra.peff.net>
Date: Sat, 06 Jul 2024 11:21:51 -0700
Message-ID: <xmqqplrqpeio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E732226-3BC4-11EF-8B05-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> It looks like this is computed at build-time based on FLAG_BITS:
>
>   #define REV_SHIFT        2
>   #define MAX_REVS        (FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
>
> That's defined in object.h. Looking at "git log -GFLAG_BITS object.h",
> it seems it was 27, then 29, and now 28. So I'm not sure how it was ever
> 29, but 26 makes sense now.

Originally it was bits-per-word minus REV_SHIFT -- back then we
didn't even have FLAG_BITS.

> It is unfortunate that it _could_ change again without us realizing the
> documentation is now stale. But I don't think it's something we'd touch
> very often, so this is probably OK in practice (and as the TODO above
> those lines says, ultimately this should use a commit-slab to handle an
> arbitrary number of refs).

Yup, I was hoping I can craft a response that tricks somebody
(preferrably those who are not too experienced, as it should be too
easy for some of the experienced ones) into tackling that TODO item,
but you responded before I did ;-).

>> Signed-off-by: wonda-tea-coffee <lagrange.resolvent@gmail.com>
>
> We generally want a real name here, since this is certifying that you
> agree to the DCO. See:
>
>   https://git-scm.com/docs/SubmittingPatches#sign-off

Another rule is that the name used to sign-off and the name of the
author of the patch on "From: " line must match.

Thanks.  I was getting tired of the only person to point it out to
new contributors.

