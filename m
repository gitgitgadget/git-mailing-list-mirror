Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD636D528
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248488; cv=none; b=A5mS4sAJhgpdS1N5JH598VvdoCVT8Yi8Eq3uXNqLVZFwEwJ3fjDcRDm06ys01elwwNQLiUrVEM69oZ+ldo3qS2g2a3TVJOdw0jZ540FH3/z2zfrxwNZ7gMZgo7sjpvwXWtR/jnk07UKXmZunXcsAjL2typJeuSDvYLzcqhEL1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248488; c=relaxed/simple;
	bh=IZjBTR5mKFiuaOQJFp9zygwIpvkgAUaWoHMjQbK/hH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VcPSpko8DgU2OMmNDNFpnpCHCv8kZXb8AjXwUoyxl92uPr/cFoIUWZvh59W/Pxn2pjwt5/bss0S6O0vJhPw8Ed+sMRv9uNpth7+15pdvvT1ZhbMeqoMAgIof8UEU2CZ7u/+rxCnKfKhWbt7WYQZ1EG6isAin11V0nV1NtOktn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FD8DF3fJ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FD8DF3fJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CAED375F8;
	Thu, 29 Feb 2024 18:14:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IZjBTR5mKFiuaOQJFp9zygwIpvkgAUaWoHMjQb
	K/hH8=; b=FD8DF3fJVTa66sIvqozRjFoM3J+XV9CAHIwFdrIVO+khjsRV1gpuCE
	7R3Sn2AibFdCJoSwn4rYt0BQy0bigarA25LFL7E2VJ54ih5/R2SceEurrxWp1ems
	VSjNeH776oILTYnz2kd+KowSsOZOno5Q4rrpIzP08rotlGyooI42M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54D91375F7;
	Thu, 29 Feb 2024 18:14:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E71C3375F6;
	Thu, 29 Feb 2024 18:14:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
    "Patrick Steinhardt" <ps@pks.im>,
    =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
    =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Eric Sunshine <sunshine@sunshineco.com>,  
    Aryan Gupta <garyan447@gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com> (Aryan
 Gupta via GitGitGadget's message of "Thu, 29 Feb 2024 21:57:11 +0000")
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
	<pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 29 Feb 2024 15:14:41 -0800
Message-ID: <xmqqle72c17i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 521AC526-D758-11EE-811F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aryan Gupta <garyan447@gmail.com>
>
> Modernize the formatting of the test script to align with current
> standards and improve its overall readability.

OK.

> diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
> index 837c8b7228b..2ceac06c9c2 100755
> --- a/t/t0010-racy-git.sh
> +++ b/t/t0010-racy-git.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='racy GIT'
> +test_description='racy git'

This does not look like updating formatting to the current standard,
or improving readability, though.

> -	test_expect_success \
> -	"Racy GIT trial #$trial part A" \
> -	'test "" != "$files"'
> +	test_expect_success "Racy git trial #$trial part A" '
> +		test "" != "$files"
> +	'
> ...
> -	test_expect_success \
> -	"Racy GIT trial #$trial part B" \
> -	'test "" != "$files"'
> -
> +	test_expect_success "Racy git trial #$trial part B" '
> +		test "" != "$files"
> +	'

These are not wrong per-se, but if we are updating, I wonder if we
want to get rid of statements outside the test_expect_success block,
not just the formatting of individual test_expect_success tests.

Looking at an iteration of the loop, the executable statements from
here ...

                rm -f .git/index
                echo frotz >infocom
                git update-index --add infocom
                echo xyzzy >infocom

                files=$(git diff-files -p)

... to here is what we would make part of one test, namely ...

                test_expect_success \
                "Racy GIT trial #$trial part A" \
                'test "" != "$files"'

... this one.  Then

                sleep 1

is a cricial delay to have before the next test, which we may want
to have outside to make it clear what is going on to readers.  But
the following parts ...

                echo xyzzy >cornerstone
                git update-index --add cornerstone

                files=$(git diff-files -p)

... up to here, we would make part of the next test ...

                test_expect_success \
                "Racy GIT trial #$trial part B" \
                'test "" != "$files"'

... in the modern style.

So, we may want to do it more like this, perhaps?

	test_expect_success "Racy GIT trial #$trial part A" '
		rm -f .git/index &&
		echo frotz >infocom &&
		git update-index --add infocom &&
		echo xyzzy >infocom &&

		files=$(git diff-files -p) &&
                test "" != "$files"
	'

	sleep 1

	test_expect_success "Racy GIT trial #$trial part B" '
		echo xyzzy >cornerstone &&
		git update-index --add cornerstone &&

		files=$(git diff-files -p) &&
		test "" != "$files"
	'

An added benefit of the more modern style to place as much as
possible to &&-chain in test_expect_success block is that we would
catch breakage in "git update-index" and other things used to set-up
the test as well.  With the original loop, breakages in things
outside the test_expect_success blocks will go unchecked.

