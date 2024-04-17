Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F521411CF
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368478; cv=none; b=eK5gksEEsvxDFs7M21ZvL/xjNOmuh6qarAteNUCOVsAa0ZM6Y4m5+P9xQUbyvK5XO5GkXR4h7bEnc2JbfILUv16obeZGFu5BHuCYWE7breNqZTKcLMNOsE3gS8DOgaHzVryF2PbG8S6yVfhVY2wK8t1Z0zu2mrpUDvNNBDsNn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368478; c=relaxed/simple;
	bh=H8EnqBZ7CuIKp244bcLimy0uKYAGiOgytCkdxSEttJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CbcChC6bNaovI/4ZKVHS3BZGXsI8mi3oy+opgbTeZlfcLiCKiaGOCv9o6C1DQh4H+QaR3Yn3coHHIvZvycNR2pfqctPMa2Ww+PGNwRY2SDaj1n5PIGCfQMs6XcDUYNv8atVlsvUUO9KARCt8d65KdpSRHf3jUIAt6nDOjsI6wdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R7OVicxg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7OVicxg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E567B1DA8D0;
	Wed, 17 Apr 2024 11:41:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H8EnqBZ7CuIKp244bcLimy0uKYAGiOgytCkdxS
	EttJU=; b=R7OVicxgQisCRUJHv4r/dw2HP8957Z4sz1ANhQU4NFrAOaoHxIehU7
	it7SoreKiu9lL918Vh05I94sVlp+CJrvWohKoH4dQXe7KuEN8a5Pb1fYblcM0c7V
	6dr1jeUShYETx86OIQu03KxAPggEG24jwa3JRGHeCq1gT2Z4pCTuM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D0D1DA8CE;
	Wed, 17 Apr 2024 11:41:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9CB1DA8CB;
	Wed, 17 Apr 2024 11:41:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] maintenance: running maintenance should not stop on
 errors
In-Reply-To: <a86bcf2e1a0aadaaaeb5bfe5b0a4a0fa12594921.1713342535.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 17 Apr 2024
	08:28:55 +0000")
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<a86bcf2e1a0aadaaaeb5bfe5b0a4a0fa12594921.1713342535.git.gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 08:41:14 -0700
Message-ID: <xmqqo7a89eud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECE11824-FCD0-11EE-9787-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In https://github.com/microsoft/git/issues/623, it was reported that
> maintenance stops on a missing repository, omitting the remaining
> repositories that were scheduled for maintenance.
>
> This is undesirable, as it should be a best effort type of operation.
>
> It should still fail due to the missing repository, of course, but not
> leave the non-missing repositories in unmaintained shapes.
>
> Let's use `for-each-repo`'s shiny new `--keep-going` option that we just
> introduced for that very purpose.
>
> This change will be picked up when running `git maintenance start`,
> which is run implicitly by `scalar reconfigure`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/gc.c           | 7 ++++---
>  t/t7900-maintenance.sh | 6 +++---
>  2 files changed, 7 insertions(+), 6 deletions(-)

Other than the N_("") thing Eric noticed, I didn't find anything
glaringly wrong in these two patches.  Nicely done.

We may want to fold overly long lines we see in the patch, but I'd
prefer to see it done as a post-cleanup task (#leftoverbits), as the
lines in the preimage of the patch are already overly long.

Thanks.
