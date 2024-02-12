Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256A3EA74
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758367; cv=none; b=GPQq5nLZDo0VGu05zg2GmOzrHELBo9jMpfFwEoLWcK1xd6B84NRLcYjgO9GXv5n4fjqPBSoDfBv+ejCSkgEBRAPLigmmd/OxbOWa/BgNqT2xDjTsJlk4HzlsVmGHF2NFdYVcLIsip6guup8vpy/FA+zGiccwQYnT8hA8uO1/bcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758367; c=relaxed/simple;
	bh=GgzAOFIg4YJikB49gmxd+AokSOoBNbn1+xJq2dSnR/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYP//1Qtn6I1AnqUz/J/pwL9Pya+bO+4rJ9sbD0YHkUw1DS12/tDdPh02ZOlUsKnLNRwLFOKJInO6FCaukbT78mv9/rgXSOJnhW34TBciCEARbIlDPyswMBvQ2cdcoLgFeuPNTcSyaL5+Ta4bUVckkfWL90G1j8IoFyngVKa1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uTlpK7jt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uTlpK7jt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 530562C35C;
	Mon, 12 Feb 2024 12:19:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GgzAOFIg4YJikB49gmxd+AokSOoBNbn1+xJq2d
	SnR/0=; b=uTlpK7jt1Yl/qKKqKmne8irQPj7sC5D5VwoR8k6VLyyT1eGyWihL+V
	Nsl1Wvy91lI52pBpoWiDrcZDmmOFpCoxerQnHhsDUH0TrvPJ9de+/ikqmh854aUz
	vcHdQJl9B7xq0zOLT9laVCDx8qlLDEn2IcOaRpT40uuftGPQhbYqc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AB4A2C35B;
	Mon, 12 Feb 2024 12:19:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E25BD2C35A;
	Mon, 12 Feb 2024 12:19:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 7/7] reftable/reader: add comments to
 `table_iter_next()`
In-Reply-To: <167f67fad841ad06535a5532088fa6c9125fb1cd.1707726654.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 12 Feb 2024 09:32:57 +0100")
References: <cover.1706782841.git.ps@pks.im> <cover.1707726654.git.ps@pks.im>
	<167f67fad841ad06535a5532088fa6c9125fb1cd.1707726654.git.ps@pks.im>
Date: Mon, 12 Feb 2024 09:19:20 -0800
Message-ID: <xmqq4jed7g87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCC375C4-C9CA-11EE-B7E1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> While working on the optimizations in the preceding patches I stumbled
> upon `table_iter_next()` multiple times. It is quite easy to miss the
> fact that we don't call `table_iter_next_in_block()` twice, but that the
> second call is in fact `table_iter_next_block()`.
>
> Add comments to explain what exactly is going on here to make things
> more obvious. While at it, touch up the code to conform to our code
> style better.
>
> Note that one of the refactorings merges two conditional blocks into
> one. Before, we had the following code:
>
> ```
> err = table_iter_next_block(&next, ti

");"???

> if (err != 0) {
> 	ti->is_finished = 1;
> }
> table_iter_block_done(ti);
> if (err != 0) {
> 	return err;
> }
> ```
>
> As `table_iter_block_done()` does not care about `is_finished`, the
> conditional blocks can be merged into one block:
>
> ```
> err = table_iter_next_block(&next, ti
> table_iter_block_done(ti);
> if (err != 0) {
> 	ti->is_finished = 1;
> 	return err;
> }
> ```
>
> This is both easier to reason about and more performant because we have
> one branch less.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reader.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 64dc366fb1..add7d57f0b 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -357,24 +357,32 @@ static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
>  
>  	while (1) {
>  		struct table_iter next = TABLE_ITER_INIT;
> -		int err = 0;
> -		if (ti->is_finished) {
> +		int err;
> +
> +		if (ti->is_finished)
>  			return 1;
> -		}
>  
> +		/*
> +		 * Check whether the current block still has more records. If
> +		 * so, return it. If the iterator returns positive then the
> +		 * current block has been exhausted.
> +		 */
>  		err = table_iter_next_in_block(ti, rec);
> -		if (err <= 0) {
> +		if (err <= 0)
>  			return err;
> -		}
>  
> +		/*
> +		 * Otherwise, we need to continue to the next block in the
> +		 * table and retry. If there are no more blocks then the
> +		 * iterator is drained.
> +		 */
>  		err = table_iter_next_block(&next, ti);
> -		if (err != 0) {
> -			ti->is_finished = 1;
> -		}
>  		table_iter_block_done(ti);
> -		if (err != 0) {
> +		if (err) {
> +			ti->is_finished = 1;
>  			return err;
>  		}
> +
>  		table_iter_copy_from(ti, &next);
>  		block_iter_close(&next.bi);
>  	}
