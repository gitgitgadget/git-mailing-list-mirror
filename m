Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66051168CC
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782635; cv=none; b=g+bJ4p060xzbhI9+gp7rfRNiw9Imt/bXCDyyw/K5Nd8o7ePJiRq2pmIMr7sDQUdA1I1RTfOUjSBFRcaDp3mUD3Pfxc+nTltZusdDxYj1x1UmQ/8TCm/C0dUxylO5vYTCVSfAb8/ZrDFSchi/gCMLxLbe5buQqIPrf3CPkoy3nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782635; c=relaxed/simple;
	bh=7jUQr3KHKM6Gcs+YtBZVWsmG+QNI3Zc1Am/SMfNZwqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SU/GzVgcONPaNs78xUbtcBd8vWmHZi6PXOeyUwS9tLGuh6QLInIoXOevugozKq5AN5rf17wm6IjLHJokQ+GMaSTAq16RUZ6z74okQ1LGbxoaFtzsBJd+DpOEAojPdrz9pHVJYoz9Ix7PmtxYjImzUiv1z/fXz81AaqNIPWzS3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HtrLb/ew; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtrLb/ew"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32E751E1A04;
	Wed, 10 Apr 2024 16:57:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7jUQr3KHKM6Gcs+YtBZVWsmG+QNI3Zc1Am/SMf
	NZwqY=; b=HtrLb/ewd9k9E+vH1kOm9HMQVdxGEh+zND7YBKihsp5KSGGLU1wy++
	dQESJ6qJpy7U5LzX5pPMtE1MCkkVTdOH4cfgKPq6G+EDuUS38Z5AuP/0DYM8u/5o
	wogSs+qM69bvhRP3xHMC10fNS2x3ivUJUsaHfzzPQ50GlBaEZoinU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ADCE1E1A02;
	Wed, 10 Apr 2024 16:57:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FC951E1A01;
	Wed, 10 Apr 2024 16:57:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
In-Reply-To: <Zhb7YwMdtNKzpCSw@google.com> (Josh Steadmon's message of "Wed,
	10 Apr 2024 13:49:39 -0700")
References: <cover.1709673020.git.steadmon@google.com>
	<eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
	<xmqqplw8z73y.fsf@gitster.g> <ZhW6BM9V-Rto_CW4@google.com>
	<Zhb7YwMdtNKzpCSw@google.com>
Date: Wed, 10 Apr 2024 13:57:11 -0700
Message-ID: <xmqqh6g9rl5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E771BAE6-F77C-11EE-BCE0-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> It turns out we do need FUZZ_OBJS in OBJECTS so that we define a build
> rule, otherwise the Makefile doesn't know how to compile the fuzzer
> objects. So V2 will have most of the fuzzer rules in the line
> (1434,2698) range.

The reasoning and the conclusion sound sensible.
Thanks.
