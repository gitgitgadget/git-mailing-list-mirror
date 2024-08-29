Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509162BD08
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947966; cv=none; b=PzsG5cDqnZao5tbBITfdpTgMXIAywz2pD2H4T2erWVoOFbswaO/BPF3Yl1k5KNv8zV2h7EuphKWZnl6UwtA07zQAm8ru1E+IWKB1jsyaJ3DbzkyskIaOYfd9hYKDhpgN38Zw80s/nV9uW3OB8u+SkltpQ07wUDY8JqVppw/yYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947966; c=relaxed/simple;
	bh=LFLykA04dX/W9+2M+fVMoSKWF0Ebazj0RTqTVtkbRNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5KCQNm4s5X1KRvbhVI8IBYdef8JcwUZasnv5vJh004UicLvlZiHB+JyP/KXyBf0idx1j3l5qfveOWAnLyofeXtgXLAWAopvE8QGWrLbO7lsKL2nmJW1WJfy2FM8yHkmlBxP3HU9HhgiZkfL2kPRy5w/z85C+X4LRTLNGVLifZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mqYZM2DR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mqYZM2DR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EE45324ED;
	Thu, 29 Aug 2024 12:12:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LFLykA04dX/W9+2M+fVMoSKWF0Ebazj0RTqTVt
	kbRNE=; b=mqYZM2DRutx2TzvQcZjTX6cMsN+xSBROUGPh4h7rHI3/q+BuWPK2tD
	V7q/qF5HTIv1lsOBGPTknbclZVf+vinA5l7xfQRmFEf/C3D6PRau36/T++CtK6HT
	X37kyVAhgWzftnW+SRia8Z7KaqV4yrTXIqJBK3gHIwA+4UypJ23eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77519324EC;
	Thu, 29 Aug 2024 12:12:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCFB8324EB;
	Thu, 29 Aug 2024 12:12:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
In-Reply-To: <ZtCYMiOXVUM7SD3v@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 29 Aug 2024 23:48:02 +0800")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
	<xmqq5xrjzzxt.fsf@gitster.g> <ZtCYMiOXVUM7SD3v@ArchLinux>
Date: Thu, 29 Aug 2024 09:12:42 -0700
Message-ID: <xmqqmskvwbnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85F5A700-6621-11EF-BD79-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> From my current understanding, I think I need to rebase two patches
> provided by your here:
>
>   https://lore.kernel.org/git/xmqqle0gzdyh.fsf_-_@gitster.g/
>   https://lore.kernel.org/git/xmqqbk1cz69c.fsf@gitster.g/

They are to be squashed into your patch, "suggested edit" for your
changes, not "to be rebased".  In other words, we do not want to see
a patch (from your v2 as-is) to create problems and then another
patch (taken from one of these links) applied on top to remedy them.
We instead want to see a patch (start from your v2 but with the
changes from these links) that does not introduce problems in the
first place.
