Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA482191F77
	for <git@vger.kernel.org>; Thu,  8 May 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740574; cv=none; b=C3udL/jic06glJ6VY2SnD5O6KGSaNQn57JRnXZwsTwwUgFh4kw5iO+APUUHDy0C5sDIBdzFiGw5eAy6FL6efgKqBxd3CZyqg5/AS3SM3UXKrEMqf+TgIUp6x3LCB9+Dn7qTQ5uDFQQF0JWZhdUkWv0LoriADLy11l4/5zV2h4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740574; c=relaxed/simple;
	bh=2EMMUIYRdfeYBaJMYddERIi20XxWDJNWAKFUtaDAJa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV30Cfbzr+9CLKHRmChNQNfCInOckTH9GHli30UBID5Wxnoo8vk86oc5+msqnpsTxAYIulyiFZlq4vWj27D7dFP3ouAX3++dCqqSVGOyrkYe/LN+g/tITGafX1FU1Y5aQS2H2VaQgc/AEXFNOXY+Z947QNc8XLYn2GziI/AI+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jdpHVQyQ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jdpHVQyQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746740559; x=1747345359; i=l.s.r@web.de;
	bh=qvBAoy2cMqWGaSTzXW+WX8k34RRMlilC3DazRIDc7PM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jdpHVQyQcACVkCnHcbTqjI3Sbb8siPzJioI0c4df1QKDmbdvo8/teglJ6UYcXLWj
	 JF9WVJ6cEV900wT+ZxcQ7U1SrC0PksS547wFwKOLNVXs8vMvozjiAiKm5kvlWC1A3
	 sM7rAdIZP6DtxFgFFihi26G6C3uzrHqs0TZ6MYxcqToAhq+zQOlvRq6sI1NV2Dtzo
	 mv3jf5jg8yRo+bCXGvXniw2k+1D0TNomG+ujkjKmsCxKZrhdgoAe0O+tm08XyOftk
	 YS/wAvILrzRV/9WIFuov9zkY8jym5eH5PzRNh0AWOKXVhtFI8c/ujRJZkLokUpDPw
	 gdDuzFCl2Gj1I6YN6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.115]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1uItFJ3SJz-00Dw5T; Thu, 08
 May 2025 23:42:38 +0200
Message-ID: <174cb568-e2bd-41e0-b090-eadd919d1ddd@web.de>
Date: Thu, 8 May 2025 23:42:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] REFTABLE_REALLOC_ARRAY: fix potential memory leak if
 realloc failed
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MlYRAZWaC4sCVQ4MAnvu3QiqEWpU4aXXk3RzBVpCXmkD18/bL6K
 y0eo8OKuAgRJ6F9c8AZw4Ztlx8c9Nz8P6dnuBOOftX+cUqtWaSLQi1FPWtGylk2CPiyTKFL
 uGPBnxy4vqmStJRyTZlyxhjHDV+wP/xPd9i2Dwiaptv6Ot4EzMXlQmSXlpG3bUjUiHPZjLV
 1ZZQcr1TGUDn0lQ91Nbiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5H+l1oiAU34=;LJ6T9cPb6yDqL/vntjk+l1rqQc1
 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
 5XJfP4mZ5T7e9RgrCNIQo3hAdnIJ5DUATa

Am 08.05.25 um 15:39 schrieb Lidong Yan via GitGitGadget:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>=20
> REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
> failed. This leak can be fixed by add a free(x) before set x to NULL.

Hmm, this macro is unused.  Perhaps remove it?

Ren=C3=A9

