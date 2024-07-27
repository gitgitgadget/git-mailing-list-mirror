Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493A15BB
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722044454; cv=none; b=M3sHL6qc8f+6O41TuNT9jwxWiTQyZVseqZwmpmm0de1B/0w2dBjLRmpjkmTnzRnPK45wk/u3qxVlxahOpAemvr+9+UKd6o9ZKUmCfLdPIyZO4QLh4hm0ApfrrzXkAel8mgTdTQsF7WEdFpc5CH5ao5fZNrc12cAErcivhNvm7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722044454; c=relaxed/simple;
	bh=+JBmCsAlSuDGvCD/TANJamUy4fbYexlx6NhMJX0hqXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtQ0VRb/sR6WJe+yThGZwoB3EGT49mPeBr5jIdmkyHFOrqKc9Ji5hwxC6t9P8nK/UQN6T9Qx1b14dZzHXH+IhsO0TTpP29qqT457RfyyBrVuNjOr2cEulDFJlpYa9l0kUDrBppyLU14RZufaY7QTix4J+y6Q1wV42G1f/8MB6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VI4XW1Op; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VI4XW1Op"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2AFC26B37;
	Fri, 26 Jul 2024 21:40:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+JBmCsAlSuDGvCD/TANJamUy4fbYexlx6NhMJX
	0hqXE=; b=VI4XW1OpTo12yroBbDHKa5CZCmegaoT2Ui9Q7BvK5AoZ80Aj9TdbFh
	+lEkV5UYPBRB3nbx+Gq2fpIrkZQoDCrsONvpgendPLqLvsekdyhXH+MhqXS34pil
	36ohP0jdZUSMahXuCjU+c31iCgnUs4FRB6OpD+SxV2e7NbuhEyGdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7A1626B36;
	Fri, 26 Jul 2024 21:40:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3632926B35;
	Fri, 26 Jul 2024 21:40:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] add-patch: render hunks through the pager
In-Reply-To: <xmqq8qxouhjv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	26 Jul 2024 11:36:20 -0700")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
	<2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
	<5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
	<a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
	<97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
	<xmqqcyn1lcjo.fsf@gitster.g>
	<24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
	<38e190de-cbe4-4f75-acdb-fe566e541179@gmail.com>
	<xmqq8qxouhjv.fsf@gitster.g>
Date: Fri, 26 Jul 2024 18:40:49 -0700
Message-ID: <xmqq1q3ftxwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 418A2D52-4BB9-11EF-93AA-BAC1940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> In any case, that is an appropriate thing to say in a commit that
> fixes use of such a construct, but not a commit that uses the right
> constuct from the get-go.
>
> I have to say that the [4/4] in the previous round, i.e., fc87b2f7
> (add-patch: render hunks through the pager, 2024-07-25) in my tree,
> is better than this version.

I do recall that you once had a version where the code violates the
guidelines (and breaks dash) in one patch, and gets fixed in another
patch in the same series.  The above material would be a perfect fit
in the proposed log message of the latter step.  If we spent so much
effort and digging to figure out exactly how it breaks with which
shell, a separate patch to fix, primarily to document the fix, would
have made sense.

But the latest squashes the two and avoids making the mistake in the
first place, eliminating the need for a documented fix.  We generally
prefer to do so to avoid breaking bisection (and the recommendation
to keep the fix separate so that we can document it better was made
as an exception), so squashing them into one is fine.  But if we
commit to that approach to pretend that there was no silly mistake,
we should be consistent in pretending that is the case.

