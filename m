Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D711A2562
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568851; cv=none; b=X+l1dwcRRgwe6aE4JZwHAS7t/CCsNmMiUBxVAh1PpSauILzls6MwozNx3m6AduFljRnFcuuu3TmhtuW9+p/ECKSN5foIj+zDxigNHxWjOA38+Ej+wEz66IRV2qspKkbNo0x4QOFndiBTtvLDNms/bu6oR98K0RtSlc1l4DWRETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568851; c=relaxed/simple;
	bh=/q0z5x/tstCAm4YhPpfeEVleuAGO6DCeV3Svo2kTLGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PejeRTwTdebpI/vN30WwekqrWvHzAi3WdOls5NaGAaSg1LEGpFKN8Pvz53kZnBoRoyuO+sTuSZE/Ht3qlV8yFIixfncAiG2xqKgZc6woddKs4SzaucUXvwM7NtzsQBsBmWkXFmdC9JK/ftexfp1gR16diIOP9Sqg3aGSimhPwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s3FCvQvP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s3FCvQvP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1588281F9;
	Tue, 13 Aug 2024 13:07:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/q0z5x/tstCAm4YhPpfeEVleuAGO6DCeV3Svo2
	kTLGY=; b=s3FCvQvPpFYiKoC/j2c4L3kPk/HmoLIrL37S86mFUo+wBlsOCJqdEK
	4+aVlspygI8aAgs3hhhAd3qHGgGryZnG0d2O2o5gexSRxGrbKVnG/SeTPDDi0N3P
	6dZBrJ0ewlKVqyTzn+BYBFDRZTWJArQMPc/5BGqGEwcZPV7bZ4nJs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98693281F8;
	Tue, 13 Aug 2024 13:07:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A593281F7;
	Tue, 13 Aug 2024 13:07:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/20] Stop using `the_repository` in "config.c"
In-Reply-To: <cover.1723540226.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 13 Aug 2024 11:13:17 +0200")
References: <cover.1723013714.git.ps@pks.im> <cover.1723540226.git.ps@pks.im>
Date: Tue, 13 Aug 2024 10:07:26 -0700
Message-ID: <xmqqwmkk5p2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84D953D6-5996-11EF-A19E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that drops the dependency
> on `the_repository` in both "path.c" and "config.c".
>
> Changes compared to v1:
>
>   - Various typo fixes in commit messages.
>
>   - Rename `strbuf_git_common_pathv()` to `repo_common_pathv()`.
>
>   - Reorder arguments of `strbuf_edit_interactively()` such that the
>     `struct repository` gets passed as first argument.
>
>   - Document behaviour of `worktree_git_path()` when no worktree is
>     given.
>
>   - Wrap some overly long lines.
>
> Thanks!

Nicely done.  I found that both of the two larger changes relative
to the previous iteration are sensible.

