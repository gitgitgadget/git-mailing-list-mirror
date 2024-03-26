Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093312B151
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486965; cv=none; b=c2S+tUNVolSHJSd1ux62imxDTGE1eTIlWhd94tpGTzApqRYex5JCK3AH17Oue2A4h4fFv6T1A40daWFT8Fd7OXm9aKLKdySU28QGW7UD4LMlc0ViyVuSWSh+YwKaeTLcC3yAF6cY8VAfGV1wHMg3DlRqaAj6Slu2qsvocw8Xyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486965; c=relaxed/simple;
	bh=kaQ+BMm9ysDwmdSJlaxzX4/stfD8EkI1tKBOzprLPD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjWdoTsQ2NYcf4yZPLBQ22GTho73hpazqkl6BT3mU/n6ZX5WR8VWubXfgXdkQeAgrXomb4u4ykUlCD4FnP89qGvRQyrdo66xYY6+NR30seMx7mPOogrwbkux2ZbOyfySaYi8G68my/3AiSzuaOLctepleuPvrGWyXEMTbnGt5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SxECKofD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxECKofD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AEC91F2ACD;
	Tue, 26 Mar 2024 17:02:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kaQ+BMm9ysDwmdSJlaxzX4/stfD8EkI1tKBOzp
	rLPD0=; b=SxECKofDgmazXQ1OWkukN5GffQ15wOf/X2sSoXm/eD+SMatG1L0psf
	7fSdjcBvOWxtyD2J/50hMqjG7y87buUE0AZr11OdpvLq2sDnxMYCugJM5eB7mkh5
	MlO3vpEToscU9oDwEnoTCU17PF3ndfbJMVidlpKHBV1ouwsIWSkj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 120241F2ACC;
	Tue, 26 Mar 2024 17:02:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6806C1F2AC8;
	Tue, 26 Mar 2024 17:02:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #08; Tue, 26)
In-Reply-To: <ZgM2zMykhkIAaXro@nand.local> (Taylor Blau's message of "Tue, 26
	Mar 2024 16:57:48 -0400")
References: <xmqqle64algt.fsf@gitster.g> <ZgMwaG28aoC7Njcg@nand.local>
	<xmqqwmpo90xk.fsf@gitster.g> <ZgM2zMykhkIAaXro@nand.local>
Date: Tue, 26 Mar 2024 14:02:41 -0700
Message-ID: <xmqqo7b0905q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2FD8A8C8-EBB4-11EE-806D-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Sure, try this:
>
>     The pack-bitmap machinery learned to write pseudo-merge bitmaps,
>     which act as imaginary octopus merges covering un-bitmapped
>     reference tips. This enhances bitmap coverage, and thus,
>     performance, for repositories with many references using bitmaps.

Beautiful.
