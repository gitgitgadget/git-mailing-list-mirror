Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12B4EFFAE
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973881; cv=none; b=JhQWLSizH0DgZqNNAR2YKTlBn9JmrKE6yrF8TiAL8l2lkSvgmDmZ3i3FhLeMaRHklwX4pgwYbpxr0hAo4QU4VvwfWD9mwGrnGamWqE/zuyhJfGUZxkJ5AggT5gLAaED1O6OKNcj+RtcgwJAfToomlqY0gV5Ljvlh7ykx6M5vNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973881; c=relaxed/simple;
	bh=coYRH1gVmjv1Obu53gwvqlM2hR2LFJfuiOWk7D+yorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kemgDa6SjJOkbd5S/g+AJ1otBBIvCdWAyCmZikgaz0WDN2fQbTEGsMJLNMGgM+WoZr1m5EfoNkl0Ax/NKeLOvdZXfbl2jDr1GUn2ojHBf0DSb1BBaXbGL9LSjw3XFiw3NESBramaERhuP4cO+DnfbkJTvUL2xPbJvmgi9nHW2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NhKMdBUj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NhKMdBUj"
Received: (qmail 69347 invoked by uid 106); 14 Oct 2026 10:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=coYRH1gVmjv1Obu53gwvqlM2hR2LFJfuiOWk7D+yorE=; b=NhKMdBUjsbF20MH7BeIo/4z+VrE8tCbMsZKmhlH7BdqAN4JZamNNVgUeWZr1JZgnxw/3Fu02f+KwXInDbkl8F9ek4KdhpM1TTiH93pbeWa9onw7DYW97nSOd7azMTmPHFZYt2cdTSWsPhbMhu29/F2VrsjdIbGdsWeW8rnlkipONg+AHS2oIrMFHhckOzj01Ma4jmkr9gGX+5+EsdPpBmjCP1ExE6adWWgtFtTieX5R/JpUNcIubN4hBOQbXP+veVF05QgYCeHomAUJno8Dp9BCbCqqWn8p1CHjkRatKo/9/Mo/3pA/F7QoBvxqaw+IP/iEuIwyrCrjKmDbGubapzQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 10:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36473 invoked by uid 111); 14 Oct 2026 10:31:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 06:31:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 06:31:18 -0400
From: Jeff King <peff@peff.net>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH 0/3] Add hostname condition to includeIf
Message-ID: <20261014103118.GA1356555@coredump.intra.peff.net>
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
 <20261012015846.2649843-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012015846.2649843-1-bellacaselli20@gmail.com>

On Sun, Oct 11, 2026 at 10:58:43PM -0300, Isabella Caselli wrote:

> This series adds a "hostname:" condition to includeIf, allowing a
> configuration file to be included only on machines whose hostname
> matches a pattern. It also adds GIT_HOSTNAME to "git var", so users
> can see which hostname Git uses for matching.
> 
> The series is based on Ignacio Encinas's v3 from March 2024 [1].
> Ignacio dropped the series and agreed to let me give it a try,
> so I am sending it as a new series.
> The "hostname:" patch retains his work and credits him with
> Based-on-patch-by.
> 
> Changes since Ignacio's v3:
> [...]

Thanks for thoroughly collecting and including all of the review
feedback from the earlier round. I gave the series only a fairly cursory
read, but I didn't see anything to complain about.

-Peff
