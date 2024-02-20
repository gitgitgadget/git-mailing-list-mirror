Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47E2E630
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397569; cv=none; b=aBsNtUyCVeECtJ0tRSFbq2eZvshk2PXxigtrn3dl+skwqINoIzJ7GG788gMd0BoAwrm55l2R3+Ndok6SDxS4V2/BQhRIw0hIGw+WtuGepmhw6jzo65NWicjXOsFEUJI0fpyQFXF3A6eh3UI0cDNu2Hm/hMPS6cBk0iNzH4eKbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397569; c=relaxed/simple;
	bh=IvY2nMjHO+amOawzjr/dDoWTltAEWdWCmA7JLBYWjZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pLxxkcfR1LkJXy8Xp5Woh0/kvSUWrhJpuxipuSVAmxKgg96fA3xDkN7PPNXuuvl73xuuzuAfUCOpVNT3LIhHb8cD0sU3Oge66NoFGKm5uJbIhMO0qO8SWglq3ZUL+aEBqEYNf8TKBKvRFL4Lf77tNzt+JHIEE13Mg1dmH0I4Qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DHEAE3lJ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHEAE3lJ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 933B91D5132;
	Mon, 19 Feb 2024 21:52:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IvY2nMjHO+amOawzjr/dDoWTltAEWdWCmA7JLB
	YWjZY=; b=DHEAE3lJI82B5xImIR3Fo0KQ4mG82+xr+ywDFQwRKLz08UK8ziPQX6
	95SIdnaXdbiYLaiEMI2otb851EBUypKLxGBDNO1Dq60o5Peo4D2gVgamXtPXvKcJ
	K4+8R58I1Cusi28n58rjzE/pWVxaICx1zX6zMQXGQGass3alXpRc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B0C81D5131;
	Mon, 19 Feb 2024 21:52:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F02B01D5130;
	Mon, 19 Feb 2024 21:52:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: MithicSpirit <rpc01234@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
In-Reply-To: <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com> (Phillip Wood's
	message of "Sun, 18 Feb 2024 10:32:22 +0000")
References: <20240218033146.372727-2-rpc01234@gmail.com>
	<99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
Date: Mon, 19 Feb 2024 18:52:44 -0800
Message-ID: <xmqq34tnyhhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 20127200-CF9B-11EE-A778-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> How does "stash.keepIndex" interact with "git rebase --autostash" and
> "git merge --autostash"? I think both those commands expect a clean
> index after running "git stash". They could just override the config
> setting but it might get a bit confusing if some commands respect the
> config and others don't.

The "autostash" feature fundamentally should not respect such
configuration variables, as the reason why they exist is not to
create a stash of any unusual kind the user expresses preference to
by the configuration variable(s), but to clear the slate and bring
both the working tree and the index pristine with respect to HEAD.
Also, when able, they would automatically unstash after the main
operation to rebase or merge is done, right?  IOW, normally the use
of the stash ought to be invisible to the end users.  I would not
worry too much about the "confusion" factor for these reasons.

You are however right that this will confuse the toolchain.  These
two commands we provide may not be affected (or we can make them not
affected by changing their implementation if needed, while we add
such configuration variables at the same time), but third-party
tools and end-user scripts that has trusted that when they write
"git stash", the command will give them a clean index and working
tree will be broken big time.

So, I am somewhat negative on the patch in the current form, until I
see how the plan to help third-party tools and end-user scripts that
rely on the promise we have given them looks like.

Thanks.
