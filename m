Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43814F9F3
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258223; cv=none; b=srOZWmvc6T9oS1QsEiMyH5c13qFg2hRbq/29/7fOJeOli+QZT8HIR/9cQXYSRB2GCPkoE2WhlKgpu2HOs4KxU/5pXjAfdoKYy9UncW9tcG+AnD5DsWiwr+GiSmg0VlkIrYnb62duK9iz1ehmGgqYCuwTkWVUoZ2aCHVtpT0WMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258223; c=relaxed/simple;
	bh=Ldqpd8AJjtVYWqOJ1EaT6HQ7fHmVc4aldtIVJWe0PZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szOGCnYncFR9GFbovQ9bFeWUpw/cI/ER8xx+21upvU/ESFJxiU+KX+46TDHgxrdzCbEWahD/E92ytrenq5nOXu6vFHgfTWwJqwaKvixdUARrYDM1vMiMU2d5NuxdAL2NWycHn4E7iYymN3smIcgY9m2g+JZwa6vY9g0WiWyYvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wu+Cb3LL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wu+Cb3LL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DBCB2F612;
	Wed, 21 Aug 2024 12:37:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ldqpd8AJjtVYWqOJ1EaT6HQ7fHmVc4aldtIVJW
	e0PZk=; b=wu+Cb3LLbpSaofUr815LnMWEmB0GiM9ieA8064svfFgSc59cygvFZp
	ApQfbTrrKovXKf2x8u+N0zwff4jYcogvQ6PKeiJI9eQeqNeSblJf7b9ewk6q3tvx
	WMBOUXT+seolo2KMQC35gDFKMLO8EwJ3wO4WXl/yYJGDHcg9d2yNY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 65BB32F611;
	Wed, 21 Aug 2024 12:37:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E64D12F60F;
	Wed, 21 Aug 2024 12:36:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  ps@pks.im,
  james@jamesliu.io,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Wed, 21 Aug 2024 11:02:25 +0000")
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 09:36:56 -0700
Message-ID: <xmqqbk1l25p3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 955471B4-5FDB-11EF-AFD8-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Advice is supposed to be for humans, not machines. Why do we output it when
> stderr is not a terminal? Let's stop doing that.

Last night while skimming the series on my phone (read: not a real
review at all), I found it very annoying that GIT_ADVICE=1 had to be
sprinkled all over the place.  I wonder if we want to instead set
and export it in t/test-lib.sh and turn it off as needed?

The end-to-end tests we have are primarily to guarantee the
continuity of the end-user experience by humans, and ensuring that
an advice message is given when appropriate and it does not get
shown otherwise is very much inherent part of them.  An alternative
workaround to counteract the breakage this series causes of course
is to run everything under test_terminal and it probably is much
more kosher philosophically ;-), but compared to that, globally
disabling the "if (!isatty(2))" while running the tests, and
temporarily lifting that disabling during tests of the new feature
added by this series would be easier to reason about, I would
suspect.

> This series is motivated by an internal tool breaking due to the advice
> message added to Git 2.46.0 by 9479a31d603 (advice: warn when sparse index
> expands, 2024-07-08). This tool is assuming that any output to stderr is an
> error, and in this case is attempting to parse it to determine what kind of
> error (warning, error, or failure).

The "anything on stderr is an error" attitude needs to be fixed
regardless of where it comes from (tcl/tk scripts have, or at least
used to have, the tendency, which I found annoying), but regardless,
I thought we added a mechanism to squelch all advice messages for
this exact purpose at f0e21837 (Merge branch 'jl/git-no-advice',
2024-05-16).  Why isn't the tool using the mechanism that already
exists?

I would have supported the behaviour proposed by this series 100% if
it were on the table when we were introducing the advise mechanism,
but unfortunately nobody seemed have suggested it back then.  I am
willing to go with an "experiment" to change the behaviour,
deliberately breaking "backward compatibility", if we have a wide
support here during the review period.  FWIW, I think any scripts
that scrape the advice messages are already broken.


