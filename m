Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2B2517AF
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592727; cv=none; b=bMNfjejehAooztNRf8vGiy6NwdkTdW9/0VZqrMTZm0AQDYp30+4gT+3MHBQCr37CVJCrNQjsyEIwGZxfpbGELPvVdw3VYoeGia8uBJ0VUO2hAFMHoTxYCIKkeDNe0dp8DrhswZTO5vUvl0Ja1pfmvpm0aLamldnJUe0D9TFXq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592727; c=relaxed/simple;
	bh=0sxuxc2YatjZyT0UPjCh3cIz9j1UDj6gXibJZHnIeZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiOTrnPllona4nR8z2vzLgmmOdJMyFlXljwx2e9uT8F7+RlOtOgzEDnEAABytW52El/C5khIT78/FbzU3EVtdzbHiQPAMS3P9tqaYbk5hakXHRXUR1XOgGe/0KflaHXKD8jY/opk1S0i02SmmsYPfqXIIa8/qfduKZ7M4J7GZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y16S5Fc9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y16S5Fc9"
Received: (qmail 9580 invoked by uid 106); 1 Aug 2026 13:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0sxuxc2YatjZyT0UPjCh3cIz9j1UDj6gXibJZHnIeZI=; b=Y16S5Fc9T5qybZUFLCppmfDD0EIVWxs6aL2vK6+YVJud8Y2nsHDFMiV2p55d+1LcRgF2o9T1WIhF/Cmfjk1JmEB9bbImOoaiIDoZ4ctjYdIQ6C1kRxwdTQ6mn672CRykBwGBMi9GeqAGJtS2+dDv2wKE8dbTz8YNFraJlMAhMMg9suOl1eqTtzNK2/0Rh8v1I/XUe6UQLD9h2owpyN4zf1Z00+FbrCoKCgc+dIXLbf0ehUYxjCywpY6HxvREaNZ8f/6Eb86P6LKhw/4OSUHCGqljvmAeDcJOAHIsks2S9USfmAbJ+QZNSGQEZVw1/RKXA7eb6SjwKVvS9q2S8CKg8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 13:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17230 invoked by uid 111); 1 Aug 2026 13:58:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 09:58:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 09:58:44 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, ps@pks.im,
	karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v6 3/6] http: accept HTTP 416 for complete partial packs
Message-ID: <20260801135844.GB2041176@coredump.intra.peff.net>
References: <cover.1785047139.git.tnyman@openai.com>
 <cover.1785111375.git.tnyman@openai.com>
 <677e5399eb8ce260f6aa98d91b5b2634ff95e46c.1785111375.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <677e5399eb8ce260f6aa98d91b5b2634ff95e46c.1785111375.git.tnyman@openai.com>

On Sun, Jul 26, 2026 at 05:28:40PM -0700, Ted Nyman wrote:

> A resumed pack request may already have all bytes of the remote pack.
> A server can respond to the resulting Range request with HTTP 416
> instead of returning an empty response.
> 
> Accept that response in each pack-download caller and let index-pack
> validate the completed staging file. This can happen without concurrent
> downloads when a previous attempt completed the transfer but failed
> before indexing it.
> 
> Add a regression test that seeds a complete partial pack and checks that
> http-fetch indexes it after the server returns HTTP 416.

Again, thanks for splitting this out and demonstrating the
non-concurrent case. It all looks good to me.

I do wonder what will happen when we get a 416 and we _don't_ have a
complete pack. E.g., imagine the file size on the server changed (it
shouldn't if they are using the hash of the pack contents as the name,
but that's not strictly required).

Previously we'd barf on the curl error. Now we'll guess that we got the
full file, even though we have a partial download. Presumably we'd then
just barf at the index-pack level. I guess this is not really any
different than other resumption problems. If the file changed on the
server, we could easily download half of one version and half of
another. Ultimately we don't trust any of it until index-pack processes
the whole thing.

So this seems like a good direction to me.

-Peff
