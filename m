Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376581C8FB5
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593340; cv=none; b=VQiwA7vN9WX5u5bIrkY1LOWWKMDjejhXCLGBg/uI3GiAyyAtMSpHavAEuK18WwsUz4aCpk9CyFuI82M0ZCg5Z7+ClI2+mYV/uA3RF1jtXOhv6oAoaVtSTctEQRIYC8Wx+ZEJefU76LFGNEc+1BldUBo/NxgxzaU9ktf4UyY/LyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593340; c=relaxed/simple;
	bh=fky2MtS4IRdxkXMyqEm4sBosK5z15wM8nMxE62DEjA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qrq2Y6UqrJLFXhjvNVgL3ZSXL5DYPUCncZz29HWSeIHGt+vDOhS7eAAEJLrMFCUri1uELL/Joor6ODkzQpnr6wTKIeKaaaWsz6n9r6I7k9d51M/XWyxmym2rMjL6wtcMjyWJxUAoP2P8NiO3IrspD+37vc6JmGuUQa32DU08H2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=POmHdfUV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="POmHdfUV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA85033B6F;
	Fri, 28 Jun 2024 12:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fky2MtS4IRdxkXMyqEm4sBosK5z15wM8nMxE62
	DEjA8=; b=POmHdfUVVkeWHY+yYV0X7KTY+c5hu+ChUYFbz8SIiOFMeHTvKIbxBs
	6LEkfzXyppyjpR/Egy1fACvdfwkb90o8lT4UyARwqulG0e0Y10Qb1mpsgcNHwTYZ
	DrjXNxQxL6siIyBIPmulUa4xMH7wp6x+XU6ITfI4WyZGwDdF55XZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E229B33B6E;
	Fri, 28 Jun 2024 12:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55F0B33B6D;
	Fri, 28 Jun 2024 12:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Florian Schmaus <flo@geekplace.eu>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <27cadffb-ca3f-487d-86b7-3508c45c446d@gmail.com> (Phillip Wood's
	message of "Fri, 28 Jun 2024 10:35:25 +0100")
References: <20240626123358.420292-1-flo@geekplace.eu>
	<20240626123358.420292-2-flo@geekplace.eu>
	<9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
	<72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
	<xmqqa5j71snb.fsf@gitster.g>
	<5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com>
	<xmqqpls2v1zx.fsf@gitster.g>
	<27cadffb-ca3f-487d-86b7-3508c45c446d@gmail.com>
Date: Fri, 28 Jun 2024 09:48:54 -0700
Message-ID: <xmqq7ce96mix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EA22D0C-356E-11EF-B674-965B910A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>     We may want to discuss who protects from whom with the
>>     safe.directory mechanism and git-daemon-export-ok mechanism.  The
>>     former is "the daemon trusts that repositories won't harm the
>>     daemon user", while the latter is "the repository owner is OK for
>>     it to be published".
>
> Yes that would be helpful

OK, let's see if somebody volunteers for documentation updates in
this area.

> I think doing this would be more helpful than updating the
> documentation to recommend adding "safe.directory=.". If we do this we
> would also want to convert "//" -> "/" in the config keys as we've
> been forcing users to add paths like "/srv/git//my-repo" if the
> --base-path argument to git-daemon ended with a "/"

OK, so the idea is to normalize both safe.directory and data->path
(which might come from either worktree or gitdir) and then look for
a match.  path needs to be normalized because it can say '.' and
'/srv/git//my-repo', and values of safe.directory need to be
normalized because the users may have written '.' --- oops, relative
to what directory do we normalize safe.directory values?  That would
not work.  Let me retry.

 - Compare entries of safe.directory with data->path literally
   without normalization, as the user may have written in the
   configuration "safe.directory=.", expecting that data->path to be
   '.' (the git-daemon use case).

 - Normalize entries of safe.directory and data->path and then
   compare them, turning path="." (the git-daemon use case) into
   "/srv/git/my-repo" and a safe.directory entry "/srv/git//my-repo"
   user wrote into "/srv/git/my-repo", so that they match.  

Or we could treat "." on safe.directory as a synonym for "*"
(i.e. "anything goes"), and compare all other cases only after
normalization (which would save the cost of "literal" comparison for
safe.directory entries that are not ".")?

I may have missed some corner cases, but either of these would
probably work.

>>   * For "http-backend" invocations, we should think about potential
>>     additions that would help users, similar to what I listed above
>>     for "git daemon".
>
> That sounds sensible.

OK.

>> Having said all that, I do not think I mind GIT_SAFE_DIRECTORIES
>> that is a ":" separated list of paths that is honored just like the
>> multi-valued configuration variable safe.directory.  Once an
>> attacker can influence your environment variables, it already is
>> game over, so trusting it does not make the attack surface any
>> worse.
>
> Indeed in that case the attacker can influence the path that we read
> the protected config from by setting $HOME (and do far worse by
> setting $PATH)
> ...
> Yes having to set all the GIT_CONFIG_* variables can be rather confusing

OK.  

So an independent effort may be to introduce the said environment
variable, and have it split at ':' and feed into the same machinery
used to check paths against safe.directory configuration.  It may
need a minor refactoring to lift the current comparison logic that
assumes it is _only_ driven by the git_config() callback, and we
would probably want to define how these two sources of whitelist
entries interact (who overrides what, is "an empty element clears
all the previous entries" still true, etc.).

So, I think we have three actionable items here.

Thanks.


