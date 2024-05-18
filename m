Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5783D56D
	for <git@vger.kernel.org>; Sat, 18 May 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716058492; cv=none; b=WiqT1RI8Wnl8080B2eNxNiPzWeMEHbWBtzdUfHJVWesRNohVVuXgPvyod9BjGM/hy1DDhNbfOdx2z3VejgDuWvXYTa2ipnz5gMR/9DA/mJ7RW8AFpwdSKwCGXnm2jdADZXfPDMwch+auHAoP8F6JLHRnWAiU0lrna7XFXq1M4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716058492; c=relaxed/simple;
	bh=3ePHG3EShk0FbpbvQLrZoomsNi19rP5GUZ/hJ3G3rJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQYqCclEOdCBq0bbWj4sDLo4Q/WE9V0fet1/TFkzijugE7OaK9R9pScFD64MkwW2Qzm7vs4bXPPD+UkIXcP3qpgo8vGoMBzxSy7fLSg//cQ3j0Myr/e7tTPrvleXLDRnO8E369w3gfJDCs2H4rNid8CJpNHpi/hgPi/YXFCD1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W4QtbVwd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W4QtbVwd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34F9518427;
	Sat, 18 May 2024 14:54:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3ePHG3EShk0FbpbvQLrZoomsNi19rP5GUZ/hJ3
	G3rJc=; b=W4QtbVwd66Zp40remXZ4cbwBNupG+VEKHtGHekRQwnxWxxd9oxBEdk
	DQyxCJPpiWEdf/zycjYe1Gh/qcsx/yvM2SfMWiXQzZ7Na2HI23jWx46qO1DR1EFN
	7WUuu9YCyh1/bHlBktMPF5NO5GxkRa+7XBzlh84gXnkftS0dzLKbE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BC8718426;
	Sat, 18 May 2024 14:54:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 842CE18425;
	Sat, 18 May 2024 14:54:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <20240518181432.GA1570600@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 May 2024 14:14:32 -0400")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
	<20240518181432.GA1570600@coredump.intra.peff.net>
Date: Sat, 18 May 2024 11:54:41 -0700
Message-ID: <xmqqmsonne6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 175D3BF2-1548-11EF-A3B8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> In either case, we're considering config to be a trusted source of
> truth, so I think the security properties are the same. But for the
> system here, a user updating a hook needs to do multiple steps:
>
>   - compute the sha256 of the hook (for which we provide no tooling
>     support, though hopefully it is obvious how to use other tools)
>
>   - add the config for the sha256
>
>   - install the new hook into $GIT_DIR/hooks

I am not sure why any of the above is needed.  

Hmph.

I was somehow (because that is how "git config --help" explains
"safe.hook.*") led to believe that this "safety" was only about "git
clone would prefer not to run ANY hook before it finishes operation
and gives back the control to the end user, but historically it ran
any enabled hooks in the resulting repository that was freshly
created by it---so let's at least make sure the contents of the
hooks are known-to-be-good ones when 'git clone' runs the hooks".
Most importantly, once "git clone" gives control back to the end
user and the end user had a chance to inspect the resulting
repository, the files in $GIT_DIR/hooks can be updated and the hooks
will run without incurring any cost of checking.

Isn't that what happens?

Looking at the control flow, hook.c:find_hook() is the one that
calls the function is_hook_safe_during_clone() to reject "unsafe"
ones (and allow the white-listed ones), but I do not know offhand
how the code limits the rejection only during clone.  So perhaps
this set of patches need further work to restrict the checks only to
"while we are cloning" case?


