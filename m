Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E383F9C2
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550583; cv=none; b=ZBNnIS3CUgeBAqfnoqp5mGTRzQ6SANrgvxXaEjpG02/TcumsEw/j8BEHzJb0isDsWyCZ1CxBvgdUlgRSyTPv5fkk0AJ1wiIyXiHsp/SK0zN4nhOA6m37rOorzADSFgJBMVmbnGAWUvqfsfqZ1mwQ2iAIKzf0DZ/l9pm0EtVz/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550583; c=relaxed/simple;
	bh=dVAtqi+TP3C8A9JxgvVIxyWhhykuBNgDprMY360jk+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZShCPWw7lDHzsKB+LlvV4DOhmTqhJprdehkz6Mp1knEfbaW47iw1LRxDwunmVjUhLkYgcKcMYBaCCwhfzVgFpp1iPffsW+16TOdkjR6l+CIEtbx+yB1kdPzJwdXYVkObywJGhrydtV7CMpe5nl+Rx7I3v8eud0VCVxJ/M7XQcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgzHEJ/e; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgzHEJ/e"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A68B220C4F;
	Mon, 29 Jan 2024 12:49:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dVAtqi+TP3C8A9JxgvVIxyWhhykuBNgDprMY36
	0jk+I=; b=jgzHEJ/es6ID3m20Rbg/+PSFV85/mYITr7A4xzU3xa6JwiqtNfD8+m
	9sGob61vdLlhcdJmi5ilWcLfYfK+P1+/8tAZfcJDhcwCbC1LuohhUkWhArsQ3pzn
	vH+4DGSGUQJWXzH0FY6H4QnoJCZrVVI+F3DjVq/d+QzwmbaQBOrhA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F68120C4E;
	Mon, 29 Jan 2024 12:49:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CE7720C4A;
	Mon, 29 Jan 2024 12:49:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] merge-tree: accept 3 trees as arguments
In-Reply-To: <pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sun, 28 Jan 2024 20:34:22
	+0000")
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
	<pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 09:49:36 -0800
Message-ID: <xmqqbk94jahb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C5973AAE-BECE-11EE-99B1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When specifying a merge base explicitly, there is actually no good
> reason why the inputs need to be commits: that's only needed if the
> merge base has to be deduced from the commit graph.
>
> This commit is best viewed with `--color-moved
> --color-moved-ws=allow-indentation-change`.

Thanks, let's merge it down to 'next'.
