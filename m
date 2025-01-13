Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77794190692
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789068; cv=none; b=sjJZb45U9Zds6nhpbywHfytoFEYu/E6tqBqo/g9qGy4HYluGaOMT28+RPzD6pc+WXzeAVPF5sDBSxN1YNL3xUVvhAT8aM77841/i/tZwxX140o+2fY7/TVKLONHT06SYcd2vC7QZcOa2wxGE2rHdvFoD/ioRMh9sm+lAUYtt5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789068; c=relaxed/simple;
	bh=cyZuL3o2mOxAk3otH007npfMfTfnjmH7xUj07FkRmMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pLTlnIYC2bFjU0L3bF0ZtA5jxufZoFXdymILb/ABhIAY9ERmHDLwKy0C9g4z5zThuxG3Ghvv9Gjxsnzt9OEr5c0WktIRq5OYIkbx7q5ydXLiGmLuXCnScfZgYXm32xy574EL2ZQUGFaAnitViq3RkcQl/EiQyCnuFlqXcMLku9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=k7sw/F2M; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="k7sw/F2M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736789060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB8eD9/sc7bvOnY57L6LAR9b7538rAlkEhMpIQ3Lumk=;
	b=k7sw/F2MozL8BHPt79xCtEv87PLWWX/kEpNUGPf/VgJlpBwc5EQq9HDwXwGliY1l/UZYRu
	CmiregZCBbDHjgUMNm14CW+x7FAs1YupeZRgg0RKvxuGFuu3oxDnGJBochQjRkeB6D4x4P
	SvxkU7nXo9g/nt1NmWkLSVB7lEYRzgo=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] meson: ensure correct version-def.h is used
In-Reply-To: <xmqqr056abry.fsf@gitster.g>
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
 <xmqqr056abry.fsf@gitster.g>
Date: Mon, 13 Jan 2025 18:24:04 +0100
Message-ID: <87bjwak4p7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> What happens if we use <version-def.h> to include (which is how C
> standard tells us to do), with an explicit include path specified
> with -I<directory>?  If it solves the issue, that may be a better
> approach.

I don't have a good source, but for example Wikipedia[1] says:

    Some preprocessors locate the include file differently based on the
    enclosing delimiters; treating a path in double-quotes as relative
    to the including file and a path in angle brackets as located in one
    of the directories of the configured system search path.

So behavior seems to depend on the implementation of the compiler. I'm
not sure we can trust all architectures to do what we expect. Or,
because I don't expect many people to use Make and Meson at the same
time, do we not consider this an issue for most anyway?

[1]: https://en.wikipedia.org/wiki/Include_directive#C/C++


--
Toon
