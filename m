Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0D1448DC
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158732; cv=none; b=Xc4ixiDpr2rL5ZfckXChhPmRh6FG1sRsB63crEuZSA7uwaKUmU7LLVZtqzFd0MxOWCXGMMdNX1mRy5RvaSg7HmeowT6mWYKzxgkTqn3zT49hPrw/Qr/qtB5WRC1+d6/4xBBRmyBuugofdrccNJSY39c4JYGI2+vJuSjL6ShKzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158732; c=relaxed/simple;
	bh=PSVUvovacoPkpZu+qqZIInNJje9ZNMegllHqSeYUJbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTDdSmrRG01bKMULdvSoUZZmD7u55ZHSNl3Zw0Ww4xGsiBrEYAWQpxQAQb7vczvQ0fYFa+T7kVvsVy1ubrZs10w/qMVtEeuICgjKbT1FYudJdNtAVC0iOn2T7ebsvaOk7U8VTSt99mu8boaQJClZaFVYyyKNMM00GiZDYvgK3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cc++7qGc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cc++7qGc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B00D333AEB;
	Thu, 12 Sep 2024 12:32:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PSVUvovacoPkpZu+qqZIInNJje9ZNMegllHqSe
	YUJbY=; b=Cc++7qGc4bDSZJ+frVbH1OQ204NO57dAvNjiAAKd/rQL/HvULsyL7Z
	20yU7dWKrl4q7ZD96mxUHI4e8veu55B0CKtBHgrU/9g6LKqgufhMiVkV28IH1Tgs
	YJCtkxYWkdU0RuwHA/VDw5TeA2xynqCCmA5swpWPSeFxLv3h9mulM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80F5E33AEA;
	Thu, 12 Sep 2024 12:32:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5D1933AE6;
	Thu, 12 Sep 2024 12:32:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] remote: check branch names
In-Reply-To: <ZuK80YvPSo8WUpp2@pks.im> (Patrick Steinhardt's message of "Thu,
	12 Sep 2024 12:05:05 +0200")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
	<xmqqfrq686n5.fsf@gitster.g> <ZuK80YvPSo8WUpp2@pks.im>
Date: Thu, 12 Sep 2024 09:32:02 -0700
Message-ID: <xmqqjzfg4yv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B1C1058-7124-11EF-A064-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Agreed. It's also kind of curious that the function lives in
> "object-name.c" and not in "refs.c".

Because the helper groks things like "-" (aka "@{-1}"), it does a
bit more than "is this a reasonable name for a ref" and "please give
me the current value of this ref".  Also "refs/remotes/origin/HEAD"
may be valid as a refname, but forbidding "refs/heads/HEAD" is done
conceptually one level closer to the end-users.  Eventually, I think
it should move next to branch.c:validate_branchname() as a common
helper between "git branch" and "git remote" (possibly also with
"git switch/checkout", if they need to do validation themselves, but
I suspect they just call into branch.c at a bit higher "here is a
name, create it and you are free to complain---I do not care about
the details of why you decide the name is bad" interface).

Thanks.




