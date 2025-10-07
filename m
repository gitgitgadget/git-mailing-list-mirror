Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC663FF1
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804374; cv=none; b=b4eLDKOMLeOXoJ8pAZdtrw0+7GHdCvHt2jETcOqB8dsStQ0eHaMvO1u5cae8NX8e9V2QY8a6nUF0Q0pC86dIpEYvPaW5UQUaxREyw6Ps078D9snmJ+VZIiNZQAAlNyGPXePNR1jLYf9OdRrKRAqYunrR3pN3YHXPkqsJbyNfBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804374; c=relaxed/simple;
	bh=fQKy+Z8LGf6HsmKsBYyiG8T9eezV5IM1PVLwEcZzYMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXyL/boFa/dQIaPk7xJst3C8B+CjUaJpBXOhU8UMwtQWhwYXWRD519eILcOu/xtTzA3s9I8vI0CIP4BmAgChlqpSvAAPhnXK8mNQd62Z4Cu66nN2vXpOAOxPucQWvKfRwbcPXGQWoYUszFxI+HV2z+jDUm96R4QYHrVYMsMHBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P4cA+vcd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P4cA+vcd"
Received: (qmail 153151 invoked by uid 109); 7 Oct 2025 02:32:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fQKy+Z8LGf6HsmKsBYyiG8T9eezV5IM1PVLwEcZzYMA=; b=P4cA+vcdDJDMSCyp87bwBeSkvNeRTbaeQ9fd37GiDHhk9CZ1Xrp3r3wMxc/lASxe9qHOfJ3+kSw6mExvYr5qOWwYLuJu9Vuc930SSHm7WYRC6NtXGOmCjdtvv1C23Ujmfv7Y7n57qkACiQIE58jjSUbjOl+qqLqGoKOw25qPF6/ctJ+m374YhRqSknN9BuLP/gnOgIX5OoXtyApbrSxZ+kMUe+f0PrIvvNxRodPJr9vJsHju09VFvitGBUpu2EteEXzpswRW0c80ga2XsNtdDWMIfmoLma8S449clIfgP1xJS4nON6hka0754yjUswZ3Z+F1Nr9SrT7osd6nCfn2+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Oct 2025 02:32:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 226652 invoked by uid 111); 7 Oct 2025 02:32:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Oct 2025 22:32:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Oct 2025 22:32:42 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v5 7/7] refs/reftable: add fsck check for checking the
 table name
Message-ID: <20251007023242.GA2747748@coredump.intra.peff.net>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
 <20251006-228-reftable-introduce-consistency-checks-v5-7-f196d386214f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-7-f196d386214f@gmail.com>

On Mon, Oct 06, 2025 at 04:23:05PM +0200, Karthik Nayak wrote:

> +test_expect_success "no errors reported on a well formed repository" '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +
> +		for i in $(test_seq 20)
> +		do
> +			git update-ref branch-$i HEAD || return 1
> +		done &&

Did you mean refs/heads/branch-$i here? As it is written, it creates a
root ref, and the name does not conform to the usual rules (all-caps,
and ending in _HEAD). There are some holes in our checks, which is why
it doesn't barf yet, but I have a series to fix that which I hope to
send out later this week.

> +		# The repository should end up with multiple tables.
> +		test_line_count ">" 1 .git/reftable/tables.list &&
> +
> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)

Arguably this verify command should be complaining about the broken
names, too.

-Peff
