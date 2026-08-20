Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8D3DD50F
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214065; cv=none; b=XCshL3EF5VpomOrLTVcwrvgi8naTg10RLqNcvWVbiwOyL5eXoiJv5ykrw84yGr4CZXCbGmIvID7MDTG+l8Lzt4rGmTp6+sOaU4VRz2S3JeDKZTcTOMWs7IqrKp6kzfEmu2gq3AKurden+L1zqg/NwwoqD9cnfKwx5uI3uxpnPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214065; c=relaxed/simple;
	bh=VGrBWJ1LjQ9B7ABQXMbEreT1BPfXl2f1uxidn7bTOPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQU94Fbx1sck5c3vy4vrSRjtR3RNJW8hsDj6M1BSW6Iai+4fk56qVcqYXCB3DRz/msEZmSYIozWpkhqLuzHBJ7k+Ir05LH84NukV4BUPZitFhVWVsLTSRZ3V+KZsx9mhAi2X5Pzc7gYfqPnQXoSO8A0YBdZv9PgTpsm5MpKSxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GmbaA37k; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GmbaA37k"
Received: (qmail 82199 invoked by uid 106); 20 Aug 2026 08:21:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VGrBWJ1LjQ9B7ABQXMbEreT1BPfXl2f1uxidn7bTOPQ=; b=GmbaA37kn/MSj8z8s0w8P+JicTzOabfEF733T9ab1mRO95FCKczW9rI4LrcPartJtOHQ2Mn7gSa7yzLP8B3/MHTKLmZX6ZBWJ+RuateX5N6JmHVVJwW6HQXBgdETCXU5XsI7Dgt7dLrScJLWao78RnKQUvXWWhQtxhcUvyjHsi3gC1uhudhyK2LFIAcvb7hl70ac8bbQgm2IClY3wlX9iL+QDQCnH8gzKX0KeS9UdNMvPVVuxL0F3YZYP1slrodWv0V97pH2Rn6jpmNXi2iWfauruMyLVvMz2ZYCbJmB2d0nC5/RPnQwNQ7du/CzOvIriqM3UjUQJKjHwKuqH2vaxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2026 08:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58289 invoked by uid 111); 20 Aug 2026 08:21:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2026 04:21:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Aug 2026 04:21:02 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: friel@openai.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
Message-ID: <20260820082102.GA2973952@coredump.intra.peff.net>
References: <20260817233914.8740-2-friel@openai.com>
 <xmqqo6f02q2f.fsf@gitster.g>
 <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
 <aoaTjWMSO8og_iFw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoaTjWMSO8og_iFw@pks.im>

On Thu, Aug 20, 2026 at 07:41:33AM +0200, Patrick Steinhardt wrote:

> On Wed, Aug 19, 2026 at 04:28:10PM -0700, friel@openai.com wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 1ec5b6f206..252530172c 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1389,6 +1390,8 @@ static void write_pack_file(void)
> >  			display_progress(progress_state, written);
> >  		}
> >  
> > +		bytes_written += hashfile_total(f) +
> > +			the_repository->hash_algo->rawsz;
> >  		if (pack_to_stdout) {
> >  			/*
> >  			 * We never fsync when writing to stdout since we may
> 
> I guess the addition here accounts for the trailing hash written by the
> hashfile. If so, shouldn't we also use the algortihm that the hashfile
> uses in the first place via `f->algop->rawsz`?

Perhaps, though that is used to write the hash (via CSUM_HASH_IN_STREAM)
only in two of the conditional blocks. In the third we finalize the
hashfile and then use fixup_pack_header_footer(), passing the_hash_algo
directly (not even the_repository->hash_algo, though of course they mean
the same thing).

It all works out, of course, because we created the hashfile struct
earlier using the_repository->hash_algo. So I think this is mostly
academic in the first place, but your suggestion harmonizes two of the
conditional blocks while creating disagreement with the third.

I think something like this would "fix" it by consistently using the
hashfile's algo in all three blocks:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a5fcbe5f5..0fdff72f41 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1413,9 +1413,9 @@ static void write_pack_file(void)
 			 * If we wrote the wrong number of entries in the
 			 * header, rewrite it like in fast-import.
 			 */
-
+			const struct git_hash_algo *algo = f->algop;
 			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
-			fixup_pack_header_footer(the_hash_algo, fd, hash,
+			fixup_pack_header_footer(algo, fd, hash,
 						 pack_tmp_name, nr_written,
 						 hash, offset);
 			close(fd);


But there's a subtle yet interesting difference here! f->algop won't
necessarily be the same pointer as the_hash_algo. If we compiled with an
unsafe variant, that will be used for hashfiles. If we're just looking
at rawsz that's OK; the two variants should be identical (other than
performance and collision detection), so taking rawsz from either is
fine.

But fixup_pack_header_footer() actually recomputes the hash (as it must
if we tweak the header). Right now it does it using the "normal"
variant, but we should be able to use the unsafe one (which my diff
snippet above would start to do).

Of course this whole thing is absurdly pessimal in the first place. If
we are just going to throw out the hashfile's checksum, then why bother
computing it in the first place? Because we don't trust a disk write at
all, and actually verify the original hash computation as we read the
bytes back in! So we'll actually sha1 the written packfile three times.
Yikes. I wonder if it's really worth being so paranoid. But that is how
it has always been.

Anyway, that is a bit of a tangent from the patch in question. I think
either spelling is OK for the purposes of this patch. If somebody wants
to pursue harmonizing the paths (and maybe even doing some timings to
see if switching to the unsafe variant is noticeable here, and what the
total cost of this triple-write approach is), that can happen
separately.

-Peff
