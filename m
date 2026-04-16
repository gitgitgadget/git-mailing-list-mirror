Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514235E529
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316673; cv=none; b=mSiQSQHj52WFYGuHs/7HJYCqrX4HVSmpxJKkp9K2G0cAs0wqOc+BlGBnrJqgkXV+E7nJHW0XJz3zNO71Mn1SDSKGS+bVfhigXHrOze5sBD1k6eIcX5lMNvLtrdkINU/kj78cKtr4T8Oer/BbBTDtLn26NVJhsoyBFwzoLvkGOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316673; c=relaxed/simple;
	bh=+uZX5GEwdh17A6ILCuuxngxxZSmYoGSGRAMfnSq+oIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF/z56c3EiHgQLcu3VzICG4yCagIwdfR9yUStvFDDLyTYkAnZPwwNmSsLoquthGnR8jHzHFeMT33HmI3w99ImCevQScPSWj/mXyp4oJISJ08NknC6p89EsUFaWaiGmmH2tSIw/atzfj6Rqy35bC6eKgR7UWDxwz4TBx46j4xoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AblZCPo3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AblZCPo3"
Received: (qmail 365418 invoked by uid 106); 16 Apr 2026 05:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+uZX5GEwdh17A6ILCuuxngxxZSmYoGSGRAMfnSq+oIk=; b=AblZCPo3Mhgg7I19/NRgU+837t3ciaPTlaAP/Q0XMmEWE172Y0lnCtPVPcGZxUoqbNY+DfRv/rLfB6VrKPRouDPr0PFeOseYtq94zbHwoGzwPH7SrvCWm1qy6CzNb4NVFYBHeT16Jvycpw4diayn0dBQ7pS/tmrw97dz5e4J6zt6IBAU2h2nmif8nBxayPEm2hg4fr9iam9CgKo2SVjAmfhKIb/z/+IolDPSpuKDCHlsC8m4Db5xDPeGk3WlFPm+7HS0Xp4xLQkhN6hCzEo9ZwSAJPVnP6K1T2ohCaEdLGkeKZg/kwVbp2FOQejwFMAsaOuPrd1tf1OZsz4CvG+o1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 05:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 610717 invoked by uid 111); 16 Apr 2026 05:17:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 01:17:33 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 01:17:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <20260416051732.GA48541@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x5s540j.fsf@gitster.g>

On Wed, Apr 15, 2026 at 02:04:44PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  * Further work on incremental repacking using MIDX/bitmap
> >
> > I just noticed that a fetch with v2.54.0-rc2 into an existing repository
> > rendered it unusable for Git v2.53.0:
> >
> >   fatal: multi-pack-index version 2 not recognized
> >
> > Is it possible that v2.54.0-rc2 forcefully uses a MIDX version that has
> > _just_ been introduced?
> >
> > If so, that might have been a premature bump of the default MIDX version,
> > if even the preceding Git version fails to handle that MIDX version. It is
> > guaranteed to cause substantial problems in setups where e.g. libgit2 or
> > JGit is expected to be used interchangeably with Git. It also causes
> > problems when users have to downgrade Git, or use several Git versions
> > side by side (e.g. using GitHub Desktop, which bundles its own version of
> > Git).
> 
> Is b2ec8e90 (midx: do not require packs to be sorted in
> lexicographic order, 2026-02-24), which says
> 
>     This change produces MIDXs which may not be correctly read with external
>     tools or older versions of Git. Though older versions of Git know how to
>     gracefully degrade and ignore any MIDX(s) they consider corrupt,
>     external tools may not be as robust. To avoid unintentionally breaking
>     any such tools, guard this change behind a version bump in the MIDX's
>     on-disk format.
>     
> relevant?  The version bump seems to be doing more harm to "older
> versions of Git" that "know how to gracefully degrade" by not
> allowing them to degrade.

Eek. The midx _should_ be an optional component, so returning an error
during load would then just look in the regular pack .idx files. But
there are a few die() calls in the loading function. :(

Something like the patch below on top of v2.53.0 gets the desired effect
(we print "version 2 not recognized to stderr" and then everything works
anyway). But of course we can't go back in time now to fix it (and
earlier versions).

I wonder how libgit2 and JGit handle this:

  - Looking in the source, JGit will throw an exception, which is
    presumably caught and handled OK (at least seems to using the "jgit"
    CLI I have handy). So that's good.

  - libgit2 seems to "return midx_error()" if the signature or version
    isn't matched. I don't have an easy tool built against it, but
    looking at the code I think it would quietly fall back to using the
    actual packs.

So it really is just our old versions that are the problem.

I think removing the .midx file (and optionally regenerating with the
old version) would be the appropriate workaround, but I wonder how hard
it would be to go back to generating v1 midx files by default. I know v2
is a building block for more advanced features, but for those who are
not using those features yet it is a strict regression.

-Peff

---
diff --git a/midx.c b/midx.c
index a75ea99a0d..79ce6a1e3b 100644
--- a/midx.c
+++ b/midx.c
@@ -134,22 +134,26 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 
 	CALLOC_ARRAY(m, 1);
 	m->data = midx_map;
 	m->data_len = midx_size;
 	m->source = source;
 
 	m->signature = get_be32(m->data);
-	if (m->signature != MIDX_SIGNATURE)
-		die(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+	if (m->signature != MIDX_SIGNATURE) {
+		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
 		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
 
 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
-	if (m->version != MIDX_VERSION)
-		die(_("multi-pack-index version %d not recognized"),
+	if (m->version != MIDX_VERSION) {
+		error(_("multi-pack-index version %d not recognized"),
 		      m->version);
+		goto cleanup_fail;
+	}
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
 	if (hash_version != oid_version(r->hash_algo)) {
 		error(_("multi-pack-index hash version %u does not match version %u"),
 		      hash_version, oid_version(r->hash_algo));
 		goto cleanup_fail;
 	}
