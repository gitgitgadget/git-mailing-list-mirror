Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FA1E5731
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634783; cv=none; b=Wtmvp4dgJkhxMjONsEIkAnb5vCw3KLV6ImbZAAfQdeKQAyudXYw2tNTXH5d/fUfwjo5Xlh711H6HT8PauYw0M0Bu6tZCeqh9tmmzkwl4h4G9xgV7mrs5U7M/GOp3tLjViQanVlSoNzqb1WuqTNFSGbOXjad7oJ5TJH16tzBI454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634783; c=relaxed/simple;
	bh=tk7WclRI8Gro+YJU+snnX9z9hylYKnnLdYCxP/zQpsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYXSg4fudSZzTQkWk7Pg0luM4V6OI4vESo7kbBbcVWwTgwNnVPmgrVb8Oxh5P/nVXS1b4+YIPqLwkd9haS6znD4jMTmrEL21hg3P7HdpVe17AFK+3vTVn2lCMV8c+bmL09merJYMJjmTYrkZyj/6CzqJudveI03m5tHhRtynt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e8FO3k1p; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e8FO3k1p"
Received: (qmail 5677 invoked by uid 109); 11 Oct 2024 08:19:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tk7WclRI8Gro+YJU+snnX9z9hylYKnnLdYCxP/zQpsE=; b=e8FO3k1pCoEZbj5QHV68u3L6NBwrhCp9tC4URUVQ7T39mRVfuDUekWE5TKW4fanGguoLYZkoSHRqG8DBOjxIli4MRTKHn/xrTf4krmRsHrPmCbfPG/pMaA114QJpUkWQzqErqRP0rvmAqxqL2sjdebEivD/kXmdGf71SXxDjtGmys2ipkzswlZ5KT+wsSVxFV4aBx7UjVRL0JnDk9ECIHvSg/xvv0Agz/Df9+OAFdHFU1cHpgt70rp4lMpAdOwj/L42YHwogBQ6QplsBx7fZXr2RvSOAcCyMDqKrvAcYLos7eT4sO7Y6LlRNFD8xJJgVsx6ftia+o49quu6+xDHHoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:19:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17658 invoked by uid 111); 11 Oct 2024 08:19:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:19:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:19:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 08/11] t5332: enable OFS_DELTAs via
 test_pack_objects_reused
Message-ID: <20241011081939.GF18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <9d81d890402f94f4126aedef0845d615d10455bc.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d81d890402f94f4126aedef0845d615d10455bc.1728505840.git.me@ttaylorr.com>

On Wed, Oct 09, 2024 at 04:31:24PM -0400, Taylor Blau wrote:

> Back when test_pack_objects_reused was introduced via commit
> 7c01878eeb (t5332-multi-pack-reuse.sh: extract pack-objects helper
> functions, 2024-02-05), we converted bare pack-objects invocations
> into one of two wrapped variants, either test_pack_objects_reused or
> test_pack_objects_reused_all.
> 
> The latter passes `--delta-base-offset`, allowing pack-objects to
> generate OFS_DELTAs in its output pack. But the former does not, for
> no good reason.
> 
> As we do not want to convert OFS_DELTAs to REF_DELTAs unnecessarily,
> let's unify these two and pass `--delta-base-offset` to both.

I think that matches what happens in the real world. I am puzzled that
your BUG() instrumenting turns up some conversion cases. Why are we
still converting in those cases?

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0fc0680b402..0f1b22b8674 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c

You need to indent or otherwise comment-out this diff. Otherwise "git
am" will pick it up as the start of the actual diff, adding the bogus
BUG() call to the applied patch (and dropping the rest of your commit
message).

-Peff
