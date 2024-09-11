Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4E1A38EB
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074313; cv=none; b=cfF1RB2p4ZSx0S1HsJa86fe1Fls23LtyKbXYMviJOyuvd3VPwA3S7Ug4OHuN3DJoryOjrRpIdzJnqIpQ4ocdjzZxlvahbd8o8rVxUxHH/XSiInAqqNEMAP+TBc/Yd+mZpHGVHoLwMgqRFbUgJ5faWKBX/hExM2xDSfLHIx8LhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074313; c=relaxed/simple;
	bh=PwOJ7dpCSow+pPN+6N2FwQeyw8lCb+a2vodV3mltIgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWS+nH3+Oc+RjFvpyxJWkvJw2zyw1LpzKZCW64iImgPfgkjsN3/fhYwnmrS2NTTuMzFGHif15zhbaLq868nP+YK6KSLAqKA9BaUFIO6eJYxHdxtPAZT7vYFdUa9eIrmP4dxJwZFoRJEQY3hJPXXVRxaQGyGn464nqXUrNfPDhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SpowV1vQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SpowV1vQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FAF11B01E;
	Wed, 11 Sep 2024 13:05:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PwOJ7dpCSow+
	pPN+6N2FwQeyw8lCb+a2vodV3mltIgk=; b=SpowV1vQf5eftJxCFy1J9vsyOHDt
	MIHByqxOvPtPERw1GzwRR12yglYbb7Q68592gWVKmci+QS3R4YLN5eNTlByvi9Hl
	sdA1a0PKd5yQuuuNGF6GnbklLjBRb1dXxV4VGsQx5Ih9EtjrNPg+HZsFDJCtX/Ra
	T0LCunW6R6Ou04c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67BD61B01C;
	Wed, 11 Sep 2024 13:05:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 043E81B017;
	Wed, 11 Sep 2024 13:05:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/4] remote add: use strvec to store tracking branches
In-Reply-To: <f30c77bc36072df57662cac0cb7bf1bbea378062.1726067917.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Wed, 11 Sep 2024 15:18:36
	+0000")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<f30c77bc36072df57662cac0cb7bf1bbea378062.1726067917.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 10:05:06 -0700
Message-ID: <xmqq8qvy86kd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FFF718F2-705F-11EF-A4C4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Store the list of branches to track in a =E2=80=99struct strvec' instea=
d of a
> 'struct string_list'. This in preparation for the next commit where it
> will be convenient to have them stored in a NULL terminated array. This
> means that we now duplicate the strings when storing them but the
> overhead is not significant.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/remote.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

This has a slight conflict with a topic that has already graduated
but nothing serious.  If you need to reroll, you may want to base it
on a bit more recent tip of 'master', younger than bb424845 (Merge
branch 'rs/remote-leakfix', 2024-09-03).

Thanks.


