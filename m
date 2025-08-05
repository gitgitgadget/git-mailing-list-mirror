Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8E23F40C
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395908; cv=none; b=GcFmvmCYIUGhLeFUTIuuq/hposZW8/Ow5qLTH6WWDWRF8wpPXgJ+2CgThkMq2SO/+RAloH2yBK6evHvAwpQc4DjBtrY3l/gNDLKQcjROKtfQt1b7BAuitjExTOprsoG8cjEmUFsGT3DeN/oH4Iu7MM7zGAwflR5c0r/kXeYBOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395908; c=relaxed/simple;
	bh=bOg341LhhA4w86PZoytErxswgACGLqgbd8EKJy+gc/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LPs4KDPMMvXHuC0x2wZqcEj2c/xU8HLF4LonCkvCRxx4goq3uPBJ/tVQxfC+S1KtaRfZ0GKaG8xVd08v7i7o2oLennjoPD76iI8JtrhJjDxse5FadrjHedF5rVx9lgf7uPfREg7sC7KJJyiaDOKEyrZMMhz8ltL0giHPfz9ztYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=B0N5CUFX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="B0N5CUFX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754395901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fNX4v32XV9YSMHZy46hcvubVOmpl0+tBTxWNOWSpNew=;
	b=B0N5CUFXinuR1T55mghYQy34aDlMNtVDhtLnAcD/uA3QS5KgxHofHXHKiw6LUY6vJNRsae
	VNJHGqbkADLtvN/ZX+jPrcMwHTTZMJWpCxfYPbIvsLvbfz1P436QlMp0cvPbrGPXT2p6ha
	czDRrCgzCK+fe/ofD88dBS3Xkqgruyk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0450: fix test for out-of-tree builds
In-Reply-To: <aJBnuOcQQ1AY6hR4@pks.im>
References: <20250804073002.1586332-1-toon@iotcl.com> <aJBnuOcQQ1AY6hR4@pks.im>
Date: Tue, 05 Aug 2025 14:11:29 +0200
Message-ID: <8734a6ufwu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Ok, the change itself looks reasonable to me. One question that the
> commit message doesn't answer though is why this didn't cause the test
> to fail.

Ah yes, I should have pointed that out in the commit message. But as you
say, in short it simply skips the tests is if cannot find the .adoc.

> [snip]

> Which indicates that this prereq is overly loose: ideally we should not
> skip such tests, but rather print an error that something is fishy. I
> suspect that we have the prereq in place because there are some builtins
> that don't have a corresponding manpage though.
>
> Maybe this is something we could explore: what breaks if we remove the
> prereq entirely? And if this breakage is limited to a small number of
> builtins we can maybe use an explicit skip-list like we already do with
> "t/t0450/adoc-help-mismatches".

I think that's a great change we should make on top. Being explicit
about which subcommands do not require documentation is better than
simply letting them slide through. Every new subcommand would require
documentation, and if not so, adding them to a list somewhere makes it
clear why.

-- 
Cheers,
Toon
