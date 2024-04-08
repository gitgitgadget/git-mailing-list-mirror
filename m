Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F11422BA
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593770; cv=none; b=jFUtGAwzeQEgT42xuR9q2MJ9r53hKuDVDlOuUpZfAMtQnI9vVlN4cnSLfTaq8nlCXWj1jMGte6zabR4Joca0go5ETl4gegx4cY0fpDQ1v+8AfqrIhzVjtfaF61AnWGnkt8TPmGBLNdRpT9ugtRQB1JBg/eRSSwC/wk3/SHUFqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593770; c=relaxed/simple;
	bh=sqmFrc75+gTvgkToIO3D8Gj3RJV5wY+mpUyFCKi+UAg=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=JSNx3mBhIn2zLW4Spt/8IuIY/bWW48icpEPWcgpK1ILQZzuQG2D8sNcYJtW+5+sfoL5lkzu33tS1uVi25PTN1Vmj/8eCMw2PmMxJnlniUJWq0kCyf6nMljnQaFhv5B6UqEw+ej7B8xvfwThO1+Wt0/FxzhHrOpXIpLoYRo7hgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DBXTiiH+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DBXTiiH+"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712593765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wnjhP8D6NhLC82xwDeygvkBCGnRAsEjih48xzn6jdRM=;
	b=DBXTiiH+9Goax6qLg19t4PSWjWFO0yT7MZWNl36U2p486etncX0bZqPaKGrg41xm8DU3c4
	rl6VsJFZnj/6+2rKBjAbDvFW5SpJFfJBuXxwL7VbAaR8xIT3Zwb8eegmwx/3/w1h6G962T
	8zLgmWmRFhN8kDf0fNqS+QwGxnJfD3W5zwScTs+OSLR9EA7uDGnQdtlRxNZYRvjRjwe3u4
	cSEK8IdyZq+Zwo5XWZ9s8LbMMOEhBLAKfFuZPO+Q5szpsKuUvTFp9imMkPusTRzmMYmhMs
	9hwUuyLJaG+DV3tY6PH/c6EhBRKStTl/Hi1UOScQSglBj3e9BaYEdvUsW5Omug==
Date: Mon, 08 Apr 2024 18:29:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Subject: [RFC] Avaiable disk space when automatic garbage collection kicks in
Message-ID: <950d4ad3bcee79df1424faee09eb6b00@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

A few days ago I've noticed a rather unusual issue, but still
a realistic one.  When automatic garbage collection kicks in,
as a result of gc.auto >= 0, which is also the default, the
local repository can be left in a rather strange state if there
isn't enough free space available on the respective filesystem
for writing the objects, etc.

It might be a good idea to estimate the required amount of free
filesystem space before starting the garbage collection, be it
automatic or manual, and refuse the operation if there isn't
enough free space available.

As a note, the need_to_gc() function already does something a bit
similar with the available system RAM.

Any thoughts?
