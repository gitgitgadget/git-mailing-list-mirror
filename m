Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BA1D9D72
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396289; cv=none; b=D0f/DD4DPnseRqeEi4kUNnnb670367hpLxlwp4uTJ6GJBz9lRgSjfaqeDGWhZi9EH7sHVXA6zli4LZ210eqiodCUdLDebMS5F3t65orHOMGUWQ7EQfXCblBFzF5xcWrxsumxBkGYzo8l2TDQqvaJJMx0u6NFqDRP/B+6ZU8A0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396289; c=relaxed/simple;
	bh=lL6l8/CfwcndszWHXAJokr3UFHm6TwFyPoNP4DdfWXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lbnEzGRN0n7y1kV9pa13uOppnqDJZT7N74SUudWPpXBkKHPMPnSWZAcstorMkGzuTSVKGCAB84QpArhVnzDeWPTS7u712P3pTB+fHa/gLlCVEKUh/G1+mVfNC8jxlG2r2Cjo4LiwLqkNXkWcffx8XzMayNf0lHFP37VlLni2Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q67eWjzO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q67eWjzO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 996FB398BC;
	Tue,  3 Sep 2024 16:44:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lL6l8/CfwcndszWHXAJokr3UFHm6TwFyPoNP4D
	dfWXc=; b=q67eWjzONfOlG+voaMetfO0CkgiLAmF2YQCjswEYRKGxyBikeUIBAe
	nds233KfLKdvf8ewvj9m4Epny8XnFMwl8+Gc0yhtFFquOdlSJZKlR+900emfhF4M
	owutj68YpJqCUycXuImQ6Jgxlh5Z+pRWJ4BvZX5NSFeBv8voNKXyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F987398BB;
	Tue,  3 Sep 2024 16:44:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08F31398BA;
	Tue,  3 Sep 2024 16:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <ZtdoD/slbc+u7Aql@nand.local> (Taylor Blau's message of "Tue, 3
	Sep 2024 15:48:31 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<xmqq8qwaoh73.fsf@gitster.g> <ZtdoD/slbc+u7Aql@nand.local>
Date: Tue, 03 Sep 2024 13:44:44 -0700
Message-ID: <xmqq34mgii0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5AC6F850-6A35-11EF-8CF6-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Yeah. I would actually like to get here in the long-term, but of course
> that change is much larger than this one (the protocol would have to be
> adjusted to learn a new "tailsum" capability for callers to negotiate
> which checksumming hash function they want to use, etc.).

I dunno.  I was talking about strictly local tail sum, like the ones
in the index file.  You do not have anybody to negotiate about
anything.

We already agreed that the name of a packfile is a different matter.

