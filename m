Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1DA3D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916928; cv=none; b=LlH6My97csF2v8ahZaZJReACbfI/QFfRKX2Ls6OCp4iF+IvX3Cd8wES4i0Be1LB4D9j/PLwGjVE79CxjRx48UJFUd6r9aJDIpop8igmigrX3dxq4JQq1VSViBceGPYC3IwI45BxQeXDrxOna0R/unFndXKGEO1e3GyZwUJWbofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916928; c=relaxed/simple;
	bh=a/jdwxhgooz9d7eMMmaMu9b1Da005iAEeg4EID2uvNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8wO94I79GkufKelXyMraqcfujHqq+XoOTsojKi8zntXUcBDpHFMr3yT3ldr1BbHjAXxvKedDKq3RwsOJsMHfPxsUdYPr4UdBR4DmI1D/X/69UbmoaxK6oMgFU0wDOhhNxJE4uaXjNu5sWqb/mAXkU+lIm+yEdaGpV6EYH4GVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FP6f7BM8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FP6f7BM8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 52F161DABCD;
	Wed, 20 Mar 2024 02:42:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a/jdwxhgooz9d7eMMmaMu9b1Da005iAEeg4EID
	2uvNU=; b=FP6f7BM8UzqFvarl4ibMOJ6bYY5NBSstN4ErzE6tkEhhBlRgB747Tp
	lofaoT9Z5lj0M0SsTIvIBU14MS6v4wopV0qCy/AhzYJTGe5dmPMX6k/UrUvJCexf
	13eJG+67KHvYsVAYF5Kl185Bl312vGt4WgoUaZT71PBVDPKXzMtkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 496CE1DABCB;
	Wed, 20 Mar 2024 02:42:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98A4D1DABC9;
	Wed, 20 Mar 2024 02:42:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Mon, 18 Mar 2024 23:24:21 +0100")
References: <cover.1710800549.git.dsimic@manjaro.org>
	<92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
Date: Tue, 19 Mar 2024 23:42:03 -0700
Message-ID: <xmqqzfutjtfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6D76D5E-E684-11EE-BDFE-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> +test_expect_success 'setup whitespace config' '
> +	tr "X" "\011" >.git/config <<-\EOF
> +	[section]
> +		Xsolid = rock
> +		Xsparse = big XX blue
> +		XsparseAndTail = big XX blue 
> +		XsparseAndTailQuoted = "big XX blue "
> +		XsparseAndBiggerTail = big XX blue X X
> +		XsparseAndBiggerTailQuoted = "big XX blue X X"
> +		XsparseAndBiggerTailQuotedPlus = "big XX blue X X"X 
> +		XheadAndTail = Xbig blue 
> +		XheadAndTailQuoted = "Xbig blue "
> +		XheadAndTailQuotedPlus = "Xbig blue " 
> +		Xannotated = big blueX# to be discarded
> +		XannotatedQuoted = "big blue"X# to be discarded
> +	EOF
> +'

If you want to write tests where leading and trailing whitespace
matter in them, making these invisible characters visible is a good
way to convey your intention to your readers.

	sed -e "s/Q/	/g" \
	    -e "s/^|//" \
	    -e "s/[$]$//" <<-\EOF
	|[section]
	|	solid = rock  $
	|	sparse = tab and space Q $
	EOF

This is still true even if we assume there is no patch corruption
while the e-mail is in transit.  It is safe to assume that the
receiving end of your patches uses "git am --whitespace=fix" and a
common way to protect against it is to use the opposite of "cat -e"
as a convention, additional to the "'|' is the left edge of paper"
and "Q stands for HT" conventions.
