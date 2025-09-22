Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326423112AB
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557865; cv=none; b=h7ux3uPp8SMHtexfIgFTighhGWXHPFfisy22r1aMqc4Wpii03VSs/X3LpvoT+f+1IbLm7r0U0ImEs93f1S7NeNOlmG8WWM74Rul2jtWDEKn+IkM8YmjJA7i6QH0WpmekDI4bs0cPp6a63VIiai3d47tnWvF2UCu2vLMg8p1wVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557865; c=relaxed/simple;
	bh=JUlaI1WG5slBkkaq0NW33ennB8dNbYt0hZ/bVxyS/0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gO6hWhUijpwIYt42QDKhX73qScgNs+ee5iA48daNh3k5z/5DA4lCOwZBPwO+PCImdhw3yF9mlImreQPRR1KeSBd/tJLmG1+KtJtxXws1qJJnUIjt2sjpPbaH+DlJABzYJx7SBjql/eIAr8JsvZM8+nNByxZDjQ9uly3iZ/9eKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 004EE3410E3;
	Mon, 22 Sep 2025 16:17:40 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Michael Orlitzky <michael@orlitzky.com>
Cc: ezekielnewren@gmail.com,
  20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
  Johannes.Schindelin@gmx.de,  ben.knoble@gmail.com,  cb@256bit.org,
  collin.funk1@gmail.com,  contact@hacktivis.me,  eschwartz@gentoo.org,
  git@vger.kernel.org,  gitster@pobox.com,  me@ttaylorr.com,
  newren@gmail.com,  phillip.wood123@gmail.com,
  pierre-emmanuel.patry@embecosm.com,  ps@pks.im,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
In-Reply-To: <20250922155949.27019-1-michael@orlitzky.com>
Organization: Gentoo
References: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
	<20250922155949.27019-1-michael@orlitzky.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Mon, 22 Sep 2025 17:17:38 +0100
Message-ID: <877bxq8nrx.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Orlitzky <michael@orlitzky.com> writes:

>> We know for sure that NonStop currently does not support Rust at
>> all, and that there are problems with porting Rust to Gentoo, but
>> I'd like to hear what OSes and Architectures you use personally and
>> professionally and why adding Rust would be a bad idea. Is it
>> corporate policy? Is it that the Rust toolchain doesn't exist for
>> your os/arch? Is it that Rust is a new language and isn't as battle
>> tested as C? Something else?
>
> There is no problem with supporting rust on Gentoo. Gentoo users build
> from source, and rust is a problem for anyone who builds from
> source. I'm writing this on a riscv/musl system. If there are no
> binaries for your CPU/libc, let me tell you, it's not fun. And this is
> like, my job. A normal person would be completely helpless.
>

That is precisely the problem that Eli and I have been describing in
this thread (along with some more minor issues for Prefix to figure out,
and then missing arch support where Rust doesn't support it at all).

He is referencing issues we brought up earlier in the (various) threads,
not plucking it out of thin air.

> Nevertheless, the arch support issues are secondary. I'm sure it's a
> lot of fun for the people who are writing rust code to do cargo
> updates in the two or three directories they work in all day. But I'm
> not writing rust code, don't care what language git is written in, and
> have hundreds of other packages to keep up-to-date on multiple
> machines. I want to be able to use my package manager to do that
> efficiently. You know, the main tangible benefit of using a linux
> distribution.
>
> But every distribution is "packaging" rust the same way. They're
> bundling random old versions of crates in violation of their own
> policies because the ecosystem is unstable and the tooling encourages
> tight coupling. By requiring rust, you are require me to go back to
> managing dependencies like I'm on Windows XP again. Git is the most
> important program I use, but it's not more important than package
> management itself.

Indeed, this is all terrible, and I agree with you, of course.
