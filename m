Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55B19AD92
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240832; cv=none; b=iRrErk8uqDzXFXfWp1Gawi/hLIzFQbzNM7ZTRbj0gXfwbwnavxZd9O3Rg4wax+GslAySyEyteeJB+CdWCxwHO1BgTHXwWqTcNuFaatwyFKVQyTbcIBOX5JaTUWHG1qZbfHh7yMRgGfZfOW5LHlMUr9cxag/EBhCrgjNT/j7xVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240832; c=relaxed/simple;
	bh=Po6+giXssWyIHjqaSmsFzxsS5ZPdw57PbRDfl5W8SOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNXaieUK4gGy/jutNhpaQs3VF6siOg6lpqfFGd5c27OE7Qc2240VcL1NV95YZrpNJcv+jsJISVykrIN8Khgl6rn30vbK1/xPLwVYV2BnZXJ2cOBye13gghoVrFBQP0/4yrs0xw2g5L7JjP/JcvnUcPPHBZTSPwku1HJAiuPYIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oAP9ndO5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oAP9ndO5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 241651D7B8;
	Mon, 24 Jun 2024 10:53:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Po6+giXssWyIHjqaSmsFzxsS5ZPdw57PbRDfl5
	W8SOw=; b=oAP9ndO54kgzfBLcyQFFMo79HDYlPWqaKAwVCDGoZktSdVrHH8QOek
	AaI21TOz1NOOPnBYmI0ogjlW/ZNC16uYZFDz0NSaPQNOLDwFdnjBrEqTiwojcJqR
	XG/aiIcvO6y1IZ29LJXcw2/eMYP8xfN6i8tkFLYE3d+WoOCdDACGI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AD0B1D7B7;
	Mon, 24 Jun 2024 10:53:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 793FD1D7B6;
	Mon, 24 Jun 2024 10:53:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "David C. Rankin" <drankinatty@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <d5ff3629-ef8c-472b-886a-3ec0dd6a2c9a@gmail.com> (David
	C. Rankin's message of "Mon, 17 Jun 2024 20:08:07 -0500")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
	<xmqq8qz376fb.fsf@gitster.g>
	<d5ff3629-ef8c-472b-886a-3ec0dd6a2c9a@gmail.com>
Date: Mon, 24 Jun 2024 07:53:42 -0700
Message-ID: <xmqqo77qgznt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D31B908-3239-11EF-847E-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"David C. Rankin" <drankinatty@gmail.com> writes:

>   I read the error from the server log and then attempted to add the
>   suggested config to ~/.gitconfig, e.g.:
>
> [safe]
> 	directory = /srv/git/embedded.git
> ...
> drwxr-xr-x  7 david david 4096 Jun 15 02:42 embedded.git

You say ~/.gitconfig here.  Whose home directory does "~" refer to?

The primary reason I wrote the message you are responding to was to
find this piece of information out (and tell you that it would be
different from the repository owner's), and I am still not sure if I
extracted that piece of information out of you, after reading the
message I am responding to twice.

In short, the above has to be in ~http/.gitconfig (if 'http' is the
user Apache runs as).  Listing it in ~david/.gitconfig would not
work.  It has to come from the user who runs Git in a directory the
user does not own (in this case, that is the 'http' user.  That user
runs, via the CGI interface, the server side Git programs to respond
to pushes and fetches, serving a repository not owned by 'http'),

The mechanism is about protecting the user that runs Git (i.e.
'http' in the context of "git push/fetch is responded by the Apache
web server via the CGI mechanism spawning 'git http-backend'") from
potentially malicious repositories owned by users that are *not*
'http' (i.e. /srv/git/embedded.git that is owned by david:david in
this case), as such repositories can contain hooks and other
configuration settings that would end up running programs as 'http'
user with 'http' user's priviledge, potentially writing into files
owned by 'http' user to attack 'http' user.

Hence, the "I am OK to run Git as myself in these repositories, even
though they are not owned by me" acceptance, which is an snippet in
gitconfig file you showed above, has to come from the 'http' user,
and certainly not from the 'david' user.  The configuration is about
protecting 'http' from 'david' and not about protecting 'david' from
'http', so configuration files in 'david' user's home directory
should have no say in who 'http' user is willing to trust.

So, back to the original question.  You said ~/.gitconfig/ has the
safe.directory settings.  Whose ~/.gitconfig/?

I would have expected that the only thing you'd need to do is to let
your 'http' user tell Git that it does not want the paranoid safety
more recent versions of Git offers with the safe.directory setting
in ~http/.gitconfig, and have repositories owned by individual users
that come over ssh as they themselves.  For those who are accessing
their own repositories over ssh as themselves, everything should
work just as before.
