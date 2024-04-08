Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129141487C5
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612488; cv=none; b=YYIRNk+doyp72G9BOsiYvaad3Ezanfk/eRWieH1UYnvmVdFBtO3lU08x3oSMjM4ytJ+BgL44IK3oed7pvUQpBH1focz9U9a2JLCAulUsRvaZkCEyo0ZNW6ZFBXBLgzHVrrvRzUXRBawbj2HenHgp2/XvMhARUpxvm2zRjd2hYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612488; c=relaxed/simple;
	bh=Ih+cDt3nHKMeN0DP754sVsb6QvyhdWuCKE+/aSPDyXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YBUtvAIQqa8JqG8SVDZmlALD1TS3/SpYXFwVyFZgUqMywQai2SjSyZmY7un070xWLWFGasluHnDZWCXL7bVn5meDvz6OHFj21N3jLvafWN5b80r/yMXeB9ReY/UpMSLMb4LYJzd7EP7t2bn5PXYzHpKsJCE6QOofcHU9M3MnpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=we/jZeN/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="we/jZeN/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B1211DC3AA;
	Mon,  8 Apr 2024 17:41:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ih+cDt3nHKMeN0DP754sVsb6QvyhdWuCKE+/aS
	PDyXI=; b=we/jZeN/dL7+k/nE3CH8VKxlB15qzycZhastAxSNZI3nHKXvfqsNeJ
	3B4J23M4AdvtASf+Ys+IpRRw4vEZKtBS4GZgf47wVK3u8RgZ8lzSfhxiI5hl06bO
	BknjXkAibQ38mMbDXwrE2MievFVCglGpVOq6Ywno1tX5ThTi1MDXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13CA31DC3A9;
	Mon,  8 Apr 2024 17:41:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DE171DC3A8;
	Mon,  8 Apr 2024 17:41:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Dario Gjorgjevski <dario.gjorgjevski@gmail.com>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
In-Reply-To: <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 8 Apr 2024 11:51:44 -0400")
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	<9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
Date: Mon, 08 Apr 2024 14:41:24 -0700
Message-ID: <xmqqle5n8rcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BFE2716A-F5F0-11EE-A6B5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> When a conditional word (ifeq, ifneq, ifdef, etc.) is preceded by one or
> more tab characters, replace each tab character with 8 space characters
> with the following:
>
>     find . -type f -not -path './.git/*' -name Makefile -or -name '*.mak' |
>       xargs perl -i -pe '
>         s/(\t+)(ifn?eq|ifn?def|else|endif)/" " x (length($1) * 8) . $2/ge unless /\\$/
>       '

Yuck, it means auto indenting Makefile and its pieces almost
impossible X-<.  I'll take the patch as there is no way to revert
the change to GNU make, though.

Thanks.
