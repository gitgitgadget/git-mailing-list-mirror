Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B213F434
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131917; cv=none; b=GpSeMhXpJ++l7+8tJyoJ9W0utZhjRnmZGffgy1GFAC9ey58rel/86ZnqP3Q6JlaA2WYwTa+FFq7TxmGXEYtpLLMgaeeO4Pr+4I/zFF0bO22I3XMrYhNQsoorvnZOZGJTm4Wr5tTQEtraz1/D4bErxfBwTWa8HRfoGGqWk6fss+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131917; c=relaxed/simple;
	bh=U13zfeUmv55h4ALzqkETWS5yofXwnBcE91G944TvzxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jdvgZ/l4rp+ftVKXscACzGtEfzSOiA4tDpdkqKU1uB2ajkmUnizYZDPMsAUvHQKhnMxjjeVK9S0rWTrrBe6diLcKnRApgzQeaID+PvMwwdPn2H/6QsDfUa+1oq2aJ4Tog5XjW5VuHifUqtYfzmks/SQkqX+bSs/0HAGefp3FBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=UYclHX//; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="UYclHX//"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737131910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhCxM4lXoDKF2vblan3e0vB5K68mbwztMq+L9dQK3jQ=;
	b=UYclHX//rM3/+YxYhNiwdKuhj47yhZKbUcZwi4hwL4yOm6HLpRA2ylU2k+lgEjorBBon2V
	mIKmpl4hdi5NHorZSTrwYQsuGui19a4JEp6RcykTTEh4uyit8l4zG2hMYSGBRjB8F49nZn
	2gfFZFtpczPUfsGgnyHCyI06K4euiwE=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-1-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-1-a7fdc19688f5@gmail.com>
Date: Fri, 17 Jan 2025 17:38:15 +0100
Message-ID: <87zfjpiefc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The `fixup_pack_header_footer()` function uses the global
> `the_hash_algo` variable to access the repository's hash function. To
> avoid global variable usage, pass the hash function from the layers
> above.

I'm probably being overly pedantic here, so feel free to ignore me. But
you say "pass the hash function", technically that's not correct, you're
passing down the struct that defines several properties of the hashing
algorithm. This includes the hash function, but also other properties
like the hex size. By using "pass the hash function" in the commit
messages (and not only this commit message) it sounds to me like you're
changing the type of the object that desribes the "hash algo". But
again, feel free to ignore this comment.

-- 
Toon
