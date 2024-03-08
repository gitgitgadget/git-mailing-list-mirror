Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054952D057
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912793; cv=none; b=ih2899e00cMzNflFN7Z9RrBz9Uhj2+7CWSaEkQhOYdjMdoJjoOmPn4ywWra5E2tsMKy4GwaUQtJBeelGIOzIRCpb2QQcJ49xTfnqLlKsqPUnDV04mHz/j6mzv4r1yYRNSYSUQ8dSxRuMxDZJCBzv9d/eJ30m4p/2en5fDqJXHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912793; c=relaxed/simple;
	bh=NJ3FkCw85+3Mvn7J/NJ4WP3W3xdJOt7iPo//waJgx7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CquLYti5W7l5DpL3zZfl9xEGNcAklil8y5o3Mq52Skbs041N31h7emK118Epu43XJol5YLUq+jKtDYz26NLi7RzePzxSUTVq/Pv/JGDu5ku77yVJJPD8NgH4MgxoO6D50SZU91u4rV8ZegKgbZlMLPu7C2MhfbhnADKHQNCObXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x9+Oar3l; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x9+Oar3l"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 851A31ECCF9;
	Fri,  8 Mar 2024 10:46:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NJ3FkCw85+3Mvn7J/NJ4WP3W3xdJOt7iPo//wa
	Jgx7I=; b=x9+Oar3ldg9C3/GXKfsB22gUHtIXIC4TjTMwJt6l1MInzCxt+MOWXF
	HM1baiFg5hfktOtsib7LNCZMuTa9upbNjbi3l50tWt5pHwMc1avaoYuzGq+eEJAk
	T/m8mg3d9QmalbCRFn6mSTVcjPbALfOMp4+9tQ8bTVVwq7FWJwAiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2271ECCF8;
	Fri,  8 Mar 2024 10:46:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8F301ECCF7;
	Fri,  8 Mar 2024 10:46:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/4] merge options: add a conflict style member
In-Reply-To: <c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Fri, 08 Mar 2024 14:14:29
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 07:46:23 -0800
Message-ID: <xmqqle6shgkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04EAEEAA-DD63-11EE-8762-25B3960A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/merge-ll.c b/merge-ll.c
> index 6570707297d..bf1077ae092 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> ..
> -#define LL_MERGE_OPTIONS_INIT {0}
> +#define LL_MERGE_OPTIONS_INIT { .conflict_style = -1 }

Makes sense, and this obviously makes the previous step worth doing.

It looks quite wrong that low-level merge options definition is
hosted in a file whose name is merge low-level.  Is it too late to
rename the file to fix this, by the way?

Thanks.
