Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CE1272CD
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935118; cv=none; b=rN2Hg6TDW3YhAjBj0xRW8vnmlhr/t/WZmIRNUHeR/keIMf4Oy+0nm35keuAsy3XTMjyF5kcU2F20JwZ86qREv/G22WUJilg88yM37P+ZSoXLFw/FsDtFXGsyk6NmOsYFOIPhmA/25qOBxMZ/ALBARddPfMTgegE5FR6FzKpB4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935118; c=relaxed/simple;
	bh=KUtmzoojY6Cc+CFDJKXLaNdTf8sQCAcrnGUlrAOWd5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4zKYdKfRqu3Xqfy7QGF3bCMga2hIQzsnm4dCwcR48yCQbnmhLM5pDyHzpVL0psV1Vmu8kV4nUI3L7aOjBd+Oiczr3dxIySw8fjBuTfoofVus4S42/lhoGjWcwajdTXHjniYBFw/gTU/zTRlJv+0Y9r1VOGvIa67gQNBG4m8rvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FIjwO/Nj; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIjwO/Nj"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 523481F393;
	Wed, 14 Feb 2024 13:25:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KUtmzoojY6Cc+CFDJKXLaNdTf8sQCAcrnGUlrA
	OWd5A=; b=FIjwO/Nj3ufu7rJ3yRsraMQxcuw3RK34ELcCPozOcnPgpL4JE8zfhK
	PQgu4jov+GYMhaJaJ91Zbvihu82ghYi0rhaCBuZ1xxasnJpboqkv6+KANyKKEzWl
	iRCXFUn/KIDMq3uFKAt7/JRb3qDV0/1aMzPxlG0lky7T/s+KjYp70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E2A81F392;
	Wed, 14 Feb 2024 13:25:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D47A91F38F;
	Wed, 14 Feb 2024 13:25:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential/osxkeychain: store new attributes
In-Reply-To: <pull.1663.git.1707860618119.gitgitgadget@gmail.com> (M. Hickford
	via GitGitGadget's message of "Tue, 13 Feb 2024 21:43:38 +0000")
References: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
Date: Wed, 14 Feb 2024 10:25:11 -0800
Message-ID: <xmqqzfw2vr7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 64889466-CB66-11EE-8161-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
> and a5c76569e7 (credential: new attribute oauth_refresh_token)
> introduced new credential attributes.
>
> Similar to 7144dee3 (credential/libsecret: erase matching creds only,
> 2023-07-26), we encode the new attributes in the secret, separated by
> newline:
>
>     hunter2
>     password_expiry_utc=1684189401
>     oauth_refresh_token=xyzzy
>
> This is extensible and backwards compatible. The credential protocol
> already assumes that attribute values do not contain newlines.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---

OK, this adds both oauth_refresh_token and password_expiry_utc,
unlike the recent one for wincred, which already stored the expiry
but the support for oauth_refresh_token was added with f061959e
(credential/wincred: store oauth_refresh_token, 2024-01-28).

>     [RFC] contrib/credential/osxkeychain: store new attributes
>     
>     Is any keen MacOS user interested in building and testing this RFC
>     patch? I personally don't have a MacOS machine, so haven't tried
>     building it. Fixes are surely necessary. Once it builds, you can test
>     the feature with:
>     
>     GIT_TEST_CREDENTIAL_HELPER=osxkeychain ./t0303-credential-external.sh
>     
>     
>     The feature would help git-credential-oauth users on MacOS
>     https://github.com/hickford/git-credential-oauth/issues/42

I do not use macOS to use this on, so let's see how others can help.

Thanks.  Will queue.

