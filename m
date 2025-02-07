Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5B1448E0
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934705; cv=none; b=o5rQ5MMIvU9L8Q0bqZLVoQITDfiunZQdxQ2bFKbFr6QDKkVZ+RNlgz/jjQ5a2oNrXcyPr6cryE/xnNHufawuQrriBJjQvAHV747HXVmZi9E9VsH9qkF4H+09TKgsmi9tBmXNFJ6BN+5sAPE8372ZsHxrbJapUzal5T2WB0Ri14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934705; c=relaxed/simple;
	bh=/fUAIIYGVyc8MGimV33VoXAv9XPD2RelvLTwYOg8kYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QE5mRLhkYB2v+3SGUurYmhLMYP6MrB4OpJ0ocYrb1wWzB86/iruuiR98KHB6SgB2l7L8n1ZR22X0zR2Oj3BEFzzK12YdxsjiZCrVWWeVm7R0oxVm9d1IsilfwLtyGrdabzRmREhoqo7wkoi7VziwfGByCZeJ11YSEdhSRV4Tqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=uz9TNlU3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="uz9TNlU3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738934694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/fUAIIYGVyc8MGimV33VoXAv9XPD2RelvLTwYOg8kYs=;
	b=uz9TNlU3ahqsF6P7eGMcLpq0Yx1qn4BkQgDwRRQzGrKnRy0/zMK303s71n3G2AScEd7gmD
	ZpjzcSTqg/wFHc5u35NUU0F93O9U8rlRmvLsB1NT9pej/eLEuxItOblgj+YEWHSo9zR4qB
	pMsKPUIMDQQ9mVf5QkkMqT4+SrIe4c0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 07/13] meson: drop separate version library
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-7-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
 <20250130-b4-pks-meson-improvements-v2-7-2f05581ffb44@pks.im>
Date: Fri, 07 Feb 2025 14:24:42 +0100
Message-ID: <8734gp51lx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When building `libgit.a` we link it against a `libgit_version.a` library
> that contains the version information that we inject at build time. The
> intent of this is to avoid rebuilding all of `libgit.a` whenever the
> version changes. But that wouldn't happen in the first place, as we know
> to just rebuild the files that depend on the generated "version-def.h"
> file.
>
> This is an artifact of an earlier version of the Meson build infra that
> didn't ultimately land. We didn't yet have "version-def.h", and instead
> injected the version via preprocessor directives. And here we would have
> rebuilt all of `libgit.a` indeed in case the version changes, because
> the preprocessor directive applied to all files.
>
> Stop building the separate library and instead add "version-def.h" to
> the list of source files directly.

I'm happy to see this "optimazation" go. The solution using
"version-def.h" seems simpler and more straightforward. Thanks!

--
Toon
