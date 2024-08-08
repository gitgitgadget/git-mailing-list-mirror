Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181C1917C5
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137848; cv=none; b=kiUhWGPY9JjqnYWjVlilSPuvpboTUzJ+caFk/m1srhIUWxZxEIiEdkJbQ624Xj5Ka2V2i24PWmPrp1APBpVJLzodlXwx3LLwO9QjHDwiMsQJN+trjUN+OiPSxUf/8FgIsk/UsGtCsvW0BYQleacL2ljCTJ8027ufwwBOvtuQvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137848; c=relaxed/simple;
	bh=6LdHVZoTTPyDkIX3ysDgPwytWHFeClqvIyMGwGHm6qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObeSPcDd9We3A7LAtiJBn9EP7laO2ccxL0fIXtKdiscUHYkTRjsCngFtr9eZSJ2JLFundFcjqg6fC5Nh0XWCbdgzp/9lkzVBYupjmEqv0pX+URdrDB1BcXCeFipIZXjgDX6vWDCeRe+uZjJs1fQNWxxh6PZMoEjMItcXSrE27xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CmnMOL0o; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CmnMOL0o"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2C8523B06;
	Thu,  8 Aug 2024 13:24:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6LdHVZoTTPyDkIX3ysDgPwytWHFeClqvIyMGwG
	Hm6qc=; b=CmnMOL0omM1D7EpVy9Tbsz25oYXPuySHTMi0y1P8w6Qlj59qumvGDZ
	HImEZIvflZLu2s3wqO8WOzZmNrpw7eHzY66mvn7m720n9X18FOAHSFCHYnNaGJBy
	pTGmnfSkeruB6txL2dt4drJOF/Nr9qRfCDq1lTy7nLbZjBEakEuZw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB79A23B05;
	Thu,  8 Aug 2024 13:24:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3E8C23B03;
	Thu,  8 Aug 2024 13:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: blanet via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  blanet <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] diff-tree: fix crash when used with --remerge-diff
In-Reply-To: <CABPp-BGo7-P+3w=Y2Mifox4xztzMhgLKBtnrrF9R1XM9ZDPqqw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 8 Aug 2024 09:03:53 -0700")
References: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
	<CABPp-BGo7-P+3w=Y2Mifox4xztzMhgLKBtnrrF9R1XM9ZDPqqw@mail.gmail.com>
Date: Thu, 08 Aug 2024 10:24:00 -0700
Message-ID: <xmqqr0azgc7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 01B4CB14-55AB-11EF-986E-BF444491E1BC-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

> The commit message from my patch also included an explanation for why
> diff-tree was the only caller that was missing the necessary logic
> (see the last paragraph, which kind of references the one before it as
> well).

... which we may want to resurrect.

> Test looks good too.
>
> I'll be happy to add my Reviewed-by if you fix the header include order.

Thanks for a review.
