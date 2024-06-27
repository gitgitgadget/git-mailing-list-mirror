Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B519939A
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502124; cv=none; b=rsnH057BX+/cvsQ3Tq3PhTA0Mpk2yDjL8QN1+kg0xeWlz9jOLTixowC3b6cDVSSyesxBq7zlA1K6SC0GAMxBbzo6f2g87wrlp/UY6wQrf4rHg6IYO5xW49t9bJ3DhX1Y2CxFZkPs+a7LA34DiDKTKZaNswz9Bkvy8VmZPYIdVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502124; c=relaxed/simple;
	bh=ZAdI1F9R68DZyC5fSs193vPKTh6yvL+0pjj5OgfNRS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oVfLetelUoXtC+WdqzjqlixVE7w0s6/2gA6OAjydItO38RpM9a4EB57wjjOHj1hCmZeq+b4XL5x7ZYZyT3RZylX6uIgMsN/Kdm/zfzLDOXLvjEpBddqQSoDW9t+s3oKVzI044baWEDYizpXyhJo5nNWGhpnVM7+d8ANSdPa3c04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DfrED5G2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DfrED5G2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63C1E37B85;
	Thu, 27 Jun 2024 11:28:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZAdI1F9R68DZyC5fSs193vPKTh6yvL+0pjj5Og
	fNRS4=; b=DfrED5G2ri4dcYH9aKXsfbdqvCZdeQM1x4NyrLzO8jD0Mjy1BoNnbF
	/vBUExqO9m4Z4m18/En2HI2w9L5vDIz2Gr5EaVZU6c3YdXokyiBznSL2Cf2K2+Jq
	fD8ISU9EddlUWA+ZxWdizVeKw/a7uzgwuDlHR+hvTbTmGmIdnF10Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ACB537B84;
	Thu, 27 Jun 2024 11:28:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8044737B82;
	Thu, 27 Jun 2024 11:28:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Florian Schmaus <flo@geekplace.eu>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com> (Phillip Wood's
	message of "Thu, 27 Jun 2024 10:50:36 +0100")
References: <20240626123358.420292-1-flo@geekplace.eu>
	<20240626123358.420292-2-flo@geekplace.eu>
	<9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
	<72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
	<xmqqa5j71snb.fsf@gitster.g>
	<5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com>
Date: Thu, 27 Jun 2024 08:28:34 -0700
Message-ID: <xmqqpls2v1zx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB60D010-3499-11EF-8BC3-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/06/2024 19:11, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> To expand an this a little - a couple of times I've wanted to checkout
>>> a bare repository that is owned by a different user. It is a pain to
>>> have to add a new config setting just for a one-off checkout. Being
>>> able to adjust the config on the command line would be very useful in
>>> that case.
>> True.  As long as it is deemed safe to honor the one-off "git -c
>> safe.directory=..." from the command line, for the purpose of this
>> "I who am running this 'git' process hereby declare that I trust
>> this and that repository", I think it would be the best solution
>> for the "git daemon" use case.
>
> This actually works already, the behavior was changed in 6061601d9f
> (safe.directory: use git_protected_config(), 2022-07-14). The reason I
> thought it didn't work was that I remember it failing on Debian
> bullseye a few months ago but that used an older version of git. There
> is some more rationale for the change in 779ea9303a7 (Documentation:
> define protected configuration, 2022-07-14)

Thanks.

So, does this more or less conclude the episode about how best to
deal with the 2.45.1 regression that Florian's patch in this thread
started?  It seems that we already have enough mechanisms to help
users tweak their existing set-up, so we may not need code changes,
but I am wondering if we want to add a bit of documentation around
safe.directory to tell them when it makes sense to set it, what
value(s) they would want to set it to, etc.

 * For "git daemon" invocations, because we know the command is run
   after chdir to a directory with '.' specified as the repository,
   we recommend to have safe.directory=., either on the command line
   with "-c var=val" or in daemon user's ~/.gitconfig, in the
   "git-daemon" help page?  We could recommend safe.directory=*, but
   they would mean the same thing in the context of running "git
   daemon".

   We may want to discuss who protects from whom with the
   safe.directory mechanism and git-daemon-export-ok mechanism.  The
   former is "the daemon trusts that repositories won't harm the
   daemon user", while the latter is "the repository owner is OK for
   it to be published".

   Also optionally, we may update the code to take the absolute path
   of the repository before passing it to the safe.directory check.

 * For "http-backend" invocations, we should think about potential
   additions that would help users, similar to what I listed above
   for "git daemon".

Having said all that, I do not think I mind GIT_SAFE_DIRECTORIES
that is a ":" separated list of paths that is honored just like the
multi-valued configuration variable safe.directory.  Once an
attacker can influence your environment variables, it already is
game over, so trusting it does not make the attack surface any
worse.  As Peff explained, we can trigger the more general "git -c
var=val" mechanism by exporting a set of environment variables, so
such a specialized environment variable is not strictly needed, but
it would make writing the "SetEnv" directive in apache configuration
(and similar ones for other HTTP server implementations) slighly
simpler and a lot more straight-forward.


