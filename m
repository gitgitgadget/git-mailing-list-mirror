Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B96168D0
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775094; cv=none; b=KdpFIERJSO0PuVIsuZ0WFuJwkaiXO3lgaKqHaFGjLZtgh/cI49OHZ31IgFUqy93LEu91Z6B5tgSjokZdjprrD7YSpU5QwIzhV+34JTjwOCCDUX6TJVagG+Q2k9iwZszWo1OwYQlHdHV3E/Qc/flP8askvbwVLuh2A5n33bYwfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775094; c=relaxed/simple;
	bh=Q+JLdnqYbXs4VdnHvAN35ySMew+ROr6vrblMoAXCMTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBMH/HkMDqeqTHo8TQnd+3tBBaN25WpQ0FIoNFsVHGD1p44s+DLZfYWuUSRdDSNVdz/3zT6pribMICd3jnqzWVpi84//gT5MUVcrXcvLEhquk9gpd1CpCp/mdqes/M63rUyDSsj26DKHuInr3ybJDJxNsm8JdhhgeP0TTryhA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ex7+E2xl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ex7+E2xl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0FBF1EE9E0;
	Wed, 10 Apr 2024 14:51:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q+JLdnqYbXs4VdnHvAN35ySMew+ROr6vrblMoA
	XCMTs=; b=Ex7+E2xlhcUc9COolD5jgkTtjMEXoc52gJpbJcbp5BquF+xqZYLqNZ
	A0aBAIwnc8V2F02N0LbRQYjbALELqCI+l77qkV2As4N/N70UUuZCmGAQU9fqTz9h
	BC1Q+buKxrOA4y0UHx+Mn6PpCtuQDKAxvZ2urXzJj8RIPMyM86QqM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7F0D1EE9DF;
	Wed, 10 Apr 2024 14:51:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 602D61EE9DE;
	Wed, 10 Apr 2024 14:51:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 7/8] fast-import: forbid escaped NUL in paths
In-Reply-To: <dc67464b6aec46c5b6ac0d9cb8549d48a35c5353.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:56:11 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<dc67464b6aec46c5b6ac0d9cb8549d48a35c5353.1712741871.git.thalia@archibald.dev>
Date: Wed, 10 Apr 2024 11:51:30 -0700
Message-ID: <xmqqwmp5rqz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 588A6D16-F76B-11EE-95D1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> NUL cannot appear in paths. Even disregarding filesystem path
> limitations, the tree object format delimits with NUL, so such a path
> cannot be encoded by Git.
>
> When a quoted path is unquoted, it could possibly contain NUL from
> "\000". Forbid it so it isn't truncated.
>
> fast-import still has other issues with NUL, but those will be addressed
> later.

Later meaning outside the series, as 8/8 is not about that?  Not a
complaint, and if the way I interpreted is correct, then there is no
need to update the above statement.  Just double-checking.

> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  Documentation/git-fast-import.txt | 1 +
>  builtin/fast-import.c             | 2 ++
>  t/t9300-fast-import.sh            | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index db53b50268..edda30f90c 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -660,6 +660,7 @@ and must be in canonical form. That is it must not:
>  
>  The root of the tree can be represented by an empty string as `<path>`.
>  
> +`<path>` cannot contain NUL, either literally or escaped as `\000`.

OK.

> +		if (strlen(sb->buf) != sb->len)
> +			die("NUL in %s: %s", field, command_buf.buf);

Nice.  !memchr(sb->buf, ch, sb->len) would be more general solution
if we were looking for ch that is not NUL, but for checking NUL,
what you wrote is the most natural to read.

>  	} else {
>  		if (include_spaces)
>  			*endp = p + strlen(p);
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5cde8f8d01..1e68426852 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3300,6 +3300,7 @@ test_path_base_fail () {
>  	local change="$1" prefix="$2" field="$3" suffix="$4"
>  	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"hello.c'    "$suffix" "Invalid $field"
>  	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"hello\xff"' "$suffix" "Invalid $field"
> +	test_path_fail "$change" "escaped NUL in quoted $field"    "$prefix" '"hello\000"' "$suffix" "NUL in $field"
>  }
>  test_path_eol_quoted_fail () {
>  	local change="$1" prefix="$2" field="$3"
