Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0F12E71
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522466; cv=none; b=reuJAYaLI+qvfLZbz8pRhWWVVpOIpQgPtnrCXD9Gk6ArpC+hLCLvtkskX3m3Ryj5WGadU8KemLHnK8Z3CScwnmR9+cNMGPobg0THEFwjmlfRGcJVjrhUIXJ2RvGUQJD5ufHHIofr13Dxq84feEOeE97ex/Sf3qo0VgNAcbJzuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522466; c=relaxed/simple;
	bh=E+iS7rsgA0sMzpzZc6nGw4sd7ntHKfEMB9/Rxao8UaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JidFzLb3eNpdm0v7A+EzHwcNeHLwzl6Kfm1AvgwCTdeX9o+9yhmW7Ca1dyHC7nsrY50TIV0bsUcm+bB4WRsK/ajk7MXjeGlXP4ckwLjxtan868HmZO/6/nXuuno91/f/I40iqXgcJWq7DRbYBy0zshsuPccZ3XaDQNeKd0SA4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wo5i0zch; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wo5i0zch"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 881A92BEDD;
	Fri, 15 Mar 2024 13:07:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E+iS7rsgA0sMzpzZc6nGw4sd7ntHKfEMB9/Rxa
	o8UaY=; b=wo5i0zchS35i/zMS3pMrA6FlpEU2aUI/syYpn24yZFhBBvhvyoLfgc
	hlxTjHm+If9WjizHlK5JivtZIqPmoo92F2P7eX9B8VyFS76+yzOGI77lH66oZnXP
	seW9+lO8JnDdOeY/EHAhcogvpfoffFj7r7iyL2bfLB7MTXJ3bXPDA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FFF02BEDC;
	Fri, 15 Mar 2024 13:07:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 258422BEDB;
	Fri, 15 Mar 2024 13:07:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  szeder.dev@gmail.com,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] t5300: fix test_with_bad_commit()
In-Reply-To: <pull.1688.git.git.1710478646776.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Fri, 15 Mar 2024 04:57:26 +0000")
References: <pull.1688.git.git.1710478646776.gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 10:07:33 -0700
Message-ID: <xmqqttl7qv8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84B60B48-E2EE-11EE-B6D3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 0f8edf7317 (index-pack: --fsck-objects to take an optional argument for
> fsck msgs, 2024-02-01) added a test function test_with_bad_commit() that
> contained two bugs. test_expect_fail was used instead of test_must_fail,
> and a && was not included at the end of the line.
>
> Fix these two issues in the test.

Wow.  This is an embarrassing one.  Thanks for a fix.

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>     t5300: fix test_with_bad_commit()
>     
>     0f8edf7317 (index-pack: --fsck-objects to take an optional argument for
>     fsck msgs, 2024-02-01) added a test function test_with_bad_commit() that
>     contained two bugs. test_expect_fail was used instead of test_must_fail,
>     and a && was not included at the end of the line.
>     
>     Fix these two issues in the test.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1688%2Fjohn-cai%2Fjc%2Ffix-t5300-tests-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1688/john-cai/jc/fix-t5300-tests-v1
> Pull-Request: https://github.com/git/git/pull/1688
>
>  t/t5300-pack-object.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index a58f91035d1..61e2be2903d 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -465,7 +465,7 @@ test_with_bad_commit () {
>  	must_pass_arg="$2" &&
>  	(
>  		cd strict &&
> -		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"
> +		test_must_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack" &&
>  		git index-pack "$must_pass_arg" "test-$(cat pack-name).pack"
>  	)
>  }
>
> base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
