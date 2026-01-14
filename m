Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2336C585
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426573; cv=none; b=PsED0NmgP6MNWjlb3SVX1hYSw5LGmoWD+kzj3PEiMr1HCMNbHUIgu2VODXd+VN74KAv4dZbDQ9PGwVvOndP0+dxL6q6cLO4QTmZG9FaCxZF/WEk6pvb5xPuZn11e0YZ4b5llbgjgMBhBlzr1MDKjZ1Sq1iBuRpsEkWYCd6/Oqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426573; c=relaxed/simple;
	bh=uQugTeFgYGEhiQQJllsX2VjaheSLXm8g+x1tfMLDVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7JFDaPsD9J6YNhybLCyJb+Oo3BOGiURLZIK2jQ/j4AgxzVWDeV1JQn49o7AMCktGsYuoe4CI7Bhqpi8sLjDCD+OQE8LXXMNi1saygmMB60GWX8Ktg99kwkQdmJ4SlpgKrZngTA42wNWLbTOXWPjo+7AWaHDGlSR9yELlkVNiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J2kXw/BI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J2kXw/BI"
Received: (qmail 41851 invoked by uid 109); 14 Jan 2026 21:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uQugTeFgYGEhiQQJllsX2VjaheSLXm8g+x1tfMLDVq8=; b=J2kXw/BI5hNneP9NabzCgVOZ+TEjQiEkH9cLoXIRqxPC5RkvyyFaK860BNl/cLQ2E3wV81jseOaiNRQ1VUKiruHPo3t6/P8UKgqX5RQaD3io0qgOM2d4/PBU3ZEp4WFmFAQAWcaHea1baXuCHby2cDCgW2r3RLMjxtc/Tzrq6opgQo4BUjN/76vMy1BI0jA0F9hPIv8G7gRE1xuwFDUZYlsKnzFZNoC3qJq8v65FYTvtDElquYv0blLsIsizUThqQ5oIVXQVCCMRciwSuaQbiCN7uoPB1G0rUYE6oxYSphjbf4ak7gDPR7cSwRtfjyLwwaUI+r5G91f0KUjfYuU3tQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:35:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 70296 invoked by uid 111); 14 Jan 2026 21:35:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:35:53 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:35:51 -0500
From: Jeff King <peff@peff.net>
To: amisha <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
Message-ID: <20260114213551.GC1010080@coredump.intra.peff.net>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114192803.4852-1-amishhhaaaa@gmail.com>

On Thu, Jan 15, 2026 at 12:58:03AM +0530, amisha wrote:

> Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list' by constructing it unsorted and sorting it afterwards.
> 
> Signed-off-by: amisha <amishhhaaaa@gmail.com>

Thanks, I think the patch is an obvious improvement. In general, please
wrap your lines to something more reasonable (usually 70 or so is
common). And make sure your sign-off identity matches the DCO section of
Documentation/SubmittingPatches, in particular this part:

  Please use a known identity in the `Signed-off-by` trailer, since we cannot
  accept anonymous contributions. It is common, but not required, to use some form
  of your real name. We realize that some contributors are not comfortable doing
  so or prefer to contribute under a pseudonym or preferred name and we can accept
  your patch either way, as long as the name and email you use are distinctive,
  identifying, and not misleading.
  
  The goal of this policy is to allow us to have sufficient information to contact
  you if questions arise about your contribution.

I think what you have is probably sufficient, but if you are not opposed
to giving more identity information, we do usually prefer more full
names.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 15d51e60a8..0a44808ed2 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>  
>  		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
>  			/* pe->pattern starts with "/", skip it */
> -			string_list_insert(&sl, pe->pattern + 1);
> +			string_list_append(&sl, pe->pattern + 1);
>  		}
>  
>  		string_list_sort(&sl);

Since we already sort here, I was quite curious how this came about.  It
looks like the _insert() call and the _sort() were both added together
in de11951b03 (sparse-checkout: list directories in cone mode,
2019-12-30).

I'd guess it was just a typo/brain-o to mix up append and insert.

Doesn't the same issue exist in write_cone_to_file(), too (in two
separate spots)?

-Peff
