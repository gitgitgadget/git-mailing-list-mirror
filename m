Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D161CD30
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477744; cv=none; b=GjV2AWK4HHdP6YRK2jx/0IuGhbXGyhm/Sg+lEedNoZXCdZzuXenr2NKhArGW5Ot4xYCiZrs6PwS8T11UfmNokODvEsnqsbRMzo3k1/Eu+jOadBP1iDv6kb2VChMi649RG7CrL4uTglDg3bAKwVkdN/VNzU6q11rhQvN/MzCpSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477744; c=relaxed/simple;
	bh=0+5XuvJvNjO43x1MXRXEtE6V7VERQle4MXTiI9qVVw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFQaUevPilqcjWtdr/PEdtNFqkyTpRmNXOgLJQSboJp4QWwM7CxPhRqj7mcoONOirzJu+15BzLkDIMv60d2cRMj/suxuYryiBr6ZXduUHSF5BCkWH5z8mevGqHVEv+kVYMTAmLTd8KOvBC+xvltyBaXp6NFrXVOEwVfdieE5puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Am6TQhEs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Am6TQhEs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60CA91F1BC1;
	Tue, 26 Mar 2024 14:29:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0+5XuvJvNjO43x1MXRXEtE6V7VERQle4MXTiI9
	qVVw0=; b=Am6TQhEs+/0zj2tZ0hlvBW1a1A6Xwkk9ASdwbF3SO/8Lkkish1L4ZX
	jMC24vdczAblKUbkB6cOIuCL2e0RVgF1AhAbvTKxtBXR6J3Sz4fGMVkQSdM9Fysm
	1r5DR/0s85ioSQflL4FdEFmKV+bqDw9AyHO5oISLzEJGsSuZdPyI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18FBD1F1BC0;
	Tue, 26 Mar 2024 14:29:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2832A1F1BBF;
	Tue, 26 Mar 2024 14:29:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v5 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
In-Reply-To: <a397f3dd-e4e1-4275-b17d-1daca9e166fe@gmail.com> (phillip's
	message of "Tue, 26 Mar 2024 14:45:45 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240325232451.963946-1-brianmlyles@gmail.com>
	<a397f3dd-e4e1-4275-b17d-1daca9e166fe@gmail.com>
Date: Tue, 26 Mar 2024 11:28:58 -0700
Message-ID: <xmqqplvgalud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B6F59DF4-EB9E-11EE-8383-25B3960A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

> Hi Brian
> ...
>>       +		head_commit = lookup_commit(r, &head_oid);
>
> This version is definitely more readable, thanks
>
>...
>
> This looks strange, but if I do a range-diff locally from v4 to v5 I
> only see the line wrapping changes above so I don't think it is
> anything to worry about.
>
> Thanks for working on this

So, I take it as an Ack from the person who acted as the main
reviewer for this series?  If so, I'll mark the topic for 'next'.

Tanks, both of you.  The resulting series does look very good.
