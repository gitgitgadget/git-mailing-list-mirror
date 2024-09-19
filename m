Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002835FEE6
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781663; cv=none; b=JI/sLWwNcis+zdtNIQB/Yp2FWa5UYh2Cj+GYeEfd0tXHwWsiL6UMa6lJn3VYLMO/fdxLmMAPoKJmtdfU6IveWg6FKX3yEXHYa6usrhiMSC/TqwvR4fChd9VM6heBX+L4PaBt7E0B7Jkbwz9DEmlHxU/uPOs+a9Qa74jtNtMF02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781663; c=relaxed/simple;
	bh=L2mHKeH2tC9qWn7fpWkMhdnrbIwo+w+RL8Qwoj/WsrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eHjR2vRStCb9CYzKihinjksojTQp2MThdz6kN1581iDEcbdRAiW+2zmxA28GGYwaX3CPgzEhufq6oxZbcujnPfhMxluI5zM6eVqflEZ916Mj8YCxp64kyiiNj760zywdr2I+Ziqmcn+oIX53DCr6B4W2fqLLWOHdEr7T2Mx/Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LrKR2342; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LrKR2342"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC8EB268F8;
	Thu, 19 Sep 2024 17:34:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L2mHKeH2tC9qWn7fpWkMhdnrbIwo+w+RL8Qwoj
	/WsrU=; b=LrKR2342M5p4F0wqzw1R3mCjKnkDsKUX31Rwcn5d4eVRxt6yAAfomZ
	FyS1khcHNxGUiBhg90DSPveeSXSajMABivFLRQsMwsntFSqNb3YUT/cz5k6b4rtG
	l48kRrJpD0QGXE66YLVQXfc1+XXJY7oyorhDwHrWz7c5phubFuDww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2458268F7;
	Thu, 19 Sep 2024 17:34:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18009268F6;
	Thu, 19 Sep 2024 17:34:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v3 1/3] refs/reftable: introduce "reftable.lockTimeout"
In-Reply-To: <77cffd3b1eb638e05c031e2949fdc9374d599e05.1726653185.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Sep 2024 11:59:27 +0200")
References: <cover.1726578382.git.ps@pks.im> <cover.1726653185.git.ps@pks.im>
	<77cffd3b1eb638e05c031e2949fdc9374d599e05.1726653185.git.ps@pks.im>
Date: Thu, 19 Sep 2024 14:34:13 -0700
Message-ID: <xmqqmsk35nvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB152BAC-76CE-11EF-AA99-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +reftable.lockTimeout::
> +	Whenever the reftable backend appends a new table to the stack, it has
> +	to lock the central "tables.list" file before updating it. This config
> +	controls how long the process will wait to acquire the lock in case
> +	another process has already acquired it. Value 0 means not to retry at
> +	all; -1 means to try indefinitely. Default is 100 (i.e., retry for
> +	100ms).

Existing timeout knobs are in a hierarchy that is too wide
(i.e. core.*timeout) and this fixes the mistake by placing the name
in a lot more appropriate name (i.e. reftable.*timeout).  If I were
designing the system from scratch, I would probably place all of
them in "refs.*timeout", but I do not think it is worth extra
engineering effort to rename them and pay the transition cost.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 1c4b19e737f..ca281e39a29 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -256,6 +256,13 @@ static int reftable_be_config(const char *var, const char *value,
>  		if (factor > UINT8_MAX)
>  			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
>  		opts->auto_compaction_factor = factor;
> +	} else if (!strcmp(var, "reftable.locktimeout")) {
> +		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
> +		if (lock_timeout > LONG_MAX)
> +			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
> +		if (lock_timeout < 0 && lock_timeout != -1)
> +			die("reftable lock timeout does not support negative values other than -1");
> +		opts->lock_timeout_ms = lock_timeout;

Existing lock timeouts this models after seems to consider a
platform native "int" is good enough size to represent the timeout
value in milliseconds, but the eventual user of this value in the
lockfile API expects a long, so lock_timeout_ms being long is fine.

Perhaps #leftoverbits to straighten out the types used for the other
two timeout configuration variables.
