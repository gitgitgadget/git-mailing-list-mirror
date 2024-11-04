Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105011C4A04
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741542; cv=none; b=QvIrEbup8gKUn8efJdxEuAblL2qHYC8Z701Eam2E5hm7/MYYRoiyCx0zaxQTij9Ktdq6SFjso7aNB09hklwna1V6gIknVT5cnm0cJcLUBFWtX7K/1JjrwCyBy1t/pkqOEp5sCC3QOUFLzF9jFa37vXhG+1vcnzhKZzZEadPsNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741542; c=relaxed/simple;
	bh=ComYpIDEdz4PXzYEp7r4+2trTFT38kDorInTyvFuJDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdYV3JzUMZCU5Ysz8f8umtHqNhJ7X4Go5Nd2VNoKRvDuZUQCUYRyabVYqMy6w5mrTzi5Gvp2wq7PwfeDCcd5s3aMiPjLzcOFZND/9U6R9qYvGS8ZKDPbEgdt0NJ6gHeGXBf0ANHvYFn91t73lBlyBoAmECBJMEJTL2XZGanflEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XBbfgJsB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XBbfgJsB"
Received: (qmail 12649 invoked by uid 109); 4 Nov 2024 17:32:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ComYpIDEdz4PXzYEp7r4+2trTFT38kDorInTyvFuJDo=; b=XBbfgJsBXTR7W7Zs7Z7powz+TBhPH9EJWpupqDEqOPbgrfmO2P2gfSm5bb0zg9qHIpZLBbjOJQbzkWGk7+haQKcK+J4vb7QbviTfAoyFZy2fhMGX/tNiBD1jMzADOo1uvHI6IrhXHHkHozn3qt7bqG7X8/mDPcpyAR565n7wwe/7fVyK9jlzCL7sYhheCqW2GJu7p2057u9Gp7osvGwAkf1FC28ofEOapK7lnCy2Mtjp5FMM8Wdo9ZFUW/3XRtp9l7eOuBd5R8BgIGVLo4K6EYAt4T0asQ0vtAqXQhSMxakBVpFGcOKC835gIg6GuWZW47zydK0obek1a1FscJBBtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:32:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14572 invoked by uid 111); 4 Nov 2024 17:32:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:32:18 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:32:18 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v5 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <20241104173218.GB2989472@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1730714298.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730714298.git.karthik.188@gmail.com>

On Mon, Nov 04, 2024 at 12:41:38PM +0100, Karthik Nayak wrote:

> Range-diff against v4:
>  1:  b3d518e998 =  1:  6c00e25c86 packfile: add repository to struct `packed_git`
>  2:  bb9d9aa744 =  2:  70fc8a79af packfile: use `repository` from `packed_git` directly
>  3:  d5df50fa36 =  3:  167a1f3a11 packfile: pass `repository` to static function in the file
>  4:  0107801c3b =  4:  b7cfe78217 packfile: pass down repository to `odb_pack_name`
>  5:  2d7608a367 =  5:  5566f5554c packfile: pass down repository to `has_object[_kept]_pack`
>  6:  2c84026d02 =  6:  1b26e45a9b packfile: pass down repository to `for_each_packed_object`
>  7:  84b89c8a0e !  7:  7654bf5e7e config: make `delta_base_cache_limit` a non-global variable
>     @@ Commit message
>          this value from the repository config, since the value is only used once
>          in the entire subsystem.
>      
>     +    The type of the value is changed from `size_t` to an `unsigned long`
>     +    since the default value is small enough to fit inside the latter on all
>     +    platforms.
>     +

I think this change is not ideal, for the same reason that the other
type changes were: you can conceivably have a 4GB or larger cache here.
On Windows using "unsigned long" would prevent that. (On most other
systems it is OK either way since "unsigned long" and "size_t" are
generally the same size).

I do think the config parsing should change to use size_t here (like I
mentioned elsewhere in the thread), which would fix it on Windows.
That's outside the scope of your patch, but in the meantime we should
not be making things worse by moving the variable itself to the inferior
type.

-Peff
