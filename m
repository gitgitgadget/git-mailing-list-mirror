Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A528E7
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393767; cv=none; b=f17fNsiWaTLGrvHF6Hv3CSdgs5SMouqyNFCUs/WfyMPLV73jAcx0XEdwFZw0JNYl49RbP466mx+n8kOTAyYEiTSt/jO7h3dtyQLWRcQLOovIp+vhc38LdaJUkGlPLaxbkHQRfsziyrW2KKNTdmpWggY+V6podAzJd2LBHZO35Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393767; c=relaxed/simple;
	bh=IxhQYuCeKEFTKguCBboSg9WzKt5rDaW1SS0weBchTAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5H1OvpZEqbQqag1fAxJQh6lekSyMOwk9475zFo74l/wSU+rcu9N9SgnBqPPJKDx6KT7XhCPzo5cOK6Xm2wanifCBDAwDjzaLksuzQoMbjq+qdYFZA3dNywsWEjIC7v2njrzID9llZhKj1FqQRjALO0ZOYdQWTft0kdtOMyZQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y01+kNk/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y01+kNk/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8480B1E9B2;
	Tue, 30 Jul 2024 22:42:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IxhQYuCeKEFTKguCBboSg9WzKt5rDaW1SS0weB
	chTAc=; b=Y01+kNk/ggYSkeSTu0GDZ5FblwdTzU0MumyrInu/CMTEhSstxhrSKl
	WVd+p0sFZBalUEUsyyXVkJzWvAsWenG5yunOcJBY2KylPDgSfPhzXMDhLSW8EWFH
	CBhq16XFQAuD5U4F1F09e5GU4SOqm4ahwzH3XknLnDeUmtcq2Yt18=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D1521E9B1;
	Tue, 30 Jul 2024 22:42:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15DA71E9B0;
	Tue, 30 Jul 2024 22:42:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen?=
 <tboegi@web.de>,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v5] convert: return early when not tracing
In-Reply-To: <pull.1744.v5.git.git.1722310937061.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Tue, 30 Jul 2024 03:42:16
	+0000")
References: <pull.1744.v4.git.git.1722002432630.gitgitgadget@gmail.com>
	<pull.1744.v5.git.git.1722310937061.gitgitgadget@gmail.com>
Date: Tue, 30 Jul 2024 19:42:40 -0700
Message-ID: <xmqqle1i8eov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F0A8DEE-4EE6-11EF-89D6-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: D Harithamma <harithamma.d@ibm.com>
>
> When Git adds a file requiring encoding conversion and tracing of encoding
> conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING
> environment variable, the `trace_encoding()` function still allocates &
> prepares "human readable" copies of the file contents before and after
> conversion to show in the trace. This results in a high memory footprint
> and increased runtime without providing any user-visible benefit.
>
> This fix introduces an early exit from the `trace_encoding()` function
> when tracing is not requested, preventing unnecessary memory allocation
> and processing.
>
> Signed-off-by: Harithamma D <harithamma.d@ibm.com>
> ---

It seems that you forgot to adjust to

 https://lore.kernel.org/git/xmqqed7gyyyd.fsf@gitster.g/

where I asked you to be consistent in the authorship name and sign
off.

For now, as I like to allow "git shortlog --author=..." to group
contributions by a single author to a single bucket, I'll rewrite
both to the same name as used in d254e650 (build: support z/OS
(OS/390)., 2024-03-06), but will not merge it down to 'next' before
I hear what your response is.

Thanks.

