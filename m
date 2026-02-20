Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCD344D8B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601574; cv=none; b=o4Yg7hrLvoCqycZFB4EOCQB/joyDByXsnRl1viNoKOUJairDTM5oWHJvbqa0Xrsnx0clJ7I/5WsplZYQjdxlIwIu3XE/pSrkSeqFkhZu+fsWJeeOpM6ok0KbPPJHPMKK3AAtNslSF6BHlFaQGPef9oIaTFtGqqDciJbfKfoU0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601574; c=relaxed/simple;
	bh=DKs74T9Mr/mQ8zUvNY98ynfOw6zvjaDwvCsInpkLk0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+VvsF/7lTM2NtkXfcZhXp5Yjfmqw32WRg3FjvnsiibfkncEpxdW/0+qX/lOSi2bJiMFvQhY/ILAmj18yeqU3WhpAVpl4IsJR27G2VMxfqduqIukIdCdXy+2EA7aUjdJZ3KIEWwv9yJTILAYilFPTtIBk8/6cItmE92MzAW3O0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DVXm3pKF; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DVXm3pKF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771601570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZVC+GZQWlgYemLO/RyAMOulbVVg7RsAy8xXDhSPZQI=;
	b=DVXm3pKFvlY5GL41DBIYqxUaYpIi0UQyl544XSCkhubUegpcLxIyLTybnLbkDH57EPWTwT
	xFoOUPWdtGGsV1mT9WGaH/0Q1w/bCy3T8uPikdkyhRU9q4jSSs4svzkRMYE1ODuqnZPJzq
	Sm1mhwdx0JMv6QyFPBCt2mo4H+fDny4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v7 4/6] refs: receive and use the reference storage payload
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-4-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-4-16f27860dbdf@gmail.com>
Date: Fri, 20 Feb 2026 16:32:40 +0100
Message-ID: <875x7rfn1j.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c7d2a6e50b..9a635f4e6c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -666,4 +667,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  					  unsigned int initial_transaction,
>  					  struct strbuf *err);
>  
> +/*
> + * Given a gitdir and the reference storage payload provided, retrieve the
> + * 'refdir' and 'ref_common_dir'. The former is where references should be
> + * stored for the current worktree, the latter is the common reference
> + * directory if working with a linked worktree. If working with the main
> + * worktree, both values will be the same.
> + *
> + * This is used by backends that store store files in the repository directly.

s/store store/store/

Also, shouldn't it be this?

* This is used by backends that store references in the repository directly.

-- 
Cheers,
Toon
