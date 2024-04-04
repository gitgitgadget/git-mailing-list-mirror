Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E817BA8
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249801; cv=none; b=f/rWbcbTDzxv/depNKUTi/I1JYQhfLWg5rKl4INKGwZJj2H53zCVsR0EpWwOeIkmOVt6J6oic6GylXVFDQem6Etfg4YqjafaMU+5ZNpPL+QTdqpPUvPy1IBsCp5ufdfWTiPgGWEp/WzFUbPdSZjRhHMXz5r4qUakYEais3bciEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249801; c=relaxed/simple;
	bh=lPeuB0vvocqviv6hRqIh9MhjG1TSuMaH0K9mAB3s6tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCrs5XdAJQbuHOK/YgmiowYAzEhJfk5gVsduN26wyqbEvyBwax1yuc8jR0qUUArIknDUFFO7Zk7hXyJTYBSTBrpiRhkIgdcKNE41nCZ3PNsR18aBsFyIpYsyi8/IM44tO0zvrpoR8C5xqS1uSXGUTOScvJdjQapNcIeH469uv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dV05G8Zv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dV05G8Zv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39A361E5D0A;
	Thu,  4 Apr 2024 12:56:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lPeuB0vvocqviv6hRqIh9MhjG1TSuMaH0K9mAB
	3s6tA=; b=dV05G8Zv6dasB2UHNr+znbuyYJQi5ibjjTMKv/kZIBZpSCHvg21F1O
	jPmyE3DswfQB+K+hKHAD31mHgtFcbaBPp2VCV1/GCTKIxWY+3ea7PfGjX/bwl3+M
	5C98OHoeNQ04TEWkwteDjOAHUh8kPL3LU8TDX1pfcuxIkw5V6l6Dw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3124B1E5D09;
	Thu,  4 Apr 2024 12:56:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90A3C1E5D06;
	Thu,  4 Apr 2024 12:56:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexandre Badez <alexandre@badez.eu>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: Git log --decorate show prefetch objects
In-Reply-To: <5a16d4e3-6fa4-45f3-ae79-576f3fa80d44@badez.eu> (Alexandre
	Badez's message of "Thu, 4 Apr 2024 12:16:20 +0200")
References: <5a16d4e3-6fa4-45f3-ae79-576f3fa80d44@badez.eu>
Date: Thu, 04 Apr 2024 09:56:30 -0700
Message-ID: <xmqqh6gh12yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49762B10-F2A4-11EE-8822-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alexandre Badez <alexandre@badez.eu> writes:

> # What did you do before the bug happened? (Steps to reproduce your issue)
>
> <on a git repository not fetch from a "long" time so you have missing
> branches and/or objects>
>
> git maintenance run --task=prefetch
>
> git log --oneline --decorate --all --graph

I do not use the prefetch stuff, but unfortunately the person who
was most familiar with "maintenance" are no longer active on this
list, so let me take a crack.

I think your complaint is that "--all" really means "all", not just
"heads" and "tags" but also includes "prefetch", while the prefetch
hierarchy is not included in the "--decorate" sources.

What does

    $ git log --oneline --branches --tags --decorate --graph

show, and is it closer to what you expected (note: this is not a
direct suggestion of a workaround---trying to gauge what the
direction is to move forward)?

Thanks.
