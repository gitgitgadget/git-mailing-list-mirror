Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2448781
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HQC1mOaj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF8FD1C9312;
	Wed, 10 Jan 2024 17:11:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4i80nBZeY0FJsIPKaDG60byiRoKg1Pq38s+2YR
	EgF+M=; b=HQC1mOajFkpYpY2EDU/Wu5bZMvwQ7RseKen5fb44xt0cF0WY7a4xyX
	evhrltTXePFOKbuODdSKNYU0XY2Y9mfVLad9BMVFyQyyBkLdTk7hPEDhv/XbYbxP
	kx6quQT9FjBKq5vja9QcmtUVU6BYorusgniKyB3QuWwUdvq4GhAwM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A62671C9310;
	Wed, 10 Jan 2024 17:11:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10B751C930E;
	Wed, 10 Jan 2024 17:11:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> (Dragan Simic's
	message of "Wed, 10 Jan 2024 22:57:21 +0100")
References: <ZZ77NQkSuiRxRDwt@nand.local>
	<b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
Date: Wed, 10 Jan 2024 14:11:34 -0800
Message-ID: <xmqqjzog96uh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 384B1A94-B005-11EE-A47D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Thus, Git should probably follow the same approach of not converting
> the already existing code, but frankly, I don't see what would
> actually be the "new leafs" written in Rust.

A few obvious ones that come to my mind are that you should be able
to write a new merge strategy and link the resulting binary into Git
without much hassle.  You might even want to make that a dynamically
loaded object.  The interface into a merge strategy is fairly narrow
IIRC.  Or possibly a new remote helper.

Adding a new refs backend may need to wait for the work Patrick is
doing to add reftable support, but once the abstraction gets to the
point to sufficiently hide the differences between files and reftables
backends, I do not see a reason why you cannot add the third one.

And more into the future, we might want to have an object DB
abstraction, similar to how we abstracted refs API over time, at
which time you might be writing code that stores objects to and
retrieves objects from persistent redis and whatnot in your favorite
language.
