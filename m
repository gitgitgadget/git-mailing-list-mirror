Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB07E9
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727143112; cv=none; b=fYP/BB1zNLBLj/ckDwuWH1TsCVxPF5jQAAbRqv2ef20WeFiWdzn4lWBzuTqZEzPstUPQhdYpnaV+sCL9qOCn2HbAvR3aubuQL+m9j2dlUvNEVebnDkRWpi6rO9MgHkH3hiU2kFPPE5YPNMR/VpQBP6KGhIoXmOwN5cAOIxTH58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727143112; c=relaxed/simple;
	bh=pOLbmjB8U7fVDkEuvYtRrY8q2n+c+jtUbzvZ5z4UrfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ljFpN8J1dxoexDKPBKQSyPoMBaNSTZkENjZEL8NXmNirSmxwZXlJISGZPGLci8bbxBgezzvdaJcxCsHJEauRG0DQ6M5dSMyH5mu/58JgeHz3/G0ZRbxKY0ycn7EEmu0S8v0qkQ0xrJAYoeVorqienYxsQado6noViDvpXlvEpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJ6mdBIJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJ6mdBIJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE42929FB9;
	Mon, 23 Sep 2024 21:58:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pOLbmjB8U7fVDkEuvYtRrY8q2n+c+jtUbzvZ5z
	4UrfA=; b=CJ6mdBIJs+ORPcDlqa81y2ky0BlwNFEIiyvOPW3bM38peisKvDzjwC
	ZlXO0n7KZTbmCN9CNLGDu0K6k9sVKXGfbCiqQBFhGBukIppkAdQt67nidZKlsq9u
	Lh3ml4OX4/Nx1KUPNYiPivtHlGSlYBJmNx7FQimP3fy9J2VYdNwmw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5B4F29FB8;
	Mon, 23 Sep 2024 21:58:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09A2729FB7;
	Mon, 23 Sep 2024 21:58:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] cmake: generalize the handling of the `UNIT_TEST_OBJS`
 list
In-Reply-To: <pull.1797.git.1726687769585.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 18 Sep 2024 19:29:29
	+0000")
References: <pull.1797.git.1726687769585.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 18:58:27 -0700
Message-ID: <xmqqsetpx16k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E6B804E-7A18-11EF-8627-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> With a4f50bb1e9b (t/unit-tests: introduce reftable library, 2024-09-16),
> however, the `UNIT_TEST_OBJS` list became a trio, and the CMake
> definition has to be adjusted again. Now that we can use the
> `parse_makefile_for_sources()` function without many complications,
> let's do that.

Am I correct to understand that it is not "trio"-ness (has three
things) that makes the approach feasible, but the fact that all
three things are concrete values?

The longer-term aspiration is to migrate everything to clar-based
unit tests, so the list will hopefully keep getting shorter and then
become empty (https://lore.kernel.org/git/Zt_lLsnylKJ9uoqj@pks.im/).

Will queue.  Thanks.

