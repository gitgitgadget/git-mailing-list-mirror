Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95935F503
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992872; cv=none; b=ESLe7Zsb9eQ0ceNttVJ0jBfBoyvT1RdOA2II1uxm9uuftIUWO4mBwCDWxB6r+ktpRmREIS8HYJjKdTXg4mSxSBVqtoWSjKAw7DDHgybPRXtAoKfGcxFBYmGFHQmeO8t/kB8sUPw25iZQcZeyDyvqycI/SBYOAc6w8X8gBAdooig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992872; c=relaxed/simple;
	bh=OvZjSOA2zXVlbPt2qbLVXi0uZjCwCf2DBvmRxWmQOug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpMBIrhdVcLzDv5r0L7urVdx7k0Eom1bO4ItBiRJipAFp+ethzEM0YzbjYGncjen2gVrNhxUl2UG9Pt5o9f0LZ1ZLT1bJ4qliOG1tkyr1uUMmsMH3ISVn0QEMfIA0LG2xjsRQOe+FZQeI+CR41VHuODTQYxkESWjSVqjqOEkxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UkC9DuQT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UkC9DuQT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DEA51CEAA6;
	Sat,  3 Feb 2024 15:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OvZjSOA2zXVlbPt2qbLVXi0uZjCwCf2DBvmRxW
	mQOug=; b=UkC9DuQTj7fV2nofCBgNXOzzp5DOiXSUGhNxbYQ09THr+CA9fSTgIX
	C6xFggEJtArErcB/YUIuRm1oKnPYN4lHab1weXktYzMlqTSAQeobYlVOtUth0RVh
	4Gur3vThBqLmn4sQoVjEcdhd8qtgWnMCgffJl/9vvpA5kirZhmvNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28C591CEAA5;
	Sat,  3 Feb 2024 15:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DBA31CEAA4;
	Sat,  3 Feb 2024 15:41:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/2] refs: introduce reftable backend
In-Reply-To: <cover.1706862705.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 2 Feb 2024 09:38:25 +0100")
References: <cover.1706601199.git.ps@pks.im> <cover.1706862705.git.ps@pks.im>
Date: Sat, 03 Feb 2024 12:41:01 -0800
Message-ID: <xmqq8r41qo0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B713028-C2D4-11EE-97D8-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that introduces the
> reftable backend.
>
> This version addresses the feedback by Karthik. I don't think it really
> makes sense to spell out every change here -- the range diff should
> likely be easier to digest.

This, when merged to 'seen' (which also has "for-each-ref now thinks
an empty string is a signal to show ref-like things outside the
refs/ hierarchy" topic, kn/for-all-refs), seems to break *-reftable
CI tests, cf.  https://github.com/git/git/actions/runs/7765401528

I'll tentatively eject the topic from 'seen', even though I have a
suspicion that it byitself would pass all the tests.

Thanks.

