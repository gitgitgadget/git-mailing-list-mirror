Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1A1B5AA
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810111; cv=none; b=hebTsczZXicnUt2sxejRVr+DPxGhyzVDumsHy6euMoSIk3XYZ6fMxwIy/nA2XPA4UCo5Gqn72gc2TjfH2G3g9EAWD33M1+R9J94FRDyhU4tPWIpfoboBMg5fnYj2z/OABNmBD8xJaKRcvW9nlpnkJEsLRq9MaXzFNyzyAbe6Buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810111; c=relaxed/simple;
	bh=PwG2JAVOQHDSe24uifmu1nRPc59ePPBLDNIAYvhBJT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D61EUfVOSWazbux1vC9VMRUw4Quc8nlPXJ4BwTfkWRq3MWOElcP3CGU13tCKL9f9zKtDmYsYcMS7LlvqHxTewamdKuZd7H8hOnDO9lCwR62w4fItjLZkxKdpryiquH2dRtbuXRldJhRfsi130q4QcCI/13jduoD3jM6asq/IicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A2rG9Kj4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A2rG9Kj4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4CC23A1ED;
	Tue, 27 Aug 2024 21:55:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PwG2JAVOQHDSe24uifmu1nRPc59ePPBLDNIAYv
	hBJT0=; b=A2rG9Kj4+R7owX6zi9PeGgj0S/W4qZ9d1Im+MDAliMf+dZn1Wq5xTH
	fFLShhKAw35Jjv6oCvm4PMyVq0yD+BIjrJ1xStHvI5i+k9SFVFMKBkKgCsMgS49O
	0jZhplr3POEL7KEaEe49WdoP2BrJpr3IkmATE/4NLceuCs1GMJPac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E0D23A1EB;
	Tue, 27 Aug 2024 21:55:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51C293A1EA;
	Tue, 27 Aug 2024 21:55:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Josh Steadmon
 <steadmon@google.com>,  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] send-email: add --mailmap support
In-Reply-To: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
	(Jacob Keller's message of "Tue, 27 Aug 2024 14:27:15 -0700")
References: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
Date: Tue, 27 Aug 2024 18:55:04 -0700
Message-ID: <xmqqjzg15s3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D0B3FCE-64E0-11EF-8856-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> Changes in v3:
> - Edit description of patch 1 to clarify lack of validation of email
>   addresses.
> - Update tests for check-mailmap, removing the bogus contact tests entirely.
> - Link to v2: https://lore.kernel.org/r/20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com

All the incremental changes looked sensible to me.  Let me wait for
a few days and then mark the topic for 'next', unless others find
issues.

Thanks.
