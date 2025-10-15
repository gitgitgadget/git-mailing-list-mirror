Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AF31A804
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526120; cv=none; b=b1mRAHT090U+B8yYDmTq9M2I3q0HGE7jfBt05tTG7Cbt4DWWmWbPFM2Ffu1wb6XXamAWwtTpOibuuAIKahGdNmbBROIFE7HcorBDN+xJNvXbGp09gmFHFWDXoXAau2FZZM0HULNUn1QSqT++olVzWjg6PUQJFPfHuCSv8mNAtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526120; c=relaxed/simple;
	bh=uW09rWi0lRo4jK5Yj/JjqF8ZD6SF9s4xjs+HrNQ83pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+Dfx1vLyYRiKXQbnybvIrygjoz4YYDm5meJQhha+shfQ1PkC6SXVPkzL/IMi7w5ChQ0ZGOTQYQLKQNrGYZXxI6caRfwL/X/0ZMHtNgXQD63jf3GGNoM/seNj6dNxOzy5+oN6v/eCJeRa15TtOcnStvUCyVkyEdX49O02zHFUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fGGmVedm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fGGmVedm"
Received: (qmail 226851 invoked by uid 109); 15 Oct 2025 11:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uW09rWi0lRo4jK5Yj/JjqF8ZD6SF9s4xjs+HrNQ83pA=; b=fGGmVedm7RO7PDFzm6IdyyPlVuvpU1yfa6y93+K+sF1z+etPuwbtFeO8dfuacbAiETO8HsFQ1N5zQhEyCP+HtvdbX6Yv2JiNIGQRMYrHZecFAt5TQz4NDTHuq8IEzjukNDO5EhWuxKGFs+VnYLiRJkPRH/WLV3IQ0Bv5/SEwdlcVvtbP7yg4xyMIxawqqUL2wocuTocWXwg2ZGvOTLtduzB6nlpRchTW958T1MZaVC8a33yqVGadalB02sLBPCHTWrvpbBlSazFo90ia/M6nyVP+9G8kxpY1GuZh+R8MUlFYhhFc1y/jIDG/r1brsvp5zlBML7GGHO7JGY8PTRsJ0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 11:01:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 363513 invoked by uid 111); 15 Oct 2025 11:01:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 07:01:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 07:01:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 44/49] builtin/repack.c: pass `write_pack_opts` to
 `finish_pack_objects_cmd()`
Message-ID: <20251015110155.GF2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <11f78993f1d2d56b204398788780b30318d83afa.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11f78993f1d2d56b204398788780b30318d83afa.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:10:14PM -0400, Taylor Blau wrote:

>  int cmd_repack(int argc,
> @@ -294,6 +294,7 @@ int cmd_repack(int argc,
>  	struct existing_packs existing = EXISTING_PACKS_INIT;
>  	struct pack_geometry geometry = { 0 };
>  	struct tempfile *refs_snapshot = NULL;
> +	struct write_pack_opts opts = { 0 };
>  	int i, ret;
>  	int show_progress;
>  
> @@ -560,7 +561,10 @@ int cmd_repack(int argc,
>  		fclose(in);
>  	}
>  
> -	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
> +	opts.packdir = packdir;
> +	opts.destination = packdir;
> +	opts.packtmp = packtmp;
> +	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
>  	if (ret)
>  		goto cleanup;

This looks a bit funny: we are creating a write_pack_opts struct but
only filling in some of the fields. Notably po_args is NULL. It's
zero'd, which is good, but as a matter of API design, how can a caller
know which fields are important for a given function and which are not?

I guess I could have expected cmd_repack() to make a fully fleshed-out
write_pack_opts up front, and then pass it to all functions which need
it. Rather than making a custom one for this one function.

But I guess that gets a little weird, because it really has at least
_two_ such opts: one for the regular pack-objects invocation and one for
the cruft pack. And really maybe one more, for the filtered pack? And
the conditional blocks for cruft and filter_options packs shadow the
"opts" variable. Yuck.

I'm not sure if there's a good solution. My inclination is to say that
po_args should not be in "opts" at all, and that each function should
take a separate po_args as appropriate. And then we could just have one
write_pack_opts in cmd_repack(). But there is another snag: we sometimes
override the "destination" field with "filter_to" or "expire_to".

So the struct really isn't "here are the opts for repacking", but rather
"let's marshal some arguments into a struct for one function call".
Which of course is a bit verbose in C, hence these extra shadowed "opts"
variables.

So I dunno that I am really asking for any change. This might be the
least bad way of writing it. I guess if we could avoid the shadowing
like this:

diff --git a/builtin/repack.c b/builtin/repack.c
index ad60c4290d..4e4519b180 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -108,7 +108,6 @@ int cmd_repack(int argc,
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
-	struct write_pack_opts opts = { 0 };
 	int i, ret;
 	int show_progress;
 
@@ -372,12 +371,15 @@ int cmd_repack(int argc,
 		fclose(in);
 	}
 
-	opts.packdir = packdir;
-	opts.destination = packdir;
-	opts.packtmp = packtmp;
-	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
-	if (ret)
-		goto cleanup;
+	{
+		struct write_pack_opts opts = { 0 };
+		opts.packdir = packdir;
+		opts.destination = packdir;
+		opts.packtmp = packtmp;
+		ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
+		if (ret)
+			goto cleanup;
+	}
 
 	if (!names.nr) {
 		if (!po_args.quiet)

That might be nice, but introducing the extra block is kind of ugly. Of
course you can get really fancy with a compound literal, like:

@@ -372,10 +371,13 @@ int cmd_repack(int argc,
 		fclose(in);
 	}
 
-	opts.packdir = packdir;
-	opts.destination = packdir;
-	opts.packtmp = packtmp;
-	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
+	ret = finish_pack_objects_cmd(repo->hash_algo,
+				      &(struct write_pack_opts) {
+					.packdir = packdir,
+					.destination = packdir,
+					.packtmp = packtmp,
+				      },
+				      &cmd, &names);
 	if (ret)
 		goto cleanup;
 

But that may be a bridge too far.

-Peff
