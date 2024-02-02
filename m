Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD01C2D7
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892890; cv=none; b=eFvrAn5rvusjHPdnositQeHMdMXBhqzaGgyCVcn2VFpk19s/hwkRrOw/4TNkVQBfergZswT3IfEJBpZiI4XLQf7ba5plnhrlkCJN/9X2r5OXL6QJU3ASkiSN0z3kFk2m+T8yG7giJdAvO/3bu/Sw4x9BbK1SbbrDPlbe+zUP1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892890; c=relaxed/simple;
	bh=LnSgzAIRlgfrfNIln6KP0D6pSF4DdAJgRj1Es5xa4Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ai7lESLimQArAOE/DnQaXy++vUCQnMeTcrfWMXnIJHGS5CzxC0C00iqGcIQrPyQoyxqh2iJYzHnxH5lqENvkZkQpViJDfENNhOc/KmO9odHDZjX2pFU2LkC2qZgMKSJwzli+Wz8BICHYnNO6Hw+DfmTQNp0GR2vl/nqyOJrb6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fcDOYv9/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcDOYv9/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CA8A1C246;
	Fri,  2 Feb 2024 11:54:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LnSgzAIRlgfrfNIln6KP0D6pSF4DdAJgRj1Es5
	xa4Wk=; b=fcDOYv9/n5ThvJXxXFZxRZmyh6K6rU2jFHsn9hh5EyrUURMipYaPWQ
	c4WE5ankwrwoCKj1cGHopbJloqh2ZF0/3h94WfeSpzirvMkuGgFpRvp6XYo1o7iy
	AVIX2BryOUXaj/yAuT4AZW3mt1HZNSj2jg1mae9g92kcpFf3V+6c8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 449911C245;
	Fri,  2 Feb 2024 11:54:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D1AA1C244;
	Fri,  2 Feb 2024 11:54:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Elijah Newren <newren@gmail.com>,  Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with
 --missing=...
In-Reply-To: <CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 2 Feb 2024 12:29:22 +0100")
References: <20240201115809.1177064-1-christian.couder@gmail.com>
	<20240201115809.1177064-4-christian.couder@gmail.com>
	<xmqqil37yix1.fsf@gitster.g>
	<CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
Date: Fri, 02 Feb 2024 08:54:42 -0800
Message-ID: <xmqqv876u7ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3FC8A76-C1EB-11EE-BBB9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> An obvious question is if this even needs to be a new option.  What
>> are expected use cases where --missing=print without this option is
>> beneficial?
>
> I am not sure if such a case is really beneficial but some
> people/script/forges might rely on an error from `git rev-list
> --missing=print` to propagate back an error to some user interface.

Yes, and they are missing errors for starting point objects right
now, which is a bug, just like they were missing output for commit
objects before we fixed it recently?

>> If there is no plausible use case, perhaps we can treat
>> it as a mere bugfix to the existing --missing mechanism, especially
>> given that support of commits in "--missing" itself is relatively
>> a new thing.
>
> `--missing=...` detecting missing commits is new, but it might have
> been used to find missing blobs or trees for some time as it exists
> since:
>
> caf3827e2f (rev-list: add list-objects filtering support, 2017-11-21)

So it fixes a long-standing bug.  So what?

Especially given that the change in behaviour is to error out only
when the user gave an object name for a missing object, and we know
the user wants to be notified on all missing objects "found" during
the traversal, it smells like (1) a rare enough case that may not
matter in the real world and (2) the existing scripts that may feed
potentially missing objects to the command would be doing an extra
check to ensure what they feed the command are not missing, in order
to avoid triggering that "starting point objects induce an error
instead of --missing=print report" bug, and the bugfix will make
such a workaround unnecessary.




