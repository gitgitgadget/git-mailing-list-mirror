Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FC354AE3
	for <git@vger.kernel.org>; Mon,  4 May 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895228; cv=none; b=evfWZ1BviDtTTvUPNzULbfdXYl+W/4zVZw9lSDKzb67HtuIV2x9NjpEuugPxasU3Shca1GWnL7fCG4kdyho6dS3Q7rUkuQIgd63yFi6tp2jRHUCMCaFNXm3pTPB521Z+NsjZdjA4ZVQIBP48oWCt6FaJ8krrnOQvoxG9TGLCHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895228; c=relaxed/simple;
	bh=V22C0nWusCd7Lxs8/E44j7eO9RA3hDDlOwzntxtRsbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MrjRaI4gpxn/Jck7ESgOVB6LcX0OxHf5KpCMb/CIbMry4VtyL2pdh8dBJS9pge1wHWexFsckJGrU/uSowM/XL1/7YPAT2GucB6d70C8hGYCTqsTAOHD8WK7my2L+oX6554xVFsvCu7q2Og6q8FfP3vdBiGuhIbnXwokwnkKFwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5uVH+6/Y; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5uVH+6/Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777895222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MtDd7N2Yx2jdzpvCneu8tk/OhbESogz/gOqvV4iPKhQ=;
	b=5uVH+6/Y2xb+O1nPpjQfwtkHI+RfQJTetjpCIq02TdwKw58gR4sLla9BfpnukydyifOjEv
	4N/CNKpEHkCG6LrUwmZg22pVn7AAoO1sgACiKuimyv/gBJSWO29+GVqQXXynqHyjAIfVUk
	SaaD6Qoyf2c7QQzZ1vmVTYJ2ehDA2Uo=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Elijah Newren <newren@gmail.com>, Christian Couder
 <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/8] promisor-remote: add 'local_name' to 'struct
 promisor_info'
In-Reply-To: <20260427124108.3524129-5-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260427124108.3524129-5-christian.couder@gmail.com>
Date: Mon, 04 May 2026 13:46:55 +0200
Message-ID: <87bjevs8gg.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit, we will store promisor remote information under
> a remote name different than the one the server advertised.
>
> To prepare for this change, let's add a new 'char *local_name' member
> to 'struct promisor_info', and let's update the related functions.
>
> While at it, let's also add a small promisor_info_internal_name()
> helper that returns `local_name` when set, `name` otherwise, and let's
> use this small helper in promisor_store_advertised_fields() and in the
> post-loop of filter_promisor_remote() so that lookups against the local
> repo configuration use the right name.

It seems the `local_name` doesn't get filled in yet, so because
promisor_info_internal_name() falls back to `name` there is no
functional change in this commit. Okay.

-- 
Cheers,
Toon
