Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B976915
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXMm45hW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ABC7195A2;
	Thu, 21 Dec 2023 15:40:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z/Ff8MM2lO+mqVEjJlEMMalLLMxbpbquv3s4yy
	1TSHs=; b=YXMm45hWKi9RMh+KLR1dLzfvm8SqRRwXK2aEtItAaUaaewDdeS/YJe
	iVByI0++/fS5KtWpqdgH7cAzAjm/ncvugzCK+InIKJ177wtbqai961nRp7GBOrJ7
	KhjXZ/E+1Q0nc9ucYcj0go91aOFR+RyIb6ajz5flumsPCElLQUUZk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EB95195A1;
	Thu, 21 Dec 2023 15:40:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBDDC1959D;
	Thu, 21 Dec 2023 15:40:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <20231221170715.110565-3-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 21 Dec 2023 18:07:15 +0100")
References: <20231221170715.110565-1-karthik.188@gmail.com>
	<20231221170715.110565-3-karthik.188@gmail.com>
Date: Thu, 21 Dec 2023 12:40:03 -0800
Message-ID: <xmqqzfy3l270.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EF60ED8-A041-11EE-BD32-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> With the upcoming introduction of the reftable backend, it becomes ever
> so important to provide the necessary tooling for printing all refs
> associated with a repository.

We have pseudoref (those all caps files outside the refs/ hierarchy)
as an official term defined in the glossary, and Patrick's reftable
work based on Han-Wen's work revealed the need to treat FETCH_HEAD
and MERGE_HEAD as "even more pecurilar than pseudorefs" that need
different term (tentatively called "special refs").  Please avoid
coming up with yet another random name "operational" without
discussing.

With a quick look at the table in this patch, "pseudorefs" appears
to be the closest word that people are already familiar with, I
think.  A lot more reasonable thing to do may be to scan the
$GIT_DIR for files whose name satisfy refs.c:is_pseudoref_syntax()
and list them, instead of having a hardcoded list of these special
refs.  In addition, when reftable and other backends that can
natively store things outside refs/ hierarchy is in use, they ought
to know what they have so enumerating these would not be an issue
for them without having such a hardcoded table of names.


