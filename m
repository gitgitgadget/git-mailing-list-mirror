Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23121A04
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925096; cv=none; b=J5LzVgP5yEpSTgQxd04VU0/ZHaNgGEzmQxylowLCoX0llJKqmfVXI6v8Uooccp6ggPQOmgdAuvO8KYn//ckQA6T/1EAsf25MtPFU6wuyYPTowSiikHOMuwBQhksLb4mqHmYcifzm4y6cyjKRlKK8fuPHVJmzYTfldFypCAfrd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925096; c=relaxed/simple;
	bh=WgPWTzZy0G6bZ/lcDLe/T0XDWwHfwM0W2VqrOegpU8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N0gJucWp4XJX218DRLi/ffe0Wp3/TY09Cf15/m5U0Cx68lZifIcwT7EUSJjIh+Vx/YJVfCflj0FQ08E00oBM6JXgIpu6UYVEmbRgBiYTnrtU1g1XlstwfJKYaRb+Lo+a2Pq1l+MdIn7y41PtxAX62XdeMk+5pEgTSeAF1Doyw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A3HFJIPU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A3HFJIPU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C13C29374;
	Thu, 25 Jul 2024 12:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WgPWTzZy0G6bZ/lcDLe/T0XDWwHfwM0W2VqrOe
	gpU8M=; b=A3HFJIPU0IqX2RTcydeRgHIuEOdEgJG1m2XdpvgCEibYOexJqV7mSq
	VucqLQZTYj89gGpqkREEZFFLaHXY2x4GFOoE/8Xb5KjFyX4G7zl38dwwDg+HYYXe
	W6DTa73cbY7ZGcd+EVggnPAnwoLxRMb7Fc8aAgkbb1sDGLlj5X1T0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 354DC29373;
	Thu, 25 Jul 2024 12:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9158129372;
	Thu, 25 Jul 2024 12:31:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: David Disseldorp <ddiss@suse.de>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty
 notes add
In-Reply-To: <20240725144548.3434-2-ddiss@suse.de> (David Disseldorp's message
	of "Thu, 25 Jul 2024 16:41:06 +0200")
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-2-ddiss@suse.de>
Date: Thu, 25 Jul 2024 09:31:27 -0700
Message-ID: <xmqqle1pigbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58772D2E-4AA3-11EF-86BB-9625FCCAB05B-77302942!pb-smtp21.pobox.com

David Disseldorp <ddiss@suse.de> writes:

> 90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
> changed note_data.given logic such that it's no longer set if a zero
> length file or blob object is provided.
>
> Add a test for this regression by checking whether GIT_EDITOR is
> invoked.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  t/t3301-notes.sh | 5 +++++
>  1 file changed, 5 insertions(+)

Having this test separate from 2/2 breaks bisectability.  For a
small test like this, it is often a lot more preferrable to squash
it into the patch that updates the behaviour.  It is easy to apply
the whole thing, and when the reviewer/tester is curious, it is easy
to tentatively "revert" only the behaviour changes out of the
working tree to see how the original code behaved against the test
to verify the alleged breakages were indeed there in the original.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 536bd11ff4..c0dbacc161 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by git log' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'empty notes do not invoke the editor' '
> +	test_commit 18th &&
> +	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
> +'

Clever.  By setting the editor to something that always fails, we
will notice if the command invoked it, when we do not expect the
editor to be used.

Not questioning the usefulness of this fix, and not suggesting to
remove the "--allow-empty" support out of the "git notes" command,
but out of curiosity, what are these empty notes used for?

Thanks.

