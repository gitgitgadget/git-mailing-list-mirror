Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4812C7FB
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726344670; cv=none; b=BtBWPRdKqjTm7i+OqLsjElvk8csCjVDuOlCrkD5hI0xmNF7mMJbFVmAwl1Y/3C46m93/RDsITpK02bP7VbUwam4j+VL95pcefYtzKT6KTgOpf9yzF4r/ax4zhDg8b+SVw+LqwBLDEDwQjyjTZ2JEuFevKGl/lyGZiJXLvIdIZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726344670; c=relaxed/simple;
	bh=rl0qFVbBnuNU5diziT7euSYTPKrAf7rJmazCtwl10X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELGDDYyhDQxgqBU9Ultu2OrlBEi2JNsUDOZsNIVitBzQSIoKQxwEh1U2Ldy0+D7f095BNUAL44kEPIXtFWKhJ73jvMHnic6f7ZHoeIo+kfnodliWt1Aopkbghncu9sr9X0BRQQ2+H2G3OdSV4GZ+gnm3KGbbxqrKsh6L8FNLoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xupNLqeY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xupNLqeY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13B3C1B5E7;
	Sat, 14 Sep 2024 16:11:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rl0qFVbBnuNU5diziT7euSYTPKrAf7rJmazCtw
	l10X4=; b=xupNLqeYc7JPBVEbpFkELKiBgAfdIQz8t6mg7/O5C82Yv+IySQKDa8
	jDhn4DVML0YVECMrEarfFkKEazrL7r1lnLro37YChkbxmFWZIxFheixRC+RTU3O0
	nFb366N92pw6Jd6bP3WxKvujER0x5gGRR8RMjc8+VHN+kODFg6BsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF3A61B5E6;
	Sat, 14 Sep 2024 16:11:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E63E1B5E5;
	Sat, 14 Sep 2024 16:11:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
In-Reply-To: <CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
	(Shubham Kanodia's message of "Sun, 15 Sep 2024 01:05:48 +0530")
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
	<xmqqzfogsrqo.fsf@gitster.g>
	<CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
	<xmqq5xr4r818.fsf@gitster.g>
	<CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
	<xmqqplp7ze0h.fsf@gitster.g>
	<CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
Date: Sat, 14 Sep 2024 13:11:04 -0700
Message-ID: <xmqqo74qro6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79661F0E-72D5-11EF-94EE-9B0F950A682E-77302942!pb-smtp2.pobox.com

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> If we're trying to determine if a pattern
> (remote.<remote>.prefetchref) is a subset of another or not
> (remote.<remote>.fetch) (to not accidentally expand the scope beyond
> `fetch`),
> we'd need a function that does that pattern-to-pattern. Are you aware
> of any existing functions that do so?

There is no such computation for this application.  Such a
computation might become needed if you wanted to complain that the
user gave .prefetchref pattern that would never match what .fetch
patterns would allow to pass.  But there is no such need.

You will first get the advertised refs from the remote.  

Existing logic filteres them down to what matches configured
remote.$name.fetch variable.  filter_prefetch_refspec() may further
reduces the result by removing those whose .src side begins with
"refs/tags/".

Now you only look at what survived the above existing filtering, and
further narrow it down by picking only ones that match the prefetch
condition.  If the refspec that survived the filtering by the fetch
refspec (and existing logic in filter_prefetch_refspec()) does not
satisfy the prefetch condition, it won't be prefetched.

Since you are using .prefetch ONLY TO narrow the result down, by
definition, you are not adding anything what .fetch configuration
would not have fetched.


