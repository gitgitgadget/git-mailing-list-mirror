Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A538A48
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769866; cv=none; b=mbWn3Ao+fcY0COnCGDGBsyZ3LVNMq60Q1PwR5ziVeuzVUKCieHSSFXJJ7DOj8Rl3wHWPEB+4+AqkFmrG68C5WNbSqwGfXDxIK3YMz9UUVwz2F1d3EcGR7PLVJNAkcCyaUejNwRoXMgENxxHoZ02ggMvlAgTzshI0GunsNkLp8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769866; c=relaxed/simple;
	bh=5RmNZ58b6XPEmw6tqZar7wQu3PIMaFk6hrj+nrWHSkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1V7ddSC10fjhPJ5KpSWqT9pJkKrinjiu55wRJz2eXC8GCwoVGLgZFTIbWjNhSWVO6JaHmx7eU5BWmaFmZp623QRwHf6dB1saDb3GcbzljXGJPOA/lcxHhlaC8m6Uoc4XO1d67nDov2HWA5g02Bs9SfnUODkCtzyfnHonT4H7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+3rFKaN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+3rFKaN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D131F4877;
	Mon, 12 Feb 2024 15:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5RmNZ58b6XPEmw6tqZar7wQu3PIMaFk6hrj+nr
	WHSkg=; b=E+3rFKaNSAgYipvMrEdXFqwfknVgSjjw0yxlsDU88y5IxmohqpChzy
	uxgZ+u/Y+JFFCvjW2MYtG0PBqvNi4/rTHl0p4Ig+BA2ml5owE+UePuODbzr2qF8o
	sX2a0yKboBPDs+pSjeg6rSjoD9gu6x51Msw58JJxrx/yqxsqF6Yp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 174C41F4876;
	Mon, 12 Feb 2024 15:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 190571F4875;
	Mon, 12 Feb 2024 15:31:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] t9146: replace test -d/-e/-f with appropriate
 test_path_is_* function
In-Reply-To: <pull.1661.v2.git.1707765433663.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Mon, 12 Feb 2024 19:17:13
	+0000")
References: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
	<pull.1661.v2.git.1707765433663.gitgitgadget@gmail.com>
Date: Mon, 12 Feb 2024 12:31:00 -0800
Message-ID: <xmqq7cj95ssb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A366D9D6-C9E5-11EE-A602-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> The helper functions test_path_is_* provide better debugging
> information than test -d/-e/-f.

Correct.

> Replace "if ! test -d then <error message>" with "test_path_exists"
> and "test -d" with "test_path_is_dir" at places where we check for
> existent directories.

The former could result in misconversion, if the intention of the
test was "we cannot have directory here; a regular file is OK", so
we have to be a bit more careful than mechanical conversion.

> Replace "test -f" with "test_path_is_file" at places where we check
> for existent files.

OK.

> Replace "test ! -e" with "test_path_is_missing" where we check for
> non-existent directories.

OK.

>  		for i in a b c d d/e d/e/f "weird file name"
>  		do
> -			if ! test -d "$i"
> -			then
> -				echo >&2 "$i does not exist" &&
> -				exit 1
> -			fi
> +			test_path_exists "$i" || exit 1

We were saying that we are OK if "$i" existed as a file (not a
directory), but now we complain regardless of what "$i" is.  Is that
closer to what the test originally wanted to do?  Just checking.

>  		done
>  	)
>  '
> @@ -37,11 +33,7 @@ test_expect_success 'option automkdirs set to false' '
>  		git svn fetch &&
>  		for i in a b c d d/e d/e/f "weird file name"
>  		do
> -			if test -d "$i"
> -			then
> -				echo >&2 "$i exists" &&
> -				exit 1
> -			fi
> +			test_path_is_missing "$i" || exit 1

Ditto; are we sure the intention of the original is that nothing
should be at "$i" (instead of "as long as it is not a directory,
we are OK")?  Just checking.

The same comment applies to all conversions to test_path_exists and
test_path_is_missing where the original was not "test -e" or "! test -e".
The other ones, like the change from "test -f" to "test_path_is_file",
looked all correct.

Thanks.


