Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843618D621
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202519; cv=none; b=sgd6XE7d7YcYiPNQL6ab1RAWvUoquenENWUN62IlxtQMruHXzru3qlFZCQMb4ySGOoBsLNO3JSDTCQhqA/S+KXsaMtXBHDUwzY3bCpYFEKbohZLmJuf/fA1dBBIUz5RgLOtBeSdxF2CflAA0xP5Vb+iS4UWPRxI2QEBDhBI3FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202519; c=relaxed/simple;
	bh=94P+D9FOpKA0rivwsx1a0p+pmfuwnwwnCUnwxn3fuHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7sNIw8fyr2OeGYJUF5xGZwo/lNV0CwqjgXIgdNly/3x4DVc0xXZqXzqRBOk3wF2A90sRK7HQZguMPKFAPW1mW7O6oFFDRpUQHDuZeSVcpH4p6Gj1qdzILIJZOxECyIrjOnPWmE3G2QVbXjDHVfiavuMKfoENuOTxHsvRFlvfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ci12daZQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ci12daZQ"
Received: (qmail 31306 invoked by uid 109); 18 Jan 2025 12:15:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=94P+D9FOpKA0rivwsx1a0p+pmfuwnwwnCUnwxn3fuHY=; b=ci12daZQzqzWedGJHHtFZqAjav5pXTTT7VdhokZHAZ+ulsivu3SdWx/FuxntcJaLAJ1Q+k6rY+s5Ms944IL0HRZJEnH6Ady+BL4wEG1WocOcXCpH1cp0+ecqK7j0tzx2R/P4ZisgGp95AbZJcOY5NYQsJ5zi5RI9znQlRMiRQ914PcaeqWsmNRB9AFSaAjvM0UO/tvZUd4sWsYXOsroWEW6cQN2ykEunNdpbYVFonZoWGH+aeJwym2TYlvmBqz0fCVneyDZMynluRC3Rjon7KTpBx2+eQpnR5CwKLJofM1FsE0dKwbmlCdU1iCIxib4MVkTCkO0YKeWyRyRixNWsQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 12:15:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20201 invoked by uid 111); 18 Jan 2025 12:15:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 07:15:15 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 07:15:14 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <20250118121514.GB3510721@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>
 <20250110103756.GA1014709@coredump.intra.peff.net>
 <Z4GWIZkJOUa278VA@nand.local>
 <Z4rL3TbEeR8EiUOi@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4rL3TbEeR8EiUOi@nand.local>

On Fri, Jan 17, 2025 at 04:30:05PM -0500, Taylor Blau wrote:

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 433070a3bd..892176d23d 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -261,7 +261,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>  	git_hash_ctx ctx;
>  	unsigned char obuf[16384];
>  	unsigned header_len;
> -	struct hashfile_checkpoint checkpoint = {0};
> +	struct hashfile_checkpoint checkpoint;
>  	struct pack_idx_entry *idx = NULL;
> 
>  	seekback = lseek(fd, 0, SEEK_CUR);
> @@ -272,12 +272,15 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>  					  OBJ_BLOB, size);
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
> -	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
> 
>  	/* Note: idx is non-NULL when we are writing */
> -	if ((flags & HASH_WRITE_OBJECT) != 0)
> +	if ((flags & HASH_WRITE_OBJECT) != 0) {
>  		CALLOC_ARRAY(idx, 1);
> 
> +		prepare_to_stream(state, flags);
> +		hashfile_checkpoint_init(state->f, &checkpoint);
> +	}
> +
>  	already_hashed_to = 0;
> 
>  	while (1) {

Yeah, that's ugly. We are potentially throwing away the hashfile that
the checkpoint was created for. That makes my instinct to push the
checkpoint down into the loop where we we might restart a new pack, like
this (and like you suggested below):

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 433070a3bd..efa59074fb 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -261,7 +261,6 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
@@ -281,8 +280,10 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	already_hashed_to = 0;
 
 	while (1) {
+		struct hashfile_checkpoint checkpoint = {0};
 		prepare_to_stream(state, flags);
 		if (idx) {
+			hashfile_checkpoint_init(state->f, &checkpoint);
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
 			crc32_begin(state->f);

but that doesn't work, because the checkpoint is also used later for the
already_written() check:

        if (already_written(state, result_oid)) {
                hashfile_truncate(state->f, &checkpoint);
                state->offset = checkpoint.offset;
                free(idx);
	} else

That made me wonder if there is a bug lurking there. What if we found
the pack was too big, truncated to our checkpoint, and then opened a new
pack? Then the original checkpoint would now be bogus! It would mention
an offset in the original packfile which doesn't make any sense with
what we have open. But I think this is OK, because we can only leave the
loop when stream_blob_to_pack() returns, and we always establish a new
checkpoint before then.

So I do think that moving the initialization of the checkpoint into the
loop, but _not_ moving the variable would work the same way it does now
(i.e., what you suggested below).

But I admit that the way this loop works kind of makes my head spin. It
can really only ever run twice, but it is hard to see: we break out if
stream_blob_to_pack() returns success. And it will only return error if
we would bust the packsize limit (all other errors cause us to die()).
And only if we would bust the limit _and_ we are not the only object in
the pack. And since we start a new pack if we loop, that will never be
true on the second iteration; we'll always either die() or return
success.

I do think it would be much easier to read with a single explicit retry:

  if (checkpoint_and_try_to_stream() < 0) {
	/* we busted the limit; make a new pack and try again */
	hashfile_truncate();
	etc...
        if (checkpoint_and_try_to_stream() < 0)
		BUG("yikes, we should not fail a second time!");
  }

where checkpoint_and_try_to_stream() is the first half of the loop, up
to the stream_blob_to_pack() call.

Anyway, that is all outside of your patch, and relevant only because
_if_ we untangled it a bit more, it might make the checkpoint lifetime a
bit more obvious and less scary to refactor.

But it does imply to me that the data dependency introduced by my
suggestion is not always so straight-forward as I thought it would be,
and we should probably punt on it for your series.

> which would do the trick, but it feels awfully hacky to have the "if
> (checkpoint.f != state->f)" check in there, since that feels too
> intimately tied to the implementation of the hashfile_checkpoint API for
> my comfort.

I think you could unconditionally checkpoint at that part; we're about
to do a write, so we want to store the state before the write in case we
need to roll back.

> Anyway, that's all to say that I think that while this is probably
> doable in theory, in practice it's kind of a mess, at least currently.
> I would rather see if there are other ways to clean up the
> deflate_blob_to_pack() function first in a way that made this change
> less awkward.

Yeah, I actually wrote what I wrote above before reading this far down
in your email, but we arrived at the exact same conclusion. ;) Hopefully
what I wrote might give some pointers if somebody wants to refactor
later.

> I think the most reasonable course here would be to pursue a minimal
> change like the one presented here and then think about further clean up
> as a separate step.

Yep. Thanks for looking into it.

-Peff
