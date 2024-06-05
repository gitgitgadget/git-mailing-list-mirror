Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE282575A
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607614; cv=none; b=ZdVWlCsfojAV+r0ec53mYmOeNwyKmd0Dtb61tUfMDHuasJCxT6zi2Mj6EuFIfOlagowATxBdCdj6CBXARiNNSfBUY7yIQJdg9v4ulW9Jg0y19rhs54TwDrNxmKLA36m3a2CI+aXP0lvkchxlKc5GaN1w4h0O7J8xnG4XOEe6k0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607614; c=relaxed/simple;
	bh=GHAEWax8Y1oUEHTX6ckj6lGpSqNYwu/olz2epG50Ki0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMLNskUpKSnTEJ8/663T7+rz/kJGcUn57UhoT82+Ksj8vjR5eiU35qmdd7cfBBGyRJBVKtN9H1fAkFm1PYJTaYSKl6bs11psiiD/dm0Ov6cBI1+7ySx9yQ2TWDYfyGf5ENJf1e9YiAVvV9lCaITCVYpgZeoAo+5clOPmhTYYfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FpCgA0RY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FpCgA0RY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 858CC25892;
	Wed,  5 Jun 2024 13:13:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GHAEWax8Y1oUEHTX6ckj6lGpSqNYwu/olz2epG
	50Ki0=; b=FpCgA0RY/SI9u2VAyDnJjDx90CesXmc9Xc4oWad4jdUpMrocc3+pxs
	tuZYQQUEkc1qx5ZB/kAx5uvC36Dvr6JNYYKwpEJ0USfcDZb20TWWPOfb+aIGuheN
	W8HPgST5eBv1mdcRrfHZpbr57zO5YpqN/m9LGeCXRakf/GswmDFes=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C21D25891;
	Wed,  5 Jun 2024 13:13:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 991F025890;
	Wed,  5 Jun 2024 13:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
In-Reply-To: <20240605104646.GA3972667@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 06:46:46 -0400")
References: <cover.1716983704.git.ps@pks.im>
	<51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
	<xmqqplt4y1gk.fsf@gitster.g> <ZlhjN7K8JKYz6Opd@tanuki>
	<xmqq34pzozsq.fsf@gitster.g> <ZlnJ83qSnGlQ0FWR@tanuki>
	<xmqq4jaehui6.fsf@gitster.g>
	<20240605104646.GA3972667@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 10:13:28 -0700
Message-ID: <xmqqplsvtirr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDDD937E-235E-11EF-9188-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, May 31, 2024 at 08:27:13AM -0700, Junio C Hamano wrote:
>
>> I wonder if we can do something to separate these two concerns
>> apart, using a trick similar to what we often use with an extra
>> variable "to_free".  Doing so would bloat the refspec_item, but
>> unlike the references themselves, there won't be thousands of them,
>> so it may not be an issue, perhaps?
>
> I had a similar thought while looking at this spot a while ago, so I dug
> this attempt out of my stash. It's quite ugly, as you need to keep the
> storage pointer and the const pointer in sync. Especially because
> there's a lot of clever pointer indirection via match_name_with_pattern().

Ah, true.  The patch itself does not look _too_ bad, but that may
simply be because the original is bad enough ;-)
