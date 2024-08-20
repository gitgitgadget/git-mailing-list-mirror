Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66964101C4
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173300; cv=none; b=j+gR+dZiGuQ9rMweaG5ouIRBQJG/Pr/7wmsicoF8J05Repzw2ZAD8AhLBpT4UiqJsjUgmpzlFZyXrSK8eXOYaNLYpP8w/8x2fA7D9ijyqC9dAcucfuu53eVgueBgLeBvP0kzL6GrHEn0Bi+x24jOAHzoG9Aynnkib4Xy19L82aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173300; c=relaxed/simple;
	bh=s9OMQgMGYjI1vYkVgxXNLkYlcq7xOZLziJlbdv67Isg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQtEInCHKVrDGiAMJnVknGr68rbVkD+HYTLMpamoZgljvsZuYOGVc9lDHfPFdwYb7D1J5vZM660y5tKuc4mBoeDgm8G1uO+Ur0A268Of9M2KnM1xaIoILMCmiDJ0AwviHE/zeOGtU8HBHB02FxQK3++fL1SmxVvD1NKs0rUw38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O59mquwj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O59mquwj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EEFC42E13C;
	Tue, 20 Aug 2024 13:01:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s9OMQgMGYjI1vYkVgxXNLkYlcq7xOZLziJlbdv
	67Isg=; b=O59mquwjFYkJmAA86afHqwk6q0OxrCyJY5zUujQYSCwXBEhm40Rhii
	8zIso4rySSqc7aoZz/0nrVnbv+mxj4K6aFsCF0ty+Kk6a9bv8OIJd0cx6EAhquVg
	H24bU8KdeEUpzc77Q+1V0AR+aV7ahwTAnCgxa0084AFQu1ohKIkaQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E663F2E13B;
	Tue, 20 Aug 2024 13:01:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 719D82E13A;
	Tue, 20 Aug 2024 13:01:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <CAP8UFD04M2m0_Y5uVpau2BTsJWLq85fvBCVz2VYEcx902dXWBA@mail.gmail.com>
	(Christian Couder's message of "Tue, 20 Aug 2024 13:32:48 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
	<Zqpa8/aLpgtzoBH2@nand.local>
	<CAP8UFD04M2m0_Y5uVpau2BTsJWLq85fvBCVz2VYEcx902dXWBA@mail.gmail.com>
Date: Tue, 20 Aug 2024 10:01:33 -0700
Message-ID: <xmqqzfp786xe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB969678-5F15-11EF-B5F4-BF444491E1BC-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> I agree that it's more useful the other way though. That is for a
> server to know that the client has the capability but might not want
> to use it.
>
> For example, when C clones without using X directly, it can be a
> burden for S to have to fetch large objects from X (as it would use
> precious disk space on S, and unnecessarily duplicate large objects).
> So S might want to say "please use a newer or different client that
> has the 'promisor-remote' capability" if it knows that the client
> doesn't have this capability. If S knows that C has the capability but
> didn't configure it or doesn't want to use it, it could instead say
> something like "please consider activating the 'promisor-remote'
> capability by doing this and that to avoid burdening this server and
> get a faster clone".
>
> Note that the client might not be 'git'. It might be a "compatible"
> implementation (libgit2, gix, JGit, etc), so using the version passed
> in the "agent" protocol capability is not a good way to detect if the
> client has the capability or not.

It is none of S's business to even know about C's "true" capability,
if C does not want to use it with S.  I do not quite find the above
a credible justification.
