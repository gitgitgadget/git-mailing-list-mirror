Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DD16BE0E
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617738; cv=none; b=E9w8hExCPyrJADtoQXIAeQIi1Xu5r0he1VaEAitMCFocC2mnptA9SbXaTMYr2sa1oJ1GDYk+Auc6LCf5tvi8yzPJakZh5aAdt5zbCHFAxmGHLntNWFnGS8DmSKNOlkhSPEN3AdSn2s9k3scUfld36UWVx8Yipjgj0qQM3g2yaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617738; c=relaxed/simple;
	bh=SOVnsa8c09DBwcLlt/JJdM3a+0t3zZbjFIkqnOYnt/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmuvsWztiptwMpgKc7un3TOsljxb6HogovtbRW5ySgdPlj9twtTsSiPH8PyvjaV90spWxwRtBn/xFUTlhsbVV6sS48CZ1iBtXDhx3vsU63bZ+vQVb4Gys1c0gpwJbKn4naUEAwoEHX8Z2AGA0Z3Pf54lYqRdIHJQ6MmMeTgIcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hlnQN+Ot; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hlnQN+Ot"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 767A1350C3;
	Fri,  2 Aug 2024 12:55:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SOVnsa8c09DBwcLlt/JJdM3a+0t3zZbjFIkqnO
	Ynt/4=; b=hlnQN+OtZQoy6HvHGyhJGKK/gZvsbkLKVyWuUR2+9kGUntVcU1qZX8
	rhohFzpjKPtY47kz8tWUSlXa4UQ13EkxBwkhDsNsOnZoypcK4yF6ENtzZMUtTf80
	IAvt1Xon+SS9au/CKnZikbIwVycnZvJCH5WFnulffpTU4GFIDr8c0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D085350C2;
	Fri,  2 Aug 2024 12:55:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18C21350C1;
	Fri,  2 Aug 2024 12:55:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  vdye@github.com
Subject: Re: [PATCH 0/3] git for-each-ref: is-base atom and base branches
In-Reply-To: <27f3de89-55b2-413d-b4b4-6b35f8c4bcc9@gmail.com> (Derrick
	Stolee's message of "Fri, 2 Aug 2024 10:32:46 -0400")
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<xmqqmslvhmgm.fsf@gitster.g>
	<27f3de89-55b2-413d-b4b4-6b35f8c4bcc9@gmail.com>
Date: Fri, 02 Aug 2024 09:55:30 -0700
Message-ID: <xmqqzfpudful.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 079250CA-50F0-11EF-B6B6-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> consider this documentation diff, and I look forward to other review
> comments that I can use to improve this series before sending v2.
>
> diff --git a/Documentation/git-for-each-ref.txt
> b/Documentation/git-for-each-ref.txt
> index c1dd12b93cf..5154ba3e2a7 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -264,6 +264,16 @@ ahead-behind:<committish>::
>  	commits ahead and behind, respectively, when comparing the output
>  	ref to the `<committish>` specified in the format.
>
> +is-base:<committish>::
> +	In at most one row, `(<committish>)` will appear to indicate the ref
> +	that minimizes the number of commits in the first-parent history of
> +	`<committish>` and not in the first-parent history of the ref. Ties
> +	are broken by favoring the earliest ref in the list. Note that this
> +	token will not appear if the first-parent history of `<committish>`
> +	does not intersect the first-parent histories of the filtered refs.
> +	This can be used as a heuristic to guess which of the filtered refs
> +	was used as the base of the branch that produced `<committish>`.
> +

OK.  Knowing what definition you used is crucial when reading the
implementation, as we cannot tell what you wanted to implement
without it ;-)

Thanks.
