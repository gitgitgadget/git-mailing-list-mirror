Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ACF433C8
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639311; cv=none; b=RGc6wgFyCEYaAuVZaabsob6a6k5581ckacrXyBtQ3QjgOuCu/8QRvmYWv0FFSiZPqf+42eHfBjVqUAzFG8hQeHNCfpC1GapO+ODXcr7hydLKc4RnLcTtuuiNqNoKg6p3NXtmUUa0Jp6yScGb1nNgwNqfCebtjfz9xpxFjpe6p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639311; c=relaxed/simple;
	bh=3FY+OD68E0tsvspXsZQm7nlUemZcCOWXH7+XXz2psBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cCMWZkDHO6KUUtZchbU526zvTcThBQNGvs3/q9LJpsUc0riiHW9o5u4/m9RK7NbibPSAe3lM0hMGT4HOg1sJLB/OCgJ3BApWCZsLxXgbgN3J9lqugRXnqU3+Q9AHGLajnyuD7UEuOLxmvNvJx4jSVrvQeGefGek7SqGe09KDQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K9Lg9z47; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9Lg9z47"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 947D23DB10;
	Tue,  9 Apr 2024 01:08:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3FY+OD68E0tsvspXsZQm7nlUemZcCOWXH7+XXz
	2psBU=; b=K9Lg9z47+sbdtx7QLnsCzBhc6YhFA/9kd3vijmPXzWhwhQCqhuIhPs
	q/WkAyiA6FMLZVZGK2HOSPV64beObsOKjtydwwV9pqysSI+xSHA3QXppSPtgZx1k
	2yPDv4l0PWfgtlv/iZqJWZ07pXcTuXj1SzQDML/PsZ8ICrm6JLo5A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C1DC3DB0F;
	Tue,  9 Apr 2024 01:08:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B4823DB05;
	Tue,  9 Apr 2024 01:08:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking merge
In-Reply-To: <ZhS-IllueSZa1NXs@tanuki> (Patrick Steinhardt's message of "Tue,
	9 Apr 2024 06:03:46 +0200")
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
	<pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
	<xmqqle5n7ajt.fsf@gitster.g> <ZhS-IllueSZa1NXs@tanuki>
Date: Mon, 08 Apr 2024 22:08:24 -0700
Message-ID: <xmqqh6gb2kdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3234BC8A-F62F-11EE-8051-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> So I think it's okay to not mention the exact commit here because we
> cannot reliably second-guess the ultimate extent. My basic assumption is
> that in many cases the user may not even be aware of them trying to pick
> a merge commit, and that it may not have been their intent.

Hmph, if that assumption is really true, would suggesting "merge -C"
be the right thing in the first place?

I do not deal with non-linear stuff in "rebase -i" or sequencer, so
I may not be a good person to judge how good your basic assumption
is, though.

Thanks.
