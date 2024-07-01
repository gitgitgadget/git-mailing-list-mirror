Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3B2BB04
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857818; cv=none; b=J9IG9mTvzF7uAsH1kpb18cSp+HEqwZDBC7Jo/KSQOO1sbBpora9hMeIMOdWWrgL7mbMtXEvnLgGDkmh0fcyQ96LJz1nlyYpMm+xT/JrgFfNrKYOQLPZRiw3C1GonIGryO32ciQKQvReLhuI7mrdMlcBcNKdc4JVs/pLuHzJBvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857818; c=relaxed/simple;
	bh=s84dThdhke/+fuGs7N9POP8Y64a7Me4I5DxfAWyDaiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6Omygy/Y7GaACsRWsuHqqGCvhxpJAE6xQYyqEB9KpIp5NGL7G+tPgGe9OlChRkh3teag18JEQfsoaMKLcBKAyJd5pNwF7LQlaSIhzwjOHBB6umSe9/SPFZWeM1QBbEX78K73XyjyTbgB9mM7eNL4jjcoHTKara5olLYgXj0ZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UQy+EDr7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UQy+EDr7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BCE0529FF0;
	Mon,  1 Jul 2024 14:16:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s84dThdhke/+fuGs7N9POP8Y64a7Me4I5DxfAW
	yDaiU=; b=UQy+EDr7/ssnaekzVor7ZWgjzfDyEd956Z9S+DFdv2FZbkdmU+/JOH
	z0HfphIF99ukelh54HYez+uDyPLY+OjUkdYtV71Bgnes/71mRIvbV8E+/i7zM74+
	1iJB2YagjOJQe7zIsp0w62FIk/NjEhM/KZC66UyYyHPemXCkdexyk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ADC8029FEF;
	Mon,  1 Jul 2024 14:16:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55B6629FEE;
	Mon,  1 Jul 2024 14:16:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: Determining if a merge was produced automatically
In-Reply-To: <CAChcVu=bWR_DvR==b7L0tn8PmK+9KOWWw+e7RtjMhywMv3W+qA@mail.gmail.com>
	(Pavel Rappo's message of "Mon, 1 Jul 2024 17:08:13 +0100")
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
	<xmqqle2lyvdd.fsf@gitster.g>
	<CAChcVu=bWR_DvR==b7L0tn8PmK+9KOWWw+e7RtjMhywMv3W+qA@mail.gmail.com>
Date: Mon, 01 Jul 2024 11:16:51 -0700
Message-ID: <xmqqbk3hx9ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17CDE7CA-37D6-11EF-AE0D-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Pavel Rappo <pavel.rappo@gmail.com> writes:

> it for such merge commits produced automatically because of the
> assumption that nothing bad can happen there.

I do not think that assumption holds in the first place, though.  A
typical and often cited example is when one side changed a helper
function's behaviour while the other side added new callers to the
helper function, still assuming the original behaviour.  In such a
case there may not even be an textual conflict but the end results
may be broken, and if the breakage is subtle, it may take weeks or
months before somebody notices such a semantic mismerge.

Your "review a conflicted-and-resolved merge on one integration
branch once, and skip the re-review as long as the resolution is the
same way as the original one when the same branch gets merged into
another integration branch" is a neat idea (and the integration
branches we have in our project are run more-or-less like that).

But there, you'd need more than "both are cleanly auto-merged"; more
like "both may have conflicted but they are resolved the same way"
is what you are interested, no?  Since at that point, your primary
interest shouldn't be "does it cleanly auto-merge?" but "do these
two merges do the same thing?", determining if a merge was created
automatically becomes a problem you do not need to solve, or solving
it would not further your true goal.

If you have two integration branches A and B, and a topic branch T
first gets merged to A and then after proving its worth it gets
merged down to B, I wonder if you can verify somebody's merge of B
into T by comparing the result with your "verification merge", which
you preform locally and on a throw-away branch by using "git rebase
--rebase-merges" or some mechanism, to replay the original merge of
T into A on top of B (before the merge of T you are verifying).

