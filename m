Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4D73452
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284324; cv=none; b=RkhA5OH0aUlECaSgEmLG7YfcP7lZJRz+howmp3eM0Vm5camNDt/qsLG76awoBntMac+7BbJ5c4JIyugjGulKpRtiDORaRkEljrjCg3pCkG/A58GyEVdd9W3+M4tkO8KKgqsvOOhoQGq0pTzq4ZAFlnLjNM9I5hxqx+PNeBV4Tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284324; c=relaxed/simple;
	bh=m9TUrWLvSlzFpoSb4uc5HTugnKRXhIJMYtxazCQ9Qss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgtywpaPMM1ZvRzClhsdkKOTLJX22ujByi46Bg1zqe6VMGBlZpd6OYIXG5u+Qw+uWyUk/ocz5FlyLAW0JpvPlN543gw8cCshNX1ivuaGUZ7c3wZhHu4RPStEbroQdtjTXvHL6E1DOHts9qIu7NMpDvB9aNVW0wDNehpyDx/71a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cNxbDGQk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNxbDGQk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2443E2D36A;
	Wed, 25 Sep 2024 13:12:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m9TUrWLvSlzFpoSb4uc5HTugnKRXhIJMYtxazC
	Q9Qss=; b=cNxbDGQkuw9PFewju3mrZeTKroG8zcMyHI/+JCUkWauCUL8nV9iu8W
	q03znImFEw7yfZIaZ8k6QTjIRqmNCnLI9gY61IOKZFJyJO+oKigC8bKpCMxUv3P6
	fY44m9r5CNWRyCuBwqRrtljr8KdgOGUjdGYKcoVuunpMjSpU2zNwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E44AC2D369;
	Wed, 25 Sep 2024 13:12:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8259D2D366;
	Wed, 25 Sep 2024 13:12:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
In-Reply-To: <ZvM3N3+JJNlkpZSa@nand.local> (Taylor Blau's message of "Tue, 24
	Sep 2024 18:03:35 -0400")
References: <20240915111119.GA2017770@coredump.intra.peff.net>
	<20240915112024.GB2017851@coredump.intra.peff.net>
	<ZulEwjnNQet6th8w@nand.local> <xmqqed5il3ui.fsf@gitster.g>
	<20240924205558.GC586150@coredump.intra.peff.net>
	<ZvM3N3+JJNlkpZSa@nand.local>
Date: Wed, 25 Sep 2024 10:11:59 -0700
Message-ID: <xmqqfrpnody8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 470990D8-7B61-11EF-A13E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Yeah, this is definitely all academic. I do not at all mind the
> implementation that you went with here.

Neither do I.  Thanks, both.

