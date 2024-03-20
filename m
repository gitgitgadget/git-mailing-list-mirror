Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25864F1E5
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951070; cv=none; b=aNsPlpvJHKSDiHrmpMmwWoKw/5nMLT6CQlA6JqA/MWklveRUUfmkyZBR8xekOb2YreI81tCOn3QdPXpXW6jlEfwdCDYdYLxbp+BgdYxc2Zk4VoBg0gIH+nayrxOEIo76v42XMDztnxsy3xAW7WCSad49CkFuKNukj/oFywyy/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951070; c=relaxed/simple;
	bh=HX0Lk/ZhlGh3mb7dBR7swAPTVZ2rJt9/GunlrhaEeiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRNtFpsBnslPFwGUAZTNX/Rp3KkgKVpg/fjzXHAQGPXbjxpdUSIs7csJYFkTWBOXpxXZL0IMFKrOfazL9A09ulFgE1f+PhRLFxfxWWTMTPVAly94RQktY84DN0wO+VgyGuDzUPn5A9F01VAUiPs87/743/T0C42jucfpWqVr5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tcyTqLN3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tcyTqLN3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7227930601;
	Wed, 20 Mar 2024 12:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HX0Lk/ZhlGh3mb7dBR7swAPTVZ2rJt9/Gunlrh
	aEeiE=; b=tcyTqLN3tGd8aKsh9+0vUceVj6QOy2skKnuwaFtGqyUHOIf9LYYtFt
	oHX07z/GEfTT+Qx/OjamYxs5pp0CT8zVD2pSCowaSa3N0OxT979K061bqQVOeSu0
	LCkF+VNqFRmiEeMV9jH191ge8Tn7wggpSPaJ6Z4v9VcTxkwJJoBh4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6ABAD30600;
	Wed, 20 Mar 2024 12:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC9B0305FF;
	Wed, 20 Mar 2024 12:11:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>, phillip.wood123@gmail.com,
    =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <17be81eb83ff314d.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Wed, 20 Mar 2024 15:15:56 +0000")
References: <17be81eb83ff314d.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Wed, 20 Mar 2024 09:11:03 -0700
Message-ID: <xmqqmsqshoiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7407DB70-E6D4-11EE-80EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

>>  "cherry-pick" told to keep redundant commits needs to be allowed to
>>  create empty commits to do its job, but it required the user to
>>  give the --allow-empty option, which was unnecessary.  Its UI has
>>  also been tweaked a bit.
>
> Note that the description here is a little out-of-date; we're no longer
> changing the relationship between --allow-empty and
> --keep-redundant-commits (and the user didn't have to manually supply
> --allow-empty previously). I'd summarize this as:
>
> 	Allow git-cherry-pick(1) to automatically drop redundant commits via
> 	a new `--empty` option, similar to the `--empty` options for
> 	git-rebase(1) and git-am(1). Includes a soft deprecation of
> 	`--keep-redundant-commits` as well as some related docs changes and
> 	sequencer code cleanup.

Very much appreciated.  I wonder if we can have a better workflow to
do this, like perhaps contributors write a paragraph in the cover
letter with the expectation that it will be used in the What's
cooking report (which will become an entry in the Release Notes when
the topic gets included in a release)?

> You can expect a v4 reroll tonight to address a few remaining comments.
> The only thing I haven't heard back on is this change [1] to the docs
> for the new `--empty` option, but I'm confident enough in my proposed
> alternative there that I'm comfortable rerolling even if I don't hear
> back today.
>
> [1]: https://lore.kernel.org/git/CAHPHrSfiMbU55K2=8+hJZy1cMSRbYM77pCK8BdcAPHLvapHO_A@mail.gmail.com/

I added a few folks who were in the review discussion to Cc: of this
message.

Thanks.
