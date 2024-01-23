Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314F5FDA8
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033943; cv=none; b=q/JZPEMLBUJ4pdPMNni7wbFvG7ty1a9GWTHZrV9c5xIhAugZOTCalWXq0Bgw1blGOzHAYw+UNRbK6lVMyzf47w11ThfzQFUdtNQy1WGI3P+Mx+YKinsITBBitjHn16THp0FVeASPQrx5uBbap6HBXLVSh6LIsJkxhpPHweUlEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033943; c=relaxed/simple;
	bh=8gyTJahCH0OWB28uy6K75CdaCrGtsI64v+5DFT92Jk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TW2GmenK5SxL80XSqAeUDupbN5JAFWmO8tOoix73+vv1t1k1phHAFmjyxATU2pY8Nz3e8g+5aucr0cgWK5cnhtLMz0SdfvivESTMFoo2PSXSd2oGqiuSSGNcajZNkkQ5WqZNeXVZVhAnpAVhi/UETMTa8CWZ9rDRjgHQEWlQen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QKYW/liQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QKYW/liQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 69CE7328DF;
	Tue, 23 Jan 2024 13:19:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8gyTJahCH0OWB28uy6K75CdaCrGtsI64v+5DFT
	92Jk4=; b=QKYW/liQJa/HkhWEWGajvaNfHzBXuOTNz+D0ch/23N82NyeF6BuKI6
	mNpHO3CF0V0VtS0qQyo2Tdosmi3ipb467NM7hfxQbOvobG7uEOH1l0lfGVOGthgw
	8Jnh6QdIkxhr52nHnM5SJXyE6UIuYr+LBmVOcvDy8tFrNQlfNSf6c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 631D2328DE;
	Tue, 23 Jan 2024 13:19:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE5A7328D6;
	Tue, 23 Jan 2024 13:18:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: brianmlyles@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  newren@gmail.com
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for
 redundant commit options
In-Reply-To: <7bf5036b-9f55-4451-a13c-8a2c815dfbb7@gmail.com> (Phillip Wood's
	message of "Tue, 23 Jan 2024 14:23:52 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<7bf5036b-9f55-4451-a13c-8a2c815dfbb7@gmail.com>
Date: Tue, 23 Jan 2024 10:18:56 -0800
Message-ID: <xmqqy1cfnca7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DFFE3BAC-BA1B-11EE-B42B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> This implication of `--allow-empty` therefore seems incorrect: One
>> should be able to keep a commit that becomes empty without also being
>> forced to pick commits that start as empty.
>
> Do you have a practical example of where you want to keep the commits
> that become empty but not the ones that start empty? I agree there is
> a distinction but I think the common case is that the user wants to
> keep both types of empty commit or none. I'm not against giving the
> user the option to keep one or the other if it is useful but I'm wary
> of changing the default.

This may not a new issue introduced by this series, but one thing I
would be worried about the usability of the keep-redundant is that I
know it takes more than one tries of cherry-picking of the same
series, at least to me, to get a series right.  The initial attempt
may make some commit empty and thanks to --keep-redundant they will
be kept, but I'll inevitably find more things I need to tweak and
cherry-pick the resulting series, possibly on a different base.  And
to this second round of cherry-pick, these "were not, but now have
become empty" commits appear empty from the start.
