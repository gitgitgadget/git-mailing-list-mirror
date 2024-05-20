Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF528E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249408; cv=none; b=Xrr8bin63Fj3Xn1HhdbV48yn5OuC3bIc69OFjz3TMMsoILF5dy9KW3Ppi5XwqH7htCqRN2W5eUc2jtzoh9qgL3m1OSig5GN2Q2LPt9I0Xu6kQ/GoX7ds3mIfVcG0eTnEs0Ck7d+0BkcB6zeukGxblqpMcMv8RkXzqlEcB66ZVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249408; c=relaxed/simple;
	bh=AZQ4xnAyAvSCLnd0Bv3DtempAU3CDw6Zvyn4Gfy6BWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mht6DJqfEkQongDu3A1gn9nrdsq2pUSDm7hyc0pKyxsoVpnZLMJ6+MWgw5VmF1mkfPDrA6K78OGi2HligVZEff3rbggJkwr5QfAge2HU7MFkwJSMwf7gpni7Edq8Oy4l4k2nPgEMpKjlb6JLVWTv6wHCHUdBNHhcHCdocvVOz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L8AW65Ru; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L8AW65Ru"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C08AB1B2ED;
	Mon, 20 May 2024 19:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AZQ4xnAyAvSCLnd0Bv3DtempAU3CDw6Zvyn4Gf
	y6BWg=; b=L8AW65Rul327np0ATOeb0mnPX0a6X8Pqi8t9j5tKO2X7kSenhKyCjM
	ml/RPvfswAnaMLN/L2Vw4NVYLF7JFHHLiSdZD2VNT5/DtxokCskIn+RPa/kq6i7G
	Hpw4fM2O+Ssjqx0NBlcyY6sKJHtAXqCOCMcZ7PRPapfD+jJgG+W+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B816D1B2EC;
	Mon, 20 May 2024 19:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 284D81B2EB;
	Mon, 20 May 2024 19:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 20 May 2024 20:21:59
	+0000")
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 16:56:44 -0700
Message-ID: <xmqqseycca0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9CEC446C-1704-11EF-AB6F-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series is based on maint-2.39 to allow for (relatively) easy
> follow-up versions v2.39.5, ..., v2.45.2.
>
> Changes since v2:
>
>  * instead of introducing an escape hatch for the clone protections and
>    special-casing Git LFS, drop the clone protections

It is debatable if we are ripping out clone "protection" or a new
restriction on executing hooks before the end of clone that has
backfired. 

In any case, I just compared the result of applying these patches to
v2.39.4 with the result of reverting the following out of v2.39.4:

    584de0b4 (Add a helper function to compare file contents, 2024-03-30)
    8db1e874 (clone: prevent hooks from running during a clone, 2024-03-28)
    20f3588e (core.hooksPath: add some protection while cloning, 2024-03-30)

and the differences was exactly as I expected.  A Makefile fix and a
new test added to t1350 are the extra in the series, but otherwise
the patches are essentially reversion of these three steps.  Very
nicely done.

Thanks for a quick turnaround.  Will take further look.


