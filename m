Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E5211290
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658606; cv=none; b=IvDAXQeLugNgwG4uiumWH2TSZ/H6T4wZVEZBVXc+yS1nmu0fMt95awgbTn6im4pCDkYlrTMcO9rf+WebSfBJXjVrSBe8NqbGZDHNU6o4D9T72lyeXJMv90FmEHgBylEWE9u1bQGkGYOjMbo5e/1coSEWqrD4CwRqD305wV/lk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658606; c=relaxed/simple;
	bh=GTxgvYSeTm4oo6ZrS6B36DlxGyIjTkvzKFq0l5FT+7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpCBzqQgBDoeO6jSKvHx/b8V2KJ4TLJHlvSlAxtdq3R2rVqZvvuXRSurG8jAJz8B/BrakFziKYh2y27QnZahm7dc11BxEx8Ifpwy9bSt12GUoU332JQIWxSY6sv9m+ykt+88sJCyk5lDXfIR7TYH5L0u8vO7955Z/xjcvt/1J/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fjJdt0DYWz9vCh;
	Sat, 28 Mar 2026 01:43:14 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
Message-ID: <a4a03bae-b987-4b21-a7fd-fbdb9d832430@opperschaap.net>
Date: Fri, 27 Mar 2026 20:43:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] connect: Add support for per-remote and per-namespace
 SSH options
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Bence Ferdinandy <bence@ferdinandy.com>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-4-wesleys@opperschaap.net>
 <20260327214559.GA599365@coredump.intra.peff.net>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <20260327214559.GA599365@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4fjJdt0DYWz9vCh

On 3/27/26 17:45, Jeff King wrote:
> On Thu, Mar 26, 2026 at 07:37:38PM -0400, Wesley Schwengle wrote:
> 
>> The following configuration is supported, in order of precedence:
>>
>>    1. `remote.<name>.sshIdentityFile' and `remote.<name>.sshOpts'
>>
>>    2. `core.sshIdentityFile.<owner>' and `core.sshOpts.<owner>'
>>
>>       Where <owner> is derived from the repository path. Nested groups
>>       aren't supported: git@host:owner/repo.git becomes "owner",
>>       git@host:owner/group/repo.git also becomes "owner".
> 
> We already have some conditional config mechanisms, and I don't think
> it's a good idea to add one that only works for certain keys. If I
> understand correctly, this <owner> feature can already be accomplished
> with:
> 
>    [includeIf "hasconfig:remote.*.url:**/owner/**"]
>    path = all-your-options-for-that-owner
> 
> It's a little more verbose (and you have to use a separate file), but it
> also allows other conditions, like "gitdir:" for selecting based on how
> you lay out your repos locally.

This doesn't work as you would think it does. The includeIf on hasconfig 
with the remote URL is used if it finds the remote in the config, and 
not on the actual network action. Thus if you have two remotes with two 
includeIfs on the remote URL it takes the config of the last defined 
include. Thus breaks the expectation that it is configured.

Cheers,
Wesley


-- 
Wesley

Why not both?
