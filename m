Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4659535D8
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379353; cv=none; b=FzIeTOmueJZErwQRqhdjs7szIiBAsP0g1jqGHlIB/IoD5sP90Z4G7NyekWeQ3V6RQodu3+bgVNXNmqRgXwTyaFUgYFlkI3UbwfFWo7aF4Tblpqvt7pst6gv9j9QfXLNLh6OdN1S+nq8GzRu+xTT4MgzkqqXjuCSyWxH13e+Mfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379353; c=relaxed/simple;
	bh=dSVluCzsar0vsuI7M8f5aftFWnIxV3Wq9DmkExCAL5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwNU01+e9pC0aBOyBO1JLbnGjMCxT5SjdCMSpyPlTwRnIroWDvQijtxAQ9VlxEiPx+/5HkDWfgs5vpxJnmcwNWxl4OZ7fa6yVQ17MuNsb5fCbKfzeXYwFV/gxfJ1bHDB1xZLZgP2kks040pHZfwZthGGHkEJYTp+4mKeksLQtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eT/MbuA8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eT/MbuA8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 839961E1CEA;
	Mon, 19 Feb 2024 16:49:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dSVluCzsar0vsuI7M8f5aftFWnIxV3Wq9DmkEx
	CAL5c=; b=eT/MbuA8xMWgTWwFAjsfTe3wTLpX3sH6TjeYofon4KETOAGcYYGoHM
	WJM75Ox2mQjuX7D4+TgzsCamWRxK3sEn/nOKTWGz8JAjzEuFJCWycGzdS8GvMKCU
	zz49QXurRjF+VWIWpJ2MeSyxsgYgvWKq6D6yUIYuqjLZitaCqOR/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77A291E1CE9;
	Mon, 19 Feb 2024 16:49:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E364E1E1CE8;
	Mon, 19 Feb 2024 16:49:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 2/2] apply: rewrite unit tests with structured cases
In-Reply-To: <7dab12ab7b8af3e6a0778fc1a01dd1479990bcff.1708317938.git.gitgitgadget@gmail.com>
	(Philip Peterson via GitGitGadget's message of "Mon, 19 Feb 2024
	04:45:38 +0000")
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
	<7dab12ab7b8af3e6a0778fc1a01dd1479990bcff.1708317938.git.gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 13:49:08 -0800
Message-ID: <xmqqcyss5dm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B674CEB2-CF70-11EE-82C6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Peterson <philip.c.peterson@gmail.com>
>
> The imperative format was a little hard to read, so I rewrote the test cases
> in a declarative style by defining a common structure for each test case and
> its assertions.
>
> Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
> ---
>  t/unit-tests/t-apply.c | 123 ++++++++++++++++++++++++++---------------
>  1 file changed, 78 insertions(+), 45 deletions(-)

In this project, we do not add a version of a known-to-be-bad file
in patch [1/2], only to be immediately improved in patch [2/2].
Unless, of course, there is a good reason to do so.  And "to
preserve the true history of what happened in the developer's
working tree" is not a good reason.

We give our developers "rebase -i" and other means to rewrite their
Git history, not just because we want them to be able to pretend
that they are a better developer who never make such a mistake or
misdesign in the first place, but because a polished history is
easier to review in the shorter term and to maintain in the longer
term.

Thanks.
