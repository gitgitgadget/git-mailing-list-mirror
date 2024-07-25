Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EE19D88B
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924650; cv=none; b=LCdxIggz2kc0lfiSFbWPGnsz441codYGm3YJRHChEklkYEMcC/Wv9BqccdtWj13QGb5/KtYLIm2xVXAMkmH+0Z/Z7BEgK41x5Yl41flacZl30kMszoVRhkOk4yK6Gcs+OHLhi+pzEUNkX2Q7827NoZyN7qWwYbN5g7WAYX3Vhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924650; c=relaxed/simple;
	bh=Hgoof4IW1qZSS5Qo+ADF5lTgvG//RTqOJQC/3O2Xpsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FanivC9qOJ271eG9b0B4S+7z7isS+T3Cw2W7CGHIIS+7xHtOPFzGEsPrQL9wDySLdTumnYqoNJGEZB1up53g/B+tqiBb/a3YJ4Or4twD3Ox2gq0kGJITA3q9zO0qAAvr7gzIVzxlLFVOcPVHsYuYuGm+0p86PijAybLKi3ZaoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FunUx0Wt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FunUx0Wt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8DD836133;
	Thu, 25 Jul 2024 12:24:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hgoof4IW1qZSS5Qo+ADF5lTgvG//RTqOJQC/3O
	2Xpsc=; b=FunUx0WtvzL+1inOK0ftbHjbw/Rn2n4l8z+sKZ2wsaf5+Hsnd1J7xu
	0ARr81Rhm5PfQBpqiW7gMmGs1S4f4Xz9QMjr/xGqLDrtoP81neibqrsdSoonKgJU
	3NTbOGj7yt+gB0aW6ih0uRARIfMn9vGw4MWUCwVxdNcdKLvN81Ri0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFCE536132;
	Thu, 25 Jul 2024 12:24:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 214B33612F;
	Thu, 25 Jul 2024 12:24:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
In-Reply-To: <258254527.2690084.1721914093743@mail.yahoo.com> (avih's message
	of "Thu, 25 Jul 2024 13:28:13 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
	<xmqqy15rzwi5.fsf@gitster.g>
	<1542063589.2363688.1721786934049@mail.yahoo.com>
	<1106076396.2672924.1721906849141@mail.yahoo.com>
	<258254527.2690084.1721914093743@mail.yahoo.com>
Date: Thu, 25 Jul 2024 09:24:05 -0700
Message-ID: <xmqqsevxignu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 50BDEF9C-4AA2-11EF-A589-BAC1940A682E-77302942!pb-smtp2.pobox.com

avih <avihpit@yahoo.com> writes:

>     eval "$(printf '
>         __git_SOH="\1" __git_STX="\2" __git_ESC="\33"
>         __git_LF="\n" __git_CRLF="\r\n"
>     ')"
>
> I think it strikes the best balance between the options, both
> for this patch, and possibly also as a general recomendation.
>
> So unless there are objections or better suggestions, this is
> what I currently prefer for this patch.

Modulo my superstition against \d and \dd, the above does look
very readable and hard to break.

Thanks.
