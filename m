Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA013AA36
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079023; cv=none; b=lRv/wLHnoCOSyZk4LW8u5tyCRlW3ymYjyqklPWIoPaLCkl56haWeHtwvox72LcAU4fg+WbnCwwAsXyrOFWptId7o1uZWDiS8GeKtHd6ZPKiTMATA0esOmYsdhRi3prPTYZZlyb3LGyc4kcGU2PwHk/q5Kpl0yQYCK/buH7C/9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079023; c=relaxed/simple;
	bh=aeFkdxCaYrlFmV+oQfXxf2Gc4I5a5XF+etxaatigof8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lkxq9hrwmd6ZCK8Tx4R8MMzTY6vaN26UJlRIr7L95K1/5fKx0C/fnlhY70PtQiuyPJld2f9hUdJ4rQtd+o/PNq8dqVusfT8A9b6biFqlXj5yqoM0h2V08oHAHut8ydBYC+NHxaaAd9HE1IUWO/6hQTAmUgTu+pZqIl2+bCNEWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6LvcYkf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6LvcYkf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1585E1C235;
	Wed, 11 Sep 2024 14:23:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aeFkdxCaYrlFmV+oQfXxf2Gc4I5a5XF+etxaat
	igof8=; b=f6LvcYkfEN8tgxADKJjCXkMPvf7eSWLFcCtZRAWbDZpuBcwKHPbRrQ
	+289W0XF3aSst/Dhq/RGi82/qXdrM3zJEAI0m3e9w3qgfyVvrHy4T9UvNk+ti3nT
	RE7bV5tnz3dd73ptb0qUqcX3SrCeuC9bT/cUsfZLMz8HRDC6zfs7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07E621C233;
	Wed, 11 Sep 2024 14:23:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C6411C22E;
	Wed, 11 Sep 2024 14:23:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] add: pass in repo variable instead of global
 the_repository
In-Reply-To: <6956d3fe8971475dde87909bb6b9760be6964488.1726001963.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 10 Sep 2024 20:59:20
	+0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<6956d3fe8971475dde87909bb6b9760be6964488.1726001963.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 11:23:37 -0700
Message-ID: <xmqqed5q6od2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F7857B86-706A-11EF-AA5A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> With the repository variable available in the builtin function as an
> argument, pass this down into helper functions instead of using the
> global the_repository.

Nicely done.

