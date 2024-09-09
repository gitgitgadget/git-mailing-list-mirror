Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850D3CF51
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913604; cv=none; b=fEk+4EcdgJ3UrD33RZwf+qaFuLu5FQ5DiF6hBtk/YSc5R6Uz1ju7GlroVwWWT+TJIdV+VoDWqpy2PmaBSH3rR0moTXZEsCLPICNAKRg06YDCDZlkyX28EY2f6QOu3A+TV3w4fx6B9GiTt5GMRbvyEOWSWg8OkmBnIGDpJA8KL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913604; c=relaxed/simple;
	bh=3bbt1eHb2LQq35bSyTwbJSLF3ZYJp6r6vvxyDwfR01Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+FyDWS4zV3UyZc2qGePu0Vlg+5OEtD0Yw7lQxAWSODatYFzVr9pMM30eES/hTYUO67HVLnc1+cLwxDiTQTeU8IGDKZQToO45w6sgdIXaASJ0eRo8JZQ/UtR3nVM3pzbGkHjPOQhdRuvMUNct0vvH/+V+oWPIiYpB0NECXd/0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tdZ3SiOK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tdZ3SiOK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E89322E44;
	Mon,  9 Sep 2024 16:26:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3bbt1eHb2LQq35bSyTwbJSLF3ZYJp6r6vvxyDw
	fR01Q=; b=tdZ3SiOKO5hmhHlyvD20towHV3V8M0yxT3ei32Es1PtjgZvKUjG68A
	49gYO0gg2BIN6NHRLX0XT9oOOvEMJX+nKxcBGH2CM2WpUIqWw67LG4xpFLiqH5pF
	WYX5gxlxJGfjGeFIOgHHFpii/YedQfwf+ZG40iH4ROEa0gVIi9Etk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 069C022E43;
	Mon,  9 Sep 2024 16:26:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6281922E42;
	Mon,  9 Sep 2024 16:26:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Okke Timm'" <okke@timm.sh>,  <git@vger.kernel.org>
Subject: Re: [bug?] git diff --cached in a non-git directory
In-Reply-To: <xmqqy140pt67.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Sep 2024 11:40:16 -0700")
References: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
	<05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
	<xmqqy140pt67.fsf@gitster.g>
Date: Mon, 09 Sep 2024 13:26:40 -0700
Message-ID: <xmqqikv4po8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2C2F3F0-6EE9-11EF-B097-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> <rsbecker@nexbridge.com> writes:
>
>>>error: unknown option `cached'
>>>usage: git diff --no-index [<options>] <path> <path> [...]
>> ...
>> Because you are not in a git repository clone, the --cached option has no
>> meaning.
>
> Yes.  "git diff" unfortunately has a mode where a limited subset of
> its features is available and that is called the "--no-index" mode.
>
> Because the command is capable of working outside a repository, "You
> are not in a repository" is a not a good error message in this
> situation, either.  It is not that you stepped outside a repository
> that is your error.  It is not that you used "--cached" that is your
> error, either.  You used "--cached" outside a repository, that is
> where your error is.
>
> A patch to improve the error messages in such a situation is
> certainly welcome.

Having said that, there is already a warning() close by.

	argc = parse_options(argc, argv, revs->prefix, options,
			     diff_no_index_usage, 0);
	if (argc != 2) {
		if (implicit_no_index)
			warning(_("Not a git repository. Use --no-index to "
				  "compare two paths outside a working tree"));
		usage_with_options(diff_no_index_usage, options);
	}

and this gives

$ cd / && git diff foo 2>&1 | grep -e error: -e fatal: -e warning:
warning: Not a git repository. Use --no-index to compare two paths outside a working tree

a relevant warning.

But this is a bit too short to be effective for all failure modes.
parse_options() would die if it sees an invalid option.  For that,
I suspect that we'd need to pass the usage string conditionally,
i.e.

    argc = parse_options(argc, argv, revs->prefix, options,
			 implicit_no_index 
			 ? diff_no_index_usage_with_non_repo_warning
			 : diff_no_index_usage, 0);

with

    static const char * const diff_no_index_usage_with_non_repo_warning[] = {
            N_("git diff --no-index [<options>] <path> <path>"),
            N_("Not in a git repository; some options may not make sense"),
            NULL,
    };

near where diff_no_index_usage[] is defined, or something silly like
that.

