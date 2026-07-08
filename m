Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275013016E9
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516773; cv=none; b=AHUndYiNq3XWlNcvlD+LcMKkUyHtrOxYvN0BSjfojw3SNtvBffxq5Hfp3CZ42XbsNcU/H6fDZ/WHiWl1aheUCdVFnuI1sY+zQYHPh+PiMx7/0vux5atZ3Zm3gmjdK5d5hmJDfXDQwOvkFOv2C3SGc+mGlCKEbnRVYRgCweMcKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516773; c=relaxed/simple;
	bh=Hpv+OOUP4lddSuCMqEb9Mb9bFIqzFINykaBvDMDyc3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJavtQ1zjXwrvm5Ta4rp+/W1ounMFD/p84tdJR+ACnLAUMmNRrofTBAFxOZG991/N4e7dbCzfmwDUdQwrJ7w41+q4ZVborLFbuvPToqgQ4+YCdZZHX3Aw/x2ha89Od8a9+eU2SXaKC/d1ndeSehbAM1zaQLP2i2jYOKl2Rv8iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=d0iaXXiS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="d0iaXXiS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783516767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nccrzdEBxfoHcZrpglLqOPKGpqyRz/F9IIhzCF+N87A=;
	b=d0iaXXiS0JS+8xnnzNFWQo2Im6f14+5c2k7amVMUXb+ST7kzZPC7Nj0kH+xrrqjKXIneH8
	vVw6OyO63EwrKfxMHLvZrNan6oEvAToOgfFzngys9VeFe8Vqcgm9MY+12oOGJxaidTxaFG
	6NnarYRK3ttOjYsb31K64mDIDNcdhro=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 00/12] reftable: harden against corrupted tables
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
 <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
Date: Wed, 08 Jul 2026 15:19:22 +0200
Message-ID: <877bn5obz9.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series addresses a bunch of errors that may happen when
> trying to read corrupted tables. These errors include out-of-bounds
> writes, out-of-bounds reads and the ability to hit abort(3p) calls.
>
> The out-of-bounds write was originally reported by awo on the security
> mailing list. As we never transfer reftables over the protocol it would
> require local disk access to create such corrupted reftables, so there
> isn't really an easy way to exploit these.
>
> In any case, I took that chance and wrote a fuzzer for parsing the
> tables, which surfaced a bunch of issues. At the end of this series
> though the fuzzer can now run for an extended amount of time (2hrs+)
> without surfacing any new issues.

Great work on providing the fixes with their corresponding unit tests.
I've manually verified if each test, and they all fail correctly without
the code changes.

All looks good to me. The only thing I'm not sure about is whether it's
useful to have the Asan output in the commit messages.

-- 
Cheers,
Toon
