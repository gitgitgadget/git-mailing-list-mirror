Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A711F614
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006308; cv=none; b=iVxtkiU1KQCTkJIzZUDMRtcZdVX+FpiVSlIJNDIMz3SN9Qki9jgWxP/b429jbuNUF4jYk7C/Pdxj5iGv1ooQVjwb+rxPQMM6yNF9c2B+MPjZkshkaoEECmw9MUoaU2XAbBYxqu6JAZ5rKG5B6tQCNa5odWjvOHBcKm3TWDE2QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006308; c=relaxed/simple;
	bh=joSw4/y9B4elC7IcZvLwm4oSaUz4JXIbOkqk56wP1jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGIPouCzU1+Bll538sQMPwX1IiqI+XsGwq+PDa7RVEgJoSwH9BxhEyVOHSxH8tT/UTp/E54szvb7vHaoUpl/UUex4BASNQLB5ng4BWbn7CH/u5D/Wn70JnWdyd2HPAppnFIEzaf2hv3ZU3BLNIscwC1cCOzyZdeqZTJExfSUk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WxIUhrU+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxIUhrU+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DCA4C1A5FD;
	Sat,  9 Mar 2024 12:45:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=joSw4/y9B4elC7IcZvLwm4oSaUz4JXIbOkqk56
	wP1jA=; b=WxIUhrU+va2zmkDIyRLZ8MmksilR7hG0B6QWbtn7myq5tJR0dk+k96
	rZjrlmqwDJE5ZVgffSB/flXBpfldKVveD9Z9izON7gK+hmLh7gdqdmfxbtK8suOx
	1xHcR1FQLs+YeUtJjNq60FTopEcD6P6IIfyT4jSnCVIXUDGqXLaMY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D35751A5FC;
	Sat,  9 Mar 2024 12:45:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 226721A5F9;
	Sat,  9 Mar 2024 12:45:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] The merge-base logic vs missing commit objects
 (follow-up)
In-Reply-To: <pull.1686.git.1709993397.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sat, 09 Mar 2024 14:09:55
	+0000")
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
Date: Sat, 09 Mar 2024 09:45:00 -0800
Message-ID: <xmqq4jdfe1ur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C18AFC38-DE3C-11EE-834B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Jeff King reported that Coverity pointed out a problem in the patch series
> "The merge-base logic vs missing commit objects" (which made it into the
> next branch already): The return value of merge_submodules() is assigned to
> an unsigned, single-bit variable, which as a consequence is not able to hold
> a negative value indicating a non-recoverable error.
>
> I looked into this issue and am happy to report that there are no other
> instances of the same issue in that patch series. The first patch in this
> here patch series addresses that issue.
>
> While looking into this issue I also noticed that the merge_submodule()
> function did not even return negative values! This was an oversight on my
> part (which I attribute with a large amount of self-compassion to my utter
> lack of enthusiasm for submodules as a Git feature), and the second patch in
> this here patch series addresses that.
>
> This is a follow-up for
> https://lore.kernel.org/git/pull.1657.v4.git.1709113457.gitgitgadget@gmail.com/,
> based on the js/merge-base-with-missing-commit branch.

Thanks.

>
> Johannes Schindelin (2):
>   merge-recursive: prepare for `merge_submodule()` to report errors
>   merge-ort/merge-recursive: do report errors in `merge_submodule()`
>
>  merge-ort.c       |  5 +++++
>  merge-recursive.c | 21 +++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
>
> base-commit: caaf1a2942c25c1f1a15818b718c9f641e52beef
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1686%2Fdscho%2Fmerge-base-and-missing-objects-followup-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1686/dscho/merge-base-and-missing-objects-followup-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1686
