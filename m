Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D1DFEF
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721671856; cv=none; b=Zj1+Fmumnm5RZ6syfKxB5ruiNlEH94V+9M+oFHD2OgFAIx+fsT+Qu/K6X47FvLG4iHDGqno8JSwbu5TzOSqdMA2w399DLoNMnpreGwmS+QlfbjOTCwgMcn348w0CL2ydcP+Hhzi2Qt1v2W8XheGaftlcELzzAKks4tuVKK3nD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721671856; c=relaxed/simple;
	bh=TTXPtE4a3NXbzKhOnZUA2FoZbwNT0kUWmt4pRQCNjc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRfx6rw3g2k0pRvLm6CZqcVtQskXw7C+YteTdInytfXpiW3UOf6lnfMfDxOLgGAB5QfI8FHifs2o8m0nOScISGnYtwAAGPmwf2/4cHNOTNSKthLD1Nc76UFKbOkSi/K1+KabiEzWvegjFQZfujGvP3NA7yO3RjDIPyMnw5FLKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IePjGfie; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IePjGfie"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20CB820BD9;
	Mon, 22 Jul 2024 14:10:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TTXPtE4a3NXbzKhOnZUA2FoZbwNT0kUWmt4pRQ
	CNjc4=; b=IePjGfienbuf+/wYYIVY+ny+jnR/aOok73vtlk3CvCu+v7GytvAmFS
	f5HlBhKrhH78wg1qBcyI4pejlp9CbNcDb2hOKLKRi8lOsKR6eTKpKjeDFErAAhTG
	8IVi96XjjvsThhuCw3+pDBslruqsScmBv464RaRRDmgurvsT+z2W8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1769220BD8;
	Mon, 22 Jul 2024 14:10:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72DFB20BD5;
	Mon, 22 Jul 2024 14:10:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,
  =?utf-8?Q?Rub=C3=A9n?=
 Justo <rjusto@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
In-Reply-To: <CAO_smVg8+WCG0dWZNPVbDM4gBJLLHrg96nOCzje6B3hUGneDGg@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 22 Jul 2024 10:26:10 -0700")
References: <20240722065915.80760-1-ericsunshine@charter.net>
	<20240722065915.80760-4-ericsunshine@charter.net>
	<CAO_smVg8+WCG0dWZNPVbDM4gBJLLHrg96nOCzje6B3hUGneDGg@mail.gmail.com>
Date: Mon, 22 Jul 2024 11:10:52 -0700
Message-ID: <xmqq34o1cn6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBF9B786-4855-11EF-BD89-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> Is there an example of a shell on Linux that has this behavior that I
> can observe, and/or reproduction steps?

Every once in a while this comes up and we fix, e.g.

https://lore.kernel.org/git/528CE716.8060307@ramsay1.demon.co.uk/
https://lore.kernel.org/git/c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu/
https://lore.kernel.org/git/Koa4iojOlOQ_YENPwWXKt7G8Aa1x6UaBnFFtliKdZmpcrrqOBhY7NQ@cipher.nrlssc.navy.mil/
https://lore.kernel.org/git/20180713055205.32351-2-sunshine@sunshineco.com/
https://lore.kernel.org/git/574E27A4.6040804@ramsayjones.plus.com/

which is from a query

    https://lore.kernel.org/git/?q=one-shot+export+shell+function

but unfortunately we do not document which exact shell the observed
breakage happened with.

The closest article I found that is suitable as a discussion
reignitor talks about what POSIX requires, which may be more
relevant:

  https://lore.kernel.org/git/4B5027B8.2090507@viscovery.net/

