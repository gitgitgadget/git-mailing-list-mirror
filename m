Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B435DA61
	for <git@vger.kernel.org>; Sun,  3 May 2026 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782589; cv=none; b=P2S7yD+E1Zpvj68XHqSB3Ot9nm1enK/FYKVpKx+4VFJ5lBYcILncvPRgoxSAYwgzqrX3T/CTpDjgKoBH09VtVfzYQ04sq2jNYzbH/jdAWlOQ+DCRlDk2ou5EsUsurti2xmak4ofYO2yOVnaKuQ2eLdEUOQU+gXtC7CokusPdQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782589; c=relaxed/simple;
	bh=0RGDB28LA2GjWNCkvzYUezENuCMKOidZ/zx1f8EfSig=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osOxqgxUApRNEg3sqLnVKrVPHEFB0StdhMLPHjw7PtHwu/90kdipvVI5s2MRkdbxevHlNyeBrqaQ6e0bRnzbeY4qdTANbwl133yfJ436a0vzd2r/r8UtI+6K3ioscbHo9gy0AWJ09t/a8zJCG0MsO+Fi6vXQ3LbciCIEk8sCYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matheusmoreira.com; spf=pass smtp.mailfrom=matheusmoreira.com; dkim=pass (2048-bit key) header.d=matheusmoreira.com header.i=@matheusmoreira.com header.b=HlFF6Jeg; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matheusmoreira.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matheusmoreira.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matheusmoreira.com header.i=@matheusmoreira.com header.b="HlFF6Jeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matheusmoreira.com;
	s=protonmail2; t=1777782584; x=1778041784;
	bh=prt0dFeDQDTZyfPwsgZtzJu6ly6fYpHhsHu0lENmWSc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HlFF6JegpEui4HvuJvx0cB5ifDARRa+uZhe8YweFI9jiljCGEv0xaoILFHcIsWLsV
	 1oU4JncRGtEyc+u5ZS+iIMGFqNB/jw1MT8nOScGEGedQCMQAmOarEwjVdxukljrh/+
	 fGJ55Oi/EgpX/8bw51uQuz9pAfFdL8HW3EWFjBv042GCnSbEbQMGIYaVyCtSxmRoPZ
	 7FLwVLj717b5NI5xajauJ4qQ5vsoqPNGVIi9yfANNFudWJMjVikSDDD8LNuaBBfZGT
	 iszvb4li/sdVgAlTSu6T45zj90ekInUtxSVLpTbVL6Uc4UTSbQ6B9vFWNuiZaazQ2c
	 Zi2OZpcfXfhdg==
X-Pm-Submission-Id: 4g7WyZ6cMBz2ScpX
Date: Sun, 03 May 2026 01:29:38 -0300
Message-ID: <b7155ff9d03be5b1baa1358fe8a5f434@matheusmoreira.com>
From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
In-Reply-To: <xmqqik95taoh.fsf@gitster.g>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
 <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
 <xmqqik95taoh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Junio C Hamano <gitster@pobox.com> writes:

> Nitpick.  With "git url-parse", these scripts has to do what they
> traditionally have always done, i.e., shell out to the command, no?

It's a good point. I should have worded it better:

  Tools wanting to reason about them have historically had to
  reimplement git's parsing logic externally. With git url-parse,
  scripts can delegate URL parsing to git's own parser: validate
  a URL, extract a component (scheme, user, host, port, path,
  password), or both.

What I meant to say is that git's URL parsing was never exposed
as a standalone operation, leading external tools to reimplement
the logic themselves.

For example:

    npm/git-url-parse       millions of weekly downloads
    crates/git-url-parse    half a million downloads

With this builtin, scripts can rely on git's own parser
instead of a third party reimplementation.

References:
    https://www.npmjs.com/package/git-url-parse
    https://crates.io/crates/git-url-parse
