Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456F2AE70
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074285; cv=none; b=Pk7fh4xc8Xu9HByYLGY/ZEDzkTiSNUH9N/BN7lPuvoWU9fiT78rIQfsMapKvzdzWvIzz8p1lxW6Tf3YrJET1AT9FpvioEtMmX5+pcLP5NnYhInHeAgBZI2eDd3/SCNB+MZu9r4wgf+JsZcRJCPeRgVAA3fLU8wis7MVi4R9ATp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074285; c=relaxed/simple;
	bh=4ayj828wLNagjsJeO93Bo32UbIJ8pM7U3IaAK+D8X2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6KirARCLoGsX6KgfzoRVPKDia1wQ9tFs+QSJKSz5/dRtOypTdqO/bPqVwiHMhX8oTs1hPY33NdbfoSEfKk2NIXpz4ap1fmiyt1tRHOSIrr1txDBAUxSVbi6Jp+GNH4zYW7meeVyuQVG8wg+PprkXgy8o1fhpVh4OUCbpktAQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OFdD+G4E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OFdD+G4E"
Received: (qmail 182111 invoked by uid 109); 10 Oct 2025 05:31:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4ayj828wLNagjsJeO93Bo32UbIJ8pM7U3IaAK+D8X2k=; b=OFdD+G4EnocxAIfsDhUVVZbQJQ80fFKjyEpgoArH5Cxh7aJRA+U1uLP+CD2YTcAxTHET61+cS/57V6sIMm7tOyto0/roRChHQOpxCcpNBq4h2uWpuJxJ+F4KMhchnOsz9y+I1b3yrFSwr5nONbHPhiyimhzi4Jo+kgL6N9gwvG1v5zivTICVpj7KF/hzDdz8hWZxSK7pTxBKShqJCZ3yCmDXQSKTW7BaBGISvSc+tE3MTMClMHAMhonQuiSFy1qaouLvCRjIn6MpkVfV0CcWtZP13JoqhetlwTHlVS/lhWAgucQj+GOj7Y3grZ9dP3ko7vSPlxmW7EeV1tXQMxnaQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283015 invoked by uid 111); 10 Oct 2025 05:31:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:31:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:31:15 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 09/49] builtin/repack.c: avoid "the_hash_algo" in
 `finish_pack_objects_cmd()`
Message-ID: <20251010053115.GC1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <f16dfbf0c7fdb2ff9bbfa8f3cdbc849916a722bd.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f16dfbf0c7fdb2ff9bbfa8f3cdbc849916a722bd.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:45PM -0400, Taylor Blau wrote:

> @@ -1150,7 +1151,8 @@ static int write_filtered_pack(const struct pack_objects_args *args,
>  		fprintf(in, "%s%s.pack\n", caret, item->string);
>  	fclose(in);
>  
> -	return finish_pack_objects_cmd(&cmd, names, local);
> +	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
> +				       local);
>  }

OK, my last musing on which types to pass around, I promise. ;) This is
a great counter-example to my initial comment on patch 2: if we had put
an object_source into the "existing" struct back then, we wouldn't be
able to pull the hash_algo out now.

(Well, sort of; object_database does have a pointer back to its
containing repo, which itself feels kind of weird. I'd just as soon not
rely on that, here, though).

> -static int finish_pack_objects_cmd(struct child_process *cmd,
> +static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
> +				   struct child_process *cmd,

I am mildly surprised at some of these spots that _only_ need a
hash_algo and nothing else, but the proof of the pudding is in the
compiling. As they say. Well, as I say.

-Peff
