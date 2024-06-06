Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EE7345D
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713882; cv=none; b=sjQs0Vn5FSL6fbW/eZAP0sQBe3D28DcgcACIA9hBPTMla9pIcHsADwgfEpX8m2PGJ2Efj7ZSq0Rxa03eNSoXHyAyHRtJfecka+FVOl9hyzJXGiZmXugb6IZ3B/miBFXHPEhU9O8G5zgHZtj4J+p3MPcXQdC1P4YcG2URAvkK1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713882; c=relaxed/simple;
	bh=J9FNpqqzHm5EecZizf3iiob4UIwN002eWpnoYqsh/nM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NdPg7Qj2ZSgM3ZIySa4cNgaKAtHzqsiEukiaY71geNFlNFXBpXifDshTmZMXpR8HF6XAg4OlzF+C0ZEiK9jpn9xFCQMUXpujla/YtJykB+MVLzFvr5yo5U7cilfI8gB25XNJxOkFp1LFbF1q+P8UnybMzOg61BeO4UdcKfPohGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4qYXcfA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4qYXcfA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F834264B5;
	Thu,  6 Jun 2024 18:44:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J9FNpqqzHm5EecZizf3iiob4UIwN002eWpnoYq
	sh/nM=; b=D4qYXcfAus21/WCjyn/CgYv5WffuFarkf96tYMgsSagOvZt50x2RwF
	flL8l7tszY/774r/Bmkfm5SblprZ8/vIISmJuZeQWNwwVYVoukzNqZ35upO5Hdi2
	y7Bamzur4mZ68mHsYWpZjyl32cLBkOoAVyb2T2jbN+f++q/zrLcTc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 477B7264B4;
	Thu,  6 Jun 2024 18:44:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 662B7264B3;
	Thu,  6 Jun 2024 18:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>, Aryan Gupta <garyan447@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com> (John Cai's
	message of "Thu, 06 Jun 2024 17:02:05 -0400")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g>
	<F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
Date: Thu, 06 Jun 2024 15:44:35 -0700
Message-ID: <xmqqed99k7xo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5A682DF4-2456-11EF-8813-ACC938F0AE34-77302942!pb-smtp20.pobox.com

John Cai <johncai86@gmail.com> writes:

> On 6 Jun 2024, at 14:21, Junio C Hamano wrote:
>
>> ADMINISTRIVIA.  Check the address you place on the CC: line.  What
>> we can see for this message at
>> ...
>> I fixed them manually, but it wasn't pleasant.  I think we saw a
>> similar breakage earlier coming via GGG, but I do not recall the
>> details of how to cause such breakages (iow, what to avoid repeating
>> this).
>
> oof, apologies. Didn't notice that. I'll be more mindful about the cc line.

I found the previous occurrences of the same problem:

  https://lore.kernel.org/git/xmqqjzm3qumx.fsf@gitster.g/
  https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/

The last message in the thread

  https://lore.kernel.org/git/CAMbn=B7J4ODf9ybJQpL1bZZ7qdWSDGaLEyTmVv+ZBiSeC9T+yw@mail.gmail.com/

says that the original user of GGG found what was wrong in the way
the user was using GGG to send and fixed it, but unfortunately we
didn't hear exactly *what* the breakage was and *how* it was fixed.

Aryan, do you remember what the problem was and more importantly
what the fix was?

Thanks.
