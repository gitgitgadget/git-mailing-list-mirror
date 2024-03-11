Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876E56B62
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190979; cv=none; b=W1UqkeEP3gXnZFjvuBgsaYYZurFY1+nuUSS5Vp+W40l31w9RwbfolynUW1TnbZNgTlZjUl9/EBsOo5BWaAhCKPpj2h8zFIgFR+rAjHuAZN54orvZfX6ahElyZgHSTk+Qe6Zm280bmoJYmAYUol4NVRTWmRSJc6VwpNjad2jcWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190979; c=relaxed/simple;
	bh=JJn2kkEd9meoV4rr0n4qPQ15+XdQyWSQuxgsILqqEO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roY21Oxzud7tDAGeX4DCHRp8y6Al9yHsaqj3cvcZMj1Y6sIw/3P7+9imR7JeTo06xYN5pcUqYdsRBGRMyu/N71lE9yys1tb7YEwANxOr72CQ9GXpbn9eOQ023HAnsKqal9XefyQLzCyUaZylLHnblZ3l4LTGQnP+6svyC46drMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P1DbqY+e; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P1DbqY+e"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EF65C2EAE0;
	Mon, 11 Mar 2024 17:02:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JJn2kkEd9meoV4rr0n4qPQ15+XdQyWSQuxgsIL
	qqEO4=; b=P1DbqY+ekufawtf0K12V1zZqqAP5tjy0z3Kkvo92ywxtX9QAYCIb9o
	quVcyJR/OY1TobhfKBTSv/VmXtnPxhI8lV/FlxagKc77WnIVunDuamlSIy6kIS91
	xl1ouopXece95pFJWqkonPFH8SHZhSCxp77qzCFgWwSl8ChQ/8TO8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7F3E2EADF;
	Mon, 11 Mar 2024 17:02:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 460EE2EADE;
	Mon, 11 Mar 2024 17:02:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org,  Kyle Meyer <kyle@kyleam.com>
Subject: Re: [PATCH v2] setup: notice more types of implicit bare repositories
In-Reply-To: <CAO_smVhAp4V1pb7LQV7yvhs98JVrtDgW5LzjzyJHupGuGSA+sg@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 11 Mar 2024 12:23:08 -0700")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
	<xmqq5xxv0ywi.fsf_-_@gitster.g>
	<CAO_smVhAp4V1pb7LQV7yvhs98JVrtDgW5LzjzyJHupGuGSA+sg@mail.gmail.com>
Date: Mon, 11 Mar 2024 14:02:52 -0700
Message-ID: <xmqqsf0wpjlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAB80220-DFEA-11EE-8418-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> into a bare repository in unexpected places, but often gets in the
>> way of users who need valid accesses too the repository.
>
> nit: 'to', not 'too'
> ...
>>  - A submodule worktree (whose name is $hame) has its $GIT_DIR
>
> nit: '$name', not '$hame'
> ...
>> Helped-by: Kyle Lippincott <spectral@google.com>
>> Helped-by: Kyle Meyer <kyle@kyleam.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  setup.c                         | 28 +++++++++++++++++++++++++++-
>>  t/t0035-safe-bare-repository.sh | 26 ++++++++++++++++++++++----
>>  2 files changed, 49 insertions(+), 5 deletions(-)
>
> Looks good, thanks!

Thanks.
