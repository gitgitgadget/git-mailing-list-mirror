Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A6288530
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764673295; cv=none; b=l0xcO146x3wnidp3248rMyfc734NZQZZ5vRqLnDWTijkRWZd+Oxynt5n+CMS11XpVGMdA5jdS1mGwPoif/H4a0cbGiTtKLESCts/rZ1Jr0V78gOlin1pTryn7f7GGnCuk5278TnWubrrgM8axtGYPE/5SPX8UUkF/hRYhCPXjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764673295; c=relaxed/simple;
	bh=lZxzCsiSYAWg1OCvDhwQy2gx37umjdWMWkk5FIQ94po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPAC/kemm1pkRAlk+SgPOnT7UJnzIyj6GYTDDoKRvJNuKJWPVfD8lVpiSJZaL1LNynepzNAF/fynhBRWnArReIIRuM696VAknYxkeIhcvEc0uScUB1VDuH3UgPlTPTguOkCHT50tVv6AXmaXa+PNzX47Sr4qjUPNdmRxE4A4Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ydpMZ72p; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ydpMZ72p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764673290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96yC6y6IV5z1MhbNzLKDCrFizQH+Ob+SU73lISZ5RPo=;
	b=ydpMZ72pYensN1p6jA4liOvp31q6IEGRLD/3Ide+LiGmiQxTaMEE3MLScHGq+NSHKutbBu
	DZUhMJaphnrc/mTYwV7DXph5ubzxmmOf91Uau4z9nSI4lRn4L40jMAzhBxCZGDzs/Js7cM
	3m5UZUuc+eXvKdqpfNs6iLqVEkLGV2w=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] last-modified: better document how depth in handled
In-Reply-To: <aS1uz6mc0WW9kjzN@pks.im>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
 <aS1uz6mc0WW9kjzN@pks.im>
Date: Tue, 02 Dec 2025 12:01:18 +0100
Message-ID: <87tsy9w3k1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hm, that's confusing indeed. Is it possible for git-last-modified(1) to
> do the "right thing" automatically? That is, given "sub/file", show when
> that specific file has been last modified? Or is there a good
> (non-technical) reason it behaves the way it does?

You bring up a good point. In the version of git-blame-tree(1) that
GitHub did share, the `--recursive` flag is enabled by default. So if
you pass a file path to the command, you'll get the "right thing". But
as I am pointing out in this patch, if you pass a subtree, everything in
that subtree is shown too. You could argue this is the "right thing".

Anyhow, in the version of git-last-modified(1) I submitted upstream,
recursive is not enabled by default. My reason, at the time option
--max-depth wasn't implemented yet. I submitted those changes in a
separate series (these patches also originate from GitHub by the way).
If those patches wouldn't land, I think always-on recursive behavior for
git-last-modified(1) would be quite annoying.

So long story short, as git-last-modified(1) is still marked as
"EXPERIMENTAL", shall we make recursive always-on?

-- 
Cheers,
Toon
