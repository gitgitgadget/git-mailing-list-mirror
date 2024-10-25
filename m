Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98418C018
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838513; cv=none; b=tvgN8YdYCsYOUk560o2ILFhuBmKmnbHVpn3t2a6z6+KhwCl5A14jGezntkmMsnz/y6uVOEfTyXMI+sdmnvCZCOsCoo0ARHrQ1WUyGsSWjnMFMVZEJIz7oTlGR2aFEFx2Z1ZJkrV7ApRIUn6b88wgSJpIgBUYehsFHjtccjFdDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838513; c=relaxed/simple;
	bh=/TXR34skYjcnHL6tNxFgx4sAzjjPnHBZM1AUBPm26rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onafiaeutujCLHmc19UYfNPtK9kxgov5rfoJ/SYvhxHbn8jEkHlBVU49jgLxaPKomZjrpp1FoJ0m+5VCyYF6nsWWlLUtNWhdV64R8EN5Abhi1KMZZ5qweJ4dCLnrzZcOEpG75VUZtQ8YAHVad+KGLyRPmC3vkxHLIAimKbjj0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xru4+ovW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xru4+ovW"
Received: (qmail 330 invoked by uid 109); 25 Oct 2024 06:41:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/TXR34skYjcnHL6tNxFgx4sAzjjPnHBZM1AUBPm26rQ=; b=Xru4+ovWUO+5azQyTE8kp11nHVI/7tAaRZRdgfjCW1zdxKWWDvMM+xeCRblhgoFU4ZUnEy+BzzmkJiegvFB9kjNK7kgcZjPvfbqyPrvFYz/PtMarMXdfyp7hM5fiPAvL/nW9yERVgWpJazRlOU/KZTZf0CkXFCGt21EhnR7iGMiDS1DFdYl9Ah8h1Y2Y6mvT+VAZVywWXRYVPRlTMkdsthlxtWDBy7PIPU3f1oYdtBtKXwM7SuqSmDNP1O9axN78Rv1ElvQLAWOTgdvF3T3AF6L1WCZ9Yrg0rvPmeu86mlaQlZE01LHedgQzX5zSpj6Z1AacFADWnX2revrUefIBhQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 06:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12646 invoked by uid 111); 25 Oct 2024 06:41:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 02:41:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 02:41:48 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 0/11] dumb-http pack index v1 regression + cleanups
Message-ID: <20241025064148.GA2110169@coredump.intra.peff.net>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <20241020024022.GA615104@coredump.intra.peff.net>
 <Zxa6ixwP2aOJdfmL@nand.local>
 <20241022051402.GB1247135@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022051402.GB1247135@coredump.intra.peff.net>

On Tue, Oct 22, 2024 at 01:14:02AM -0400, Jeff King wrote:

> I'd also like to see if I can clean things up around parse_pack_index(),
> whose semantics I'm changing here (and which violates all manner of
> assumptions that we usually have about packed_git structs). It's used
> only by the dumb-http code, and I think we want to refactor it a bit so
> that nobody else is tempted to use it.
> 
> I'll try to send something out tonight or tomorrow.

This took me a little longer than I expected, mostly due to triggering
an (existing) bug related to midx. So here's the series I came up with.

The first patch fixes the midx bug, which otherwise causes spurious test
failures in patch 3.

The second patch beefs up the existing tests for the area we're
touching.

Patch 3 is the actual regression fix. I apologize in advance for the
length of the commit message. ;) I tried to summarize all of the weird
dumb-http implications I discovered.

If we wanted to we could stop there for maint, and treat the rest as a
separate series. But since it's cleanup with no intended behavior
change, it's pretty low-risk.

Patches 4-10 are mostly about cleaning up crufty interfaces that I ran
across while working on the earlier patches.

And then the final one is an oddity where I think the code is doing the
wrong thing, but it's not possible to actually trigger the bug in
practice.

  [01/11]: midx: avoid duplicate packed_git entries
  [02/11]: t5550: count fetches in "previously-fetched .idx" test
  [03/11]: dumb-http: store downloaded pack idx as tempfile
  [04/11]: packfile: drop has_pack_index()
  [05/11]: packfile: drop sha1_pack_name()
  [06/11]: packfile: drop sha1_pack_index_name()
  [07/11]: packfile: warn people away from parse_packed_git()
  [08/11]: http-walker: use object_id instead of bare hash
  [09/11]: packfile: convert find_sha1_pack() to use object_id
  [10/11]: packfile: use object_id in find_pack_entry_one()
  [11/11]: packfile: use oidread() instead of hashcpy() to fill object_id

 builtin/fast-import.c         |  6 ++---
 builtin/pack-objects.c        |  4 +--
 builtin/pack-redundant.c      |  5 +++-
 connected.c                   |  4 +--
 http-push.c                   |  4 +--
 http-walker.c                 | 25 ++++++++---------
 http.c                        | 43 ++++++++++++++++++++---------
 midx.c                        | 22 ++++++++++++---
 pack-bitmap.c                 |  4 +--
 packfile.c                    | 51 ++++++++++++++---------------------
 packfile.h                    | 40 +++++++++++++--------------
 t/helper/test-find-pack.c     |  2 +-
 t/t5200-update-server-info.sh |  8 ++++++
 t/t5550-http-fetch-dumb.sh    | 28 +++++++++++++++++--
 walker.c                      |  4 +--
 walker.h                      |  4 +--
 16 files changed, 153 insertions(+), 101 deletions(-)

