Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513330E0D8
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458623; cv=none; b=m0Of7rA1IXY49R7zWMEl4PnEE/9bNbW2Bg6G6BBmRybdRgPU8gy4Htysie4DY96BOPas7gUPHzPS+kW6/YBiMqanXaZgLJLPEhOL/EqnMnAliHNndgpoQ6529WB82pmgA4J+bz60fn4y9G2KdWi1rysqP1b8oPZ++uJsmbkBdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458623; c=relaxed/simple;
	bh=2gQdMONy3wy9J+J2vQSIpj0XSIc3psWURG1g8bCNbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQGtayBRTLPY3q5uRdFCZuibjklpzC754aEWGlurG7jovhc5T2kE8k1fv0bKiDFvzaJSD2BFx5OX2RPpnXR82EBrLTzy2dQseWv5qZGrlmjzJwyyM997Qke53gRtfjTHOW5Webw1YyfZ5YwTQ3UKTRPBR9i31o6KUjt00Hntz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Mw7M+W82; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Mw7M+W82"
Received: (qmail 20087 invoked by uid 109); 18 Nov 2025 09:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2gQdMONy3wy9J+J2vQSIpj0XSIc3psWURG1g8bCNbNY=; b=Mw7M+W821APn2Bw7Svj+rs7oQYomaEUBBBiSrpZxwSfXL0pPJdffYWndIBnlKfibI0tzR2Zw/e08GAhFCAqlqQW2+mc6oIm4Edlbf1LgGEuf+XcAEi5be8hUBroDwGUH4fPpZ2U7Db+8YWpautC4GInZkGpDRWWsQog16yZYB+UXzF+KbdtMJH6+UfRcOnaClA5KPhAlxXmQ1HRlDLs9Q7HHbj0vaVE7aqlLxdn0uPb7Jy9KT6Hp1fFPa9o5P4lEwoKm+zRWYnyOK3DbyyOxkZQ/s68wUMByjcOP3StrBu44hzcoqaNDoEy8aUD/lZRZd4TmPv80i9ae6GAdw2MAEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27725 invoked by uid 111); 18 Nov 2025 09:37:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:37:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:36:59 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
Message-ID: <20251118093659.GA530545@coredump.intra.peff.net>
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>

On Mon, Nov 17, 2025 at 05:04:24PM +0000, Johannes Schindelin via GitGitGadget wrote:

> The way this signaling works is for the workflow to write into
> special-purpose files whose path is specific to the current workflow
> step and which can be accessed via the `$GITHUB_ENV` environment
> variable, which differs between workflow steps. It is this file that is
> missing write permission for the `builder` user that was introduced in
> above-mentioned commit.

Thanks for fixing this. It bit me recently, but I hadn't had time to
look at it yet.

BTW, I ran into a similar issue (no useful output from a failed test) in
the windows-meson job, but the cause is totally different there:

  https://lore.kernel.org/git/20251118093221.GA530337@coredump.intra.peff.net/

-Peff
