Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C983FD4
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489128; cv=none; b=D2+UAVtBgaVIAkS3BMHumIhoxBI/2JvLkdXXMibDzpQMNn7gaQyvd+N3HVelKo0dol8IpWLNUpyfrf9A4g3hu813M1hXLm3Gvsoyxm1y6JwNELICdQ+9reeMGSlQcJh/72cHsGbgTOit/nOsJ/9+Q0L8ZM+anE15z42uI2O4us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489128; c=relaxed/simple;
	bh=PaJl18sMcalSTmUW5YCxMTGJUneNvodaqCvLm6l4oE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G27WBbaws+0oJxGKKZ4St4ddlGudP8XLb2lam4Esaz/RZ4qruEjEkgtDmlzCqnzGT33EUCI3xFwnl2o3f3NzJdtltZAVDc3/kZLuDmEWuQ+BRdGuDn9mKvt01oUo3UoYuCdNhOTwrZKKSqvfF9MRaJOwaFN4Z7erAd1vU5NqyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZanWTDtQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZanWTDtQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 29AE530260;
	Tue, 26 Mar 2024 17:38:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PaJl18sMcalS
	TmUW5YCxMTGJUneNvodaqCvLm6l4oE4=; b=ZanWTDtQeQeYB0OExBSY86dhLtHz
	EB4b7VYuGfct7in/yyBGsp6Prb3cWUw2l+6vjGE6H5RLfrWTCypMpfhLI89PyMju
	RFOTStwDIU8iKUOA9tUnB6YjxPJ3nbl7Syp2pNjTlgoFLUklyBeailnPQeH41LSb
	ebe/cJFYhAVdcag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2157E3025F;
	Tue, 26 Mar 2024 17:38:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5C403025B;
	Tue, 26 Mar 2024 17:38:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Jeff
 King <peff@peff.net>,  Steven
 Jeuris <steven.jeuris@gmail.com>,  Steven Jeuris
 <steven.jeuris@3shape.com>
Subject: Re: [PATCH v2] userdiff: better method/property matching for C#
In-Reply-To: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
	(Steven Jeuris via GitGitGadget's message of "Wed, 06 Mar 2024
	20:21:33 +0000")
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
	<pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Date: Tue, 26 Mar 2024 14:38:41 -0700
Message-ID: <xmqqfrwc8yhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 377EE966-EBB9-11EE-B707-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Steven Jeuris <steven.jeuris@3shape.com>
>
> - Support multi-line methods by not requiring closing parenthesis.
> - Support multiple generics (comma was missing before).
> - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
> - Remove `instanceof` keyword, which isn't C#.
> - Also detect non-method keywords not positioned at the start of a line=
.
> - Added tests; none existed before.
>
> The overall strategy is to focus more on what isn't expected for
> method/property definitions, instead of what is, but is fully optional.
>
> Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
> ---
>     userdiff: better method/property matching for C#
>    =20
>     Change since v1: I removed "from" from the list of keywords to skip=
.
>     First, I considered adding "await", but I discovered both "await" a=
nd
>     "from" are "contextual keywords", which unlike the other keywords
>     currently listed, aren't reserved, and can thus cause false negativ=
es.
>     I.e., it is valid to have a method named "await" or "from". In edge
>     cases, this may lead to false positives, but a different exclusion =
rule
>     will need to be added to handle these.

It seems that this has seen no reviews.  I somehow find it doubtful
that =C3=86var or Peff would be writing too much C# to be familiar with
the language to judge the quality of the patch, but can somebody
with C# background (I hear that its most common use is for
developing Windows applications etc. there) chip in?

Thanks.
