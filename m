Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BA1E9B3D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073780; cv=none; b=rqMkVEAGOU7L+Dn3Bnl1qcXSa7e1yFLUL+qB/XU6CKiGuulvsh/v2e3pAWg19eEOSC29YqoWG7AxkXypcsfyq3jgoYSa8+QS+yq6xlvftLdCybU+bur+NRoU50MH5NoXIsMV0+ORdx10kVerydg1n4sf8oOImzi3JxcTmUoFsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073780; c=relaxed/simple;
	bh=QVGnxNFjnh2vrxQ2hFJXwQoAuauSufsiq1S2X7GNCQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe5qMNXUgJQgzy5Gp7ugCkULe63SP5bOFrOGTzYSchCUHlQAjv/6sWUNzCmZ6UdOx1eseh/ZlNSkOD04kNkmpYXXOv3XWjOX3b1h48+fCbD1cpgSUaL5DI1AJ25Yyy5yB+dlm20uC0qzy8FrLzujfOdJIZJd7PDtJuK2JONtqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f526+vxx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f526+vxx"
Received: (qmail 182035 invoked by uid 109); 10 Oct 2025 05:22:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QVGnxNFjnh2vrxQ2hFJXwQoAuauSufsiq1S2X7GNCQI=; b=f526+vxxFyqeIbRooVSmhhaKo/GjzAtKGkXh6UDaObCEGvVsjP+f3Y6grgfyM8M6vmpfQBgKYs3DxK4tijAILDV1KA1VY9bddkRLW+U7rRZA9E4/reTIqPP4Dlj/Rvo6zHGZ2xqaUL1jpfhT5H+t3PWdByV6VCNPKTish0vq2Qi6dViTiZ1Kh36q6ZqNih95KtHUGBL0gMLX4KicwjRi8T//k8sWrUET9eR5IKUX5t1yRKU6fJuQ9Ft04cz+muhXGLr8UtjLBh5vJXjfx0rTw6uj790DL217S7nUuaqwx0YvUk9Uoabz/SdEG9bvkqrPBfFsAqso5ZQ06VQ8JKmXkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:22:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282886 invoked by uid 111); 10 Oct 2025 05:22:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:22:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:22:56 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 04/49] builtin/repack.c: avoid "the_repository" when
 removing packs
Message-ID: <20251010052256.GB1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <f404dfa34f06a882e5ebf0b6ffa01ba365ac866b.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f404dfa34f06a882e5ebf0b6ffa01ba365ac866b.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:26PM -0400, Taylor Blau wrote:

> -static void remove_redundant_pack(const char *dir_name, const char *base_name)
> +static void remove_redundant_pack(struct repository *repo,
> +				  const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct odb_source *source = the_repository->objects->sources;
> +	struct odb_source *source = repo->objects->sources;
>  	struct multi_pack_index *m = get_multi_pack_index(source);
>  	strbuf_addf(&buf, "%s.pack", base_name);
>  	if (m && source->local && midx_contains_pack(m, buf.buf))
> -		clear_midx_file(the_repository);
> +		clear_midx_file(repo);
>  	strbuf_insertf(&buf, 0, "%s/", dir_name);
>  	unlink_pack_path(buf.buf, 1);
>  	strbuf_release(&buf);
>  }

Ah, yeah, this is a good example of what I was talking about in the
other part of the thread. Probably this function could just take the
object_source pointer to find the midx. But then it wouldn't be able to
use clear_midx_file(). That function arguably should itself take an
object_source pointer and not a repo pointer, but it feels like minimal
gain to go around trying to tighten these (and certainly something we
could easily do later, even programatically, if we cared).

-Peff
