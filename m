Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC093308A
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709963174; cv=none; b=HAATFvAaIqgISWNYxPohgypz5CfPfUmkHzm4FoOIbR4GVSrtk+tcGWpSxxtB3AuXCqmDguMr71zBiBOxQQU+34blc/e3pw9y3uQImNXiU/4+1dCqztZM1pfnJw/LwIaDDMIMIvbEWELB2QsIy14SsXCff6CorlSwv/MijOU3Ilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709963174; c=relaxed/simple;
	bh=oy8Q7zZKD9yZ88cE/L+14vw5Q63e+WD9hWREWej3AVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6SDq3a73hIdDrLl5aMLrMd154xr7AYos8ZaWQeOYoYJ5js9VdeycET2bNbMchrlaR1TrBmKO2+o5HXc+iRXbVruEY1i9zS+fHX5T+PDiGQMBOkzCzkGo+e6iFwvoVcmKV6pHUQiXFGjwXyrP90Tq+55H1t3JfPSBfhpiR00C68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dfmxH6ki; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dfmxH6ki"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 653DA3E552;
	Sat,  9 Mar 2024 00:46:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oy8Q7zZKD9yZ88cE/L+14vw5Q63e+WD9hWREWe
	j3AVI=; b=dfmxH6kifrlYn1UjzqF7iwv7muWXm3WfZ7i3Gw4n5ACqkfjH3o95yP
	89H7FVZb1CiJyWszEPLO9X7ePFWaeEMebPhlPHWO6U/ALOdAebpz+X18OGpf+KNK
	HrdTYUeFeO46BZYTjWC5JRBNfmVAUcTBGqpz3wlxqSzLVlJiT6uRw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B3573E551;
	Sat,  9 Mar 2024 00:46:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE3F53E550;
	Sat,  9 Mar 2024 00:46:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood123@gmail.com,  Phillip Wood via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/4] merge options: add a conflict style member
In-Reply-To: <CABPp-BFBNDkdL5Z-VOrv2Z3aWaA3OpWFqd6ZGmU9YC8jBRsAog@mail.gmail.com>
	(Elijah Newren's message of "Fri, 8 Mar 2024 20:33:00 -0800")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<c0d7bafd43823ef9df5a73bc80b90cf003988bc9.1709907271.git.gitgitgadget@gmail.com>
	<xmqqle6shgkw.fsf@gitster.g>
	<48b2d5b1-a59f-44c3-94ba-e7f81913b7f5@gmail.com>
	<xmqqwmqcfz4y.fsf@gitster.g>
	<CABPp-BFBNDkdL5Z-VOrv2Z3aWaA3OpWFqd6ZGmU9YC8jBRsAog@mail.gmail.com>
Date: Fri, 08 Mar 2024 21:46:05 -0800
Message-ID: <xmqqplw4dkki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5389EAAA-DDD8-11EE-8F30-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

> a different suffix), I'm still not understanding why ll-merge makes
> more sense to you and Phillip than merge-ll.
> Could you explain more?

Language and grammar?  In other words, "low-level merge routines" is
an understandable phrase, while "merge lo-level routines" is not.
