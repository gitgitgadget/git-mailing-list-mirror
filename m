Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7721836CB
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030610; cv=none; b=vGm/C8gJdj8mf1+gpnQiP03ttSrWCu2vhE9+ykds6tt64XRx9qN2x46IOKL9HbrQ4navqzbHh4tcDk4m3XSJY88/vPBlu5oARXoMjSSOUGsQnbV6RSzM/lEQAbw2ie2FzWXJcJji1dBB5fRsMilLpepAofa/eRmzwOJ0nUVnlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030610; c=relaxed/simple;
	bh=AuH0iM8Tv6E4dFZOqE0n3hHiFQeaf7b1P+Fg2S+BuJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pl3j/i4cIJC7+G7ce5IoLWF8fxsJXzyZsquulKRgA9CNByJY1KB0+eOgXfNjcxdN7FDYyju+xOiVkwYn5rwA0ShSgiVT/1VyLe2MmMU+JHy5B8HKQpuftWz9LvpfJyIqR4IqXAoK9FMVBJtL27stcxwPG71rEcWP5afOCH/2dWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GNEAUHNe; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GNEAUHNe"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BBA52BB0B;
	Wed,  3 Jul 2024 14:16:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AuH0iM8Tv6E4dFZOqE0n3hHiFQeaf7b1P+Fg2S
	+BuJA=; b=GNEAUHNeYcTvu+jtjPjlIrxxe36PQXPkR4oIQDnc1MxcMoHgU5ZVq5
	kp+n4X9EnAMMpADe6xTFsR8hvMyzPH2SNuC0/5orR8I6O40V6eWJl1EkIEGpKPna
	GbG9mkNXH3jx+MwuaqbUTWOE+TxuXAfA8Q43r0noE2vxaRoQZJ2TY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13CD62BB0A;
	Wed,  3 Jul 2024 14:16:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C802BB09;
	Wed,  3 Jul 2024 14:16:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  vdye@github.com,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH] advice: warn when sparse index expands
In-Reply-To: <pull.1756.git.1720019679517.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 03 Jul 2024 15:14:39
	+0000")
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
Date: Wed, 03 Jul 2024 11:16:46 -0700
Message-ID: <xmqq8qyicpdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6920D1E4-3968-11EF-865A-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Typically, forcing a sparse index to expand to a full index means that
> Git could not determine the status of a file outside of the
> sparse-checkout and needed to expand sparse trees into the full list of
> sparse blobs. This operation can be very slow when the sparse-checkout
> is much smaller than the full tree at HEAD.
>
> When users are in this state, it is common that 'git status' will report
> the problem. Usually there is a modified or untracked file outside of
> the sparse-checkout mentioned by the 'git status' output. There are a
> number of reasons why this is insufficient:

Nicely written to explain why giving an advice message is a good
idea to cover this situation.

Making it possible to squelch comes with no cost (once the code to
do so is written), so I do not have a huge problem with the use of
advise_if_enabled(), but I offhand do not know if the users would
ever want to squelch it.  Is this something that users would choose
to say "yes, I know what I am doing is making my sparse working tree
unusuably slow and I've heard how to whip my sparse working tree
into a better shape already---please do not tell it to me ever
again; because I need to leave these crufts outside the sparse cone
anyway, I am willing to accept the unusually slow response,
overhead, and wasted cycles and power" to?

Other than that, nicely done.

