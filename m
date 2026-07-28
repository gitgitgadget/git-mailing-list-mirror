Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A7230264
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246267; cv=none; b=mI5c3i06jc02Bb4/IMGQJp5UWl4AX+79kSJRv0ivLvZv58yMDHazmrL/Ioahx8gaVc1vHA/UWr3RVT8oihrFE6yWyejmEMRc8XX36fgsBpwhweKBcgKlm4Vc37qLGz/QTXCF6Ab+bcOSj//idmVt24+rLwXgzJrzrXYuKg9jPHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246267; c=relaxed/simple;
	bh=CG0Ecfir7ePpEVz5ueRvTwSLA0ONvRBtwM/cQqIZJGM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEJyPBszHb5UThjJbyBNoJydEWOwPgbBqBCOEcVx+lMxP0JvTj32+17hWWQ0k7C4OgiOD4K+DQTIkSlOqbDmUNRw+G+UAeb5GL5/e36Vppzmc3/G8YlAe3oNSzYINkUtS0V523cJlBt8YnadjKKpU1EvSqQxyGXDtYAVmkHJBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=MJ8uJ3lL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="MJ8uJ3lL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785246263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CufA+x/GN/7YgdWR/pAU1yH9bzzmknc5z9YI7LK348=;
	b=MJ8uJ3lLjk0sg/jUGHDKPquCc46xGxzz6zowgLUyp6pe72S/T2aXPkNdpr4qPkHLE18DWE
	VCk+pzP+oCmoUHIKd+G+FcJmwxUAdJI9g6EF0385WwI03aT1qS2+vINSAEdM2aTKYnqX6o
	Q4CLL2s5xS0Az4jSFYfOV5QXeEGskBE=
From: Toon Claes <toon@iotcl.com>
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Subject: Re: git-history(1) fixup broken with worktrees?
In-Reply-To: <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com>
References: <87jyqt1m6g.fsf@emacs.iotcl.com>
 <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com>
Date: Tue, 28 Jul 2026 15:44:18 +0200
Message-ID: <87y0evcjpp.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think what's happening is that the branch "feature" is updated because 
> the commit it points to is rewritten, but the index and working copy in 
> the work tree "feature" are not.

Yeah, it's relatively easy to understand what goes wrong, the fix would
be a bit more involved.

> Rebase's --update-refs option refuses to update branches that are
> checked out in other workers by default to avoid exactly this
> problem[1].

Ah, thanks for finding this existing discussion, interesting.

> As you can see in that thread there was some discussion about updating
> the index and working copy when the work tree is clean instead. I
> think that is a friendlier approach as it preserves the relationships
> between branches and avoids materializing changes in other worktrees.

Yeah, I agree it would be nice if git-history(1) would give it their
"best-effort".

> On a related note, rebase refuses to rewrite a branch that is being 
> rewritten by another rebase running in a different work tree. That's an 
> important safety measure that I think the history command is missing.

From [2] I've learned there are multiple ways a branch can be checked
out. We have to take them all into account. It can be build on top of
the changes in that patch.

[2]: https://lore.kernel.org/git/590382fb-731b-4e14-911e-ff68356d1082@web.de

-- 
Cheers,
Toon
