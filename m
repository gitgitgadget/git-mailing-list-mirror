Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F21F4163
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336316; cv=none; b=tF25G3OF09jEO5n0O3ztXvMVh3mNmxNt2O7qsiGNvM5UereW64/hc0hRDhgg5iM89wt9Cwz85pW9XGcef24YyBizSR054tW3j4ghlVEpp1leHpyhVU3QOQS+/W5EcffI5dEMP7d3ALo7sQ6q8TgOAFWi4Vn0/KVP6LIla5k+PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336316; c=relaxed/simple;
	bh=r4Q5wL4n4rhVdf0rF0P+SBYcgnPO/yZgTNh/ZKZwz/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUfKOOqokJXrbhHRsfzu6EtKlbFSB7WI46EJKQ1zAK2+3/aU5g//bZdLQW4kclSus83Z+CTCOGcJygox5JdC4kynxa0psMvbXDx1gjAPfRFJ7n1iI37zS9uRLhR6+yjMbPm+gwkOoUZ2MAqacCEqoyFlNohFbIMDM+t5NuRu+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XPHLJvyY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XPHLJvyY"
Received: (qmail 32718 invoked by uid 109); 15 May 2025 19:11:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=r4Q5wL4n4rhVdf0rF0P+SBYcgnPO/yZgTNh/ZKZwz/8=; b=XPHLJvyYWUehZcM5ktoXR8/kBUsBfa1NkqwGauE+tzL9pkBbhSeLzcFCfQgYr+7WLUf0E5JxX2Z0HfNHZI45oitokVilYS3SpIwt37NBeNokIzS5ik93EK2aVgpXsARkXaVrW/8bhwSuyMdKsqOSYwiSYIg3Vgm20ZwdgjsPKCh1v76QLMzvnt+88aDxeLiTo8zBwayyIGbdadwq+Ry8R7ruzNX9dYY/EoVwpSAeFm/kaB5Ue/L4bW4muRKWPf9ehhK17st0Szna/4RUSsadjNwBOjZlXuyZes+J9oG+EzlJ1v0aGx2DnHWgZakY/MuaLuKGcWvtil4Bbzd0hYqz5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29878 invoked by uid 111); 15 May 2025 19:11:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:11:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:11:53 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 1/4] refs: add function to translate errors to strings
Message-ID: <20250515191153.GB3309052@coredump.intra.peff.net>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>

On Thu, May 15, 2025 at 04:07:25PM +0200, Karthik Nayak wrote:

> +char *ref_transaction_error_msg(enum ref_transaction_error err)
> +{
> +	const char *reason = "";
> +
> +	switch (err) {
> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
> +		reason = "refname conflict";
> +		break;
> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
> +		reason = "reference already exists";
> +		break;
> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
> +		reason = "reference does not exist";
> +		break;
> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
> +		reason = "incorrect old value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
> +		reason = "invalid new value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
> +		reason = "expected symref but found regular ref";
> +		break;
> +	default:
> +		reason = "unkown failure";
> +	}
> +
> +	return xstrdup(reason);
> +}

The assignment of "" is dead code, I think? We will always assign
"unknown failure" as a last resort. Not a big deal, but just something I
noticed while reading this related to what's going on in patch 4.

Also, s/unkown/unknown/, but that is present in the pre-image. I hope we
don't need to retain it for bug-for-bug plumbing compatibility. :)

(I guess the dead store of "" was present in the original, too, for that
matter).

-Peff

PS Sorry for all the nit-picky comments. I was just going down the
   Coverity rabbit hole and didn't really review the rest of the series.
   But I wanted to say that the numbers you are seeing are very cool!
