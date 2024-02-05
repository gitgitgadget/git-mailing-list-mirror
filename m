Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405484A9B0
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175227; cv=none; b=pRndEiTRYBsTyuhjcCJur51GnOJrHFdVw2awUWX8E94h4zgo6F606ok2+ZhlpC+vFwT+GHPUhSXq/a5myOFspDz7UEys+kjZosh1QuCdEC7ZKZx6rPUh6q1p6ZDFkTnaMsLfFpy1hNCFK/S5gFvP+Ht+2EIEEm4JISIRzEIabnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175227; c=relaxed/simple;
	bh=W2WGHn8DW0DPCvarBdq72NbSjwuqbK7cwpodEanQBwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4NNRv2YCK5NA8HMnKuZz1V/NMFSfCXWeG22Hd4SlSVogNglyQLeehIBRhfi5Wmd9VlHocYQVu9IuQtvHXZ015Or8Hhe0AJJ4pRu3Iu0/T3SHHZJ9c848WJ1Bgd2w8VlKqEcSpNX1g/Y3ALFfq0cX2QjLzj+QvJYHfAX7D4FJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YehyYk6L; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YehyYk6L"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B16F11E3614;
	Mon,  5 Feb 2024 18:20:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W2WGHn8DW0DPCvarBdq72NbSjwuqbK7cwpodEa
	nQBwU=; b=YehyYk6LIKKY6xcLlaDh1Ny+uB2wu+HHzstmIuoimniId5e37e7/e5
	GSJWFW+71UkxleiMdlsX9gVPCltZ7oZDYfvaKx2v9LI5gAlj0fgqho6d9f4k7zKc
	LKXknFtokpR92IZ8skbtKcO12OZ8bgwAM1QvodoZDawfFlA0LdKRc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A92411E3613;
	Mon,  5 Feb 2024 18:20:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC12A1E3611;
	Mon,  5 Feb 2024 18:20:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #02; Fri, 2)
In-Reply-To: <087d3438-98a1-46fe-89d9-8e7e1662151b@gmail.com> (Phillip Wood's
	message of "Mon, 5 Feb 2024 18:57:49 +0000")
References: <xmqqmssirm6t.fsf@gitster.g>
	<087d3438-98a1-46fe-89d9-8e7e1662151b@gmail.com>
Date: Mon, 05 Feb 2024 15:20:21 -0800
Message-ID: <xmqqjznimrbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22DC59B6-C47D-11EE-B084-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm concerned that the UI could use some improvement. If I understand
> correctly the proposal is to make
>
> 	git for-each-ref
>
> and
>
> 	git for-each-ref ""
>
> behave differently so that the latter prints the pseudorefs from the
> current worktree and the former does not.

I would actually think that is perfectly sensible.  The optional
arguments for-each-ref name "filtering patterns" and you can view
the behaviour of the command as using "refs/" as the default
filtering pattern when nothing is given.  But it is easy to defeat
the unfortunate and historical default filtering pattern, by saying
"we do not limit to any hierarchy, anything goes" by giving "" as
the prefix.

