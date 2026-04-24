Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D8B35DA60
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028497; cv=none; b=EUwuIFWGg7sBGHjMmt4scw+hvjla7IeJYzgF56zgxgDpyeRaB9YGpcpno4dSGNVVPW+oMPXp3mUPyElpcXouRyIKZRQmlr7JFH6MrxAH1IH9bZ8KEz/hBiMyH5sEVEH2tKixhXu2An5Ek2dviOLpjG8hEPqjAevR53qK3HEbhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028497; c=relaxed/simple;
	bh=CrfzDwZKZluCBSUjB4Ii7ydSbg8SHYdhJ7nc/CoEdSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zsmqbe6FoZmeoKfdjZPHEfIQBb8cVTSm/TCz0BuY77VjeJcWzL57lwChUKIAgpf0k0d5yI7ZxLb/kDCVPvJJtbZLzWyXLFe5m5nGEaFVmdJb7uOKChAZXhyWr7j2IM/4PXFviJMzdKRcaoRRVaJicEwP5+4xHHCrauERLuLUQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YuLwGwRO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YuLwGwRO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777028492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CrfzDwZKZluCBSUjB4Ii7ydSbg8SHYdhJ7nc/CoEdSE=;
	b=YuLwGwROOFEaKvmZFcuMg/GHxyztZup9LQJCmfc3epXsf5Md/Udiz2+lrQcUwQgxJw+vfo
	EQdKPNM5g3LzIdAwqEYrr4xRHq75IwXk4AJIjDAZ08P5pd1qZZjpa9ZHAO49MIVNjgtLgW
	zQ8aguW8wMjQgTjW19inCycBaBYyxGg=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v2 4/9] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-4-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-4-ae5a4f146d7d@gmail.com>
Date: Fri, 24 Apr 2026 13:01:25 +0200
Message-ID: <875x5gei62.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The `ref_transaction_update()` function is used to add updates to a
> given reference transactions. In the following commit, we'll add more
> validation to this function. As such, it would be beneficial if the
> function returns specific error types, so callers can differentiate
> between different errors.
>
> To facilitate this, return `enum ref_transaction_error` from the
> function and covert the existing '-1' returns to
> 'REF_TRANSACTION_ERROR_GENERIC'.

I had to look it up, but it seems this enum was introduced not long ago
in 76e760b999 (refs: introduce enum-based transaction error types,
2025-04-08). I'm happy to see it's reused here.

> Since this retains the existing
> behavior, no changes are made to any of the callers but this sets the
> necessary infrastructure for introduction of other errors.

Makes sense.

-- Toon
