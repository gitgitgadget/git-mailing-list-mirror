Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E5272E43
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760063; cv=none; b=K3mRVrpG8ezWuX4VV1lCpCDasinc6QpJT1daq27JuqAdsGQFRKfvy5zWzXxwetON2gBf5AqIY2HpbDh/3qD4gcoezwS2fZ8R3Plvl+HrbFZdsd0W/JHrhqd5Gt59DpoThg1Xufwq4dikD4FWDDGWmyjEinKCBYYHrh0BXl0WfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760063; c=relaxed/simple;
	bh=uIvXELpp1cGnf9da1OU/IMJ90nPCJXde/xYeq7qv37U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2Ik3odplC/3CxFByjBFf5e+VVFlwKVknyn+H8ZoGnB1i31PTeg3rlGtzBOcWhzPNCUtVB6RBXusfUa5Q4b/1MOoeU7ANaBxZRCha18AGvKCEqYFw0SdCGgbPYqkvm8dRtAuwo0eu/CmCuDqgcNig1SlyBiInxgsIc2N2rnkvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CgHz0VzF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CgHz0VzF"
Received: (qmail 42081 invoked by uid 109); 21 Aug 2025 07:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uIvXELpp1cGnf9da1OU/IMJ90nPCJXde/xYeq7qv37U=; b=CgHz0VzFYatG/r1j+uZzHz2rZEeLzV/qwX9Nse6aCew66F1IzSrK3KGbBTkhuFoEvrZM1bqLkZ+Vj2v8J4xWg4nYOpgh3YuYVmbvOyKtXIxlD4+JwNpFoC4/SRPbZ2w3Gj22FoUhuokYaP32+LjTl/v13zgykmcl0gjAGtmSEkp4yGctpAQEPqJnEgXL1dCTaVlv8fcf8c+NQmN1IO2fWc4suTU5a7c8LV4iVEL0qKrySSNbEvnjTOasuXHcS5Jy2k23fFhjwDGqDqm+8CBC7WqB5T5LHzW+q/adBbR1/aSqJpu/VMetOOmeKJJ0lBF9q8uGzTfWMKQ3UUIFnomVFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:07:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72073 invoked by uid 111); 21 Aug 2025 07:07:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:07:40 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:07:40 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: git@vger.kernel.org
Subject: [PATCH 0/4] oddities around add-interactive and color
Message-ID: <20250821070740.GA3356411@coredump.intra.peff.net>
References: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <20250820220439.GA1668511@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820220439.GA1668511@coredump.intra.peff.net>

On Wed, Aug 20, 2025 at 06:04:40PM -0400, Jeff King wrote:

> I'd expect something like this:
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index 3e692b47ec..ad8b4907e1 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -50,6 +50,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
>  	else
>  		s->use_color =
>  			git_config_colorbool("color.interactive", value);
> +	if (s->use_color < 0 && !repo_config_get_value(r, "color.ui", &value))
> +		s->use_color = git_config_colorbool("color.ui", value);
>  	s->use_color = want_color(s->use_color);
>  
>  	init_color(r, s, "interactive.header", s->header_color, GIT_COLOR_BOLD);
> 
> to work, but it doesn't seem to. Maybe the diff code is independently
> looking at git_use_color_default, and we really do need to set the
> variable?

Ah, indeed. There's yet another bug here. And while adding a test for
that, I found a third bug. Yikes.

So here's a series which I think addresses everything I found. These
bugs have been lurking for a while, but I guess not many people tend to
set color variables to anything exotic.

  [1/4]: stash: pass --no-color to diff-tree child processes
  [2/4]: add-interactive: respect color.diff for diff coloring
  [3/4]: add-interactive: manually fall back color config to color.ui
  [4/4]: contrib/diff-highlight: mention interactive.diffFilter

 add-interactive.c             | 88 ++++++++++++++++++++++-------------
 add-interactive.h             |  7 ++-
 add-patch.c                   | 12 ++---
 builtin/stash.c               |  4 +-
 contrib/diff-highlight/README |  8 ++++
 t/t3701-add-interactive.sh    | 51 ++++++++++++++++++++
 t/t3904-stash-patch.sh        | 10 ++++
 7 files changed, 138 insertions(+), 42 deletions(-)

-Peff
