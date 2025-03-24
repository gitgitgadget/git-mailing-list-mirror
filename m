Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516723A9
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742785189; cv=none; b=OhWtvID0RyTiGcqo69JnsNQR4StNVTR2ny8wHcrlaU3cIFm9VjC0sr99r/OUkm+Dbyl3cf+Y/t2hjyf48RBPIPcVau2SwJRJQLdjPatBPNnqIo1zbFhRS44rArFS6YEWUbEr+RmvFz5eeffZkLiq5b7i7TpVMJGvDG/fLjwV+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742785189; c=relaxed/simple;
	bh=kCeFHweKThYK041ToX18BjsQaWhpnh33bkbDPhEPYKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur3l+OFuNJgiVn15PCC/AowBj1kQdtjVVta2UDMbQZxtDmKgGa/HEKgB7uG/mG5f0ekUjZ49vpkshQGDsttEiEn3ZEGMWIhMCo464H4Ya9lGpMmye+eVEl+aNmCye8+5Mc7zIn2ZfnbmLutu7iNzFYEqhMPaPcll+O46j3Z1wD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U4ae8Piy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U4ae8Piy"
Received: (qmail 15109 invoked by uid 109); 24 Mar 2025 02:53:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kCeFHweKThYK041ToX18BjsQaWhpnh33bkbDPhEPYKI=; b=U4ae8PiyK9572C8NNhGgHDJZd4r51PGIRw0pq+DQ2UuMZt/uXYp3TFXDZ5lCCCnI45DMysjT6O+OSTfiPncdzFXponTMWlx8883FSX5JAJIL2pW/PJSgNcPO3sXwNVL4CM5vV1pWVYaP9kOMqrAwiTwzaKse90xwaXEIa4gBzmXfiyEg97mdeiACacW8XAG7hkd+xcki31qdKJhQkYh/pVml21Q74G/Fu0EocRbpSE1PNcIyBoGRUg76OKvhWSsOZ7dIGjPhaoRKh18hTe/N0l78Zw+Yzwa7wesz8Kw5j6TaJTcUYS0XqYsggS99OTsUfOiEZl+v4xFEsQ70g30nzw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 02:53:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16727 invoked by uid 111); 24 Mar 2025 02:53:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Mar 2025 22:53:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 23 Mar 2025 22:53:00 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
Subject: Re: [PATCH] bulk-checkin: fix sign compare warnings
Message-ID: <20250324025300.GA690113@coredump.intra.peff.net>
References: <20250321200715.3338-1-taahol@utu.fi>
 <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>

On Fri, Mar 21, 2025 at 05:08:06PM -0400, Karthik Nayak wrote:

> > @@ -192,7 +188,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
> >  			offset += rsize;
> >  			if (*already_hashed_to < offset) {
> >  				size_t hsize = offset - *already_hashed_to;
> > -				if (rsize < hsize)
> > +				if ((size_t)rsize < hsize)
> 
> Something I found peculiar here is that `rsize` is of type ssize_t'.
> But it only seems to store a positive value.

I assumed it was ssize_t because it would hold the result of a read
call. But it doesn't! We put that into the "read_result" variable.

So it could just be a size_t in the first place. And indeed it is better
as one, because we assign from "size", which is itself a size_t. We do
not yet warn about type mismatches outside of comparisons, but really it
is equally bad.

However, if you switch it, then we get a different -Wsign-compare
problem: we compare "rsize" and "read_result". So you still have to
cast, but at a different spot.

If we are doing this a lot (and really this conversion is necessary any
time you look at the outcome of a read call), I do still wonder if we
should have a helper like:

static inline int safe_scast(ssize_t ret, size_t *out)
{
	if (ret < 0)
		return 0;
	/* cast is safe because of check above */
	*out = (size_t)ret;
	return 1;
}

(yes, I know the name is lousy). That would allow something like this:

diff --git a/bulk-checkin.c b/bulk-checkin.c
index f6f79cb9e2..fbffc7c8d6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -178,9 +178,10 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	while (status != Z_STREAM_END) {
 		if (size && !s.avail_in) {
-			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			ssize_t read_result = read_in_full(fd, ibuf, rsize);
-			if (read_result < 0)
+			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
+			size_t read_result;
+
+			if (!safe_scast(read_in_full(fd, ibuf, rsize), &read_result))
 				die_errno("failed to read from '%s'", path);
 			if (read_result != rsize)
 				die("failed to read %d bytes from '%s'",

Though it does kind of obscure the call to read_in_full(). You can use
two variables, like:

  ssize_t read_result;
  size_t bytes_read;

  read_result = read_in_full(fd, ibuf, rsize);
  if (!safe_scast(read_result, &bytes_read))
	die_errno(...);

which is a bit more verbose but perhaps clearer.

This reminded me a bit of the issues we had with write_in_full() before,
where:

  if (write_in_full(fd, buf, len) < len)

behaves unexpectedly because of integer conversions. There the solution
was to never check against "len", because write_in_full() either writes
everything or returns an error. So:

  if (write_in_full(fd, buf, len) < 0)

is correct and sufficient.

But alas, we can't do the same here, because reading returns three
cases: error, a full read, or a partial read (maybe even EOF!). So we
really do need to record and compare the return value between what we
asked for and what we got.

-Peff
