Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562793;
	b=IW31qNOfHJGj1+lSq3wwdeyqLXoem30zwiPsJOhMP6JPYszF72GUKDePfb1yTc/4seNM
	 EOFZJ/+xoq3FbA1+4GJFCCe4de4jfpyuoEaMXUeLGw9x+095aO8cnmBASj5YA3kTxGhh0
	 AnBco6PIp8pzT0HkEv0PKru/HKRBwwnTItu9KdAOdtLqs5Kdn4vJmjrUaxZvu084MpRJs
	 l1kaGTsVpn/ijavnW7d9KRb9R2WsCQVP06KWPNl//4w10G3eQyjMZC6zjJs2Des7psCfC
	 XqXgsIjAjj2kYKXZYpkJZJMddhfiEWAatrhPX1+ruFSTwEEqAE+W69zmt8vGf3+AWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562793;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=C+UDjAiUtzq6+PxduiGMoZBMbpEntloW//zOfedNEt8=;
	b=dP5T4oStbWlLPv5PYAg2Epr/wvahyDXpTDZOwotgyHa1uSNE4b3oAj95Lf5qLkjlLiRd
	 U91NdJ/qNJKgR/hXOx/HthLbmFpPZCburXYoxxBx3jsQZ4SUx/iMeH3TTQgVUnSpWYnW4
	 tET+PWDV/tTN8IEneVlMPnqAI3Xn4kn0f/HcuySBn0UZDSvsiI9MA5cTCbHmiYrfYNHFy
	 8JO+ZAzd74eUt1dwcdgvNz/ljy1RVcVnL9fmwH8c8T/mf+H3T04StZ7otWghfMdlVFEYn
	 XHuajrADsW5XP5wvUT3WNLRwiJowm1hxUbVOG4w89KMW93wm2uMrBv7bg4eh7/mFWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=ZtZD97+D;
	arc=none smtp.remote-ip=91.218.175.234
Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E4606A31C
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 09:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=ZtZD97+D
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6XKhEn9n0nnNYcp4D8qA+1hRO7CFoSSnW0yiTbh2sqc=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794562789; v=1; x=1795167589;
 b=ZtZD97+D2SGmppSQDpCnnI1tb0koF9+elkCTk7R94q1S/TZJZ4F6veuwWrER6xQ/BiwfUO0L
 JkD3j4GHU3YIb/ArRpPhddmU+HNcpmHMAOa71eTVtv6Vy8HU7SaPVuoat+am+xnLo9A2oY7u13w
 fpAJbrURDEsoPFg7iHnaGnTA=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 407710e1825c6715;
	Fri, 13 Nov 2026 09:39:49 +0000
X-Mizu-Trace-ID: 407710e1825c6715
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 1/2] odb/source-loose: extract logic to retrieve
 subdirectory bitmap
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-1-a00d5cdb5e7d@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-1-a00d5cdb5e7d@pks.im>
Date: Fri, 13 Nov 2026 10:39:46 +0100
Message-ID: <871p8p5au5.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The loose object cache tracks which sharding directories have already
> been scanned via a bitmap. The logic to retrieve the bitmap and mask for
> a given object ID is inlined into the function that populates the cache,
> but we're about to add a second function that will need to perform the
> same logic.
>
> Extract the logic into a separate function to prepare for this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-loose.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 50cb388c352..da8f9767257 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -26,29 +26,39 @@ static int append_loose_object(const struct object_id *oid,
>  	return 0;
>  }
>  
> -static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
> -					      const struct object_id *oid)
> +static uint32_t *subdir_seen_bitmap(struct odb_source_loose *loose,
> +				    const struct object_id *oid,
> +				    uint32_t *mask)
>  {
>  	int subdir_nr = oid->hash[0];
> -	struct strbuf buf = STRBUF_INIT;
>  	size_t word_bits = bitsizeof(loose->subdir_seen[0]);
>  	size_t word_index = subdir_nr / word_bits;
> -	size_t mask = (size_t)1u << (subdir_nr % word_bits);
> -	uint32_t *bitmap;
>  
>  	if (subdir_nr < 0 ||
>  	    (size_t) subdir_nr >= bitsizeof(loose->subdir_seen))
>  		BUG("subdir_nr out of range");
>  
> -	bitmap = &loose->subdir_seen[word_index];
> +	*mask = (size_t)1u << (subdir_nr % word_bits);

So `mask`'s type is changed from `size_t` to `uint32_t`, which is fine
by me, but shall we use `uint32_t` here too?

> +
> +	return &loose->subdir_seen[word_index];
> +}
> +
> +static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
> +					      const struct object_id *oid)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	uint32_t *bitmap, mask;
> +
> +	bitmap = subdir_seen_bitmap(loose, oid, &mask);
>  	if (*bitmap & mask)
>  		return loose->cache;
> +
>  	if (!loose->cache) {
>  		ALLOC_ARRAY(loose->cache, 1);
>  		oidtree_init(loose->cache);
>  	}
>  	strbuf_addstr(&buf, loose->base.path);
> -	for_each_file_in_obj_subdir(subdir_nr, &buf,
> +	for_each_file_in_obj_subdir(oid->hash[0], &buf,
>  				    loose->base.odb->repo->hash_algo,
>  				    append_loose_object,
>  				    NULL, NULL,
>
> -- 
> 2.56.0.500.g5d06dc02cd.dirty
>

-- 
Laters,
Toon
