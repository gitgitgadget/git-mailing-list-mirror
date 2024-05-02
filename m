Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B31E894
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668895; cv=none; b=ICbZI28piAROa1mPWPEU2V10sI0EFNMrkl7WddxcHcH5oeCNunjX/h68MwFwA4w0XfjGaoRfjGWGMTfhru6tqDoFVKH4USsb5YucH/78KejF8F374jVFCIvd5XkuUUJbM6p2WmtIRNzEeWBQK8bx9FCWA7xlmUMaGkdpXUjbW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668895; c=relaxed/simple;
	bh=esQCX0Zmw/khLQefFwEF5lEZPsVA6F4BZPn8OerzQVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hY/CyaI3bcKBbMXMz5MdyXunNYKOsRqjyVpARNIQKf7aHVB0XoOMDaLRNf/hCGnoQCMhglXc7I5eOw+Rz557EkQDR6HDsN/EwABS01azRFxhq8LLIKLPs54MdHfC2lDGzQLZP0jGSwl7zuqaZLNcvWDuFijQJcSAgiKVPCuPKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uVJIvdJW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uVJIvdJW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8225B21C02;
	Thu,  2 May 2024 12:54:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=esQCX0Zmw/khLQefFwEF5lEZPsVA6F4BZPn8Oe
	rzQVc=; b=uVJIvdJWGtiAS8CMNSiG+FfQnclr6iyazi7ji0qdHEfBL/Fm26bkr5
	mALTqQRubbvudIPYGAxPx2ekdNxZ4K3Jk7hVv7bgvamcoRzvlSXulotXNpOO2/dt
	WyiYx8sIvhS3eLSO/+rAMI7IUxKshKQ7Qts5scn0Gxb8/vm0249wE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 789AC21C01;
	Thu,  2 May 2024 12:54:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD15E21C00;
	Thu,  2 May 2024 12:54:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linus@ucla.edu>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 02/10] trailer: add unit tests for trailer iterator
In-Reply-To: <b503b539c6fff7a3894c613dfc603a8241c790a1.1714625667.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Thu, 02 May 2024 04:54:19
	+0000")
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
	<b503b539c6fff7a3894c613dfc603a8241c790a1.1714625667.git.gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 09:54:51 -0700
Message-ID: <xmqqttjgduhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B234A06C-08A4-11EF-9E5C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linus@ucla.edu>
>
> Test the number of trailers found by the iterator (to be more precise,
> the parsing mechanism which the iterator just walks over) when given
> some some arbitrary log message.

"some some", which I think you (or perhaps I while queuing) fixed in
the previous round.
