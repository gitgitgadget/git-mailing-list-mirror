Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946716FF21
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242675; cv=none; b=auYRAldxSkgOvupmjW5iUF/X8DAgQijStB3v4Sk9qWeAWLKl+nOrpYqREsR9zmo75YEVWcU0qgzUogkLQmvIP9o9ySwGkOjl7g0dAx2A7dD3gw326o+dbhPRSfXxpGVZu+HaaEmxLvP1Wlk66Nws1xVwNDoj08pTltk89eAvPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242675; c=relaxed/simple;
	bh=lXoV+9/Jv9FnHQ4qGbTlU0IbhIiSMPfSbzLnlvN48a0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQGJOfbRO0lUZwGyoUV64P/VkSNC4Cau0OGGwiAr4K1P84fvTHTW50mzMguKhdvGJMvcWNhv237Vs2CRvG+z6df4WVk1zv3StOoZNYp96GW8e4vSlm9fFjwZRpK+508Ojz92AY22h9s1cbcSQPwTFaYYOI08m28ndetjRf439vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ay0qD7iP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ay0qD7iP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 061B936C18;
	Thu, 29 Feb 2024 16:37:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lXoV+9/Jv9FnHQ4qGbTlU0IbhIiSMPfSbzLnlv
	N48a0=; b=ay0qD7iPwR4Cpb/2kd+6WU8Q60EdboLWGb2nxy9+SOHjTBhAyU3+pQ
	0gcu/wZNj8svaFgvJquhdXU514MGCSotrlmmEfYUmWjtu7YAez9tZMEK8mfdKwE4
	K4XeeKoxNZcTe3Zs4ze+Hz3trFUar66iGblR+jZDWwOufvGiaWYRM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F345036C17;
	Thu, 29 Feb 2024 16:37:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2BEB36C16;
	Thu, 29 Feb 2024 16:37:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git list <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation/user-manual.txt: example for
 generating object hashes
In-Reply-To: <a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
	(Dirk Gouders's message of "Thu, 29 Feb 2024 14:05:07 +0100")
References: <cover.1709240261.git.dirk@gouders.net>
	<a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
Date: Thu, 29 Feb 2024 13:37:46 -0800
Message-ID: <xmqqil27c5p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C800F426-D74A-11EE-AAD2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> If someone spends the time to work through the documentation, the
> subject "hashes" can lead to contradictions:
>
> The README of the initial commit states hashes are generated from
> compressed data (which changed very soon), whereas
> Documentation/user-manual.txt says they are generated from original
> data.
>
> Don't give doubts a chance: clarify this and present a simple example
> on how object hashes can be generated manually.

I'd rather not to waste readers' attention to historical wart.

> @@ -4095,6 +4095,39 @@ that is used to name the object is the hash of the original data
>  plus this header, so `sha1sum` 'file' does not match the object name
>  for 'file'.

The paragraph above (part of it is hidden before the hunk) clearly
states what the naming rules are.  We hash the original and then
compress.  If I use an implementation of Git that drives the zlib at
compression level 1, and if you clone from my repository with
another implementation of Git whose zlib is driven at compression
level 9, our .git/objects/01/2345...90 files may not be identical,
but when uncompressed they should store the same contents, so "hash
then compress" is the only sensible choice that is not affected by
the compression to give stable names to objects.

> +Starting with the initial commit, hashing was done on the compressed
> +data and the file README of that commit explicitely states this:
> +
> +"The SHA1 hash is always the hash of the _compressed_ object, not the
> +original one."
> +
> +This changed soon after that with commit
> +d98b46f8d9a3 (Do SHA1 hash _before_ compression.).  Unfortunately, the
> +commit message doesn't provide the detailed reasoning.

These three are about Git development history, which by itself may
be of interest for some people, but the main target audience of the
user-manual is probably different from them.  They may be interested
to learn how Git works, but it is only to feel that they understand
how the "magic" things Git does, like "a cryptographic hash of
contents is enough to uniquely identify the contents being tracked",
works well to trust their precious contents [*].

    Side note: 
    https://lore.kernel.org/git/Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org/
    explains the reason behind the change to those who did not find
    it obvious.

FYI, another "breaking" change we did earlier in the history of the
project was to update the sort order of paths in tree objects.  We
do not need to confuse readers by talking about the original and
updated sort order.  The only thing they need, when they want to get
the feeling that they understand how things work, is the description
of how things work in the version of Git they have ready access to.
Historical mistakes we made, corrections we made and why, are
certainly of interest but not for the target audience of this
document.

On the other hand, ...

> +The following is a short example that demonstrates how hashes can be
> +generated manually:
> +
> +Let's asume a small text file with the content "Hello git.\n"
> +-------------------------------------------------
> +$ cat > hello.txt <<EOF
> +Hello git.
> +EOF
> +-------------------------------------------------
> +
> +We can now manually generate the hash `git` would use for this file:
> +
> +- The object we want the hash for is of type "blob" and its size is
> +  11 bytes.
> +
> +- Prepend the object header to the file content and feed this to
> +  sha1sum(1):
> +
> +-------------------------------------------------
> +$ printf "blob 11\0" | cat - hello.txt | sha1sum
> +7217614ba6e5f4e7db2edaa2cdf5fb5ee4358b57 .
> +-------------------------------------------------
> +

... something like the above (modulo coding style) would be a useful
addition to help those who want to convince themselves they
understand how (some parts of) Git works under the hood, and I think
it would be a welcome addition to some subset of such readers (the
rest of the world may feel it is way too much detail, though).

I would draw the line between this one and a similar description and
demonstration of historical mistakes, which is not as relevant as
how things work in the current system.  In other words, to me, it is
OK to dig a bit deep to show how the current scheme works but it is
way too much to do the same for versions of the system that do not
exist anymore.

But others may draw the line differently and consider even the above
a bit too much detail, which is a position I would also accept.

Thanks.
