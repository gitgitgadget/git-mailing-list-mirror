Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470A38837D
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690785; cv=none; b=tME6eCj0bKqv/9fFs2afpHK61TQFfk1LY8pnsxQSfoe0fCa3MTIthDgNQtaziWuL44cZxxFJ40J+Zc4Rf5mUdFtCIaXYxE4ScqHCOVDjdPqLA42MS0VVozg8HeNFfuY/cCA5Sby2zj//pHne95P9ml2/Q9jWFZ8bTDHaQ75/lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690785; c=relaxed/simple;
	bh=i5d2lywEFJhaCVILzk8eqmuDDNGCVToEZdtRllZNJcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMdjOtzw/W9mUFIXjQozyXcXv6GhgkoZWSwYNAsjnR8sWuCwMZzAeyz0qudKu9ZGGPv1I4t0gvf/Qw9oXgk5uQnytdVKGqQCZsrg/9yLDqwogQSSBRv8Ldse+Dnzg7V9+ZIviweyyEBPwlCfZIf4eAoqcwVmFqk77DMMzQHHWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ghcELNxT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ghcELNxT"
Received: (qmail 39202 invoked by uid 106); 13 May 2026 16:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=i5d2lywEFJhaCVILzk8eqmuDDNGCVToEZdtRllZNJcI=; b=ghcELNxTYXdw6a9ExIbvUiQsznfZb7igaHZDQCRw4CVzJQrGxMYh8+emX89kZ/ogY8idosdd8TcN4PQMBHtr69yZENaSA9LXTmkHLJuP3pw5GST9GEit23yymupMIOCgmYsCApORs9qdcWgN1Zzw8GKhgvWN+KGq7Gi3KL7RCIhrhEQZbLHAh5V34pWYsjNL92uts3fvc4xP2hdzEmRBM0KNQFRalq02NMB9pvft4n/ptxS5p5Pt8j7uOfzzdGDKzLLcJouwPdP/NAp51Qls+RemNlDRV5ntUO+0uazE1nx2V5laauUACEzdAdmW34zNj4LmAzsC0DDGvWz4qXfbsA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 16:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67344 invoked by uid 111); 13 May 2026 16:46:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 12:46:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 12:46:22 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] ls-files: use strbuf_add_uint()
Message-ID: <20260513164622.GC103037@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-4-l.s.r@web.de>
 <20260512190105.GE70851@coredump.intra.peff.net>
 <2f45a33b-5945-431d-97a5-7d61e271cfba@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f45a33b-5945-431d-97a5-7d61e271cfba@web.de>

On Tue, May 12, 2026 at 10:44:21PM +0200, René Scharfe wrote:

> > ...also less nice. We are formatting into the strbuf, and then maybe
> > memmove()-ing the result to accommodate padding. I wonder how much that
> > affects the timing. It's extra shuffling, but memmove() etc is often
> > surprisingly fast.
> 
> I gave my objectsize and objectsize:padded numbers; the difference was
> 1.2 ms, albeit with 1.0 ms noise in padded case.

Ah, right, that makes sense.

Applying the fast decimal-width from my earlier message, I came up with:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c142ad4156..e17e3517ff 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -251,22 +251,24 @@ static void expand_objectsize(struct repository *repo, struct strbuf *line,
 			      const enum object_type type, unsigned int padded)
 {
 	static const char padding[] = "       ";
-	size_t min_len = padded ? strlen(padding) : 0;
-	size_t orig_len = line->len;
-	size_t len;
+	static const unsigned padding_len = ARRAY_SIZE(padding) - 1;
 
 	if (type == OBJ_BLOB) {
 		unsigned long size;
 		if (odb_read_object_info(repo->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
+		if (padded) {
+			unsigned digits = decimal_length_u64(size);
+			if (digits < padding_len)
+				strbuf_add(line, padding, padding_len - digits);
+		}
 		strbuf_add_uint(line, size);
 	} else {
+		if (padded)
+			strbuf_add(line, padding, padding_len - 1);
 		strbuf_addstr(line, "-");
 	}
-	len = line->len - orig_len;
-	if (len < min_len)
-		strbuf_insert(line, orig_len, padding, min_len - len);
 }
 
 static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,

but it was not meaningfully faster than your version.

> > I have often wondered how hard it would be to implement our own
> > vsnprintf(), and whether we could do better than the libc ones. It would
> > be nice to be able to add shorthands for common types (instead of the
> > unreadable PRIuMAX mess), as well as custom ones (e.g., hex oids).
> 
> C99 has %ju for uintmax_t and %zu for size_t.  Hmm, do we actually
> still need to avoid them?  CodingGuidelines says "the C library used
> by MinGW does not" support it.  82c36fa0a9 (submodule: hash the
> submodule name for the gitdir path, 2026-01-12) just added a %zu,
> and there are lots of them in compat/mimalloc/ in Git for Windows.

An accidental test-balloon, I guess. It's in v2.54.0, so maybe we will
see some reports, or maybe we can eventually use it as evidence that we
can relax a bit.

-Peff
