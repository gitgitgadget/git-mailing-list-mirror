Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06754649
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323946; cv=none; b=heu4gwb1y8ys+nqpdKQCfoguaeaJJLPGHSDu73z2S72ypmj20f0Ukg4BAblYs6q7kNGWZvAoUNSwYEGAypaD9Nsx5a8h6IjKNlsz8CXjxCCIm3/jKBwvwcS4DsGmqYa3LUh1U5AkJr8CxlVsLX6zW2l8WR+zhG+L5HCMr0yXXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323946; c=relaxed/simple;
	bh=gbAFk/AmNxuf2q0qiAdn5Db588isucutTTnMrnqhyN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RwXeoLtxrARAdeb+FNqMl0cGUw+x69EFF1wdIalKgGBGS6oDv8XbLDvrJ4Nnzh/XguFiESAFALqS5dTVL9pxHl2UeNBjW5J+Uzpd5GNzwuvUwawVrMGwL06SDtr9W5IpiitAqnWKypJzlSuRZWVXpnbZNeCted9Y5cDVlLJ8pHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EPDt3DhP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EPDt3DhP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BED601D726D;
	Wed,  7 Feb 2024 11:39:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gbAFk/AmNxuf2q0qiAdn5Db588isucutTTnMrn
	qhyN4=; b=EPDt3DhPDIq2Vae41rtBDgArWCbTEZi0xkTylWI2dl9HIOCGdDUb0f
	5/cZ3FjQfFOh8NVM/XBAPZectgdlyfaciV2vcdYWMZc2GY8UdSIfa7iyYOJY2gmn
	/CRhsMzMhrLaEKnN9pusD40ZpH1Gu3gu2KcuXRQL+YngoX1a+EdTk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B4E2C1D726C;
	Wed,  7 Feb 2024 11:39:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EA261D726B;
	Wed,  7 Feb 2024 11:39:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  git@vger.kernel.org,  Jonathan Nieder
 <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com> (Phillip Wood's
	message of "Wed, 7 Feb 2024 14:03:16 +0000")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	<xmqqy1bymru0.fsf@gitster.g>
	<b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
	<xmqqcytal01i.fsf@gitster.g>
	<4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
Date: Wed, 07 Feb 2024 08:39:01 -0800
Message-ID: <xmqq8r3wcjq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66F41FF2-C5D7-11EE-B45C-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 06/02/2024 03:54, Junio C Hamano wrote:
>> Vegard Nossum <vegard.nossum@oracle.com> writes:
>> 
>>> On 06/02/2024 00:09, Junio C Hamano wrote:
>> Perhaps it is a good idea to squash them together as a single bugfix
>> patch?
>
> I think so, I'm not sure we want to add a new test file just for this
> either. Having the test in a separate file was handy for debugging but
> I think something like the diff below would suffice though I wouldn't
> object to checking the author of the cherry-picked commit

Very true (I didn't even notice that the original "bug report
disguised as a test addition" was inventing a totally new file).

Thanks.

>
> Best Wishes
>
> Phillip
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c5f30554c6..84a92d6da0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -153,6 +153,18 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>  	git rebase --continue
>  '
>  +test_expect_success 'cherry-pick works with rebase --exec' '
> +	test_when_finished "git cherry-pick --abort; \
> +			    git rebase --abort; \
> +			    git checkout primary" &&
> +	echo "exec git cherry-pick G" >todo &&
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i D D
> +	) &&
> +	test_cmp_rev G CHERRY_PICK_HEAD
> +'
> +
>  test_expect_success 'rebase -x with empty command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
>  	test_must_fail env git rebase -x "" @ 2>actual &&
