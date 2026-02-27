Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8911DC1AB
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232322; cv=none; b=QiR1WiRCONEEK23guVzlZxiIxSoyWKirwMLgie71rLiDRyJ+xoB1JOrOiMaQg/F7it+RsxZx8vgVM/XuRV8wrrWWgLXwwKASDJjwYR7f7FWBqp4zVTI3OZnUEj/Dfw2v6+y94LgVJf2f+4EyJOErHBtSTzFsnaDTeYeyemdPMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232322; c=relaxed/simple;
	bh=SVibsR6wPL5wteak6+zyjCcL0I9kk5DBB0QA4ejzGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwVbdik1BHK5X2+mm6G4Da/sGrE7mJu0spYZuHPA+/vNge3FbJCwbpUE5B5iAUowUfkPChGncFbQJdxtaID05PFeZ/d1Rc1p2S/MFz3Pt4P2grnRzxiUSfqlLZAILbABmbWGci9mt7w2qyo4p7XNpu6nG1PdmaW3lYgZRIb0iB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e9IlyyDb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e9IlyyDb"
Received: (qmail 83440 invoked by uid 109); 27 Feb 2026 22:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SVibsR6wPL5wteak6+zyjCcL0I9kk5DBB0QA4ejzGUo=; b=e9IlyyDbfDyLODyS++ub/A8A2Z/Oii8HI50ltaMsi9/8KAmphNKP+vsKFLQmSkBqE/D66JRGdnKTSjEXfkBFQR9qWKuFIK4XqqoimW6noWbvDRsrp4+2aEDwgefjJ0kdn69xDLP3aeSl6GbPaR3nYeV9lkyckcXVI0irILFJXXVnBg3dP3w6bCS2wW79+PyWgPtvaTtUNZUDGsowybSihxKBjE2MCGVRAXz+9eTCqvftwEG0Z9QfSLlvcBaoqjrPqBD1sRNumJ10UIrpVi9eyqhfNGTBgEEhIIlI+9PEx32g6HtlHA319SNJdUxIc8+a44+THxog9Ew0YH9RgWrVnw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Feb 2026 22:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 281887 invoked by uid 111); 27 Feb 2026 22:45:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Feb 2026 17:45:22 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Feb 2026 17:45:19 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260227224519.GB2956443@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g>
 <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
 <xmqqsean4gsc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsean4gsc.fsf@gitster.g>

On Thu, Feb 26, 2026 at 08:21:23AM -0800, Junio C Hamano wrote:

> > This comment details my findings from comparing the list in
> > local_repo_env[] and the top-level options listed in
> > Documentation/git.adoc. That's how I was able to find that
> > --exec-path sets an environment variable that's NOT in the
> > list and we want to be sure we don't set it.
> 
> Hmph, wouldn't we want to use specified exec-path inside ...
> 
>     git --exec-path=~/my/git/libexec for-each-repo sh -c "do things"
> 
> ... "do things" script when we find Git related binaries?  Or am I
> not getting what you are describing here?

I almost responded with the same thing, but I think the suggestion is
going the other way: we (correctly) do not list EXEC_PATH_ENVIRONMENT
via local_repo_env, so it will never be removed from the environment.
And thus we do not need to do anything here to drop it from the list of
what is removed. Double negation. :)

The second paragraph:

> > Should we add the comparison to EXEC_PATH_ENVIRONMENT as a
> > precaution to make sure it's not added to local_repo_env in
> > the future? Or is that too defensive?

makes that more clear, I think. I did have to read the whole thing
twice. ;)

-Peff
