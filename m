Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5014D2B8
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427913; cv=none; b=qNu7H5ZKFZN4arTAgDVZyd5m5twG4x4BGrALtreRE3ifUvuQhVyZA+THIfnxCThJ1Y4WqJNsvXqo4t8pXLG0ByJTwDx6r53bxgHljHfeKARUPRkgdwtrmmf5DuM9fUzGo4taoyF2zHbbfwmtziEiKJBEXurFKY1s7mjWrEoZ3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427913; c=relaxed/simple;
	bh=IDK4tUGa763ECwU3AXh/wEukCF7cIc7f+TiGPqrxoJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahKQJ81auXt077+c61wC8Wb3D+slnuOHkbZv7k7gQpxpvUzZ+csUbvh6YnOP+6Xf+qjrWS0so2U7DKC+X/yworqO54liO9tu4hHbu5Hd1sHWJQwEOz3Huc7j+Jl5/9VlSnpENPB8jbQfA75i1bNd5x2VvCOUzSqFqfnURQivz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MfKWMR/s; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MfKWMR/s"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8939A21339;
	Wed, 26 Jun 2024 14:51:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IDK4tUGa763ECwU3AXh/wEukCF7cIc7f+TiGPq
	rxoJs=; b=MfKWMR/sGNO/frR1yoKXST8qALSr8LD0ZJfPZFUdbtcjg7kgtbaDfh
	HzvBhWtPnibXOChX45uzNfB6pMWRKe0xTMOSf2pa47oVJwuFugHGSITi+Ev1yawJ
	qwQyWyEzhHCjqOhm14fFzi8p3/PfenL9ULuwvQbX9z3hr3/4Ph8fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8192121338;
	Wed, 26 Jun 2024 14:51:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28A0F21336;
	Wed, 26 Jun 2024 14:51:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>,  "David C. Rankin" <drankinatty@gmail.com>,
  git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <aa94be27-60a5-42d9-adcc-f25f9a8d6ae5@gmail.com> (Phillip Wood's
	message of "Wed, 26 Jun 2024 19:35:32 +0100")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
	<xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
	<20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
	<20240625183411.GW19642@kitsune.suse.cz>
	<834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>
	<xmqq34oz1shc.fsf@gitster.g>
	<aa94be27-60a5-42d9-adcc-f25f9a8d6ae5@gmail.com>
Date: Wed, 26 Jun 2024 11:51:46 -0700
Message-ID: <xmqq4j9fzge5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2458B03E-33ED-11EF-B8FE-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Sorry if I wasn't clear. "." is considered safe with "safe.directory =
> *" but I was looking at why it was not considered safe when using
> repository paths in safe.directory.

Ahh, OK.  We tell them /home/wood/repo/git is a good repository to
visit, but daemon's call to ensure_valid_ownership() asks "I am in
the '.' directory; does that match /home/wood/repo/git?"  

That sucks.  I agree with your idea that we'd need to canonicalize
both before comparing.

THanks.
