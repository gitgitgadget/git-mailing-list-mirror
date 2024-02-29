Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F82446C9
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248901; cv=none; b=HEmwqovfgvrP+4IUBYrircP5X2aEZtH2fXt9pBVRacVERkW49XPxuUVaKcPqB0iE6aN1uNmGptZTZtyOYg+80bew8S5Muxh1uD95p4twMbHNeEqvtEaB7+t3QLfsXCgswYnn01MWZjstQktUzgWXrF34VpQlhejdwBi/F5IDxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248901; c=relaxed/simple;
	bh=T9KEnGyqJdvr34cpCG0s81ae8SFFyZyJQwu0GeBMLpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjfQPVz9jCrqWlYtxVu/6FUGkFk1t6B9iiH2AM9e82025i5ayktQmnLu4BR4MELDjziYrHMiK91/5bEu4/Y1cGhAXmmHaeTR9mLtmC2LXPw4mRlF56Y8wqv7E5d9C2d1CPr/E0cJ57rFlSxMxCOCiaL/+9VQlgBHmzfkpWwrS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nlBPy5/L; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nlBPy5/L"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 35BDE37634;
	Thu, 29 Feb 2024 18:21:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=T9KEnGyqJdvr34cpCG0s81ae8SFFyZyJQwu0Ge
	BMLpM=; b=nlBPy5/LTI5avaZmBdtZTx7wJi+XknOQCMMdE6p3GFa4wfFvWAMeMl
	7BFoaaNi4GUFo1Om1F+6aylO7qtdOR16QgeLmeHqktspYtV6rjxHQ7xBdkhzd2oo
	hImZnBlvkJKHvwGzYzV2efpz5BPiYSmXmTn+USK95ZdNJJR7XR0K0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EB3637633;
	Thu, 29 Feb 2024 18:21:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 260B637632;
	Thu, 29 Feb 2024 18:21:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Linus Arver via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>,  Emily Shaffer <nasamuffin@google.com>,
  Josh Steadmon <steadmon@google.com>,  "Randall S. Becker"
 <rsbecker@nexbridge.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v5 3/9] trailer: prepare to expose functions as part of API
In-Reply-To: <owlyttlq529h.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 29 Feb 2024 14:33:46 -0800")
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
	<CAP8UFD1dE2EiSxohose6U9SGn+zeHPyVB=KZ2xdQi-v-a8d1XQ@mail.gmail.com>
	<owlyttlq529h.fsf@fine.c.googlers.com>
Date: Thu, 29 Feb 2024 15:21:32 -0800
Message-ID: <xmqqedcuc0w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 47343D62-D759-11EE-B453-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Linus Arver <linusa@google.com> writes:

>> Nit: this patch and the next one will become commits, so perhaps:
>>
>> s/In the next patch/In a following commit/
>
> TBH I've always wondered whether "patch" or "commit" matters --- I've
> seen examples of patch series that referred to "commits" instead of
> "patches", and vice versa. I was hoping to hear an opinion on this, so
> I'm happy to see (and apply) your suggestion. Thanks.

I think it is just fine to use either; sticking to one you pick
consistently in the same series would have value.  If you prefer
commit, then fine.  If you like patch, that's fine too.
