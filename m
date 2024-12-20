Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEB218E9A
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710174; cv=none; b=bXXeoexrSCM5JSWrDooWv6jsfweSjB+3yCcZLcVto5d/GvQSKIVvV/KPiiVEs1iZr6ImbAP81WR6CJBHos+ZMZ0q0BcWlHpsLtKfwyQaXXNIu0OHRRYrjXDAxHQLtRtOrdiqvTPZe+f6m9tDjfobTqm8+9a7zUAwVHrmAR3ndqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710174; c=relaxed/simple;
	bh=auoRvX8+nCtRrfa7CPKOdEUl7AE0eTk7OApKxa3Yhg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFTk/LVfZLy/NSzWgxN6yeAY6qOoL3WHWZpvCqZ7JzKxDjsAw63LhSsCd89qpyH4zRgZNTGmoh3TAn+vsA2BYBi2/guhoWUV9VzDmt7Vw/OwF8+vyL6PBdgKaXoY9k9dRhjn0hFdD1eGtHD6PSkTXMsdAgzyk4uGfT6nf8c9suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O8jSp+cG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O8jSp+cG"
Received: (qmail 13882 invoked by uid 109); 20 Dec 2024 15:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=auoRvX8+nCtRrfa7CPKOdEUl7AE0eTk7OApKxa3Yhg4=; b=O8jSp+cGFgNKShMHgrww4AEauVW+rrcygS7Nz3FXLaedI4INRqpaXxoeicKYBkVOQDAjF5wI+QPZWpap6ZZBfL6L2L4PyefLw8ZvkbuGYeEll/ns9a21SO6kSPQ5hOOJrKr4bXWk0TXai/OE5d5BELkUza8tYMdopIHcDUHUohWWyF0Cn95k8SX+0+5W8+RfpdWwutzzyaFdzDpgzTTWpRTeZ7FKzuAHglh1g5TJy1aaJ2Fto5p/6VslJ5CnJIdq2j6jgznMlvw1vUYFdTpkdMothFRb6WwgvuqTq8LkBKnK7qmoURYmTgSnR7JLD/l0eGgjXITnOVjvDWczGD/6aQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 15:56:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18584 invoked by uid 111); 20 Dec 2024 15:56:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 10:56:11 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 10:56:10 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 0/5] GIT-VERSION-GEN: fix overriding values
Message-ID: <20241220155610.GD152570@coredump.intra.peff.net>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>

On Fri, Dec 20, 2024 at 01:22:44PM +0100, Patrick Steinhardt wrote:

> Changes in v2:
> 
>   - Don't strip leading `v`s when `GIT_VERSION` was set explicitly.
>   - Allow setting build info via "config.mak" again.
>   - Wire up build info options for Meson.
>   - Link to v1: https://lore.kernel.org/r/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im

Thanks, I confirmed that this fixes the doc-diff issue, and setting
values in config.mak works.

I left some small comments on patch 1. Patches 2-4 look good to me, and
I'm not qualified to comment on meson patches. ;)

-Peff
