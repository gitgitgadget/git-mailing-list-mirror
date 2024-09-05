Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C20C2FD
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555070; cv=none; b=VqYYXPl4UMlwT/OyNEWtbPqaT3geKYBGDCh8F1OFAYVdgEWkyov5X62oWsgQyzk4Zn/C/txnos6+d/lSRisIM8MMmE6GgivLs7ULvVXwoy/zf7J52f/ZKdh71sePh96oFYYhKVLDIzaJrfqNaF+wGY/de9o1YHzNQfXbgmJNXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555070; c=relaxed/simple;
	bh=0JTN9caJQNm9kHeGDtx4cwoVeRZfgYoyk3Ny62n0FkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W69eas0nPN6WWGRZqfjPEg8SETo5qK4OySbEnjS7q1YHeJS+/BUWUJILrm3P4JGaEcgfTm5vxQ800U2ZHiM94V6ctTqq48hd3tH2S7xc+p0Q7jQfJx+T69QippLDxYyJXk8dX8Z+83oX4UrkiK5vXvsh/vsey45PJbtxbhHcNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N54pQ4Tc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N54pQ4Tc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E2232CB61;
	Thu,  5 Sep 2024 12:51:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0JTN9caJQNm9kHeGDtx4cwoVeRZfgYoyk3Ny62
	n0FkU=; b=N54pQ4Tc+x6X6Oq/7gwk5okaOvxKkC6xqphocEvJ3HmtaYdReUrzX5
	GcWhiTBlaXQDiTDjwoqjrgqG6YXUDz/vjycucFpcPDsZQ7CgkMd3/3IYBsaSoZUZ
	MtNoMPDLGV99wGEFKpzq4O/0K8S+8ZQwshjMiFAi6jf1y55g0BjFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84BFE2CB60;
	Thu,  5 Sep 2024 12:51:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA0202CB5D;
	Thu,  5 Sep 2024 12:51:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <ZtnbFXL7W5DvW8UN@nand.local> (Taylor Blau's message of "Thu, 5
	Sep 2024 12:23:49 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
	<Ztdn25zfi8WHO+GS@nand.local>
	<20240905103736.GC2556395@coredump.intra.peff.net>
	<xmqq34me5crn.fsf@gitster.g> <ZtnbFXL7W5DvW8UN@nand.local>
Date: Thu, 05 Sep 2024 09:51:00 -0700
Message-ID: <xmqq34me3uyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 089038EE-6BA7-11EF-B2ED-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> If so, I agree, but would note that this series does not yet switch
> index-pack to use the non-collision detecting SHA-1 implementation when
> available, so that would not be a prerequisite for merging this series.

Hmph, I am confused.  It needs to be corrected in order to address
collisions of the tail sum Peff raised, as no longer checked the
tail sum with SHA1DC but with "fast" SHA-1.

Doesn't it make it a prerequisite?

