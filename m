Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558F7C6E2
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809728; cv=none; b=ptTiunVNj/g0tvg5GBxCC1ZfaMQ240p+Lo4Z0dy3BbtENYzq6f+lTUIz07gItAV+IC1w4klFetHukYC4fyqQgZD5BiiPxCGCF7W4OLEcPQQgpovYqWOy7RXyR4i7KlAx+aVKr/EDcY9q8T4Ji2ibQY3lxYiO3yFDgXCF7cGk8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809728; c=relaxed/simple;
	bh=M35i/HVbGLgvbQAknNE/7MZ+1LglSSTlDuj7+xDUYyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KnJx6beliFdopc0BZYUUMa2survzjcjNOB6u2GJdJj6skRFT0Nm/7RP+mPH5l4zHSyOCVwm0KRe0b5g/IpEbWRxUpD+lF+L119tZuGsjYoBgEi3f7VSmB9iNOXexT9Wyf5i/09rfNPqGhez9hEisMBonhTEgG63d/5akd5ahf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsFO9EmB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsFO9EmB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 440D23B74F;
	Thu,  1 Feb 2024 12:48:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M35i/HVbGLgvbQAknNE/7MZ+1LglSSTlDuj7+x
	DUYyM=; b=bsFO9EmBS+z/9H86KMRJ2rZhJknhP4GtyRYzuOHYVSXexlg0V3gCyM
	j6OPN2wZT7estrpMEQFP8yXJVFIXPpQI+yU9Qke1fCk0Ytcbals210zY+muqeFOK
	iY0ro2wOn8xUmT80Ei1QaXF/iBKssFp36hceNFZd1fadTzs7gXEG0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C3693B74E;
	Thu,  1 Feb 2024 12:48:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74B713B74D;
	Thu,  1 Feb 2024 12:48:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Josh Steadmon <steadmon@google.com>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>,  Emily Shaffer <nasamuffin@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <owly1q9x2io6.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Wed, 31 Jan 2024 15:21:29 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<ZbqnSNPjIQW3Durz@google.com> <owly1q9x2io6.fsf@fine.c.googlers.com>
Date: Thu, 01 Feb 2024 09:48:40 -0800
Message-ID: <xmqqjzno13ev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2397454C-C12A-11EE-BC73-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Linus Arver <linusa@google.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> On 2024.01.31 01:22, Linus Arver via GitGitGadget wrote:
>>> This unification will allow us to delete the format_trailer_info() and
>>> print_tok_val() functions in the next patch. They are not deleted here
>>> in order to keep the diff small.
>>
>> Needs to be removed after squashing v2 patch 4 :)
>
> Oops. Will update in next reroll, thanks.

FWIW, by the way, having them in the same patch made it a lot easier
to compare what the original did (with these removed functions) and
what the updated code would do.  When a change is supposed to be a
clean-up of an existing code without changing the behaviour, it helps
to make the before and after versions visible in the patch.

Thanks.
