Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6536605E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852324; cv=none; b=PqGS8HwXQ42d+pj9dTW5N/ZZQKCToXKGckoHD3lHhEXf0eNRrxsYJjF4M50WcEJTe5GQ/QN/KfgzNO09wm8Tkn3QSxYuwc9u6NwpDuvOkgrJ6SuWrDNEZMqHDiFTiE1IjGovQnvRDuPiDSJdgaRYt+3zfjzV9qGw2iqPI5PrAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852324; c=relaxed/simple;
	bh=YTiEl1xcm9JsX2uJSHpeXjrS6DHh1+0JLjyF2MWgwug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0GFSj2KHc7PMKjwvx3cS/wFdD2pJcKs/zNM2tD5T+Bib/7PA01wCYBTn11QhNV2ZgGTBw69WS8TB24fPjcdwks8wuHhCU672x/PvFnftJNXubT7hmiHTVPh18O9bXcJ2biQkwcKpq2P84/DSjSWDGbH6l3OCZg7f4mO6mPD3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NGHDnJ+T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NGHDnJ+T"
Received: (qmail 54126 invoked by uid 109); 23 Feb 2026 13:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YTiEl1xcm9JsX2uJSHpeXjrS6DHh1+0JLjyF2MWgwug=; b=NGHDnJ+T9bNDXwb6oFc3XAeYkL6/i1Gk67kQbvtfEQ/KXH5fXnGNtzyYa9eICmrHw2Pu9sqpRlfK3JI4BYhVWXFKPUxNDPQ/vwdrFoqbrSkoqFjNCkP3iVl2CWL4eTEGWU7iDr2bYKqX/glZSX7mZLl916bqS4GAxupnbyFkl8oUFRHq3KKWdAIyh6a3i852Dpxc8T8FBm59m+wNZMr/iWIrspOlOuKaeNF4m2GaHKBXqBvs5yjuUVVbrgzK4HdMnWqq08kfpStawJEleo9iWXnkBEs7dh0ze5OIZWWSyNfal3qvlXMt3Tnoz/W12V5HJDACKmnza8ZgMGvdoJ8UkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 13:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 104590 invoked by uid 111); 23 Feb 2026 13:12:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 08:12:01 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 08:12:01 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] packfile: expose function to read object stream for
 an offset
Message-ID: <20260223131201.GC215671@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>
 <20260223110722.GB215364@coredump.intra.peff.net>
 <aZxGMrGkVNeAdC1N@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZxGMrGkVNeAdC1N@pks.im>

On Mon, Feb 23, 2026 at 01:21:06PM +0100, Patrick Steinhardt wrote:

> > So your patch here might be making the problem a tiny bit worse, but not
> > in a material way. I think we can ignore it for now.
> 
> I guess the "tiny bit worse" part is that we don't handle the case
> anymore where `unpack_object_header()` returns `OBJ_BAD`. As you say, we
> previously didn't fully parse the object anyway, so we couldn't have
> detected all kinds of corruptions. But we definitely handled the case
> where `unpack_object_header()` failed.

Yeah, I think that would cover it. Technically packed_object_info()
could error on more cases (e.g., errors chasing delta bases for
type/size info). But we would bail on trying to stream those anyway, so
presumably any errors would be found via the non-streaming code paths in
those cases.

> So maybe we should do something like the below patch?
> [...]
> @@ -2571,6 +2572,9 @@ int packfile_read_object_stream(struct odb_read_stream **out,
>  	switch (in_pack_type) {
>  	default:
>  		return -1; /* we do not do deltas for now */
> +	case OBJ_BAD:
> +		mark_bad_packed_object(pack, oid);
> +		return -1;
>  	case OBJ_COMMIT:
>  	case OBJ_TREE:
>  	case OBJ_BLOB:

I think that restores the original behavior. But I'm not sure it's even
worth it. We are still missing the much more likely case of a bit error
in the actual zlib stream, which would not be caught until much later.

So yeah, if you want to feel better about making sure your patch keeps
the behavior as identical as possible, I don't mind adding this. But it
feels like the tip of the iceberg, and I'd be OK leaving it for later
(or never).

My biggest objection is not the two lines above (which I actually think
clarify what is going on) but rather this interface change:

>  int packfile_read_object_stream(struct odb_read_stream **out,
> +				const struct object_id *oid,
>  				struct packed_git *pack,
>  				off_t offset);

Now we are back to taking an oid, except we don't ever use it to look up
the object! So it's a little misleading that it's there at all. It may
be the best we can do, though.

The only other way I could think of is for packfile_read_object_stream()
to return a more detailed error: one of "success", "chose not to
stream", or "broken object". And then the caller can call
mark_bad_packed_object() as appropriate. In this case, I think
packfile_store_read_object_stream() would do so, but verify_pack()
probably would not choose to (it is not interested in fallbacks at all
but is going through an individual pack).

-Peff
