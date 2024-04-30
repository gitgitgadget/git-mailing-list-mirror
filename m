Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661212C819
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511729; cv=none; b=U0fRKhbFBwsC6mIlEgeUyFvkK68RbntaagMTiddS7pjmFCZuz4tP4GPActJ1GKk9hKnoJvb0nG702myuDjDWII00euZ57QjpzmZz77UxRySWoPlxMdjuu8Fn7sWNuiVpjfl/HV1q6NE4NTjrielGyKZOUSYDvfcVlzWodODpXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511729; c=relaxed/simple;
	bh=XiJp9sqTCU+XUrJkMlecvRZOYsrl4JFx7GGRBK6vmG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kyAX7Ca2BAd90NNDbo7bvwDd5wpCBbj1NNaf7CNSGTB9m3tGOXqmXmpHbF5ni06G3pXOGfzL620Y517OYMOzdDEpgKxz2qJ/FaDRN1CShu2TOUvuLnGgXK+y0T/4zBhGRHzAksVysPO/MFHbZ/22uckItYf9HgXO1pX9u4Aq8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZ2ZUv0F; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZ2ZUv0F"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BD83223BE;
	Tue, 30 Apr 2024 17:15:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XiJp9sqTCU+XUrJkMlecvRZOYsrl4JFx7GGRBK
	6vmG8=; b=ZZ2ZUv0FSCQ3waqRoye6PEwo5Nb3P9xLwrwj9GUu6AoRaX9KDEYEaX
	q8nht5cs+iNKUTJkd2kH+Vh2/hx8AmKm7LYbvAV37OH1aj7zKimlc4VPHOb2SpWq
	PX3H/D55lxmLtXLMZV7WFdCJEovsuB+rprbv//zKWSeVfUGtKOcYk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9349D223BD;
	Tue, 30 Apr 2024 17:15:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EC28223B9;
	Tue, 30 Apr 2024 17:15:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v5 0/7] test-tool: add unit test suite runner
In-Reply-To: <cover.1714506612.git.steadmon@google.com> (Josh Steadmon's
	message of "Tue, 30 Apr 2024 12:55:50 -0700")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1714506612.git.steadmon@google.com>
Date: Tue, 30 Apr 2024 14:15:20 -0700
Message-ID: <xmqqbk5qy2l3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C16E3C6A-0736-11EF-8829-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> For various reasons (see discussion at [1]) we would like an alternative
> to `prove` for running test suites (including the unit tests) on
> Windows.
>
> [1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/
>
> This series extends the existing `test-tool run-command testsuite` to
> support running unit tests. In addition, it includes some small
> cleanups:
> * move t-basic out of the unit-tests directory
> * don't hardcode the shell for running tests in `test-tool ... testsuite`
> * don't hardcode a test name filter in `test-tool ... testsuite`
> * add a test wrapper script to allow unit tests and the shell test suite
>   to run in a single `prove` process

I am OK to see it outside the scope of this series, but we would
need unit tests supported by the GIT_SKIP_TESTS mechanism (or an
alternative mechanism written), given that I hear "migrate tests to
unit-test framework" every once in a while, which means we would
accumlate more and more tests that ignore GIT_SKIP_TESTS mechansim.

I did spot one potential problem (rather, "we'd want to fix it as we
are changing it with this reroll anyway"), but other than that I did
not see anything wrong in the other patches.

Thanks.  Will queue.
