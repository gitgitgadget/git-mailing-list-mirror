Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6554FAD
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061672; cv=none; b=fy1GBrwSZaRB5oXyLYjqpBpOoKwXAtLxOuAiT5NMx7vpAuS+snJ8U10vdOGMG1W4bSHBv5OFX5YhFTnyVxk+OGhvSCLthCCkILXqQ3+9WiMq6UfeKUKJtxCEhiup7rpP60tWiGI0AzMcFR0Ur8ToYFdS8dFLdn+wXumx/FoQgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061672; c=relaxed/simple;
	bh=/tRYhcbEGtzc/Pad2U6rcFzmGS5Bn0/58isOiDSCcJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7xGscS7Cpi4Hv40h9KY/h9Vc7HWvqyuOReMRd4tTLcXootd3QhmXzspaWLxY53+N6viRM5zEwuTbfw87wztlscPlOkIvl/73rxX7wIEDGJ/KkfaoxOVnaPpR00jlMgWsJ9edf8tMay5nkGlgw4s66lttHTTQpTW0puYYMSeTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=J1tWZiNM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J1tWZiNM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27AF5328CF;
	Mon, 10 Jun 2024 19:21:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/tRYhcbEGtzc/Pad2U6rcFzmGS5Bn0/58isOiD
	SCcJU=; b=J1tWZiNMmq/+gF3ouqbrO4U/ZvmDx1lT0dmKhCQa7iZPD8aMqzWOv5
	NuKh09YvKtqtXmQ0qe8LuNZBDPdyNFvwNFgYBha6gNnBfz89XHpA42VZDK5Ho0Uk
	b76acgwqPk1NRz0YWFnaoBroGPywAwap4OHbGfFhL2ETsc3496iA4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F95F328CE;
	Mon, 10 Jun 2024 19:21:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93BB0328CC;
	Mon, 10 Jun 2024 19:21:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: SEGV (detected by Address Sanitizer) when using `core.abbrev`
 option
In-Reply-To: <CAO_smVjL+Ms1e_Rd5e1k-zMJb_NydBtX76Dh=ifK9Ym9ME9roQ@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 10 Jun 2024 16:01:42 -0700")
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
	<CAO_smVjL+Ms1e_Rd5e1k-zMJb_NydBtX76Dh=ifK9Ym9ME9roQ@mail.gmail.com>
Date: Mon, 10 Jun 2024 16:21:08 -0700
Message-ID: <xmqq1q54z8nv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EB3F1E4-2780-11EF-AEE6-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I just realized I didn't give a reproduction command, sorry about
> that; here's the reproduction command provided by our user:
>
> git config --global core.abbrev 12
> git clone https://github.com/git/git.git

Or "git -c core.abbrev=12 clone https://any/thing".

Nicely spotted.  And this is a curious one, as you would generally
expect that having a fallback setting in the global space would help
you instead of hurting you.
