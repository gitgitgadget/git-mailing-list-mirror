Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBE2D061D
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688690; cv=none; b=l88yp5O0UBoPC4otlllbci2D1IHytkpugGCXFVqTWCus4YFZUeniw3ECN2IMLyLTqZiV1h07L1WWNnkCj/yN0L2Ige0xjbSgNqpRXNYQ2DDGfpGPMlBq7DDvw7GsLCBmw76JGacPbb690M9M7a1rOjE7/uEFrGuCKdopD0yf8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688690; c=relaxed/simple;
	bh=f375oGMxOxJACyH6piYidWXdYJVPGiit63ln9fdJHF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ4Iv2LMho88T1tXmHFn3fBMZdnrLf3H4Fa2XWE8BKY+c1gZPB8ZHxeC+3D6ijknFGk6BxZJq60lRPB1O+54MeoaCzdTLQOc5p9vvh9XBoL9paTKm03evmZBNf+X1P0tdNZrWdKvQRby7gXMZ4HhpNf4MBVX3kLq41s1qXcxhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fm/k5cds; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fm/k5cds"
Received: (qmail 23802 invoked by uid 106); 2 Aug 2026 16:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f375oGMxOxJACyH6piYidWXdYJVPGiit63ln9fdJHF4=; b=Fm/k5cdsGP0ejECv1s47/6bRir/GTo72+ODsZupv87PvriI5VuWbIoQbJUc7+TkSAOtkfUfwe3hwWVTv4OeGozY3NLyymd6pL47nLYfRvIXAQOdTfcpwZEOG+fvc6bYW/RSi/A23/WNkQzcPWoc5C6vvX8jXc6qimXBBp/wFRUYi9gJRDmYBSugEQon6n8oXNejg7kfEULBa2cZx4LZX2MDosKhW4eVTlwNt9AARg0j8bvi0MNkyq9bQAB0z+tUtgCaZ9Z2Z0Rp8kgAr3mmyJfRvoAJcDcBXWO9dIy73KCwn9+bjQ+A7tLrY7/1ATaXnNzSIlipU1Lg8mWOYM8xyFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Aug 2026 16:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33837 invoked by uid 111); 2 Aug 2026 16:38:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Aug 2026 12:38:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 2 Aug 2026 12:38:06 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
	chandrapratap3519@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
Message-ID: <20260802163806.GA21296@coredump.intra.peff.net>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g>
 <xmqqzez67yg1.fsf@gitster.g>
 <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
 <20260801231437.GA2097059@coredump.intra.peff.net>
 <20260801232941.GA2097163@coredump.intra.peff.net>
 <xmqqpl015lfl.fsf@gitster.g>
 <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
 <xmqqcxw04hjm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxw04hjm.fsf@gitster.g>

On Sun, Aug 02, 2026 at 09:24:13AM -0700, Junio C Hamano wrote:

> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
> 
> > What I understood is that fetch_object_info shouldn't use object_info to
> > store the results, because it doesn't call read_object_info() like other
> > commands like 'info' do. Then, it should use its own data structure to
> > hold the results with flags like wants_size and wants_type. Something
> > like:
> >
> > 	struct object_info_results {
> > 		enum object_type *types;
> > 		size_t *sizes;
> > 		unsigned *unrecognized;
> > 		size_t nr;
> > 		unsigned wants_size:1;
> > 		unsigned wants_type:1;
> > 	};
> 
> I would have expected this to be an array of struct, i.e.
> 
> 	struct {
> 		struct oid *oid;
> 		enum object_type type;
> 		size_t size;
> 	} *result;
> 	size_t result_nr, result_alloc;
> 
> if you do not have the number of things you query upfront, or it may
> be an array of fixed size (i.e. no nr/alloc, just nr).

I think that could work, but two gotchas:

  - an array-of-struct allocates each item for every object. So if we
    are only asking about type, we have to allocate nr * size_t space to
    hold "size" fields nobody cares about.

    This is true of object_info, too, but there we don't care about
    memory cost because we're only using one at a time. Whereas here the
    intent is to hold many results at once.

  - you do need to signal somewhere whether "type" is valid (i.e.,
    whether the remote side supported it). You can put that flag into
    the result struct, but it is a little wasteful. It is really a
    property of the whole query, not of each individual object. So you'd
    have to carry extra flags around (one per type). Whereas NULL-ness
    of the array can signal that same information.

> If you'll be making the same query for many different objects, you
> know if you are asking for type for all of them or for none of them,
> so depending on how the caller uses it, you may not need the valid
> bit.  Or type==OBJ_NONE could signal "we have no info".

Yeah, we sometimes use OBJ_NONE or OBJ_BAD as a sentinel value for type.
But if we're not asking for a type field at all, I think that gets
awkward.

So for unknown objects, I think a separate bit is less awkward.

For signaling "the server refused to tell us this item" we could use
sentinel types like OBJ_NONE. But I don't think that extends to other
fields (e.g., there is no useful sentinel value for "size").

> And you'd be using the second pattern I outlined, i.e.
> 
> 	for (size_t it = 0; it < result_nr; it++) {
>         	/*
> 		 * you may selectively populate the oi to signal
> 		 * you do not need some values, but you get the
>         	 * idea.
> 		 */
> 		struct object_info oi = {
> 			type_p = &result[it].type,
> 			size_p = &result[it].size,
> 			...
> 		};
> 		... ask about result[it].oid using &oi ...
> 	}
> 
> to populate the result[] array with values, I would imagine.

I think that is a perfectly reasonable direction for asking many
responses from read_object_info(). But ultimately this is all getting
shipped to the remote over the object-info protocol. So we never need an
object_info at all, and even if we used one, we really would need N of
them, because we're going to fill N requests at once (to reduce server
round-trips).

-Peff
