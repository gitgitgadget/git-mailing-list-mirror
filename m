Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F814375A
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282326; cv=none; b=USlh/uFSx/P6MsOoctaXF/Tv4ghjwvMVvt253r4nkesuzJ2Yg9WoMdfWRDqMD+r/kVWzPjg4WI5rJaEFIWX7HXO/ftx+3KzJ7VjbGfUB0+3NtIyQd2rcPo55KqyaHg72sQM9/atjtS/Fl+vVuKr6bEOrtVueeO3xTyjhm/kAfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282326; c=relaxed/simple;
	bh=ivGjjTSYRjgAPXRm7vdzb6Sb9Llk7LDI8SB6+e2zEHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDJXzmQYq0mncAUzFmg1NXy9lwbkQ/mL74u0O9PTfHphLVWgRpx2DS7NYQshZ9gxS8sIXsC04yNUMeGpk4ZEWpmUyApyktSIVMymbRNyT0O0vB9qTbtKFm54xzzLzwsfXraz5EhoeBTyBfjrlINXl/QOv00gtWrbf0wH6x7zy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iTOb1cWz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTOb1cWz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D6461D3734;
	Tue, 12 Mar 2024 18:25:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ivGjjTSYRjgAPXRm7vdzb6Sb9Llk7LDI8SB6+e
	2zEHs=; b=iTOb1cWz1Ha9tpzaFeo7l5Vs+HRRQa4xMBejOtEkm7BN76HOf27Bpx
	ugd54E6p5gQL1cXa+JlVE56O/r4i5NMjVNMYiAeyO5ifQbeLnuCLYWDfcH+X7hlM
	mOng24eSZIE1m8Aytn6x7dWeVlxwyM8eDvgYrIhdVA1T+xSy3fdNU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25F921D3733;
	Tue, 12 Mar 2024 18:25:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 842501D3731;
	Tue, 12 Mar 2024 18:25:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>,  <newren@gmail.com>,  <me@ttaylorr.com>,
  <phillip.wood123@gmail.com>,  "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn
 branch
In-Reply-To: <17bbe214bab8dc40.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Tue, 12 Mar 2024 02:04:22 +0000")
References: <17bbe214bab8dc40.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Tue, 12 Mar 2024 15:25:16 -0700
Message-ID: <xmqqil1rjdf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 678A8516-E0BF-11EE-AEA1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> If I'm understanding you correctly, it sounds like you're hinting at
> something like this:

You may also want to add _READING (I do not know offhand).  Also
you'd want to make sure resolve_ref_unsafe() returned a plausible
looking refname (i.e. passes starts_with("refs/heads/").

But other than that, yeah, doing these as "extra checks" only after
we see the primary resolve_ref("HEAD") fails was what I had in mind.

Thanks.
