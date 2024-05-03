Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC1134B1
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768736; cv=none; b=RYhmva5R2FWC/sCPrJoMq1wnneO7iFOMlH9HVeVXjiaejlGSlJRJ6wEocilndjcmrvCzeDr+dwbXaVODtiwbjFqbShbzVzniq5q5TwE8KFOptgt6KkBQECJHUQ3+5yjI/x4n1bezdnr8eyfipS0129hpRZLqU0RJJi2FHWN428s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768736; c=relaxed/simple;
	bh=mxtRxkCq7kNqk6YNPpzN8boy6CXWbT5k8Bs46oWqGww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eTx4CEQHedV7V8rsHxHX1CAKTzxM9gM5IvIZNmr8Rw7lS9houTDQUi+M+RfjSERIsZ+TzNknDhRHabe2kZKN5KkSpvNAQS5Sx5ZwK2wauwi9JSG5l2XPllyrcix/X4MQXflcQfSdFo401uSjVnNQRWDmb/mGnsCq35tpQwF/eCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ydR4+vWe; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ydR4+vWe"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5162A2BB2B;
	Fri,  3 May 2024 16:38:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mxtRxkCq7kNqk6YNPpzN8boy6CXWbT5k8Bs46o
	WqGww=; b=ydR4+vWehr7uc/Tqqj2PeXnj78bwm6FK5Qk88TmDWZk25N6UF5I6xy
	Q6CMAzCzDbtvBnSAVF+EBBXnBIJ+3jJvitcmFTznz3XImtpUnXtOdCMy2GAz0nQG
	s5w3XXYEElBDqwbSYX54mdawAP54A7PntFD96giQoQVC36qeqzgwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 452FE2BB2A;
	Fri,  3 May 2024 16:38:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6EB12BB29;
	Fri,  3 May 2024 16:38:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] reftable: expose write options as config
In-Reply-To: <ZjNA2zNH5twH5qj0@tanuki> (Patrick Steinhardt's message of "Thu,
	2 May 2024 09:29:31 +0200")
References: <cover.1714630191.git.ps@pks.im> <ZjNA2zNH5twH5qj0@tanuki>
Date: Fri, 03 May 2024 13:38:51 -0700
Message-ID: <xmqqv83u4omc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27594AEE-098D-11EF-86A0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Ugh. I actually intended to pull in ps/reftable-write-optim as a
> dependency because I know it causes conflicts. But I screwed this up as
> I thought that the topic was merged into "master" already, even though
> it has only hit "next".
>
> I'll refrain from sending a new version immediately though and will wait
> for reviews first. Once those are in I will pull in the above topic.

I saw [01/11] has changes to stack_check_addition() that disappeared
by the other topic, and the resolution is to remove the function (as
nobody calls it anyway).  Also [02/11] has changes to refname_test.c
that can be resolved by just removing the file.

If there are other semantic conflict resolution needed, such a
rebasing is appreciated, but otherwise, there is no strong need to
rebase.

The mention of the name of the other topic that has interactions was
very much helpful.

Thanks.
