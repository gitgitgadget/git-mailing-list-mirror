Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970D12E4F
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224433; cv=none; b=Wme7WMUW16FhTcHqF1v7d5jYEERWGPDVv31lUcP2nP8cgaCq479MqbeaRYHbt8D2HFI79HE7x0ZZrcpjXEZGey/cHwqd7YZb5CBhJopfXxv0bX1t69AkPdS6BDJMll6acuydW3U84HS5kN7o1lajVa/WYPDcjALl4ADF7qerjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224433; c=relaxed/simple;
	bh=sktM5xkKN62N59nLA3GktOh9n2qAzj6cg8oI3xl0Nf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mjb52/zyw+UewA8g9WkhUS4OymlpSTDlM25ze54xqmPGtkZXj+u0E/8P1UJmXwwdW5zvgZePK46R3Xpk7xiyQ0p8WaHrO2q9B5pSNafH3h8L0I6AXEOa/xvd18aqj8yfrxFLVq3v4osoLErkLpGBfEbuFIY8ggxVEXotU/UO0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jxGj8MGX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jxGj8MGX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 221951C12C7;
	Thu, 25 Jan 2024 18:13:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sktM5xkKN62N59nLA3GktOh9n2qAzj6cg8oI3x
	l0Nf8=; b=jxGj8MGXHHsYnZBzzK858q6EgoJn6iYKWInH1CJqxzT2PcJvwi0mbM
	144JmWxL3SQkQv6VrqN3N7iSFNMPONr+tDNeEQWt2DhsUlAPHiVNM+5OzD2NYZgC
	8PFN/hBhRR9u5EAkpP5KHjbwG9e0qtgd5MiPLvJfTlYcJF8rV03EI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18E361C12C5;
	Thu, 25 Jan 2024 18:13:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 611CA1C12C4;
	Thu, 25 Jan 2024 18:13:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
In-Reply-To: <074e0c7ab923777c66516ced18b4fd1dadf7677f.1706215884.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 25 Jan 2024 20:51:24
	+0000")
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<074e0c7ab923777c66516ced18b4fd1dadf7677f.1706215884.git.gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 15:13:48 -0800
Message-ID: <xmqqplxpropf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65BA3162-BBD7-11EE-8C2A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> git-index-pack has a --strict mode that can take an optional argument to

"mode" -> "option", probably.

> provide a list of fsck issues to change their severity. --fsck-objects
> does not have such a utility, which would be useful if one would like to
> be more lenient or strict on data integrity in a repository.
>
> Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
> change the severity.

"Allow" -> "allow".

> This commit also removes the "For internal use only" note for
> --fsck-objects, and documents the option. This won't often be used by
> the normal end user, but it turns out it is useful for Git forges like
> GitLab.

"This commit also removes", "documents" -> "Remove", "document".

> ---fsck-objects::
> -	For internal use only.
> +--fsck-objects[=<msg-ids>]::
> +	Instructs index-pack to check for broken objects instead of broken
> +	links. If `<msg-ids>` is passed, it should be  a comma-separated list of

Very much pleased to see an additional description that is written
to clarify the difference between this option and the other --strict
option.  The original was totally unclear on this point, and it is
very much appreciated.

The other option notices and dies upon seeing either a broken object
or a dangling link.  This one only diagnoses broken objects and does
not care if the objects are connected.  However, saying "instead of"
here tempts readers to mistakenly think that the other one only
checks links and this one only checks contents, which is not what we
want to say.  Perhaps "to check for broken objects, but unlike
`--strict`, do not choke on broken links" or something?

Same comment on <msg-ids> as the previous step.

> +	`<msg-id>=<severity>` where `<msg-id>` and `<severity>` are used to
> +	change the severity of `fsck` errors, eg: `--strict="missingEmail=ignore,badTagName=ignore"`.

Same comment for "eg:" as before.

> @@ -1785,8 +1785,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
>  				strict = 1;
>  				check_self_contained_and_connected = 1;
> -			} else if (!strcmp(arg, "--fsck-objects")) {
> +			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
>  				do_fsck_object = 1;
> +				fsck_set_msg_types(&fsck_options, arg);
>  			} else if (!strcmp(arg, "--verify")) {
>  				verify = 1;
>  			} else if (!strcmp(arg, "--verify-stat")) {

The implementation of this part looks quite obvious, once you see
how "--strict[=<msgid>=<level>]" is implemented.

Looking good.

Thanks.
