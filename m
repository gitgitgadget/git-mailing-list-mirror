Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBA1DED79
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133333; cv=none; b=uYaAncIVHFUQ5Csf5SjrGDQnYJIbXg+woCkOK+Lr53puxBMEitHrDukhJ8iWZpkQ+8DObLwQ2elWUT6pa3wYRpAdCG8Yhrh/nQZ+4ViBdN+OcmQUdDGY+/IZqpYv1HJ3cNwjy4VhNEQRP+jThy+Ew4XZhB67jnVOxm+paTlGgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133333; c=relaxed/simple;
	bh=bpG+sZNWVlZjl3F+5NVv6J7YMDyqyfEqSZxe8Thg/Fw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0bJdOhqGT04OBKt8DR4xb2/BkLr4olbOLIK3rnBGH1mXDozT+nzdx1FJZyB93pjbt7aXpxXjP1VsKVxwGK4YZgWflrLypt2FNGJiS7JA9bUoffHHMf762Xp/F6PIAS9Io1kRONeu+sXR1V68tNKy+osnj5j/+/7tkOAXH5bIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b5tMW6V1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b5tMW6V1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730133328; x=1730392528;
	bh=7sG81M/GMypgoAhqkMRHuYIbovPZU8oYK/i4VSk9gBQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b5tMW6V12wcLnHDaY9JUiBBxTICwMJTU6f8L3O1XbwMCHBSoLVEMCWSX/GImcj6Gz
	 k9TJM4v1eNPaBH8JJ0a8HdU3GVm5Nb6BXM3q/yTd+lfTYVDAqrHO3MtEvtXda/+bKg
	 pPWydIoC1yssLkJhNwDj6jWjrwPJtcsTUs+XBDK3PCNWPypheRbpgF32+qJnZKc2cV
	 b1XtPp7+WaACdLgHR8oIFt6hF2wYU4LlQjw5kMqmRUm51pJnkqoUgnED/oM2No0cKG
	 IgQmTQe2cDDnAjU662OwDQRfwS1WAOBQFyWcvBFO9161bajFOV/ayKZDFXqPhV85I/
	 ci19/Ak681udQ==
Date: Mon, 28 Oct 2024 16:35:22 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path linking
Message-ID: <D57L2P544W08.2MHA3Q38UBPEO@pm.me>
In-Reply-To: <Zx7cKN9X56GrHrU/@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me> <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me> <Zx7YFPE5tjr/bn2s@nand.local> <Zx7cKN9X56GrHrU/@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: daf2554851a068e0d248cc61ac4177039ce42048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Oct 27, 2024 at 7:34 PM CDT, Taylor Blau wrote:
> Additionally, it appears that this patch breaks at least t0001-init.sh,
> but others as well. The relevant portion of -vx from t0001.46 is:
>
>     --- 8< ---
>     + git -C mainwt config worktree.useRelativePaths true
>     + git -C mainwt worktree add --detach ../linkwt
>     Preparing worktree (detached HEAD 89e2b84)
>     HEAD is now at 89e2b84 gumby
>     + git -C mainwt init --separate-git-dir ../seprepo
>     Reinitialized existing Git repository in /home/ttaylorr/src/git/t/tra=
sh directory.t0001-init/seprepo/
>     + git -C mainwt rev-parse --git-common-dir
>     fatal: repo version is 0, but v1-only extension found:
>       relativeworktrees
>     --- >8 ---
>
> Let's please fix this breakage, and then decide what we are going to do
> with the extension in the second patch relatively soon, as I worry that
> putting the original topic on master may have been a mistake if it is
> going to break worktree pruning on earlier Git versions.

Thanks for catching this, the issue is that there's a bug in the
`initialize_repository_version()` function when reinitializing a
repository---the function doesn't check if there are other extensions
in use before downgrading the repository version to 0.

This is a rare edge case, but I'll work on a fix.

Best,
Caleb

