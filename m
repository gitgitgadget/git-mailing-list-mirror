Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371565789D
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737192060; cv=none; b=l1TMCI6MoyNk+O4ofiftyfBh0M/KKz/o+g5UyIPjkR+Xt/JY3Cd3CEAYyJ6oD/8H4G3QN1A0Zb2gDFnDetjo6Rq/3UygMlQWqZFZgrt3fbwfv0oTCnhqigTGRG5jWYpN9VJmKarpl9Vo6Ue+Lhi7PmxVT+mFhTgfHgyrCl8vboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737192060; c=relaxed/simple;
	bh=iUd7wVHc3aVhmqNKoG5OIwpPZq6hcgVhKQDNNBJOAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slXXb2YKbXzhkdAf8JklW2OJXgiXamVLP6U5PrmkTA285FYa3EmBxMG8BD4meTVdcrP8Sh/ebn0YI9Nko25DuDMyRCPnsZ3lXN19MvRy5G9zpDDWNZi4grOwOICVa6zUe7ga5T7wmWxO2W//cPeqft75uP+cCyuXMDNYkv3noi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SLZ0+ArL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SLZ0+ArL"
Received: (qmail 30138 invoked by uid 109); 18 Jan 2025 09:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iUd7wVHc3aVhmqNKoG5OIwpPZq6hcgVhKQDNNBJOAhE=; b=SLZ0+ArLYoo0BsFiMeOxj9aKQEKQjHAlBBMlOWLJjN6LKLDemVE9mFKe04FbEYNP/VlbaMUE/eworT8fxpElwm45Rwfgte69SZ261D9VZsUB+ttww2IGROnsjKJnhxR7FcONCZdBqJZiUkdo0jQR6aqu5DPqBGXjpmWvZVlbCm+IA61tj6FQNg0CuaRvgy4lEfT0hWDaBSQW7o2ZiKxXsvD66cKKasA4B9II/ehqdoZOuSDG+waH6VqGkWa85b808QXxhxmIjE4s8LZaZ4fmaEP6UPIg43I19uQVyrvqxzK8rrRKW7ILruQeQ4QXSfwGpbe7qZRZWLVbFdJ38vfx1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 09:20:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18986 invoked by uid 111); 18 Jan 2025 09:20:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 04:20:53 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 04:20:48 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <20250118092048.GA3474411@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
 <20250117121121.GA2356599@coredump.intra.peff.net>
 <20250117125207.GB2356599@coredump.intra.peff.net>
 <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>

On Fri, Jan 17, 2025 at 03:55:53PM +0000, Koakuma wrote:

> This diff does fix the issue in `cmd_unpack_objects`, however...
> 
> > I'm curious if it's enough. After we write to this unaligned buffer,
> > naturally the next thing we'll do is read from it, and the reading
> > routines will do the same cast (see unpack_all() in unpack-objects).
> 
> It crashes in `unpack_all`, just as you guessed:
> 
> #0  unpack_all () at builtin/unpack-objects.c:583
> 583		nr_objects = ntohl(hdr->hdr_entries);
> 
> So I suppose the reading part needs to be adjusted as well?

I guess that's not too surprising. Probably an application of get_be32()
would solve it. But I do wonder if it would be simpler just to make sure
the buffer is aligned. You mentioned that you tried that before and it
worked. How did you do it? With a pragma/attribute, or with a union (as
below)?

The union thing should be portable, I'd think, but unfortunately has a
lot of fallout through the code because the name of "buffer" changes (we
could also declare the storage separately and make "buffer" a pointer to
it, but we'd have to be careful about calls to sizeof()).

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d933..65db435b46 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,7 +23,10 @@ static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
 /* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+static union {
+	struct pack_header hdr;
+	unsigned char bytes[4096];
+} buffer;
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
@@ -65,24 +68,24 @@ static void add_object_buffer(struct object *object, char *buffer, unsigned long
 static void *fill(int min)
 {
 	if (min <= len)
-		return buffer + offset;
-	if (min > sizeof(buffer))
+		return buffer.bytes + offset;
+	if (min > sizeof(buffer.bytes))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-		the_hash_algo->update_fn(&ctx, buffer, offset);
-		memmove(buffer, buffer + offset, len);
+		the_hash_algo->update_fn(&ctx, buffer.bytes, offset);
+		memmove(buffer.bytes, buffer.bytes + offset, len);
 		offset = 0;
 	}
 	do {
-		ssize_t ret = xread(0, buffer + len, sizeof(buffer) - len);
+		ssize_t ret = xread(0, buffer.bytes + len, sizeof(buffer.bytes) - len);
 		if (ret <= 0) {
 			if (!ret)
 				die("early EOF");
 			die_errno("read error on input");
 		}
 		len += ret;
 	} while (len < min);
-	return buffer;
+	return buffer.bytes;
 }
 
 static void use(int bytes)
@@ -645,18 +648,16 @@ int cmd_unpack_objects(int argc,
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
-				struct pack_header *hdr;
 				char *c;
 
-				hdr = (struct pack_header *)buffer;
-				hdr->hdr_signature = htonl(PACK_SIGNATURE);
-				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				buffer.hdr.hdr_signature = htonl(PACK_SIGNATURE);
+				buffer.hdr.hdr_version = htonl(strtoul(arg + 14, &c, 10));
 				if (*c != ',')
 					die("bad %s", arg);
-				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				buffer.hdr.hdr_entries = htonl(strtoul(c + 1, &c, 10));
 				if (*c)
 					die("bad %s", arg);
-				len = sizeof(*hdr);
+				len = sizeof(buffer.hdr);
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
@@ -671,7 +672,7 @@ int cmd_unpack_objects(int argc,
 	}
 	the_hash_algo->init_fn(&ctx);
 	unpack_all();
-	the_hash_algo->update_fn(&ctx, buffer, offset);
+	the_hash_algo->update_fn(&ctx, buffer.bytes, offset);
 	the_hash_algo->init_fn(&tmp_ctx);
 	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
 	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
@@ -686,7 +687,7 @@ int cmd_unpack_objects(int argc,
 	use(the_hash_algo->rawsz);
 
 	/* Write the last part of the buffer to stdout */
-	write_in_full(1, buffer + offset, len);
+	write_in_full(1, buffer.bytes + offset, len);
 
 	/* All done */
 	return has_errors;
