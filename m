Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA92770B
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737397; cv=none; b=CyOJTN0tEkIkcWPALg0nnU16DJSESNPvsPQcGa9sQ4+8M/cZbIay/T1ZY1+OCyFR8mmOSU22WO7TVWdKYFEmTP0W04Y9ppa9sbGT4+FEy7qiEDpfuHqBo/I/cIzd0eaUxzhHv4Jlknk0r9kT7izv5Mp5XMM3QDuQ56uann8NGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737397; c=relaxed/simple;
	bh=0cVgH0Jxmiw2MjcTk9zsuKYfxbEx7H7Dqa7jlDaPtxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=II20Pph8kAhnnq7uSq2RRInl56whUihB/YNHjoEhj3jPLdjnwcAfSFbaAf+mp7hxHg+a18Nr42SO8F8jwvhiE8LZVpgmnNwdipK+atsh2UU/f6ihPk14k2hiXX9mOiKmHIV16b0O21dc6qTKsSBtS39O/jKi/KU6ytncW+11huA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OijxwR5c; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OijxwR5c"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC3811F4868;
	Fri, 29 Mar 2024 14:36:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0cVgH0Jxmiw2MjcTk9zsuKYfxbEx7H7Dqa7jlD
	aPtxs=; b=OijxwR5cv9uqSkNIOdNv+tcPyoCY3YUp/Yi9px4C0Wzak0QnEt9Amk
	W9RQGr1ZoEpEEh9gt/2bbqR7nF2kf3g57q2uV/cBm5GE1xsWQNgbwuH2YoMDzgW6
	Iu8cfCrYHhtBUMC5Zbz1UPFwimzH8dXID9/m0vI2crEKSskgm/Y/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2FAE1F4867;
	Fri, 29 Mar 2024 14:36:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45B3D1F4866;
	Fri, 29 Mar 2024 14:36:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/3] reftable/stack: make segment end inclusive
In-Reply-To: <9a33914c852a0487dbd90c83f53fa0e36414fda1.1711685809.git.gitgitgadget@gmail.com>
	(Justin Tobler via GitGitGadget's message of "Fri, 29 Mar 2024
	04:16:49 +0000")
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<9a33914c852a0487dbd90c83f53fa0e36414fda1.1711685809.git.gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:36:33 -0700
Message-ID: <xmqqsf08yjf2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44DDCC6E-EDFB-11EE-AF32-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Justin Tobler <jltobler@gmail.com>
>
> For a reftable segment, the start of the range is inclusive and the end
> is exclusive. In practice we increment the end when creating the
> compaction segment only to decrement the segment end when using it.
>
> Simplify by making the segment end inclusive. The corresponding test,
> `test_suggest_compaction_segment()`, is updated to show that the segment
> end is now inclusive.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  reftable/stack.c      | 4 ++--
>  reftable/stack_test.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I'd defer it to Patrick (and Han-Wen, if he wants to comment on it),
but isn't it a natural expectation shared among CS folks that it is
the most usual way to express a range to use inclusive lower-end and
exclusive upper-end?  

After all, that is how an array works, i.e. msg[n] is NULL and
beyond the end where n == strlen(msg).

So, I dunno.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index e7b9a1de5a4..0973c47dd92 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1237,7 +1237,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
>  	 */
>  	for (i = n - 1; i > 0; i--) {
>  		if (sizes[i - 1] < sizes[i] * 2) {
> -			seg.end = i + 1;
> +			seg.end = i;
>  			bytes = sizes[i];
>  			break;
>  		}



> @@ -1291,7 +1291,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
>  		suggest_compaction_segment(sizes, st->merged->stack_len);
>  	reftable_free(sizes);
>  	if (segment_size(&seg) > 0)
> -		return stack_compact_range_stats(st, seg.start, seg.end - 1,
> +		return stack_compact_range_stats(st, seg.start, seg.end,
>  						 NULL);
>  
>  	return 0;
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 21541742fe5..4d7305623a0 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -723,7 +723,7 @@ static void test_suggest_compaction_segment(void)
>  	struct segment min =
>  		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
>  	EXPECT(min.start == 1);
> -	EXPECT(min.end == 10);
> +	EXPECT(min.end == 9);
>  }
>  
>  static void test_suggest_compaction_segment_nothing(void)
