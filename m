Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AE13E032
	for <git@vger.kernel.org>; Thu, 23 May 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475288; cv=none; b=M53ToFZKK0NT99mTnKH+D+TMdRMRxY4Ibseleq+UckrPrvU95Sie60vWsipgBhEso6GCNxfORGj+GV2hfc1/BdLUo6xyqFfOuy2wTM84WNrzsi85TV6Ud/kRciEeVE1Qfz65736dyOY9+6OEAZF0tbB+6zMJW2+IPImdU8sccuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475288; c=relaxed/simple;
	bh=LETPSfn6EQNqQIFo5yA+ZzbUXktkZwN8VzWz87jTMt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYgd4LB/mMpN7Ag6pQFjPvwNgABipz+p2Vo3kWgO0jpaL/yZJyw6wlypbhsWMCMorCFGjyTJmvtMnE48wx+gmb9t0eNujxfHv1Cd/dRUmzb/OP004VWZqpXpugIGW7yUd2Z1xzD5GfwaHf35rJ+qhgvXbQYHKdtl8Ng/eYkQEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kKlKn8Px; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kKlKn8Px"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1863420489;
	Thu, 23 May 2024 10:41:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LETPSfn6EQNqQIFo5yA+ZzbUXktkZwN8VzWz87
	jTMt0=; b=kKlKn8Pxqwu4JKaZTknAFJo3F/M5ObgMX/NFeYaS2K028MfiqlCZmu
	ATSzgE3oUk40izGdEiEm3qMcPIreCSHSJP0PoA8oZYmd0QlPnZuRY+DGrn/bLxSX
	6vmA5bvTUXTEyO+aAhxF7pfq9Q6fJshzpFirpPywcMYOHGuijvnuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0519F20488;
	Thu, 23 May 2024 10:41:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B9AA20487;
	Thu, 23 May 2024 10:41:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Reviewing merge commits, was Re: [rPATCH 13/12] Merge branch
 'jc/fix-aggressive-protection-2.39'
In-Reply-To: <79a2c761-870a-cc0c-ce46-440af3bad152@gmx.de> (Johannes
	Schindelin's message of "Thu, 23 May 2024 12:36:00 +0200 (CEST)")
References: <20240521195659.870714-1-gitster@pobox.com>
	<20240521204507.1288528-1-gitster@pobox.com>
	<79a2c761-870a-cc0c-ce46-440af3bad152@gmx.de>
Date: Thu, 23 May 2024 07:41:20 -0700
Message-ID: <xmqqfru8y4j3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86593A10-1912-11EF-8E81-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Much of what is tricky about these merges
> happens outside conflict markers.

Yes.  In other words, what you do not see in these outputs can be
leaving semantic conflicts unresolved.  If we made a change to a
location where there wasn't a textual conflict (i.e., making an evil
merge) in order to adjust for a semantic differences (e.g., they
added a callsite to a function whose signature we updated), any of
"git show --cc", "git range-diff", and "git show --remerge-diff"
would show.  If you failed to do so and introduced a bug (and worse
yet, unlike "oh, we now require one more argument to the function"
that compilers would catch for us, there are differences that
compilers would not notice), none of the three will show.

> If it was up to me to verify such fixes, short of using Git and validating
> the correctness by performing the merge independently instead of trying to
> accomplish the validation by looking at a plain-text mail, I would compare
> the diff of `maint-2.39` to the diff of `maint-2.40`. Something like this
> [*1*]:
> ...
> Both the remerge-diff and the range-diff output do nothing, though, to
> help verifying that no-longer-needed `#include`s are removed (you can see
> that `#include "copy.h"` was removed from `hook.c`, but if that had been
> missed there would be no indicator thereof).

In short, you are agreeing that between "remerge-diff" and "range-diff"
there is no difference in power to let you notice what is *not* there,
and I am agreeing to your "what is *not* there is often more problematic",
so we are on the same page.

I do not think I am married to "remerge-diff" output, but it being
the same form of the familiar "single-parent" patch, I personally
find it far easier to read than "diff of diff".  We may differ at
that point, but it does not matter, as neither of our preferred
format is adequate for the job.

;-)

