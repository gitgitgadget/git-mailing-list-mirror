Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD0481BA
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381271; cv=none; b=c+Xtb7sV6lDpfKmi47AX4bGJ/QIfkuAaVHLD891Vx2O92lIBZk4Eg+GTjX1YDT7LvE/sQdziQwHsoGKJiu73axAxTKFhawg29nqWqtXQW0QoANiYl0ulSGJPr+V8M04evMOtZfg/W9f9cTWrDA8r6BQ5+HrLD9nnhBes/g8wx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381271; c=relaxed/simple;
	bh=hdmjAWnd/zvdYblYvX94RtDgNvkam2H9OWmdIQXaLB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNpOAoOxoh9v6dMmvjrECVySUeD6DrA5C7MKpnUEsb7D1A0KvIQJWGUn2qmYDW44VZZ+Cz0b+pS1qp497WJe+5iCZtMYT9BJnmJz9cgNr3GMfcVAJZp0dmrD3mLT7NeLx/YolYh51od2psvZoKJcak4zt5WhPUymsyrynZRDr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JvqLJFfh; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvqLJFfh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B3D34625;
	Fri, 10 May 2024 18:47:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hdmjAWnd/zvdYblYvX94RtDgNvkam2H9OWmdIQ
	XaLB0=; b=JvqLJFfhgN7E/q0jWvOpgc3HXWb7YwRNuJCqIzSpUGy8RNYtgeY2/d
	LJW2TsooZtcqDVjY5xxF8QoSC1s/PDSfjRApgun4r6v2i/XpG6csTMjgW6uh0ANl
	zMhO1RpQxWp2McrbpFDS3bEYCz1vClHeOXdtCCWhtWV8xKW47Cg8c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B27DE34624;
	Fri, 10 May 2024 18:47:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2609734623;
	Fri, 10 May 2024 18:47:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kyle Lippincott <spectral@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
In-Reply-To: <20240510220228.GA1962678@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 May 2024 18:02:28 -0400")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
	<20240509162415.GB1708042@coredump.intra.peff.net>
	<CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
	<20240510220228.GA1962678@coredump.intra.peff.net>
Date: Fri, 10 May 2024 15:47:39 -0700
Message-ID: <xmqqseyp1dys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F5E0EAC-0F1F-11EF-8D1C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I do think there's value in testing with both clang and gcc in
> general[1]. And there is _some_ code which is compiled only on macos
> and not elsewhere. So this would be our only chance for gcc to see it.
> But it seems like a pretty small return for an entire parallel job.
> Especially as I do not think it has uncovered anything interesting in
> the past (even when it was working).

100% agreed.

> [1] Another quirk is that we run the whole test suite for both
>     compilers, which is probably overkill. The main value in comparing
>     gcc vs clang is that we don't use any constructs that the compiler
>     complains about. It's _possible_ for there to be a construct that
>     the compiler does not notice but which causes a runtime difference
>     (say, undefined behavior which happens to work out on one compiler),
>     but I think we're again hitting diminishing returns.

Yeah, that is a very good point.
