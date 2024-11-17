Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34108DDD2
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834222; cv=none; b=lUcvCsgY1ZtTJvD3Dwh2Wgzr0Md18ScmV5hyhev1rO92d36zD9pt0P6uwKEpQZXko8i2hKTiOiIXBGYD9c7sPQLZyudrLfGrIPJZbXgbDrLWARGpzztJuLWta049SHiOwwLQnXKzfBxEYB7m0wSuXjIziSfIaOqj2QxSKAenKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834222; c=relaxed/simple;
	bh=Wlf4mMgFb2sEjowKEO6VJAYHNgIafkdscLeFPADrA1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvUqB2JtN5tn6rJIrP6zHqpkYTkOe+lYhYEbQkladQ3/Bs4wKM/TWxP/90uGL5FxPEMiyNcIhlNnEa6y4iqvDO+RrDAKPxjQMp6ERNouL/Mm71RHaJY+rHlPN+kJSf5WSloQdbP0z1rYy80rMStg6pYySGS3NnynuSWLVZ4VWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RGX/9l3Y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RGX/9l3Y"
Received: (qmail 9237 invoked by uid 109); 17 Nov 2024 09:03:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Wlf4mMgFb2sEjowKEO6VJAYHNgIafkdscLeFPADrA1Q=; b=RGX/9l3YySCF+4T9nrepHs1PbeRsAxoNA7S8UptPG/cREZ6swEY5Bq17N4Xqj/12riNH2QKZnRrYt4+vo5K1WlzMQJ4Zwd6xVnUQ9SjRLq4W7V04l1T+fwQYK/0WmH5nT103OaEZhNJmKmUGXpvWqQdVg3APUUvthzuwliPJttuY7h52bwCI6PvgeHld1KjAWbJ2SSt1ma5I/S1MwLmcUGRSuGLcJNo7xYwgwKy55l1FKhh89ILpjCcw6JGlgST5c7GAxoVfPkNGanQImNuPojXKG7T2dmU+qDuhtDZJQYTRsIAOvSZOB2EcngzbM2iuxDG5SRqAysX1Nwf2VOnscw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2151 invoked by uid 111); 17 Nov 2024 09:03:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:03:34 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:03:29 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
Message-ID: <20241117090329.GA2341486@coredump.intra.peff.net>
References: <87wmh2o9og.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmh2o9og.fsf@gentoo.org>

On Sun, Nov 17, 2024 at 02:50:39AM +0000, Sam James wrote:

> With upcoming GCC 15, a new warning is added
> (-Wunterminated-string-initialization) that fires when building git:
> ```
>     CC object-file.o
> object-file.c:52:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
>    52 |         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> object-file.c:79:17: note: in expansion of macro ‘EMPTY_TREE_SHA256_BIN_LITERAL’
>    79 |         .hash = EMPTY_TREE_SHA256_BIN_LITERAL,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> object-file.c:61:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
>    61 |         "\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> object-file.c:83:17: note: in expansion of macro ‘EMPTY_BLOB_SHA256_BIN_LITERAL’
>    83 |         .hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ```
> 
> Context for the new warning is at https://gcc.gnu.org/PR115185.

I think the warning is a false positive for us, but I don't begrudge
them for adding it. It could definitely catch real problems.

Here are some patches. The first one should fix the warning (but I don't
have gcc-15 handy to test!). Please let me know if it works for you (and
thank you for reporting).

The others are cleanups and future-proofing I found in the same area.
Not strictly required, but IMHO worth doing.

+cc brian since I think this is a continuation of some hash-algo
cleanups he did earlier, plus he piped up in the other gcc-15 thread. ;)

  [1/5]: object-file: prefer array-of-bytes initializer for hash literals
  [2/5]: object-file: drop confusing oid initializer of empty_tree struct
  [3/5]: object-file: move empty_tree struct into find_cached_object()
  [4/5]: object-file: drop oid field from find_cached_object() return value
  [5/5]: object-file: inline empty tree and blob literals

 object-file.c | 77 ++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

