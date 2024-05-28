Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FC171E44
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915049; cv=none; b=jtW37StQW8aaCCzxwzrCH03pHndLoJnJiy+kMgtL9QjpvC7EW8zl7tmbmmGou2wZFWo0Iw4x6BFwRNgY82rRmnnobdbn+8JhWvau+EvLvJc9lK/uw02DEVjIeJTWVdOl58nNpuDaP1iKNOT9KB9jxWfpX3pUOeEEzkkdx6xYEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915049; c=relaxed/simple;
	bh=8jW4j5Wv1S9GqVtpqRM4layHtzdFnAgqm861WA24dQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qePDGJ946G/Li4Ap3hRaC4kOFlhR+q+PNBArcHdYgi6T7fZw0CQLAHK3o0kWuFKnwuLoYNlnoQncVEJeJmo7uMtEy+9s1X6tkTnoMAqx+FXdeWNd/Jhq8BBYCse7obu+38fN5HKXc7twtzKi1AnKKL2eb2g0lXGI+3DXtOgs2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=avP4Tjhy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="avP4Tjhy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B792291EC;
	Tue, 28 May 2024 12:50:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8jW4j5Wv1S9GqVtpqRM4layHtzdFnAgqm861WA
	24dQM=; b=avP4Tjhyb6A/3XSoLrQ9FgUP9LdtYnIhdTtxYJRPrnUlKsv/LBUolB
	ff3QjWf9Jfs+abnr50qT9QTRme4/i29Ly+1TSPiSD/K+a+ICsGfOZCV5L/znyaFs
	NalZmVfW3iKwMaK6OYymF2rZ8IyjGzcuLcHn/i/KepEtmC8mZpymM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 55FFA291EB;
	Tue, 28 May 2024 12:50:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7232F291EA;
	Tue, 28 May 2024 12:50:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <ZlXbxzFOJ8gVv7r5@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 15:27:35 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
	<xmqqo78ukhmk.fsf@gitster.g> <ZlQX0FmIsz2eFgsC@tanuki>
	<xmqqsey39mmt.fsf@gitster.g> <ZlXbxzFOJ8gVv7r5@tanuki>
Date: Tue, 28 May 2024 09:50:43 -0700
Message-ID: <xmqqv82x6fto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CDCEC04-1D12-11EF-8E7C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, that's definitely better. Whether it's preferable over having it
> after the signature separator I don't know. I personally liked that
> version better, but can totally see why others may not like it.

I do not think anybody posted a version that writes inter/range diff
ater the signature mark.

> Hm. By now I've gotten a bit indifferent, to be honest. I'm not a 100%
> sure whether it's an improvement or not, but I don't have a strong
> opinion either way.

I am not sure what two you are comparing.  The current version with
inter/range diff that is before the diffstat and the proposed one
that places inter/range diff after the main patch?  Between them, I
do have a strong preference.

Or placing the inter/range diff after the main patch, before or
after the signature mark?  As a reader of such a patch, I do not
have strong preference myself, either, but the signature mark is a
convention, established and honored for more than a few decades, to
say "no interesting contents come after this line".  I do not think
of a strong reason to go against that convention.

We certainly could use the "---" after the main patch before we add
the inter/range diff.  I had such a version but its output looked
rather ugly.  Because the inter/range diff output are designed to be
very distinct from the usual patch, I'd say something as innocuous
as an extra blank line would be a good choice.

Thanks.

