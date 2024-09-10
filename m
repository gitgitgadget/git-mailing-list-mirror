Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6351741E8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000588; cv=none; b=mjRtXyx3FINYSw6VgD7D7QIozFgBjfpFWKS/VOg3PCS8sIJglx9O5840NnAjpfB3QqfzhwBHkgZXWsWgC+1pioWOScYZFbMmRKqNuhr4KcQIRk6TIFyTNt728xol/XE+UXDvzQSOCRFakQ3OJDNpTv0Bqn+KFINE6B2XHTIBN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000588; c=relaxed/simple;
	bh=YGBjYFojN1n2aLf8BL2XOZ00f8kUUUdbB39nyKZ/0xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKq5llgrgFbrslrxuiTJMgCr0iD9BlFjcK4SEtePfwa4yYipQknR/RRfWmg301VJn+l12KKxC+SoQjMdnn7jQVwfUFL4uM0A4Jn79cWE3GtXxA3+Rt33AF7wBAwYm4YEVJqPZV27O6xglCAnYCqxk5ISOSs8aeBF6Fbs2KVJWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uXDZLRVY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXDZLRVY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 599C23BF93;
	Tue, 10 Sep 2024 16:36:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YGBjYFojN1n2aLf8BL2XOZ00f8kUUUdbB39nyK
	Z/0xw=; b=uXDZLRVYCzaQS2Fugub/qoBOSwf4Hbt02yUgLxDAKNPDyIyceOJLBA
	dzdmWMrNcqfrXisq118YQUf7U1hHxxu5ji5BjrI35/9/K4ThEFVML9SFMODWws58
	B/BamDDfBt86kgP2v0Zb/HeliYwvYO7ZYVMwfdB2vprSHdWMIQ3fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5014B3BF92;
	Tue, 10 Sep 2024 16:36:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB2D03BF91;
	Tue, 10 Sep 2024 16:36:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
In-Reply-To: <xmqq4j6nlcfy.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Sep 2024 09:07:29 -0700")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<xmqqjzfkr9b0.fsf@gitster.g>
	<0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
	<xmqq4j6nlcfy.fsf@gitster.g>
Date: Tue, 10 Sep 2024 13:36:22 -0700
Message-ID: <xmqqikv3dz5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 584130DA-6FB4-11EF-951E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> The thing that surprised me is just how effective this is for the
>> creation of large pack-files that include many versions of most
>> files. The cross-path deltas have less of an effect here, and the
>> benefits of avoiding name-hash collisions can be overwhelming in
>> many cases.
>
> Yes, "make sure we notice a file F moving from directory A to B" is
> inherently optimized for short span of history, i.e. a smallish push
> rather than a whole history clone, where the definition of
> "smallish" is that even if you create optimal delta chains, the
> length of these delta chains will not exceed the "--depth" option.
>
> If the history you are pushing modified A/F twice, renamed it to B/F
> (with or without modification at the same time), then modified B/F
> twice more, you'd want to pack the 5-commit segment and having to
> artificially cut the delta chain that can contain all of these 5
> blobs into two at the renaming commit is a huge loss.

Which actually leads me to suspect that we probably do not even have
to expose the --full-name-hash option to the end users in "git repack".

If we are doing incremental that would fit within the depth setting,
it is likely that we would be better off without the full-name-hash
optimization, and if we are doing "repack -a" for the whole
repository, especially with "-f", it would make sense to do the
full-name-hash optimization.

If we can tell how large a chunk of history we are packing before we
actually start calling builtin/pack-objects.c:add_object_entry(), we
probably should be able to even select between with and without
full-name-hash automatically, but I do not think we know the object
count before we finish calling add_object_entry(), so unless we are
willing to compute and keep both while reading and pick between the
two after we finish reading the list of objects, or something, it
will require a major surgery to do so, I am afraid.

