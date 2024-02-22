Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078C2BAE8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621546; cv=none; b=GrgW4aCdqDXQuPSh+Sqmw6iAJLu2uitovF1ajwgwr/Vve3hkymtv6zMPlAtj0JjaKFZY3/9sNAM0/1twT5CMvR9cITRcw001+gcggpZKjXwrGzD4raIX8bGDTmLtuSJyMHGYCg1pSJT0jxn9NMrEzk7hxWJB4a4x/ftqLsxhqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621546; c=relaxed/simple;
	bh=UtIKbwQRcSSLymOFpA+nkEhBoTreXxZMPdIexsq7CqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhKnhARv49Y2WZRKwwfVTyP68B2SO0bAQh0zkXjcfcH3zYUJ+C4AKO0DoCPzSrge8Mq3rnfihpN1il7FkUNcwjAkHOqtDTKHUFada2Y809ryjagj2FFgx7+M6HG91L/0drXIwSRLTgCCnyYjuG0QuVkAZQ86QevskklNhWjqeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Opp8dmWm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Opp8dmWm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 007F51D5F0C;
	Thu, 22 Feb 2024 12:05:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UtIKbwQRcSSLymOFpA+nkEhBoTreXxZMPdIexs
	q7CqI=; b=Opp8dmWmbu3Wq3/DbcJaPSUmmN7mM3HyNJWbqsWzEBw3P7b1JkvfFA
	01aqFZXkSZgSPm8TtDt9vtgl4XdU8lQVkvGpQ4TtDaPsbdI6BHvrFD3lR3NAIdtX
	b/Pfgd8APZB0zrO88R0Y9J5hghwMXYs3BZXmGVMfuh/NhBJBNbajY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED0BF1D5F0B;
	Thu, 22 Feb 2024 12:05:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 610711D5F0A;
	Thu, 22 Feb 2024 12:05:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/5] Always check `parse_tree*()`'s return value
In-Reply-To: <dbde46bc-501e-8433-0b8d-b83d0ca9e759@gmx.de> (Johannes
	Schindelin's message of "Thu, 22 Feb 2024 15:08:08 +0100 (CET)")
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<ffd38ad602a53dfe72cdbfe0d098ca43e7443895.1707324462.git.gitgitgadget@gmail.com>
	<CAPig+cRK_2BWYkcgaZ1pMJJtztepeEJCwuevJNj6gJwRoJgF5g@mail.gmail.com>
	<dbde46bc-501e-8433-0b8d-b83d0ca9e759@gmx.de>
Date: Thu, 22 Feb 2024 09:05:42 -0800
Message-ID: <xmqq8r3ch1jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D034E28-D1A4-11EE-9277-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If you happen to reroll for some reason, perhaps: s/Always/always/
>
> Unless I am missing something we only ask the part of a oneline after an
> initial "<something>:" to be downcased.
>
> At least all the "Merge branch [...]" commits are still capitalized and
> nobody complains ;-)

Of course.  Merge commits and single-parent commits are very
different.

I suspect that the lack of "<area>:" was what triggered the comment,
but this being more about the callers all over the place in the
code, it may be hard to say what "area" this belongs to.  If I were
pressed to choose:

    Subject: parse_tree*(): make callers always check return value

would probably be what I would choose, but I usually opt for going
the lazy way of not labelling the area at all ;-).

