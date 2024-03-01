Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCA210FB
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316394; cv=none; b=X4T5LHRjWPatxlVAAkx+DCflL4kh30dhsk5aCpq1/uc0EYDbUsiESMYp6BGc5IaAdTVhOmKPvIeisLygAiM/wYB70CdLau4frAXCkU8vuZMLON5ZRBZuav388Zn/CjxgM8UnVdscVYvRri9iskz6lfwc35VNSESnDJ2itgFrCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316394; c=relaxed/simple;
	bh=UfpJ6o/rz2lhpTnQ4p39h7YD3u8sSc5P9J8qkjGC69I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xx/gNWvMyGB3NUEyH2bH90dgvzKF5JRZjbnnFI0WR1cNyFMaiU7jHk2lWYD4ZrU5QQ/GG4tvSSXxsEY0LlbExk/Cx6wdDxNCKTchS4+S59sYZ4HmbUSQ4nle5xQg7L9RSyQlXWu0POvBJrSiLXeaU/XhRaAMTT1pgiPiad6TkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BGrxNUM3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGrxNUM3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 771C41E12E;
	Fri,  1 Mar 2024 13:06:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UfpJ6o/rz2lhpTnQ4p39h7YD3u8sSc5P9J8qkj
	GC69I=; b=BGrxNUM38AynJF1PyDfC5RdCe2BJWcGxuJaBsZ58aPf2F9d6fevShR
	c4BGU5Ss5O9Nvasat0LfYJwjJy7Uk+pecSDmuFOfbb2Ed2BmapIEeUcdg34sxTb+
	oEEvcGf9iuzj2eOg/mDoJfV6bmdtFRkw4ownsEUng8ZvgLHp2uuHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FCFC1E12D;
	Fri,  1 Mar 2024 13:06:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83CDE1E12C;
	Fri,  1 Mar 2024 13:06:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: advise about ref syntax rules
In-Reply-To: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Fri, 1 Mar 2024 16:38:41 +0100")
References: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
Date: Fri, 01 Mar 2024 10:06:27 -0800
Message-ID: <xmqq1q8t7roc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D95E9C2-D7F6-11EE-A189-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Notes (series):
>     Hopefully I am using `advice.h` correctly here.

Let's see.

> -	if (strbuf_check_branch_ref(ref, name))
> -		die(_("'%s' is not a valid branch name"), name);
> +	if (strbuf_check_branch_ref(ref, name)) {
> +		error(_("'%s' is not a valid branch name"), name);
> +		advise(_("See `man git check-ref-format`"));
> +		exit(1);
> +	}

This will give the message with "hint:" prefix, which is a good
starting point.

The message is given unconditionally, without any way to turn it
off.  For those who ...

> git-branch(1) will error out if you give it a bad ref name. But the user
> might not understand why or what part of the name is illegal.

... do not understand why, it is helpful, but once they learned, it
is one extra line of unwanted text.  If you want to give it a way to
squelch, see the comment before where enum advice_type is declared
in advice.h header file.  The callsites would become something like

	advise_if_enabled(ADVICE_VALID_REF_NAME,
		_("See `man git check-ref-format` for valid refname syntax."));

Another thing is that rewriting die() into error() + advice() +
manual exit() is an anti-pattern these days.

	int code = die_message(_("'%s' is not a valid branch name"), name);
	advice_if_enabled(...); /* see above */
	exit(code);

In the same source file, you will find an existing example to mimic.

Thanks.
