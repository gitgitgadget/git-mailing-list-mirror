Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EB4E1DD
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710026335; cv=none; b=LnTVOklr5jqzAdu9MWNDLPWsJh8w0EusRRZfHIZDrpvovsK/0E0lfa0jY0pktyS2Tn/xYmKSXvCxy1mUCj3KFY7bWsV9i0UWKdhc8jlAoYZK2ps6jPVSIYwDPhJXTrwgsyorJzokNpB67eVEqd1tKQsLy5koTxxDtlFKH/p1wlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710026335; c=relaxed/simple;
	bh=Kdp+Co/6mlj1Ki10QBlGNTyr1uPzE07UHf1gx7flOGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BTOpvI1FnBBgfw4Zo2n5me0gecj1bb6GFFnZthJOGJsk1LbSoovxfuyfXEGipj6PbAtldvBX9bQaYRUvKxB2cpaVfrFHSc+9+jpYD/t91Bt69WZ+LJb/QTlOpkuzmKaO9o3GeQM3I7yN5ljDhn5uBBstvH4CqQMMaSykAdJKlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JuHXD9hU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JuHXD9hU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E4D781DA88D;
	Sat,  9 Mar 2024 18:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Kdp+Co/6mlj1Ki10QBlGNTyr1uPzE07UHf1gx7
	flOGw=; b=JuHXD9hU6LYVr9SxRlYo00kYIWn9dpNgEVLXbepVjaBLGprGk2uCu3
	jdTbXtAduPUsU47pJQ2H1Q4QALhOCnz24J+FmuOIJ6RPRthnIQea47eitGPcEmeS
	OGm9COnyc5M9fkD+9JTkSHlMEhiT0PqO4jQmscrrIA0fb4OhNYCDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC41D1DA88C;
	Sat,  9 Mar 2024 18:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50B7D1DA88B;
	Sat,  9 Mar 2024 18:18:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] merge-ort/merge-recursive: do report errors in
 `merge_submodule()`
In-Reply-To: <a0af1155-59d9-0c35-f3e9-c0fe1ba0e11b@gmx.de> (Johannes
	Schindelin's message of "Sat, 9 Mar 2024 21:46:04 +0100 (CET)")
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
	<50fe1a26515c06afec5ac7fb723727e1365a14fc.1709993397.git.gitgitgadget@gmail.com>
	<xmqqwmqbcmrz.fsf@gitster.g>
	<a0af1155-59d9-0c35-f3e9-c0fe1ba0e11b@gmx.de>
Date: Sat, 09 Mar 2024 15:18:44 -0800
Message-ID: <xmqqle6r0zaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 604B6866-DE6B-11EE-9592-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> By my counting, 5 of the handled cases result in ret = -1, i.e.
> non-recoverable errors, but 8 of the cases result in ret = 0,
> i.e. unclean merges, whereas only 2 cases return 1, i.e. clean
> merges.

Sounds good.  Thanks.
