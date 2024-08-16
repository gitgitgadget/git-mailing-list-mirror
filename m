Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFC13D882
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846226; cv=none; b=exIhrqeWH397J8ljfBLjQQnX3X6O769CBTm+8VOiyLd70wmU22cq1jhOj0cbmOxHPBF5SoH0VBoBvHpJ1VMKTF/90i93Xg+Y9UorHuCk9SS8FknKfdRW0YhxiudssgvOH/SViKbvv9/XwXQghKvG5Xk1QrMCjOoDiaL/gMSxROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846226; c=relaxed/simple;
	bh=R543t81IWW1jdoydsTOtncldvRyLlYR7dCBiruEXeD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJWhwxxIYLcA+ACcdbBbvCmZqw5Q7Srp5ggXThkwPM5/NeCyMQoYZskN+SSeu+TnZMJ6wfpNpQdV/M69rutdg0yHb53yx8HPQXPGCtGLzRqfJ69TdZGTAMKNp26+BC2eOROwckcK6fo35LqXDsfuf7DRdeXfywsOq4Gn8gn45iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mEfZKdvA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEfZKdvA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E1FF2CBA2;
	Fri, 16 Aug 2024 18:10:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R543t81IWW1jdoydsTOtncldvRyLlYR7dCBiru
	EXeD4=; b=mEfZKdvAJVZmxaFd/Lv0Q3AupghJkFgwLdR2fmj/4ils6OjVjSVHLr
	mRKhYfoT6vDpoDq94fAB3lNDnlGmDWLkaKHkSfdgantkX1XSp9y+3I5Amy3XSLZm
	qkLaFV84GbomDbxcFZe7iz84upDP6jBjlvIv7XDfA9MAjnOQL6lhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 771832CBA1;
	Fri, 16 Aug 2024 18:10:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBBA82CBA0;
	Fri, 16 Aug 2024 18:10:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org
Subject: Re: feature request: set remote/HEAD with fetch
In-Reply-To: <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 16 Aug 2024 21:55:00 +0000")
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
	<Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>
Date: Fri, 16 Aug 2024 15:10:21 -0700
Message-ID: <xmqqplq8jf02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5525B69C-5C1C-11EF-AF57-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> My current workaround is an alias:
>>     fetchall = !git fetch --all && git remote | xargs -i git remote set-head -a {}
>> 
>> which works for me, but I think it would be more elegant not to have to do this.
>
> I believe this would be a valuable change.  I know a lot of other users
> want this features as well.  However, I think it needs to be opt-in,
> since there are some cases where you want `git fetch` to specifically
> fetch only certain objects or don't want to modify the refs. For
> example, I know some server-side implementations use `git fetch`
> internally and require refs to be updated in a special way, and they
> would not appreciate extra refs appearing.

Yeah, "remote set-head" implementation internally uses the same
"what's the current state of the refs on the other side?" query as
what "fetch" does when it contacts the other side, so it makes sense
for a new feature "git fetch --set-head ..." to internally do what
is done by "remote set-head".

What should *not* happen automatically without an opt-in is to
overwrite an existing refs/remotes/$remote/HEAD with a new value.
It might even make sense to allow it to happen, even if the
"--set-head" option is not given from the command line, if
"refs/remotes/$remote/HEAD" does not exist.

Thanks.





