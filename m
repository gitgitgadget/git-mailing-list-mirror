Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10376944F
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZXSjDQhT"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9821BD
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 23:58:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30ADA1C83C4;
	Sat,  4 Nov 2023 02:58:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c7P2mgmWyZjIpALI8VqFlODar+fLsg/qeKq0b9
	2N090=; b=ZXSjDQhTkov59BlWm75josT/q3mV6epIzjyiLQh84moxPk0CHvzE14
	4Kbub7nocFv+7oQtC5yErQfo5LHpxfRMNNC3PgPr9fUVum087VmECHqlIdHiSoHq
	JvAexc23HQtWR3f6WjS9C8WOBSAXFIP+gAKff5h+EgrxvZpYO/yik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 265B51C83C3;
	Sat,  4 Nov 2023 02:58:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31F141C83C2;
	Sat,  4 Nov 2023 02:58:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
In-Reply-To: <20231104000209.916189-1-eantoranz@gmail.com> (Edmundo Carmona
	Antoranz's message of "Sat, 4 Nov 2023 01:02:08 +0100")
References: <20231104000209.916189-1-eantoranz@gmail.com>
Date: Sat, 04 Nov 2023 15:58:09 +0900
Message-ID: <xmqqjzqygg3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84603578-7ADF-11EE-8E00-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Given that worktrees are tracked in their own special fashion separately,
> it makes sense to _not_ report them as "untracked".

My gut feeling is that a much better solution to the unstated
problem you are solving is to make sure that "git worktree add" will
complain and not allow adding a subdirectory of any existing working
tree of a repository as a new worktree.

What problem are you trying to solve?  "git add foo" where "foo" is
actually a different worktree of the repository would add it as a
submodule that causes confusion?  If that is the case, I think the
right solution is not to get into such a state, i.e. not create a
worktree of the repository inside a different worktree in the first
place.

