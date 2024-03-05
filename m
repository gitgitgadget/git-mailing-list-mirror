Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971E12D213
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679778; cv=none; b=CmgO/wBVMrQWF/VkSlDH5KjHo5+OKwFZFEJFeUmhaOTC1Q64X7XoKUENOrHkgpIu5+obcDoSE3f7E/Puag8zV9zABIRIj9e03qrwPvWg2xtfenetyVDwtE3ufLInqx096trU0X5gXb15ZcySPDECnQcSSvsIAz6Va3i7hAwHQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679778; c=relaxed/simple;
	bh=VtAwUt+CDGCOHVYIC43j14NJShXXCBDWnstfUvzp9JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SbXRUyOPoSxpZsRt1XzBc9Yj890HJqHgyTT7ESHLaDpKxNgiAXxL1Xu7CWYGQvRRIK/GfhbjCSfEH1oHqCEMEFH4QfPBjKpn/v0Jv9MIH+sxvF+8vLX0UzOF4SKoBFuiw0tYyMDh9txj8gh7ykhGEUp1COsQEKFZlvoqguMMEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TrCwGP6S; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TrCwGP6S"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B7ED6185B6;
	Tue,  5 Mar 2024 18:02:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VtAwUt+CDGCOHVYIC43j14NJShXXCBDWnstfUv
	zp9JE=; b=TrCwGP6SWLlN1daWf55k6xiASh6m9sbyfrtRDoeEwfWE1f/WqlYKIt
	0BV4rIbFV3iXfHbZNgH1xzQz33FVpSkZ9lfPQianOE68aRcP/qLSR5T6kjZFO+xK
	M67myQUL77DtVzlOvo1tZzui4RBYnCf+68ilxy/M7JmHYpM3Eatxw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AEFEF185B5;
	Tue,  5 Mar 2024 18:02:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49501185AD;
	Tue,  5 Mar 2024 18:02:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt" <ps@pks.im>,  =?utf-8?Q?Mic?=
 =?utf-8?Q?hal_Such=C3=A1nek?= <msuchanek@suse.de>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl_AVILA?= <jn.avila@free.fr>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Aryan Gupta <garyan447@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com> (Aryan
	Gupta via GitGitGadget's message of "Tue, 05 Mar 2024 22:09:17 +0000")
References: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
	<pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
Date: Tue, 05 Mar 2024 15:02:45 -0800
Message-ID: <xmqqh6hkxox6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B9C654A-DB44-11EE-BC20-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aryan Gupta <garyan447@gmail.com>
>
> Modernize the formatting of the test script to align with current
> standards and improve its overall readability.
>
> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---

Both the above proposed commit log message and the proposed changes
to the code look good.

This is a tangent but as can be seen at

  https://lore.kernel.org/git/pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com/raw

your message has these headers that are not syntactically correct
and may even cause responses to bounce unless editted.

    Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
        "Michal =?UTF-8?Q?Such=C3=A1nek?= [ ]" <msuchanek@suse.de>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Aryan Gupta <garyan447@gmail.com>,
        Aryan Gupta <garyan447@gmail.com>

I cannot tell if this is a bug in GGG, or a fault of a corrupt pull
request thrown at GGG, but it is annoying that recipients have to
edit the addresses in e-mail header.  Can somebody take a look into
it, please (or is it a known issue?).

Thanks.
