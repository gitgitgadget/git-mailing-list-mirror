Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA12E4A
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903955; cv=none; b=KItqfQthbjG3MA+11Yc1DmWCfMNy4fKELHWSTvU2+OmKtOBmnXE/uZw5nKCvP710h8TshytvPFOPY0/ws0qsXJKklZhi+b6KVt2OgkuHCkRZeJS3o4Ylk7+5BC8Yg2TfuWCvjMd9jROlsPzgtcMs0SfHy9IWQ+5KSS6zHxbeM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903955; c=relaxed/simple;
	bh=bWdwA9DYzcmQPH5X+y+vKw+VRy4k9qhJtcoVaBBWaCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1KlkU/s9oO6NBIbNI43L8N95N6oHfnxDOed/pqrpTa99KZAq8x10TFnUYwgXzf+EeuxS+FruK3LWvrF1oPBlzBc2PiCN91k88+wYxuASofLrTfrrfEagTyJHGRbFy2Qe1z7PIH4+RGIbK5GmcdAN9Z/1DY1u9bYqsC2oe2UZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G4/Ew7QS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G4/Ew7QS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CBC328F2D;
	Mon,  9 Sep 2024 13:45:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bWdwA9DYzcmQPH5X+y+vKw+VRy4k9qhJtcoVaB
	BWaCI=; b=G4/Ew7QSYGSVgo2z1oIwzYY+fumhzHCAnSOlVVnpAO/gF/NrD3ktoR
	CVdVQ0MYQXaUjMgfiBzJCRuqrgXwQ8X45RdLt0xjq00htjWB7ovG17WQlvX3/bnd
	abk0nh4330BS0hzNsEiMsjmrb5KoEMkJwZJx6Pt0eyTdp3fDiP1Zc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20D6E28F2C;
	Mon,  9 Sep 2024 13:45:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88AC328F2B;
	Mon,  9 Sep 2024 13:45:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/4] pack-objects: add --full-name-hash option
In-Reply-To: <ff30f774ca82662bb25291804559bf3f2de061c2.1725890211.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 09 Sep 2024
	13:56:47 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<ff30f774ca82662bb25291804559bf3f2de061c2.1725890211.git.gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 10:45:51 -0700
Message-ID: <xmqqed5ssots.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B9A89F2-6ED3-11EF-A7F2-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is not meant to be cryptographic at all, but uniformly distributed
> across the possible hash values. This creates a hash that appears
> pseudorandom. There is no ability to consider similar file types as
> being close to each other.

Another consideration we had when designing the current mechanism,
which is more important than "compare .c files with each other", is
to handle the case where a file is moved across directory boundary
without changing its name.  These "hash collissions" are meant to be
a part of obtaining _good_ paring of blobs that ought to be similar
to each other.  In other words, we wanted them to collide so that we
do not have to be negatively affected by moves.

I am not saying that we should not update the pack name hash; I am
just saying that "consider similar file types" as if that is the
most important aspect of the current hash, is misleading.

Thanks.



