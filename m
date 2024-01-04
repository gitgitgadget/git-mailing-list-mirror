Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2528DC3
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxolPIYw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D7D933401;
	Thu,  4 Jan 2024 13:12:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kkgPJ+ZoL3vJ/1BxwL6Lo4lVgSyPmI5Dz+LvRU
	BYmTU=; b=WxolPIYwZagOdn4GXIbtrL2O732Jej13Jr69JH2YC+5OILb8MzMgHK
	y25IUKXGCdBvdPzrwN/HKNYUP/JbK9UeWu29T2nb04vs5YKzpCCjVg097Ye9AZsh
	zSWiWr1RC8kyiPPGFPIq+0XxllzAQxYefxLY0vi+DMAttyDJPuKlE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 956CF33400;
	Thu,  4 Jan 2024 13:12:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D844333FF;
	Thu,  4 Jan 2024 13:12:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>, Taylor Blau <me@ttaylorr.com>
Cc: "Chen Xuewei via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org,  Chen Xuewei <316403398@qq.com>
Subject: Re: [PATCH] fix: platform accordance while calculating murmur3
In-Reply-To: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com> (Chen
	Xuewei via GitGitGadget's message of "Thu, 04 Jan 2024 13:56:46
	+0000")
References: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com>
Date: Thu, 04 Jan 2024 10:12:42 -0800
Message-ID: <xmqq7ckp7ysl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB63225E-AB2C-11EE-ABD7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Chen Xuewei via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chen Xuewei <316403398@qq.com>
>
> It is known that whether the highest bit is extended when char cast to
> uint32, depends on CPU architecture, which will lead different hash
> value. This is a fix to accord all architecture behaviour.
>
> Signed-off-by: Chen Xuewei <316403398@qq.com>
> ---

Jonathan and Taylor, isn't this what you two were working together
on?  How would we want to proceed?

Chen, using the right implementation of the hash function to be used
after the next rebuild of the Bloom data has so far been treated as
only one part of the solution (the others include "how to deal with
the existing data?  do we have a way to tell our binary to safely
ignore the Bloom data using a wrong hash?" and "how to make sure old
binaries do not get confused by the Bloom data using the right/new
hash?").

Jonathan and Taylor's (stalled) effort is here

    https://lore.kernel.org/git/cover.1697653929.git.me@ttaylorr.com


Thanks.



