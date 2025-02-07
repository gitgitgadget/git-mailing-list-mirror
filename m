Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EA1DDC20
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923097; cv=none; b=V75yn/TisAJkeMHQP2fTQilZ+EZoFcc8kkDN1EmlCMH0NdxmlgXBppSYdde8f2Rs5d4Gp7LbgXob4GRGjSjr7S+7VsjuNcX0OKDRRH/FwKOxJXUBOgNGcSm5QO/Hv20VVc2E3uTOK068Z9dOBIX8rm8IUWMnbaa1F3/iSFGC+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923097; c=relaxed/simple;
	bh=QIMUXutTjoK1uBfgDqh0i/yz2tCGrmsAvPh0MfVSHI0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFjSMy07fKjGETIaCWtjsZi7n7cTi09itBr24XPY/tppbT3MDhfVy1QexMc1M+6QUGsx893t9g1yYjX7TmwgS5iXDRnuMdUHoBWKfaCN9XfseHh/oKAA7HkmwNR66/2ETyGd01IsxLmBAe3IGzhOkX2NjBXdUocbgvCdLpiFl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3Tm9YrIB; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3Tm9YrIB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738923092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9Ss8BhrBsqKtjrQaEsAT6EK70/yZaBHriZBk9mFIec=;
	b=3Tm9YrIBq0nm/4L5ExOIlfubaF0F/lwB5zvwcaWCcOFVWUBoDysFoRJqsJ40y7nh2Rch2G
	JuxbLLQeWyKkQb7kgj1HDMJAgTCVdlo7fUCp+CU4gI/0bp4XivK0FtdpusZ3wm7ld3CsXf
	qPZ5scNKRmaluqSIJBoMU1SMjWxAlNk=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
In-Reply-To: <xmqqldulrvly.fsf@gitster.g>
References: <xmqqldulrvly.fsf@gitster.g>
Date: Fri, 07 Feb 2025 11:11:18 +0100
Message-ID: <875xlm3vzt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/reftable-sans-compat-util (2025-02-03) 19 commits
>  - Makefile: skip reftable library for Coccinelle
>  - reftable: decouple from Git codebase by pulling in "compat/posix.h"
>  - git-compat-util.h: split out POSIX-emulating bits
>  - compat/mingw: split out POSIX-related bits
>  - reftable/basics: stop using `UNUSED` annotation
>  - reftable/basics: stop using `SWAP()` macro
>  - reftable/stack: stop using `sleep_millisec()`
>  - reftable/system: introduce `reftable_rand()`
>  - reftable/reader: stop using `ARRAY_SIZE()` macro
>  - reftable/basics: provide wrappers for big endian conversion
>  - reftable/basics: stop using `st_mult()` in array allocators
>  - reftable: stop using `BUG()` in trivial cases
>  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
>  - reftable/record: stop using `BUG()` in `reftable_record_init()`
>  - reftable/record: stop using `COPY_ARRAY()`
>  - reftable/blocksource: stop using `xmmap()`
>  - reftable/stack: stop using `write_in_full()`
>  - reftable/stack: stop using `read_in_full()`
>  - Merge branch 'ps/reftable-sign-compare' into ps/reftable-sans-compat-util
>
>  Make the code in reftable library less reliant on the service
>  routines it used to borrow from Git proper, to make it easier to
>  use by external users of the library.
>
>  Will merge to 'next'?
>  source: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>

I gave v4 a round of review, and besides one question/possible
suggestion these changes look good.

--
Toon
