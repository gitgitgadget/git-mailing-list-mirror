Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C327F9D6
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914000; cv=none; b=pwp2E9gM2Vh3Feqg4AuF4bN/NOYrR+BZbgUi3Cb7rNQM8alDg5baKnaOKi6VltSFShn5EuwmG/6LyyKnIoyMLcELCXhFQ+Xm6sC+n0VENWDXZHlzHwbcQ3AnXy3IdW3DuDCEPcZlbfmb/n5MtsvosS3JNfRJ1jYdUKJaOVxAL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914000; c=relaxed/simple;
	bh=tavX8kidFTcxFwFxmt5LYHM0/C62PYF7NNh6+WRLXEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4GK3xjlzzvMzX6CtO8Sdzy6+xFAyTwR4HcbTPUnKCHq2ipQxopAiUNWASeTrAIfucReY4MQJb3f+D3oKOdXcZSg/xYIGMDqv3NMhExYffXaiBm3cMRF3rwthU8rR/gNCCGoCeTJWTzvWjsXzZxXFUU/J0Z+4vGfq4FQCP6qoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZRnM2Ghn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRnM2Ghn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 23F96290A8;
	Tue, 28 May 2024 12:33:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tavX8kidFTcxFwFxmt5LYHM0/C62PYF7NNh6+W
	RLXEM=; b=ZRnM2GhnQ5L8+aBo/18c5fCCSkmDIZnUwZTQwcYvxWi9+EcODoeodu
	KjJjHiH74Jux32DQiPPfXovqfC0LPi41feFDPx5UrmKNMvRYShrm1XadPDy3sYrC
	k+LU2POGvWoWu9xRRxtC9qMNQBgTY/FcXIM6C7R2oCLu36AEtyeWo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 19FAC290A7;
	Tue, 28 May 2024 12:33:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0621A290A3;
	Tue, 28 May 2024 12:33:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 2/2] apply: do not use the_repository
In-Reply-To: <ZlWHgBROsPBrmM0D@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 09:28:00 +0200")
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
	<36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>
	<ZlWHgBROsPBrmM0D@tanuki>
Date: Tue, 28 May 2024 09:33:07 -0700
Message-ID: <xmqqh6eh7v7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F7C5EA44-1D0F-11EF-BE67-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 28, 2024 at 06:32:01AM +0000, Philip Peterson via GitGitGadget wrote:
>> diff --git a/apply.c b/apply.c
>> index 901b67e6255..364c05fbd06 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -3218,13 +3218,13 @@ static int apply_binary(struct apply_state *state,
>>  		return 0; /* deletion patch */
>>  	}
>>  
>> -	if (has_object(the_repository, &oid, 0)) {
>> +	if (has_object(state->repo, &oid, 0)) {
>>  		/* We already have the postimage */
>>  		enum object_type type;
>>  		unsigned long size;
>>  		char *result;
>>  
>> -		result = repo_read_object_file(the_repository, &oid, &type,
>> +		result = repo_read_object_file(state->repo, &oid, &type,
>>  					       &size);
>>  		if (!result)
>>  			return error(_("the necessary postimage %s for "
>
> We call `get_oid_hex()` in this function, which ultimately ends up
> accessing `the_repository` via `the_hash_algo`. We should likely convert
> those to `repo_get_oid()`.
>
> There are also other accesses to `the_hash_algo` in this function, which
> should be converted to use `state->repo->hash_algo`, as well.

We as a more experienced developers should come up with a way to
help developers who are less familiar with the API set, so that they
can chip in this effort to wean ourselves off of globals.

Would a bug like the ones you pointed out be easily caught by say
running "GIT_TEST_DEFAULT_HASH=sha256 make test"?

By the way, for commands like "git apply" that can and does work
outside a repository, a change to use state->repo instead of
the_repository is only half a story.  Dealing with cases where there
is no repository is the other half.  I _think_ we have drawn a
reasonable line to punt and refuse binary patches and three-way
fallback outside a repository, but there may be use cases that
benefit from being able to do these things in a tarball extract.


