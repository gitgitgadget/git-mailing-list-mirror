Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4E147C77
	for <git@vger.kernel.org>; Thu, 16 May 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871398; cv=none; b=jeKsqb56jH0mY7IwAbwPxj3cPZXjkh8L+QlvZVp/07CpCHKS6g/NyCYcruQ7s66HuMsJbqXIUOnZJ8Ibgf5pyymkjQidS3iqSvG6LVGe57HZ8lLAfwUgAhYBl9gcLzWE36veKR92qrwUOk5rvfCohhTJbc5iBv08cVirjddHXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871398; c=relaxed/simple;
	bh=gMYT1tfVbLjYPjiGjeUA7CtRhNnClimLqpSHU5fM+7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPxxaZWXr0VRVm2O/DKGHMMPctlABhGQaoHHZVgC7S7+ZHHokc41bQTyaQ48ToCwwOeQAJONEBzPaczhfRTxV7PIykqHxZvx9OAxrWTrWtqpsZ3gx8JNOun2PsLoIqtAlnKu12i9KeBDPtYHoe7UG5ZT+wQ/8CZnlcF26OYjfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FzixotOY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FzixotOY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2193225D61;
	Thu, 16 May 2024 10:56:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gMYT1tfVbLjYPjiGjeUA7CtRhNnClimLqpSHU5
	fM+7k=; b=FzixotOYi0DKY323ZDrVtFvv2zusuYy8+K7VyIhYMBImxTmVt+AKeT
	kxqJ1+4emGnF/fsLyjfDUPzCOIKVUsHJMMKlIS5DdFP3J+iiK/YU61Xp2IQTH3Mc
	fhjJvI/JrZ0WCBQ4NVzBrut08V54LYIotdbJAvweiiNwENubqxTYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19A4D25D60;
	Thu, 16 May 2024 10:56:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 805B525D5F;
	Thu, 16 May 2024 10:56:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Brooke Kuhlmann <brooke@alchemists.io>,  git@vger.kernel.org
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
In-Reply-To: <5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de> (Johannes
	Schindelin's message of "Thu, 16 May 2024 14:13:57 +0200 (CEST)")
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
	<5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de>
Date: Thu, 16 May 2024 07:56:28 -0700
Message-ID: <xmqq4jaxvm8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A0B31A6-1394-11EF-A240-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I plan on sending out a patch series later either today or tomorrow to
> address a couple of regressions introduced by v2.45.1, and this patch
> would address your specific scenario:
>
> -- snip --
> diff --git a/config.c b/config.c
> index 85b37f2ee09..380f7777a6e 100644
> --- a/config.c
> +++ b/config.c
> @@ -1527,6 +1527,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>
>  	if (!strcmp(var, "core.hookspath")) {
>  		if (current_config_scope() == CONFIG_SCOPE_LOCAL &&
> +		    (!value || (*value && strcmp(value, "/dev/null"))) &&
>  		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
>  			die(_("active `core.hooksPath` found in the local "
>  			      "repository config:\n\t%s\nFor security "

This does not make much sense to me.  Why is /dev/null so special,
compared to say /etc/passwd?

I do think the defence-in-depth aspect of the other half of what
went into 2.45.1 and friends, around the "hooks" theme has merit,
i.e. "any activated hooks in the resulting $GIT_DIR/hooks/ directory
that is different from what came from the templates directory is
suspicious".  It has a plausible attack scenario to realize such a
suspicious configuration by using directory name munging and other
tricks to confuse "git clone" into thinking what the repository sent
as a part of its payload belongs to $GIT_DIR/.  It did have fallout
as the way "git lfs" mucked with user repository's metadata by
abusing the overly wide trust the user gave to its smudge filter [*]
crashed directly with the reasoning behind the "hooks must match
template" protection, which is "Until the clone finishes and gives
control back to the end user, external influence like hooks must not
muck with the contents checked out without user's knowledge and
consent before the user has a chance to inspect the resulting
repository".  And it is a reasonable expectation to have when
cloning a repository that has not proven to be trustworthy.  So
instead of throwing the protection with bathwater, we should add a
reasonable (i.e. easy to use for "git lfs" developers to follow)
escape hatch that is a bit more nuanced than "rip out the whole
protection" revert or "disable all of the GIT_CLONE_PROTECTION
mechanisms" escape hatch 2.45.1 and friends had.

But I cannot quite tell what the threat model this "core.hookspath"
one is trying to protect against.  If some attacker manages to muck
with the configuration file, it is already game over, and they have
better ways than pointing your hookspath to other places to take
advantage of their ability to write to your configuration file to
attack you.

So, my recommendation for this one is to just rip the whole new
logic added in 2.45.1 and friends out of the "core.hookspath"
handling.


[Footnote]

 * The user most likely consented only to allow the smudge filter to
   transform small token recorded in the object store into a large
   blob taken from elsewhere, which means it can read from the
   object store and write to the working tree, but the user may not
   necessarily agreed to give it full read/write/delete/create
   control over anything in $GIT_dir/ or in the configuration files.
