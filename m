Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540CC156F41
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973198; cv=none; b=qHhMvLckCUFg5W7x47e3QUYPfskz/M5y27bq2p7y+NH0I2IPVFkkbmbg/8ciUr5zynFgxmJw+kbNYucycpobLHSurGvh3op9uslvEEWiLoNz0/PlLekrcLbQK8OF76+xV36CddnEPI0nmcS8qALgvwZOCysOvEg3DOtAAYE46Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973198; c=relaxed/simple;
	bh=gMS40Bsydreyl/2To6CI2IXCIzehxFfZOyLv0ADWUbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICwzWSlAIKzhiq/Z2i3tssQaEl8Vce3OzzeWFFCa88WjnP7OQZpFJO7Mq9Pi+la4UFUjIEmOn9S+hB9LYC3vxOfdGRoZbKbGub/BPOfexHyyvr8QO/XEpZQ28J7ZmiyBHYugn5PR/ZlJwUTWBRrv9K4AQyi5ws9k+thnLCFf/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VNXn2NJn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VNXn2NJn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AE0536712;
	Thu, 29 Aug 2024 19:13:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gMS40Bsydrey
	l/2To6CI2IXCIzehxFfZOyLv0ADWUbo=; b=VNXn2NJnDyNiovGyXC+NBDKQMIt0
	jDABqeAmQYroIwxoLU0adPRlh725pi/3CKeue2vmeN6KoR/zB6BX9vI8G992F4mr
	tOVUvHEMwV+5q06+1rXG469MWBO1RpFOMvDu7ATwNJT2O9v4DlDp6Qsf9rqnMzSt
	7qEmzQLcyyAGRVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11A623670F;
	Thu, 29 Aug 2024 19:13:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F3FE3670E;
	Thu, 29 Aug 2024 19:13:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
In-Reply-To: <afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 29 Aug 2024 07:07:53 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com>
	<xmqqseuqerb1.fsf@gitster.g>
	<afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com>
Date: Thu, 29 Aug 2024 16:13:14 -0700
Message-ID: <xmqqed66udmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 452CF44A-665C-11EF-838F-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I'm not very happy with the new enum, but I haven't come up with a
> better idea.
> ...
> None of them are better, I think.

Not adding a new enum is probably much better.  See the "additional
thought" in my review on [3/5], for example.

Thanks.

