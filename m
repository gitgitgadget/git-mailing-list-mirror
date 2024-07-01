Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516416D9D8
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855165; cv=none; b=dMmb1Kh8/YbwupXrA3bKKg5t5MS0YaLL5gcHkZmL2s6A9C43Kyb4/5PAHpZFB8mdc6mQ5Q/iL7GsActMlQ6Ay3s9Uo2qe4H4uHuOodZzm3wH4cuv44k2FCobNCdzeqmjnigGgySLzSxLRiFJwZroQNEUg7Q1DKl/K1Vhv4B964U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855165; c=relaxed/simple;
	bh=Rz1g7wH+YTmMpaal1GLyEXBrateSjRce9OmkahEKdRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SW1bL4qwf4QU+FL04uvxwju/CeyNyti/WWAmXel1IlV+QNK6kPngxN19lRYBzfzHp9f6B6YcPqR+Y3jQgzEctpxgriIcroZl7z77YIf6qmAXG84+AP5ZuY2eiig77nKzKsPG27345hHKAG2btUJSYN8Jha8xazNJvzJPR7KNKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KEwtHavZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEwtHavZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A08C2A9EA;
	Mon,  1 Jul 2024 13:32:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Rz1g7wH+YTmMpaal1GLyEXBrateSjRce9Omkah
	EKdRc=; b=KEwtHavZ5q9jeABKRXkyNXNl9h6kbx4LT9mN/MXcYOGfpFeh/doUH+
	IrfIp+l22ALKsGNGhM8H/Ze2OsLXZhjX8V0kxkdrx0OvuHDP7LrtJjzKryWAHlXC
	sMA17ZdJlq/4tri9O4Nf+UtKdYZ//wscD+iCu/UBBELBmdTJqqlxg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4235D2A9E9;
	Mon,  1 Jul 2024 13:32:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A84BE2A9E8;
	Mon,  1 Jul 2024 13:32:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Florian Schmaus <flo@geekplace.eu>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.com> (Phillip Wood's
	message of "Mon, 1 Jul 2024 16:24:00 +0100")
References: <20240626123358.420292-1-flo@geekplace.eu>
	<20240626123358.420292-2-flo@geekplace.eu>
	<9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
	<72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
	<xmqqa5j71snb.fsf@gitster.g>
	<5742e728-a012-4960-a32d-bf3b65c3a2e3@gmail.com>
	<xmqqpls2v1zx.fsf@gitster.g>
	<27cadffb-ca3f-487d-86b7-3508c45c446d@gmail.com>
	<xmqq7ce96mix.fsf@gitster.g>
	<6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.com>
Date: Mon, 01 Jul 2024 10:32:40 -0700
Message-ID: <xmqqtth9xbk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB4A86B4-37CF-11EF-B6E1-965B910A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   - Compare entries of safe.directory with data->path literally
>>     without normalization, as the user may have written in the
>>     configuration "safe.directory=.", expecting that data->path to be
>>     '.' (the git-daemon use case).
>
> I'm not sure this is a good idea because it is not clear which
> directory the user wanted to mark as safe when they added a relative
> directory to safe.directory. In the case of git-daemon one needs both
> the absolute path to the repository and "." to be present in
> safe.directory so we can ignore "." and match the absolute path.

IOW, we do not bend over backwards to try to be backward compatible
on this point?  I can go with that, especially because it smells
like (I haven't thought deeply about it yet, though) that approach
can simplify the checks.

>>   - Normalize entries of safe.directory and data->path and then
>>     compare them, turning path="." (the git-daemon use case) into
>>     "/srv/git/my-repo" and a safe.directory entry "/srv/git//my-repo"
>>     user wrote into "/srv/git/my-repo", so that they match.
>
> We have several of normalization functions available:
>
>  - normalize_path_copy() does a textual normalization which cleans up
>    "//", "/./" and "/../".
>
>  - absolute_pathdup() which prepends the current directory to relative
>    paths attempting to use $PWD for the current directory where possible
>    but does not expand symbolic links and does not clean up the path
>    passed to it.
>
>  - real_pathdup() which expands symbolic links
>
> One way forward would be to clean up the entries in safe.directory
> with normalize_path_copy() and compare them to the result of
> normalizing $git_dir with absolute_pathdup() followed by
> normalize_path_copy(). That will ensure that we're always comparing
> the safe.directory entries against an absolute path and both sides of
> the comparison are textually normalized. I'm not sure whether we'd be
> better to use absolute_pathdup() or real_pathdup() or if we'd be safer
> comparing the output of both against safe.directory if they give
> different results. If this sounds reasonable I'll try and put a patch
> together later this week.

Hmph.  Are runtime-detected (not from $GIT_DIR environment and
friends) gitdir and/or worktree paths always relative?  If we let
getcwd() involved in the process of turning them absolute, these
paths may already have symbolic links "expanded", so we have no
choice other than expanding symbolic links before using paths in
safe.directory to compare with them.

For example, the paths from safe.directory come from the end-user,
and may say things like "/home/phillip/repos/*", because phillip and
everybody else on the system think /home/$USER should be where their
home directories ought to be, but that was based on the niceness of
sysadmins to arrange "/home/phillip" to be a symbolic link to
"/home1/phillip" because the "/home" partition has already run out
of space to add more users.  When gitdir and/or worktree paths are
computed using getcwd(), they would be paths somewhere under the
"/home1/phillip/repos/" directory.  Letting real_pathdup() to deal
with the symbolic links may be the only usable way in such a set-up
available for us.

But we will of course make tons more synonymous paths by using
real_pathdup() to normalize both the safe.directory entries and the
gitdir and/or worktree paths---are there security downsides in doing
so?
