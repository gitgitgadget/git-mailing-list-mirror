Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58211185
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222768; cv=none; b=hFieyCqQnsAkXOPerpmdaHTZJvEw7h8gevp8CbIW7AQRSxYUFefLaxZqtJ+T9siH26y64TFZlc4KMmZXgMGAzIin4YrJDPyw2TjCYTisepqDfC90AFw7IvwZye2iRkwGRVVSdiotv4LIr/U2EoIR+kxAteQeqniGDp72okOa/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222768; c=relaxed/simple;
	bh=YnbQ2C/D3gnsvUNTdkzTfcCGj4RFKI8mLqUIlsF7kgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2iiKMtZJ9AyWj92YmCD+oI6UL4a7xsXTlp3cxoon92lqmF3q4YTzLH2qaZOYu2b766knYNMHU+tzF9PhFeMtVMpxCNIPPqSEoa9JBIWK/2SdO6DeMMqnUScXlcepeALhYfq1wS1SyQ0QRfBbLWA9LuVEgq/8Xcsk1NjsSpTJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eKDDhD4u; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eKDDhD4u"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B10E91C62A6;
	Thu, 25 Jan 2024 17:46:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YnbQ2C/D3gnsvUNTdkzTfcCGj4RFKI8mLqUIls
	F7kgk=; b=eKDDhD4uk957VcGlgpt0Hi/+bCUY4a8tOZBxGlWQwbosh9ITKcZL7b
	K2D73Kur6TCcBf1/ZgSNRkoVcDphBTfo1i6jTmU7X/SB3wDPQqGcd8RK0BN2rrwX
	NrVaCiZyGv1MIh9fc92R9bbv9hpAKHZ35pUYD6mrsCovJXmUbcnvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6A2E1C62A2;
	Thu, 25 Jan 2024 17:46:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEA291C62A1;
	Thu, 25 Jan 2024 17:46:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] index-pack: test and document --strict=<msg>
In-Reply-To: <9b353aff73d6351b86cc7b55982f1565e76d08e9.1706215884.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 25 Jan 2024 20:51:23
	+0000")
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<9b353aff73d6351b86cc7b55982f1565e76d08e9.1706215884.git.gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 14:46:02 -0800
Message-ID: <xmqq8r4dt4k5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 850F7A12-BBD3-11EE-B9B7-25B3960A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
> 2015-06-22) allowed a list of fsck msg to downgrade to be passed to
> --strict. However this is a hidden argument that was not documented nor
> tested. Though true that most users would not call this option
> direction, (nor use index-pack for that matter) it is still useful to

Though it is true that ... call this option directly (nor use
index-pack, for that matter), it is still ...

or something like that, probably.

> document and test this feature.

And I agree with that.  Thanks for adding the necessary doc.

> +--strict[=<msg-ids>]::

<msg-id> in the context of "git fsck --help" seems to refer to the
left hand side of <msg-id>=<severity>.  <msg-ids> sounds as if it is
just the list of <msg-id> without saying anything about their severity,
which is not what we want to imply.

Either use a made-up word that is clearly different and can not be
mistaken as a list of <msg-id>, or spell it out a bit more
explicitly, may make it easier to follow?

	--strict[=<fsck-config>]
	--strict[=<msg-id>=<severity>...]

I dunno.

Use of <msg-id> and <severity> below looks good in the body of the
paragraph here.

> +	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
> +	it should be a comma-separated list of `<msg-id>=<severity>` elements where
> +	`<msg-id>` and `<severity>` are used to change the severity of some possible
> +	issues, eg: `--strict="missingEmail=ignore,badTagName=error"`. See the entry
> +	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
> +	more information on the possible values of `<msg-id>` and `<severity>`.

"eg:" -> "e.g.," probably.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index d402ec18b79..9563372ae27 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -441,6 +441,28 @@ test_expect_success 'index-pack with --strict' '
>  	)
>  '
>  
> +test_expect_success 'index-pack with --strict downgrading fsck msgs' '
> +	test_when_finished rm -rf strict &&
> +	git init strict &&
> +	(
> +		cd strict &&
> +		test_commit first hello &&
> +		cat >commit <<-EOF &&
> +		tree $(git rev-parse HEAD^{tree})
> +		parent $(git rev-parse HEAD)
> +		author A U Thor
> +		committer A U Thor
> +
> +		commit: this is a commit wit bad emails

"wit" -> "with"; as this typo does not contribute anything to
the badness we expect index-pack to notice, it would pay to
make sure we do not have it, to avoid distracting readers.

> +		EOF
> +		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
> +		PACK=$(git pack-objects test <commit_list) &&
> +		test_must_fail git index-pack --strict "test-$PACK.pack" &&
> +		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
> +	)
> +'
> +
>  test_expect_success 'honor pack.packSizeLimit' '
>  	git config pack.packSizeLimit 3m &&
>  	packname_10=$(git pack-objects test-10 <obj-list) &&
