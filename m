Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49D28F0
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955406; cv=none; b=Ysw31SVrv7T1gnvxHx6wjYRYuwLRwSS1h8v0SAS/ed5CqhcD57uJKv/ZcF740654pDwSFWrk2b+cj69+xc6I/0/9uBRkYBE0fiBI3+OxuMAzjQ6k52/k94VoqNiU+GamilOi/CWv+NjollluWBtElsAVztfa61AVl64KOzX2rE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955406; c=relaxed/simple;
	bh=unT08YZoc0UvVpTaGeZQo8idtfT7E9ADukR/ctNwmWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAWlhgp6FNthoDvbaAbJRgi44JVU3CwXanTAyzFZs5J3Og3o3v+FClehNqva/JBxpgWaTJwST8mNVziHV3SRX6XPIOQ+xonLEZ+/b8+T9rlZ62Lk5ZqqgALJUssXy9m3vtF5i0ioo49dArYYIxPBaqNd9jH6vng+KACEXNPDn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sFzv6hL5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sFzv6hL5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D75531DFD72;
	Wed, 20 Mar 2024 13:23:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=unT08YZoc0UvVpTaGeZQo8idtfT7E9ADukR/ct
	NwmWE=; b=sFzv6hL5pXqJDqcbec5Y2yYYgg8IopwVnmefa77G0F8WsTz/dhi9GW
	C+QqCGgsZ3WUm2610W+rn2a321ItoKSvMGiuigvflNQ8dpRUHmzjqcyIIn5JWzkS
	2cQbb5tMIWX+YEPKHOY7wbF9vsb/3RrCAp6r3BMVnp/2QhPfVRkTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF0951DFD71;
	Wed, 20 Mar 2024 13:23:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D8461DFD70;
	Wed, 20 Mar 2024 13:23:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 3/3] transport-helper: send "true" value for
 object-format option
In-Reply-To: <20240320094103.GC2445682@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Mar 2024 05:41:03 -0400")
References: <20240320093226.GA2445531@coredump.intra.peff.net>
	<20240320094103.GC2445682@coredump.intra.peff.net>
Date: Wed, 20 Mar 2024 10:23:22 -0700
Message-ID: <xmqq1q84hl6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DE3DBD4-E6DE-11EE-B7BE-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>   - remote-curl, which quietly converts missing values into "true". This
>     goes all the way back to ef08ef9ea0 (remote-helpers: Support custom
>     transport options, 2009-10-30), despite the fact that I don't think
>     any other option has ever made use of it.

Interesting.

> When the documentation and code do not match, it is often good to fix
> the documentation rather than break compatibility. And in this case, we
> have had the mis-match since 8b85ee4f47 (transport-helper: implement
> object-format extensions, 2020-05-25). However, the sha256 feature was
> listed as experimental until 8e42eb0e9a (doc: sha256 is no longer
> experimental, 2023-07-31).
> ...
> And doing so has some value: it brings "object-format" in line with the
> syntax of other options, making the protocol more consistent. It also
> lets us use set_helper_option(), which has better error reporting.

I suspect that this may have been an attempt to mimick the
value-less true in the configuration syntax, but I agree with the
conclusion of this patch.  Boolean "true" in the context of the
transport options may be fairly common, but unlike configuration
files, it is not something we have users write manually, and there
is not much point giving a special short form.

Thanks for a pleasant read.  Will queue.
