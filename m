Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91C83CD8
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549257; cv=none; b=MNKhtB4Ep9XwJB+YYFljY/l45r3jUR1dtpfGLoCKqiLu0N+SGaJBqaiBYVfdtXq7Sv/56KQ5t7TLvbcqHW1v8u8v5DKaT5xw2OpOayQaCnCs/trwwrINjhhq5/vd6LxW9vioKZUpBggKEEAbV/NDKIc/WFkXJc/q9PGawca/4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549257; c=relaxed/simple;
	bh=ezFGI3okLNbTdD13v0J4hGA2bQ/M7V/klL62bArbnvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6im/NqxNy6gZmOqRdBup37JNrjEb43mY+cSyppnw6nTbpCJ6WYqCAherCdgoLK7cTHB6irrzDpJ7FwISnDrimPUHOhVS45LekBldJguogewkTujaPA/nXjrTSllTXhUtspHLRXh5zjizhCGCtroDjHKGI7hoeang+PCoSbQlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QQwUDXIw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQwUDXIw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E4A1537E4D;
	Wed, 21 Feb 2024 16:00:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ezFGI3okLNbTdD13v0J4hGA2bQ/M7V/klL62bA
	rbnvw=; b=QQwUDXIw/hof6kW+kC/CdLnknXfGBgZL9rTzExsGTEqPzXgBnGIhNd
	4sV/0j415jeYzomJjGYz+6UZrlim9pJlfUoM8eowwl2uA49+JdPNtxHQYRCoiltb
	Tc2nd1848lsQZ1CmeAt63dgTNRVOfo/Bv+6T5vhI9PcvOmFD0y5ZE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD6B837E4C;
	Wed, 21 Feb 2024 16:00:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82F0237E4B;
	Wed, 21 Feb 2024 16:00:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: =?utf-8?Q?M=C3=A1rio_Guimar=C3=A3es?= <mario.luis.guimaraes@gmail.com>,
  git@vger.kernel.org
Subject: Re: Bug: impure renames may be reported as pure renames
In-Reply-To: <xmqqttm1pwsv.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Feb 2024 09:11:12 -0800")
References: <CAF7CYk6dERu7Lb0iKeq7zwtZVVd_bG2FMZReSDeejcu1JGiaFw@mail.gmail.com>
	<CABPp-BG2m3_fyxFL6Hw4o5HhoKVd7_tYchDxCdTaXxdxZke-9g@mail.gmail.com>
	<xmqqttm1pwsv.fsf@gitster.g>
Date: Wed, 21 Feb 2024 13:00:48 -0800
Message-ID: <xmqqzfvtmt1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B1BE7F8-D0FC-11EE-88FC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Alternatively, we could cap p->score to (MAX_SCORE-1) when
> similarity is _computed_ for filepair between non-identical blobs.
> That should happen in diffcore-rename.c:estimate_similarity().
> It would allow us to still _show_ "1 line changed among 1000 lines"
> case as R100 and still reject inexact renames via "-M100" from the
> command line, I think, as the "exact renames only" short-cut works
> with the finer-grained "score" values and not the coarser "percent"
> values, which might give us a better approach.

... the above may be "better" under a specific assumption: in the
future, we would correct the rounding of scaling from 0..MAX_SCORE
(or 0..MAX_SCORE-1) to 0..100 from the current "always round down"
to "below 0.5 is rounded down, 0.5 and above is rounded up".  If
that happens, we would still honor the "Give -M100 to limit the
rename detection to exact ones", and will exclude a change that
modifies a single line in 1000, but if you say -M99, we would show
such a change and it would be labelled as R100 as correctly rounded.

