Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBE3ED3CC
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013158; cv=none; b=tZ2OnmU7qsRd6G3w42y5tLb7yC2Kb3ek+/9EKBJNXZ1FHiOejKZqmLvUX0MRJZoJv2Ippg55GZQ/ReJutW3GmqCaSl972S/FHiyGWyZbr0G/2N9LwSWBhV+vYEObX3bLgEgRvGqWq3zB4Q5rS52qzbve10smC4nb+GyPR+rNlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013158; c=relaxed/simple;
	bh=v0eK4k8rXZNX8iYUvDW7r5MqaACIAalJO6A6B0rxblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxQIUSPsQJQU96Yris7K7L3HQG7FTpb5btGAijfy7VidXAfQxPQB6D2D2jPH+ilF9VObnwqH5WXoz/pk/14NEbyF/KDYvdLd5h2q97iYDK8ktNRuw/4KHgElSCAXEdr+V01wkwMMyXPOybi8hWWZR7Gow8HgmH5r8CJyWFSo1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JPimNcdE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JPimNcdE"
Received: (qmail 21705 invoked by uid 106); 14 Jul 2026 07:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v0eK4k8rXZNX8iYUvDW7r5MqaACIAalJO6A6B0rxblw=; b=JPimNcdEMSP6ynWEuHJnGLt0wsdtHAX6wXNg+YT2y9r/2HicIKkHCo6u+IO9WTp+UYyLc9tgHCKX2g7M4kMS8nyUvZx89aC3IY4t+kCACr3ikCq4VQd+70fC8MAdFOfO3TQbr17ykOHpcvpODwjzvSt8naBPQRpnPr9OO0UR0Q7BrAfdmlh2qleYOlekr0+yv0LSZH/H+cY4t+xR+9KU6xP5ClyM44WiGmu/XI+BypECeBLg3F7ugRLUy+LxRInDQ4rbpta/fKoZIUlWquVGJnqvBJpC9B9mctFU7qky0XOFI2vkiqMjgfUf/3xK+IsqT8tybfDthI1mfbswIw+3Yg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:12:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 42731 invoked by uid 111); 14 Jul 2026 07:12:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:12:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:12:31 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <20260714071231.GD2516582@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVoA5-fDDPwKPZZ@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alVoA5-fDDPwKPZZ@com-76773>

On Mon, Jul 13, 2026 at 03:34:43PM -0700, Ted Nyman wrote:

> When "index-pack --keep" creates a .keep file, it reports
> "keep<TAB><hash>". If the file already exists, index-pack leaves it
> untouched and reports "pack<TAB><hash>" instead.
> 
> Since dd4b732df7 (upload-pack: send part of packfile response as uri,
> 2020-06-10), fetch-pack has accepted only the "keep" form for packs
> downloaded through packfile URIs. A concurrent fetch can install the
> same pack and create its .keep file before another process reaches
> index-pack. The latter process then fails even though index-pack
> completed successfully.
> 
> Accept both successful forms. Add a path to pack_lockfiles only for the
> "keep" form, so cleanup removes only a keep file created by the current
> process and preserves a pre-existing one.

OK, that all makes sense.

>  	for (i = 0; i < packfile_uris.nr; i++) {
> +		int created_keep = 0;
>  		int j;
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> -		char packname[GIT_MAX_HEXSZ + 1];
> +		char packname[GIT_MAX_HEXSZ + 6];
> +		const char *packhash;
> +		const int packname_len = the_hash_algo->hexsz + 6;

The "+ 6" here is gross, but not really any more than the bare "5" in
the original code.

Calling it "packhash" made me wonder about this line of code:

> -		if (memcmp(packfile_uris.items[i].string, packname,
> +		if (memcmp(packfile_uris.items[i].string, packhash,

Surely we need to change more than this if we now have the hash rather
than the whole packname? But no, the original code was really just
storing the hash in packname.

Which was rather misleading, but it is not much better after your patch.
Now packname still just has the packhash, along with the extra keep/pack
marker.

Would a more generic name like "cmd_output" or something make sense? I
also think this would all be much nicer with a strbuf (which would let
us get rid of the magic numbers), but that is a slightly larger
refactor:

diff --git a/fetch-pack.c b/fetch-pack.c
index 1e8461d07e..5f94f35c30 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1890,9 +1890,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		int created_keep = 0;
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
-		char packname[GIT_MAX_HEXSZ + 6];
+		struct strbuf cmd_output = STRBUF_INIT;
 		const char *packhash;
-		const int packname_len = the_hash_algo->hexsz + 6;
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
@@ -1910,14 +1909,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		if (start_command(&cmd))
 			die("fetch-pack: unable to spawn http-fetch");
 
-		if (read_in_full(cmd.out, packname, packname_len) != packname_len ||
-		    packname[packname_len - 1] != '\n')
-			die("fetch-pack: expected pack or keep, TAB, hash, "
-			    "then LF in http-fetch output");
-		packname[packname_len - 1] = '\0';
-		if (skip_prefix(packname, "keep\t", &packhash))
+		if (strbuf_read(&cmd_output, cmd.out, 0) < 0)
+			die("failed to read http-fetch output");
+		if (skip_prefix(cmd_output.buf, "keep\t", &packhash))
 			created_keep = 1;
-		else if (!skip_prefix(packname, "pack\t", &packhash))
+		else if (!skip_prefix(cmd_output.buf, "pack\t", &packhash))
 			die("fetch-pack: expected pack or keep, TAB, hash, "
 			    "then LF in http-fetch output");
 


BTW, two things that puzzled me while poking at your patch (but neither
I think are new or the fault of your patch):

  1. git-http-fetch documents --index-pack-args, but the actual option
     is the singular --index-pack-arg. The caller in fetch-pack
     obviously uses the one that works.

  2. The code you're touching insists on reading "keep" in the output,
     but wouldn't that depend on feeding "--keep" via index_pack_args? I
     didn't see immediately where we set it, but I certainly don't think
     your patch could be making anything worse here (since the existing
     code would have just died upon seeing a "pack" line). I think it
     happens as a side effect in get_pack(), which is...subtle. But
     again, not anything new.

-Peff
