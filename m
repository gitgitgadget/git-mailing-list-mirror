Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141315EA2
	for <git@vger.kernel.org>; Tue, 21 May 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327227; cv=none; b=Viruf29qWsHmrVKGtvnKgmRXbdB6L/po+/PoLacMjpF6L8a00wpd/+I9MNNSjMeST9Hcw0LdzD1vC9W6OuCIf4ZcjVAcE+/r++V6n097izsyLSTokHOtKD78PVsYqNv/4MtnWMuOC2wpDHx7exyjgaT+VZs02y9GM7MC4KhWD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327227; c=relaxed/simple;
	bh=B6m3E+NqPt0y6mgX/ssduZm7aK/dpfZDF8qgXRvMoP0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pi2GWR83N6Vx1yRB8j3hfiBTiTy8+/gZJw874+hh9PY73c3Ic0e9F2ZHvvQoCk+ZCrQXtXSNbzLbUvUTF6+Ab7L3snDUiNaBn/+Aghq7XbM/DSjLZ9V14dkXjama7UOwZ1dSCOGCKpP4B0EpOj8pgwNoRdg3w8ljAIXxDYS+UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzPjVbw3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzPjVbw3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CE1122DEF;
	Tue, 21 May 2024 17:33:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B6m3E+NqPt0y6mgX/ssduZm7aK/dpfZDF8qgXR
	vMoP0=; b=jzPjVbw3DFrflYS7FG72BjlB05lRgP6Icp2mdvImqqS5wZVnorC6PW
	P7vtmOl5C828yRmTyUQ8S8GErF0d7r+pS+vJdfGxkyz3TY5yf8dOgxBYQch+N4HG
	96ptUdxfvLJFZLyyc936rMwhSG1awYBmfDe3ktnHVipgWliB5nMB8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D6622DEE;
	Tue, 21 May 2024 17:33:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D468222DED;
	Tue, 21 May 2024 17:33:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [rPATCH 14/12] Merge branch 'jc/fix-aggressive-protection-2.40'
In-Reply-To: <20240521204507.1288528-2-gitster@pobox.com> (Junio C. Hamano's
	message of "Tue, 21 May 2024 13:45:07 -0700")
References: <20240521195659.870714-1-gitster@pobox.com>
	<20240521204507.1288528-2-gitster@pobox.com>
Date: Tue, 21 May 2024 14:33:42 -0700
Message-ID: <xmqqseya97ex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC7C6922-17B9-11EF-9358-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The only tricky part is an evil merge to copy.h that was made
> necessarily due to recent header file shuffling.

Up to this step it seems there is no cascading impact if we dropped
the [12/12] from the series.  I forgot that hook.c needs to lose
"#include <copy.h>" during this merge, which also was made
necessarily due to recent header file shuffling.

