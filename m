Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBB3B7B76
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951724; cv=none; b=mUmL7E4r2BF5tyP2+pkGMTaz4yaE8COH59jC1IlR3hTg5swOhlMADev35dfd/rM/bdpG4VCIDGuHbTJ7Bki4aHWEIFD+131GrPhS8K8d+JEqhc20vYsk3TJIy2JW2wAEtF48xk0qk4lonWM7k+f7Gr6m6+Cjsg3U9rvEaNmP4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951724; c=relaxed/simple;
	bh=YBi+R68Rlvgh2TrJnvNLlXUZT3IeTJfTIdwajw96DyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPnpajDl566/a9JSQbaWx6RX/CZJwYGrxT3LGfDCCXsONymPUzQ3smjhBakDbaaJm56+YPZI9g0MdP9LCVdQzg0THFxlZbwF5oIcSs9b28JKNeYQUy85/BiYr2v70VREmkj6v6s2V9Jr/xtmFdM8zK8xl+fGUsLL4ogy/lEF/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RtIH2NWN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RtIH2NWN"
Received: (qmail 73166 invoked by uid 106); 17 Aug 2026 07:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YBi+R68Rlvgh2TrJnvNLlXUZT3IeTJfTIdwajw96DyQ=; b=RtIH2NWN+TOe2HEyfAKkl1/O+HJ+fL41DoKuWkdp6hVnBCZePDFisyrhFm0keDe1q4bCbVjjc+lmFSNnHpbUEpU3tIX9LW7iG7/A2Qxy8aq/BnhoAIo+BGMqqbgO0UM6lUBJ3iYI7XgtBNRH1i/pkLTEfas8uQpoBIo8I2HBohuLUyX+pbwbGlmi6Bkp3PgLTQlFRCkqoliWYt5ocdoIDCv+fL1vRVuS5GmGV58aN+nDyYaJ6z7jckVkEdOJkZ8Bn/6W5IYsk1Vq6Pb7IY04y1pGR25SFPCcr0m3VchuCkkfvsg9GqWLu/XGIiwohISFobgWNPsqeOg8h5pRIw4Qwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2026 07:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15027 invoked by uid 111); 17 Aug 2026 07:28:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2026 03:28:45 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Aug 2026 03:28:40 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260817072840.GB690018@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <aoKeeQMps50rjhWi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoKeeQMps50rjhWi@pks.im>

On Mon, Aug 17, 2026 at 07:39:05AM +0200, Patrick Steinhardt wrote:

> I also had the feeling that case insensitivity is quite a bit lacking,
> too. What we're really after is whether two directories are actually the
> exact same path. And whether the path is case-insensitive is only one
> part of that equation, so it's an imperfect metric by itself already.
> 
> Ideally, we should probably use realpath(3p) to at least also resolve
> symlinks. Unfortunately, it's not guaranteed that this function also
> knows to canonicalize casing.

Yeah, exactly. I don't think we have a completely robust way of doing
that check.

> > So I kind of wonder if we could just do away with considering case
> > insensitivity here at all. We'd err on the side of correctness in the
> > ambiguous cases, and this code complexity can just go away.
> 
> You will of course be able to craft edge cases where that would be a
> significant regression. But if your alternates file looks like this you
> may be holding it wrong:
> 
>     /path/to/alternate
>     /PATH/TO/ALTERNATE
>     /pAtH/tO/aLtErNaTe
>     /PaTh/To/AlTeRnAtE

Agreed. The more likely case to me is that repo "A" points to "B" and
"C", then "B" also points to "c" (lowercase). Or you can imagine other
tree structures that converge.

I don't think you could ever get there with standard Git commands,
though. We only ever insert a single alternate via "clone --shared", so
they always form a chain. To get multiple entries I think you'd have to
create the alternates file manually.

  You could also have a chain that forms a loop, but I think you are
  probably beyond screwed at that point anyway. And also probably
  impossible to do with "clone --shared", as the parent repo must
  already exist.

So yeah, I'd be highly surprised if anybody outside of specialized
alternates-tweaking scripts (like the ones that forges use) would ever
construct a situation where duplicates even mattered, let alone their
case. In the case of GitHub's scripts, they were always boring and
one-level anyway (forks point to a shared repo).

IIRC talking to kernel.org folks long ago, they had some kind of tree
structure that matched the filesystem (so foo/bar/baz.git borrowed from
foo/bar.git, which borrowed from foo.git). I don't know if it was a
strict tree, though, or if that system ever even saw production use.

> Hm. Weren't there filesystems where `st_ino` and `st_dev` aren't set at
> all? I think that's the case on Windows, which is unfortunately also the
> one where we see case insensitive filesystems by default. So that makes
> it way less effective, as it only works on systems where we typically
> aren't case-insensitive in the first place (except macOS maybe).
> 
> So if we want to go down this path I'm inclined to just unconditionally
> use case sensitive matching and not introduce any secondary machinery.

Yes, that's my preference, too.

-Peff
