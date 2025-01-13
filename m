Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C40231A2C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745797; cv=none; b=p+6s0z7W/Yh69znwHz1GptmIBZK3JeP17gyQ3i+QBeeRcVxkqNzQ6TLqxWPew/oz0GPVael6unLmHaJgFyn9HaLH+VeVVMayLW/wZLovVHmQgvCvM4AsTB91ye5bC7Ga1K/0RsyIhe5o/UylhN+L44ShFaru/iLmFP93qt9Bcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745797; c=relaxed/simple;
	bh=veWgmwosuWyqNUTFfZ107bJghYhri/f+dvpofwzR5GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MshFAk39Nn58Xb4TmZVtjB5Voul71tiyzUAfoat0xGnVDHZqboOUnG6YUFuIfreIAMlmY+/pOI1hARpyhfSZ7qtiJUuGF81nz0P1QgZFrw2NyjNvMGxcR9Act57cIHiNrsjHoWthcEcGd9sWdyGlhY5eUaWNEkTkdz2Dr4+sPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZQW6GMmT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZQW6GMmT"
Received: (qmail 11499 invoked by uid 109); 13 Jan 2025 05:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=veWgmwosuWyqNUTFfZ107bJghYhri/f+dvpofwzR5GU=; b=ZQW6GMmTWwi1TQGHcS9ICBkZf0BgC7jMo3lEHABEOwB9/XMmymtjO41YoLluh9WqkClb0GQH/Ng0CkzZfvvm4MQo9394JhvPvQA2FNFVNLbmYCceb4GFV4/uNKfsqEt9jUT8JsnlmpAbYfIjxDd6VX/ilf1DdHc/mgSx3sZkWt3fhu1SeGko7iboH5tz0pFid744n4KDRfQRBtI2HJsbhDr3rHQ3scovsGvMBbfO2e1RRllHk4zqJmAwLlw8rnqvJnEikGD/BqubZVAolM1SCVx7DbCmJzAqEpOyoyu1iRTOpiWitFmAHeGz4JptP5PJOQyvuwFL40givyCYS35KXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 05:23:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16898 invoked by uid 111); 13 Jan 2025 05:23:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 00:23:17 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 00:23:13 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250113052313.GA768703@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113051700.GA767856@coredump.intra.peff.net>

On Mon, Jan 13, 2025 at 12:17:01AM -0500, Jeff King wrote:

> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 42f34e1236..ed38b82346 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -61,6 +61,7 @@ int cmd_ls_remote(int argc,
>  	const struct ref *ref;
>  	struct ref_array ref_array;
>  	struct ref_sorting *sorting;
> +	struct ref_format format = REF_FORMAT_INIT;
>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;

This caller in ls-remote is the only one that doesn't otherwise have a
ref_format struct. I don't think it's a big deal to add one like this,
and it might even be nice to support --format.

But I suspect there are other weird errors lurking (however we structure
this code) because we may not actually have access to the objects! The
ahead-behind atom seems to gloss over that, but others will barf.
Interestingly we detect the out-of-repo case:

  $ git ls-remote --sort=authordate git.git
  fatal: not a git repository, but the field 'authordate' requires access to object data

but not if we have a repo:

  $ git init
  $ git ls-remote --sort=authordate git.git
  fatal: missing object 978601ccf7b27399aa349c535b29965e664046c4 for refs/heads/ci-config

I guess it would work _sometimes_ if you've fetched recently from the
remote. So maybe it does not make sense to outlaw all object-inspecting
atoms for ls-remote, and just say that the error above is the best we
can do? It does get weird with ahead-behind, though, as you'll get a
different sort order depending on whether you've actually fetched the
object.

Anyway, all orthogonal to what you're fixing, but kind of gross none the
less.

-Peff
