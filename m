Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FF138496
	for <git@vger.kernel.org>; Mon, 20 May 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227731; cv=none; b=EghEPgNtuteheI3pg+kRA/Xo1wcni8uY1dzCn7JqzrLuI4L49wWvJnwpmbf1tCXGSgHusilkwjZZfJKwYr4nPmRs7mQJzf5tAFOjx1aq6mArilkqpRBdHUIo5uxCFk0gQ4ys7cfPfPoIoS+kgdLehivCjbwQaGB92mcgtUVX4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227731; c=relaxed/simple;
	bh=z/9s/wc+4cZAKcxoaa3x5bzIsC69MWjIzeEGZkifto4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JqL9ppW/EZITWCB12V2RdgxwRlMDoM1K6xj0wEMo7U6mKDtRTu+xpyhMgyhzS+LzpaZkx8iGUkN9ct4pneRiC/aRvb+e+O1rG4lqKCco2/AOyq73V+B+Tx3kgUirEcEj+UeJLJfl2cD7OYIAUyObR7HuCUTl/nzZMIbTNfzVAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=riKykyOB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="riKykyOB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99C8F18D2A;
	Mon, 20 May 2024 13:55:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z/9s/wc+4cZAKcxoaa3x5bzIsC69MWjIzeEGZk
	ifto4=; b=riKykyOBddH1g4yOt2Ad1t8T/3AKJkleoKnMTWn2S7SCzrJV+4el7e
	G5wK/OzQV/MNSTuVQAH9FYq4e9j55u89CPvByNmPBEtE2SttR6Tswo/eXf/092Up
	U8P6KRPt6vPWGa1GPYOC3C3IbRfThtQvPFuGoWzvPL8ZsV5XkfD4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9188818D28;
	Mon, 20 May 2024 13:55:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC50718D27;
	Mon, 20 May 2024 13:55:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Scogland <scogland1@llnl.gov>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Tom Scogland via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
In-Reply-To: <95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov> (Tom Scogland's
	message of "Mon, 20 May 2024 09:10:51 -0700")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
	<pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
	<bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
	<95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
Date: Mon, 20 May 2024 10:55:26 -0700
Message-ID: <xmqq5xv8id0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 244F44FA-16D2-11EF-8FAF-25B3960A682E-77302942!pb-smtp2.pobox.com

Tom Scogland <scogland1@llnl.gov> writes:

> That said, it sounds like both you and Junio prefer updating the
> docs rather than the code, which makes me think I'm in the
> minority in that opinion.  If that's the case, I can certainly
> update the docs, and I imagine we can backport that easily
> wherever it makes sense.  I would really like to have the option
> to have the prefix apply though, either adding a new flag or an
> option to the existing one that would be invalid given current
> syntax or similar to provide the option.

[jc: wrapped overly long lines]

Wouldn't

    #!/bin/sh
    prefix=foo/bar
    git archive --prefix="$prefix" --add-file=x --add-file=y \
	--add-virtual-file="$prefix/path:contents"

be an option enough?  You only have to define $prefix once.

