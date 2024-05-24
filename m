Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6258364A9
	for <git@vger.kernel.org>; Fri, 24 May 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573196; cv=none; b=DTiDiEuZhWJYVA0G8+zBEJqEiFJcXhnrWp1yM1H7yJgYzXJUllEMFDUeHeig9SSSLaRRJ1W1iDGN1fUYrxXrpMKXhOntdLL4ZynHBuP1ZrajrJDAIGKdb0ojQomsOLedNKVPFJtG6LvQ///wewHVdnm82Ip4N3ueJTh+t5HRoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573196; c=relaxed/simple;
	bh=h+dxOmMY4BgLz6GbTb71nAwSgpaLmKtgDdGqN6Ju8KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kKX1QO6OMz5fGfo15YBBL6ZGnfUrx+44hl3BO5IjA3ZkZY/rUYuISVBO1YXJ7I9MKi7P0YdDiZ16f28o4gxrGbzu2n1vZx2ohcqYgsoydDwNmaoklYv01d6aYHMuMuiTIfF+kedyFjD1bdCYMBtQBevzaHrM9fMCyRMS35jEsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NpfFsMWA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NpfFsMWA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C9281B0E6;
	Fri, 24 May 2024 13:53:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h+dxOmMY4BgLz6GbTb71nAwSgpaLmKtgDdGqN6
	Ju8KE=; b=NpfFsMWAzCrO8mSe75iHhzIf/0HxuzfC55gII4L3EKAmpzYM/S9Z3O
	3dsWcMESTtQVuqqS8Bky9Wqyky8p9nzKOQhC4WUPdYHQSt7l875Jf2cFkgf/FFML
	C7ok8RQBOJomo0QPMlbD/p8NOaNt+733zbY1xP9GmIgoE8PS6Tf6A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 823D11B0E5;
	Fri, 24 May 2024 13:53:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E79621B0E4;
	Fri, 24 May 2024 13:53:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] t: mark a bunch of tests as leak-free
In-Reply-To: <xmqqh6ennqkw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 May 2024 09:05:03 -0700")
References: <cover.1716465556.git.ps@pks.im>
	<0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
	<xmqqwmnktocp.fsf@gitster.g> <ZlA6KHZtn4lvyFcI@tanuki>
	<xmqqh6ennqkw.fsf@gitster.g>
Date: Fri, 24 May 2024 10:53:11 -0700
Message-ID: <xmqqjzjjksfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D7B720C-19F6-11EF-862C-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> --- >8 ---
> Subject: ci: make IO::Pty available
>
> When t/test-terminal.perl, which requires IO::Pty (and File::Copy,
> but that comes standard with perl-modules?), does not work, the
> tests with TTY prerequisite are skipped.

... please ignore this, of course ;-) Your latest iteration does the
right thing on this one, and unmarks the two that are not yet ready.

Thanks.
