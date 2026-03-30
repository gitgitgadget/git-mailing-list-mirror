Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D8377ECD
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893349; cv=none; b=LSGiR6tB/QEnjKd4zIGYUp9gpS90dkBr/yZMI6gnqeZOCT3VSyS4fEXeK6+ZkWD0LLWjMAks3EFKwRW0e90NRmwQzuSHj3xHBArq9CrM3jHzcr04zvGAw8osM1re0gmxNGm9+m5fVJuWWwmFOCGmpLl3rCrS3PIh2ADQUl6ZUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893349; c=relaxed/simple;
	bh=ExN0sZxmm7csrNYVcAH+tOdGBx/mvVwh/ClVlCilXzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phL74HcyQxnSkTuyHGwxnbXbJBVgtkiaoSFHgACwXR5WErBLz1MA5+aH/U45MqYE114OIWGyH7LwXG7JrgYiK0a5vDDklqEQE3ZQiCM4Eok/c3YGD+mA3pmzO71NvnBM7CfFf+jRW14TgzNhYCOwaFyEKympncdctK8FdPHlx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=XKDdEeoK; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="XKDdEeoK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774893344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDKWt9MUwtF8bcpRau3zXMUkH97556PzEjLvxBLcKU8=;
	b=XKDdEeoKgEeGXz2T2zDDTaXA0Fw4uYDdwpAc+Hgpr+nWRwvHzSr5S9dkPBosX7JsFhj/im
	cjEPlh/vx5EcsT/3256jJbN3b4UQrwYWXV2kXWtzb9uqZtib2RXwPj6L5zX7o+5cccVN1C
	6zzl2Z3BKCqjCKfPAgA4GCspThfPzo0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/14] object-name: move logic to iterate through
 packed prefixed objects
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-5-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
 <20260320-b4-pks-odb-source-abbrev-v2-5-fe65dcd8c735@pks.im>
Date: Mon, 30 Mar 2026 19:55:32 +0200
Message-ID: <878qb9mcbv.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> +static int for_each_prefixed_object_in_pack(
> +	struct packfile_store *store,
> +	struct packed_git *p,
> +	const struct odb_for_each_object_options *opts,
> +	struct packfile_store_for_each_object_wrapper_data *data)
> +{
> +	uint32_t num, i, first = 0;
> +	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
> +		p->repo->hash_algo->hexsz : opts->prefix_hex_len;
> +	int ret;
> +
> +	num = p->num_objects;
> +	bsearch_pack(opts->prefix, p, &first);
> +
> +	/*
> +	 * At this point, "first" is the location of the lowest object
> +	 * with an object name that could match "bin_pfx".  See if we have

"bin_pfx" isn't used no more, should be "opts->prefix".

-- 
Cheers,
Toon
