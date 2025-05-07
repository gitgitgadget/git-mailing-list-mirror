Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DA289E0E
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627746; cv=none; b=i1imO8nnH1iJAlRgQRdi/b2XiTvXrMdRxXjSknFj3ESBpFA31pjlCUVKhp7aPcBWD9zVDyuQ1O+iTL/xXdN6K82N6sp3y4XRDJ4qktKWFSLO7KV1HqcQnHmreOQQlNWwRhAhaO7Vf0kesFmjnIK+wKWAfbhsTh0QRyy1kiWvveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627746; c=relaxed/simple;
	bh=uD6gv2lxjfZGiJSmO330sKfOztG848dgSrKcJhtcy0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KS/9x5zYmxyAAAc93MZl4GqFLd6OPUKnqEwBS/DjlaJKAhVSn4vV85/f8QWL32I8vnVc0qAVH2uqItaqbSixSoYNrNyJqMlZOhsf2PH+fS89MHVpyjI+Oc9tqqKjpGt/DzEGKB18jOGGYwLmSrgNcUl3T0BtqgSqjJ++0q+xEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=u5Ae4h3A; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="u5Ae4h3A"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1746627737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XvwT3p2YEkRfC/aZW9ppwLGcgurbl1ZV67ur6ANcpY=;
	b=u5Ae4h3AJk5pbt2psj2cgwqTYxqHTmuOukIBtmVdp29RvNFUZLbMcEWf9IkFHCA6eHPqLH
	BueHKomS8TxvNGXET2CAfaCFWhzNdWZbC9i0s18xAA2vYbtiPbG/7MQgSZ/fpJ8rbxH3nb
	8+YTmpc/0Iqeh0SmTZCs2pHD3W9uoXA=
From: Toon Claes <toon@iotcl.com>
To: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Derrick Stolee
 <stolee@gmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
Date: Wed, 07 May 2025 16:22:02 +0200
Message-ID: <87ecx0ijqt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Marc Branchaud <marcnarc@xiplink.com> writes:

> I feel the need to get some bike-shedding off my chest, though:

Always welcome!

> "blame-tree" would be a terrible name for this command.

Do you feel this way because "blame" as a negative conotation?

> I think that if Git ends up with two blame-like commands it will
> merely solidify Git's reputation for obscurity.

I think "blaming" is a well-concept in Git, and many people (familiar
with Git) would understand in instant what `blame-tree` would do.

> If this is really a form of blaming, then just make it an extension of 
> "git blame", like maybe "git blame --latest".

I'm afraid that won't work very well, because the code is very much
different. If naming is the only motivation to shoehorn this in, then I
think it's better to rethink the name?

> Otherwise, please come up with a new command name.  "git latest"?  "git 
> "latest-revs"?  As long as it doesn't use the word "blame"...

I've been thinking about this a lot more, but I failed to come up with a
better name.

> FYI, here's Peff's original explanation[1] of how he came up with the name:
>
>  > I wasn't sure at first what to call it or what the calling conventions
>  > should be. The initial thought was to make it part of "ls-tree". But
>  > that feels wrong, as ls-tree otherwise never cares about traversal.
>  > The combination of traversal and diff made me think of blame, and
>  > indeed, I think this is really just about blaming a whole tree at the
>  > file-level, rather than at the content-level. Thus I called it blame-
>  > tree, and I used the same calling conventions as blame:
>  > "git blame-tree <path> <rev opts>".
>
> To me that reads like an argument for folding this into "git blame".

Forgive me, but I think folding into git-blame(1) will also solidify
Git's reputation of obscurity.

I think `blame-tree` is a fine name for this feature, but in the end I
don't care too much about the exact name. If we end up naming it `git
last-for-each`, `git annonate-files`, `git log-everyone`, or `git
when-modified` ... It's all good for me.

> [1] 
> https://lore.kernel.org/git/20110302164031.GA18233@sigill.intra.peff.net/


--
Toon
