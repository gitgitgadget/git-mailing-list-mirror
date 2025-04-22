Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AF1A3154
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364086; cv=none; b=RHPKhT8DxZhj/rOW8qyf2jiMzFIATjbhXAI2qKr6JzldpXTiEVcSFPzQnKQGdbgPgYih9CqdU4lQnShU/DkmEqz2S7LPE+s4DEk71TF3/NSaj7RGEN1liNsnNZ3wvrrB4msndPGq9Yo6YbQu+tKltUVo4UKYc4G6WQzfvGdd/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364086; c=relaxed/simple;
	bh=Bh5aHazm9QYI+Vp2rX9YRuWihl9b52a+3TWQeRkRy/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K8AuqhJf1XntZb2W/zRQnskK9M0ewPu6ciXnKSB50u9QNmB6eQLkLC5d5jfQZ013Gy6GPYT0900uiz4jmWfxMuOhucJ6Vzm1uJEdbie0ZzG2BSoA1VJlDd4238goVbgRUZ0gKZxgCOM2TrQ+QNdLiEW3TNTEJuHKndyehTfqCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Zhysk1J8pz9tQV;
	Wed, 23 Apr 2025 01:21:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 01:21:12 +0200
Message-Id: <D9DJXDL6JJJ0.3BM1YMOSV5P0F@buenzli.dev>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Nico Williams"
 <nico@cryptonector.com>, "Theodore Ts'o" <tytso@mit.edu>, "Martin von
 Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Junio C Hamano" <gitster@pobox.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com> <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com> <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
In-Reply-To: <xmqq8qnr3jji.fsf@gitster.g>
X-Rspamd-Queue-Id: 4Zhysk1J8pz9tQV

On Wed Apr 23, 2025 at 12:42 AM CEST, Junio C Hamano wrote:
> "Remo Senekowitsch" <remo@buenzli.dev> writes:
>
>> Btw. since the thread was started, the implementation in Jujutsu has
>> been completed and I've been pushing commits with the change-id header
>> to various remotes for a while now. It works well. Forges can start
>> taking advantage of it. (I hope I find time to help work on that.)
>
> It should work well, until somebody finds your random is not random
> enough, right?  Unlike our object name that depends on the contents
> (hence a duplicate unless the cryptographic hash function collides
> means they are truly the same commit), there is no grabally unique
> ID assigner involved in your implementation, right?  Until
> sufficiently large number of people start using and large number of
> changes gets assigned IDs, it won't become an issue, but then how
> would it be different from what was raised in the earlier discussion
> to use the commit object name itself as the change ID for a commit
> that is not derived from anybody else, and copy that ID to commits
> that are derived from the original commit as the change ID shared
> among them?  At least that would give us a much better uniqueness
> guarantee, wouldn't it?  If you want to be able to tell between
> commit object name and change ID, I wouldn't object if you encode
> them using whatever mechanism.

Random number generators are well suited for this purpose, the only
requirement is that the distribution of generated numbers does not
massively deviate from a uniform probability distribution.

Commit hashes have 160 bits of information, the change-ids used by
Jujutsu today have 128 bits. That's still plenty to make random
collisions practically irrelevant.

And anyway, the situation of colliding change-ids will be somewhat of
a normal event due to cherry-picking etc. Jujutsu can deal with this
situation just fine today. Colliding change-ids are simply not as much
of a problem as colliding commit hashes.
