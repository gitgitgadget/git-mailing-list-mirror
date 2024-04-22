Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C152E04
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799866; cv=none; b=dnaPh6xjJ1QEhbM0Yt0W8+wpSvgwKIxm4KJvc6HRAsRiUHnsP0ObxVm3hbV55q0TKtG1sTdqMyCD5yIS1PWZI7ah+lA52yCjSxS7kMBcEiAdOilVyr/PUkEs59eP/Bj2tpmA0dnM8G45DmrDIHm82J/Fy3ov2+CawY84wlTaP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799866; c=relaxed/simple;
	bh=Ijy2874MgJFAHORySgeiF0Te1/H0C9fIN7Bx0ZWmsNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=avRA5MUBt5CgD1jfL45tsrQrYQ+GjO9EUfSRW4LCg+EkTzXmIgC9ISBk1lgX7kaF4vwn7kfRnOdXCrgjF1q46nWiXgYqhd17Xs4C5+yt3egf4o3D5rR9M0ZkJnYl2a9Ztp7YNhkdHArBIa5i+fvwtkrP7PpLOjRLBibKG14/O1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CD7AqzGW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CD7AqzGW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2232722E5B;
	Mon, 22 Apr 2024 11:30:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ijy2874MgJFA
	HORySgeiF0Te1/H0C9fIN7Bx0ZWmsNY=; b=CD7AqzGWJbktAd9s2WwXyI856t9i
	AQDkaZ0PkRTpUiziZvnUjwPpzyCKLfRVEcLhNh0tQncojPQM260ekX74lgYUpNDW
	rpQmxsNccAsIFOFuJsK/cYEoNriWqCtVkfFQF99wtJNm1zN3aOPdXkPyRtC/y26R
	0ihvfxQrcV+xJTU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B85422E5A;
	Mon, 22 Apr 2024 11:30:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 934B622E55;
	Mon, 22 Apr 2024 11:30:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] mark t3701-add-interactive.sh as leak-free
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 21 Apr 2024 12:22:46 +0200")
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Date: Mon, 22 Apr 2024 08:30:53 -0700
Message-ID: <xmqqo7a1za6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4F9BDC52-00BD-11EF-B00A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Rub=C3=A9n Justo (4):
>   apply: plug a leak in apply_data
>   add-interactive: plug a leak in get_untracked_files
>   add-patch: plug a leak handling the '/' command
>   add: plug a leak on interactive_add

Thanks, will queue.

>
>  add-interactive.c          | 1 +
>  add-patch.c                | 1 +
>  apply.c                    | 4 +++-
>  builtin/add.c              | 9 ++++++---
>  t/t2016-checkout-patch.sh  | 1 +
>  t/t3701-add-interactive.sh | 1 +
>  t/t4103-apply-binary.sh    | 1 +
>  t/t4104-apply-boundary.sh  | 1 +
>  t/t4113-apply-ending.sh    | 1 +
>  t/t4117-apply-reject.sh    | 1 +
>  t/t4123-apply-shrink.sh    | 1 +
>  t/t4252-am-options.sh      | 2 ++
>  t/t4258-am-quoted-cr.sh    | 1 +
>  t/t7514-commit-patch.sh    | 2 ++
>  14 files changed, 23 insertions(+), 4 deletions(-)
