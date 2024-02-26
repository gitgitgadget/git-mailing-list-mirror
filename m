Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EED129A91
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977706; cv=none; b=WtbdvsqWV/+LNyHg1VoWmvG+1E0pNuWymBzQGGkDHvLrAj+BVh6C1tM9Zd7GcjcedkZ1fPmC9vArM5UE5bJIfETUwdzwqmKUgq4GCei1ibSxQbWFz0H7hDlrk6HvjJKzr3bEsR8R51+djlyerCzteSwwW0+WOeHFR8IdGWUA5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977706; c=relaxed/simple;
	bh=rBvrc9o2iZkPVibKLrPRDUle33IsGZr6O1n0MkGb8BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTZunXY0Mn5QaNultUkTvzVlr6kbrz80WtceMWhhP9CAW5VUfgdxkeh2A1fZVkVmi/FQEbXuMeI3eT245oGEumJekRnTI5aBGt5dJW0opImqAchZI9S9srVaRGBAzlf8NyhCvlsUchwbrbY9Qzv4nlYDPZrMWqX7zGupfz/uUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C3Op+GBy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C3Op+GBy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A67FA1C8250;
	Mon, 26 Feb 2024 15:01:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rBvrc9o2iZkPVibKLrPRDUle33IsGZr6O1n0Mk
	Gb8BU=; b=C3Op+GByFCYZ7VSOJyOlpF5tAEnpe6KPsKK+h0oChB9Z3Hg1F8Cwdx
	8UV1AAdDzaLupvV3233PuZPHA7a75CLW+YWrAIhFQcHwx6AnKRwtRb0DyYPgD21e
	sCO/h39kQo+eCIpujHp4YpxLIqGtSQmVP3X769UWhyj8378KAUiP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CCDF1C824E;
	Mon, 26 Feb 2024 15:01:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08F511C824D;
	Mon, 26 Feb 2024 15:01:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 03/11] Start reporting missing commits in
 `repo_in_merge_bases_many()`
In-Reply-To: <c27015da-0867-f417-4cd6-f4eaad3b66a9@gmx.de> (Johannes
	Schindelin's message of "Mon, 26 Feb 2024 10:34:44 +0100 (CET)")
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>
	<xmqqle7asnu9.fsf@gitster.g>
	<c27015da-0867-f417-4cd6-f4eaad3b66a9@gmx.de>
Date: Mon, 26 Feb 2024 12:01:41 -0800
Message-ID: <xmqqsf1fkna2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCB36C70-D4E1-11EE-B487-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have an idea. How about pulling out this hunk into its own patch? And
> insert it between 2/11 and 3/11? That would probably make most sense, as
> it would make the patch series still (relatively) easy to review, and it
> would not conflate the purpose of this hunk with the rest of 3/11's hunks.
>
> What do you think?

It does not solve the primary issue that [2/11] feels incomplete and
makes readers wonder what the new parameter that is unused is about.
So unless you are squashing that small bit into [2/11], I do not think
such a churn is worth that much.
