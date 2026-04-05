Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256635B14B
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775369680; cv=none; b=hHUppKSA4WPs9oZ5FTm5rh9mIldltNMUiX6gKlmQTdAlPtg77dP3jb/tjxHzF/H9QB18xbOxk84a2B3VD3fmZwqXvttIkGDnHXMMZ4eAAM10KJC8qkbkAPK4Mg1jLIo/V8oVGGdNlFmE76e+5zCVNbstjq/wXt9hgj24yEZyuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775369680; c=relaxed/simple;
	bh=rIFwYJoRYg8yhLx5MPwyGi+hjvPoiI31cexAiJQbF7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJk2tVoFVsevLUwrHsMFLUrlU2rGjLcXAcRQjsDakJ/sP7kkIAKhWHesQIc90W0yRlASSrnvnjGWMs77SeE+mqeWsxn2zHdF73tQwufF27r/s2wGD+RRQz5KCUA3569FQaPNfxoqw+hWKHyrCZ8Gbhxb0H2j//j0HBqV8xoREGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Hjsoegp4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Hjsoegp4"
Received: (qmail 249972 invoked by uid 106); 5 Apr 2026 06:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=rIFwYJoRYg8yhLx5MPwyGi+hjvPoiI31cexAiJQbF7o=; b=Hjsoegp4wriZdaSceE7bKTWGyOoOeKdHutqPXejAe2pHZH2M8BI5Y34d69IqngJ9UzsWFEwLhazf2yN8I8+U23NJsrwwBPKkbC3te1r7AVl620hwfHhhfDncn0hcFOaxzc/LIiHAF2tjiFahiqZH0XH03N+qij57e0ZsH3DRTwfzkMHyLvNtFO6kCjXD+Q4NEKh1Olb83w1DbYKQWPOM6uQLdo+dukRUDd2vq0Qnzrr+f7VQZuwp1/GnZWrJaNVIHGrZSw2RrBKnRJ/S4J3LvG1EYqixFAhvPgJqnbdGiDG2H6Am6ziTW20bbkevxJAee+B1Ac9UZXbhATpf6Yjr+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Apr 2026 06:14:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 402768 invoked by uid 111); 5 Apr 2026 06:14:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2026 02:14:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Apr 2026 02:14:30 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <cat@malon.dev>
Cc: Justin Tobler <jltobler@gmail.com>,
	Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
Message-ID: <20260405061430.GA1451922@coredump.intra.peff.net>
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
 <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
 <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
 <20260404230939.GA1360412@coredump.intra.peff.net>
 <7841c013-1f6e-49e3-9f47-f25044764a11@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7841c013-1f6e-49e3-9f47-f25044764a11@malon.dev>

On Sun, Apr 05, 2026 at 10:48:16AM +0800, Tian Yuchen wrote:

> > Immediately after that commit, the switch from taking an odb to a source
> > is not helpful, though I think eventually it is used to set
> > transaction->base.source. But should the whole thing check for a NULL
> > source and return early? Or otherwise establish some kind of noop
> > transaction?
> > 
> 
> In a nutshell, are you suggesting that odb_transaction_begin() should return
> silently when source is NULL?
> 
> I understand and agree with your intention, but in practical terms, if the
> odb has not been initialised correctly, data will be lost silently here and
> the caller will not receive an error message. I’m concerned that doing this
> might lead to more bugs in certain situations

The source of data loss is not the transaction begin/end, though, but
the actual write operation inside it. If I do this:

  t = odb_transaction_begin(the_repository->objects);
  if (startup_info->have_repository)
	odb_write_object(the_repository->objects, ...);
  odb_transaction_commit(t);

should it be an error? We chose not to write because we knew we did not
have an odb, so there is no data to be lost. Starting or ending a
transaction without an odb _is_ a noop, because there is nothing that
can or will be written. It is asking to write that is the error.

In the example above you could obviously push the transaction begin/end
into the conditional. But that's harder when the "if" part is happening
inside a helper function, which is exactly what's going on in index_fd()
here. It passes the flags (which would omit INDEX_WRITE_OBJECT) down to
index_blob_packfile_transaction(), which then goes through all its
regular motions without touching the odb.

This used to work because begin_odb_transaction() did quietly return
NULL, and index_fd() did not have to care about the flag at all.

> Would it make more sense to treat this as a bug instead, e.g. by
> triggering a BUG() when source is NULL?

I don't think so, if the point is to be kind to callers. We should still
BUG() on an actual write when there is no odb or repo, of course.


I looked over the other callers of odb_transaction_begin() and I think
this is probably the only affected caller. But I don't think it's purely
academic. If you teach index_fd() to use index_core() when the
INDEX_WRITE_OBJECT is not set (as proposed earlier in this thread), I
think you'll fall afoul of the comment at the top of the function:

          /*
           * Call xsize_t() only when needed to avoid potentially unnecessary
           * die() for large files.
           */

E.g., on a 32-bit system we'd die() on a 4GB file now (because we can't
fit its size in a size_t anymore), and probably even smaller (because
we'd try to mmap() it and there wouldn't be a large enough contiguous
chunk of the address space).

So we really do want to follow the streaming path, even if we're not
writing out the object.

-Peff
