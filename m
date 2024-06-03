Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4F13A878
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439599; cv=none; b=fonBYjOjJgQS7+m74jOgSTjCi6uOKwPokBWMFm1Hu7j4q1BVWmMcJgUPNgmaxP7wj8skij8ucFwMKS9pqlrEUUke9JjKCEmFdsdBwYcD7Wbr8sqPfIFBEtuu0Fb1jh+fnnQU2wiawQS70oawM1Lf/Jdl0JX5WknSXsRIj5rXqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439599; c=relaxed/simple;
	bh=QL+L/lSOMrkDYujreQOPcfPQpiRtJk7CEoddk5CBdJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDUrh7BzIASDCngv16nDsZlA2woCJVGPhoXfdlH6Ahmvz21iP7RqlI7doNJiqsxTKALntGP86ViLIGCdGVxfYfakyFQ+ANzdm/6ti9DP1GR4U6i1mxk2CIFlnwMePgor4m3hgNSPae5I57Ztsdj7euI2pgEr+FDhwRLcFDIzwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=De1Nthoy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="De1Nthoy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 071AA2D472;
	Mon,  3 Jun 2024 14:33:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QL+L/lSOMrkDYujreQOPcfPQpiRtJk7CEoddk5
	CBdJo=; b=De1NthoyE9PHb8HM2EQ9F+BmTeky4wJ/P+2+Ixa7dXfKBX0H8mHRcq
	lttWq+iGVgowfJWSp6OridAbYhs4jX8uCZPtSHbaIIB4M+QLVrzM+mS6ytsN/zpr
	oxsmCSvA5wfVVWZzDejHZrD6tcG9Ij4CJNUVKzEr5IMOIoveQYvVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F31DA2D471;
	Mon,  3 Jun 2024 14:33:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6745C2D470;
	Mon,  3 Jun 2024 14:33:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kevin Day <toasty@dragondata.com>
Cc: git@vger.kernel.org
Subject: Re: Commands using -h as an option don't work consistently
In-Reply-To: <xmqq34q0rnio.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 May 2024 20:23:27 -0700")
References: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com>
	<xmqqfru0tg1a.fsf@gitster.g>
	<0F971F6E-6462-4E0D-880B-8FD67F42A782@dragondata.com>
	<84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
	<xmqq34q0rnio.fsf@gitster.g>
Date: Mon, 03 Jun 2024 11:33:15 -0700
Message-ID: <xmqq8qzl3mhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE317362-21D7-11EF-A513-6488940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Ah, then no.
>
> I am afraid that it is a non starter.  "git ls-remote -h" would then
> start breaking existing users' long established expectation, i.e.,
> "for any git subcommand 'cmd', you can say 'git cmd -h' to get the
> short help".  We need to design a good transition plan to wean
> existing users off of that expectation.

Another thing I forgot to mention.  For "ls-remote" and "show-ref",
there is a much nicer transition path we can take.  Back in Linus's
days, we called branches "heads" (and we used $GIT_DIR/refs/heads/
to store them as individual files), but if we were starting Git from
scratch today, there is no reason to.  Call branches branches, not
heads, which means we do not need to use "-h" to mean "I want to see
only the branches and no other refs" at all.  You say "--branches"
instead.

Which leads to an obvious transition path, which is

 * Introduce "--branches" that sits next to "--tags" to "ls-remote"
   and "show-ref".  If the command has "-t" as a short-hand for
   "--tags", then add "-b" as a short-hand for "--branches".
   Announce that "--heads" (and "-h" if supported) is deprecated for
   these commands, and when "--heads" (and "-h" if supported) is
   used, give a warning to train finger/muscle memory early.

 * We will keep things that way for a while, and then remove the
   "--heads" (and "-h" if supported) from these two commands.

The approach cannot be used to transition "git grep -h" for obvious
reasons, but then it makes no sense to give "-h" alone to tell the
command "I do not want to see filenames", so that is not a problem.

I checked output from 

    $ git grep -A2 '^-h' Documentation/

and it seems that ls-remote is the only one that matters, so we do
not even have to do the "-?" transition at all.

Thanks.

