Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF512D757
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293162; cv=none; b=bblFw/BZZx4soCzZ+cdj0tpvFu4hUcE1bngZyVztrqGJh5neR0wUAw1mKSUeD9H2RMOns6mgJxAsM5pgwsV7pQoMQ42qPF2JXX6GwsAi9Tg2E/XgHcUTbld9ItN19p712H1VwFVsablj2BhYZDrxMFToIft7GhO5LebtwKSzQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293162; c=relaxed/simple;
	bh=bdRV7FApkIWY5JyiwV++gx2IMJvwlw9zxE4SXmPTZak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EtGGzI8O3B/LsLxJYxXbsiM/XmhV3Ix2qvrxVZ1n3PjcIdK+9XWNaLE93dhBWcVJBl9CmvpCjHubYzk9H/SE/PzsizyeUM+py1FCXTOxDeIyxUhz+fZHGoPpGou8A/zgBEUN7Sxdw3+qH+LOjQmmfUmbhyrOPSuhWwRTs9eIG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsCYsA/t; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsCYsA/t"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 440DC29974;
	Thu, 13 Jun 2024 11:39:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bdRV7FApkIWY5JyiwV++gx2IMJvwlw9zxE4SXm
	PTZak=; b=bsCYsA/tOzTygLyZjPKZ0KYkaFlX3lgiA9sMZro+FA0eitpwOtHMZm
	2v9wp0b9krHUz95RLc6SRVWxJ6VV4qbp5MBM72+SWE0QEmNX7hZiBIg+qPyvX9AR
	4LSA5N9a5v2BWHzC0XNtqXl1wSMRG21Mayr+hQsBK0kAP5cVw9fIk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39AC329973;
	Thu, 13 Jun 2024 11:39:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C96029972;
	Thu, 13 Jun 2024 11:39:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 08/20] hash: require hash algorithm in
 `empty_tree_oid_hex()`
In-Reply-To: <66763b5a-3ea6-481f-b4d3-5fad76f5da0c@gmail.com> (Phillip Wood's
	message of "Thu, 13 Jun 2024 11:01:35 +0100")
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
	<4858cca25fe9e57c984fc3181fe8498d0b7222b0.1718259125.git.ps@pks.im>
	<66763b5a-3ea6-481f-b4d3-5fad76f5da0c@gmail.com>
Date: Thu, 13 Jun 2024 08:39:18 -0700
Message-ID: <xmqqv82cn97d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1984A17E-299B-11EF-8B56-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> diff --git a/add-interactive.c b/add-interactive.c
>> index b5d6cd689a..a0961096cd 100644
>> --- a/add-interactive.c
>> +++ b/add-interactive.c
>> @@ -557,7 +557,7 @@ static int get_modified_files(struct repository *r,
>>   		s.skip_unseen = filter && i;
>>     		opt.def = is_initial ?
>> -			empty_tree_oid_hex() : oid_to_hex(&head_oid);
>> +			empty_tree_oid_hex(the_repository->hash_algo) : oid_to_hex(&head_oid);
>
> The hunk fragment shows that we already have a struct repository
> instance in this function which we should use instead of
> "the_repository"

As an internal helper function in add-interactive.c, all of whose
callers deal with "struct add_i_state *", it probably should not
even take "struct repository *" as a parameter.  The state knows
what repository we are working with.

>> diff --git a/add-patch.c b/add-patch.c
>> index 814de57c4a..86181770f2 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -420,7 +420,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>>   			    /* could be on an unborn branch */
>>   			    !strcmp("HEAD", s->revision) &&
>>   			    repo_get_oid(the_repository, "HEAD", &oid) ?
>> -			    empty_tree_oid_hex() : s->revision);
>> +			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
>
> It's not obvious from this hunk but there is a repository instance in
> "s->s->r" which we should use instead of "the_repository"

I agree it is the same issue.

Just like a previous effort, making a "faithful" conversion from the
original that used the_repository implicitly by explicitly passing
the_repository in one patch, and then making semantics corrections
of the original (if we were ever working on a repository in s->r
that is different from the_repository, the existing code is already
buggy) in a separate patch, is a reasonable approach to limit the
cognitive load while reviewing the first step, I would say.

> diff --git a/sequencer.c b/sequencer.c
>> index 68d62a12ff..823691e379 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2263,7 +2263,7 @@ static int do_pick_commit(struct repository *r,
>>   			unborn = 1;
>>   		} else if (unborn)
>>   			oidcpy(&head, the_hash_algo->empty_tree);
>> -		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
>> +		if (index_differs_from(r, unborn ? empty_tree_oid_hex(the_repository->hash_algo) : "HEAD",
>
> The hunk fragment shows that we already have a struct repository
> instance in "r" which we should use instead of "the_repository" here.

Yes, but the same "it is better to make a faithful conversion first,
corrections separately in a later step" would apply.

As the sequencer machinery is inherently stateful, I wonder if we
should pass around not "repository" but a sequencer state object
that may have a pointer to a repository in use.  But that of course
belongs to the latter, i.e., "making corrections", theme.
