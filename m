Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47ED534
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743728; cv=none; b=KfXnaOgAJHaI94Q9kMB/8tXizud/8wxTHHnK0BbRZOD47yutszY/r4H2WlX3IRqoocLiBPXlft01RpzwdUiFfSogMJVdaZflKi1f9dk9jZN8niwtFSC0m/BPvO7SjPGH+hW8V9XHjj2h6EO6GhdqH71hcAB1fzWV5dH9ejdAI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743728; c=relaxed/simple;
	bh=D3SoY2+2MU6U7NUMuDZPUzIpPagX3mzYZBBebB0qqx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SphAD12jja4uq9zA2MLJ/8PwICLjVzs5yEsdfZDlVnkwkTOTxo30B+uXkRK8In2rVs/nYY9BE3FRm36tnN+1I3YTRr5cXad/YAhdAU/ow0kKQsrNxcyZ8ncM2li3xiUznMjPtFy0sqmgeoLtpPSjbnZmb2U3UNk/oiG+Bs8JTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RVaHwRAE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVaHwRAE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 873FB26A5B;
	Wed,  6 Mar 2024 11:48:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D3SoY2+2MU6U7NUMuDZPUzIpPagX3mzYZBBebB
	0qqx0=; b=RVaHwRAEA6lutW68l3kLZrfM52sJH9q3iEUh4Sp7l7aTMlshbNoOdp
	upddGLIqkUBMgM9r+MmuBeD4Yivi70FEV5t6yjOAgAeou/ADofJQdsvNuZKUyla2
	ma1FYFgwrtO/qz2JTJx/CQTNyuQuCKIJSJFftQh0pQ0CveKRMHGu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8079F26A5A;
	Wed,  6 Mar 2024 11:48:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E4D526A57;
	Wed,  6 Mar 2024 11:48:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  John Cai via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
In-Reply-To: <20240306075128.GA4099518@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Mar 2024 02:51:28 -0500")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<20240306004139.GB3797463@coredump.intra.peff.net>
	<Zegbw2i-PGfvb5q_@tanuki>
	<20240306075128.GA4099518@coredump.intra.peff.net>
Date: Wed, 06 Mar 2024 08:48:36 -0800
Message-ID: <xmqq34t3tifv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 613BABE4-DBD9-11EE-A6BF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> You can do:
>
>   git for-each-ref --format='%(refname) %(objectname) %(symref)'

We can even do that "ref target || object name" thing with

--format='%(refname) %(if)%(symref)%(then)%(symref)%(else)%(objectname)'

if we wanted to.  But if we have both available, I think the output
that adds the symref target, if available, after the object name, is
better than the output that switches between the two.

> to get the resolved values next to the symrefs (if any). I think that
> does a full resolution, though (so again, if you had one->two->three,
> you can never learn about the intermediate "two").

Yeah, I know we discussed the usefulness of tag-of-tag-of-something,
but this is a similar one.  

> I think for-each-ref in the above command works by calling
> resolve_refdup() itself, and then recording the result. It would be nice
> to get it from the iterator, though (more efficient, and avoids any
> races).

Indeed.  Thanks for an interesting thought.
