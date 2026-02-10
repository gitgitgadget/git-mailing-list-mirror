Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27E30FF3A
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763447; cv=none; b=lAS5ehYEJxJ/rdH46d7xkRuqi0u53YEHXUQahxSCFbFCsAOG6OlP+iJD/lPYxUKQYvoBhZNQQLbn7lXmiQUGt/FpICcDxIhFPpXraPQ08NEb610DVKfyCOc/DF5En39yNyS6EaUZ6Pfdka4ribPTSCPAN2hrteFkK+vHEgyuMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763447; c=relaxed/simple;
	bh=otRb9zcky/axUxfYlIwZHlQNsO3J235YsQlTZAVWVYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpc36WlXm9l8iON+X/RHJbWbptRZTEOhpgS2xm+ZNZWMtz6vxvMcgnA1PDfPHQTyxR9OuJQdSAEoKb2d9e2sicEje8htbWbClE5GJ6EiFI7ojA1oNV12thTDFPi44rAZIh+JkAjPU9qajlzwQ9O1LSm7blkH5N11U29K6KMo9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V/FQFXeg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V/FQFXeg"
Received: (qmail 6862 invoked by uid 109); 10 Feb 2026 22:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=otRb9zcky/axUxfYlIwZHlQNsO3J235YsQlTZAVWVYY=; b=V/FQFXegRGRXJjp1yW1xsLf6Ky8+GSvBP30DYJAs6luQbHIxAOhc5KS0aWXo2B9C4sQuF/G4i3qCEfxxMGgqv9/nqAX5iOArXV5g53DcYE65Og2oN9k8adBgcbO2PhuDdPN33JOuH7+vb4/pQ98jeHWU+/j2WzcsfKyAVVJTBfKcE5Ze8VS+1j5NFpLj123vP1LxZCzNBAZUfK23UXv94nYr5JZRZB6iTGljFEekOAbncjHB6AKzES6RZdyHU4Bxc6h/IWMbi+D6tAkTqaJ1/pW0ObqHDgjeusJceuheTZp9TE1u3dm8U1sA8JGQxA2FZ+8yhgpaI9yTL/rNPsoS+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 22:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13276 invoked by uid 111); 10 Feb 2026 22:44:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 17:44:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 17:44:01 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 3/4] refs: allow reference location in refstorage
 config
Message-ID: <20260210224401.GA1836788@coredump.intra.peff.net>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com>

On Mon, Feb 09, 2026 at 04:58:20PM +0100, Karthik Nayak wrote:

> +static void parse_reference_uri(const char *value, char **format,
> +				char **payload)
> +{
> +	char *schema_end;
> +
> +	schema_end = strstr(value, "://");
> +	if (!schema_end) {
> +		*format = xstrdup(value);
> +		*payload = NULL;
> +	} else {
> +		*format = xstrndup(value, schema_end - value);
> +		*payload = xstrdup_or_null(schema_end + 3);
> +	}
> +}

The schema_end variable should be "const" here. Otherwise new versions
of gcc/glibc will complain that the strstr() implicitly removes the
const from value (and compilation with DEVELOPER=1 fails). More details
in this thread:

  https://lore.kernel.org/git/e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com/

-Peff
