Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FA1369AE
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035559; cv=none; b=GUG/+tCuC+mk3BjMecE2XGNbvoyeLZ+wTGKAY61RhN7JDL4ec4yKRffJE8S7gSczMn+TzCqL0+bsbjokDRXJYChF5MXYzAlbLJDHzn1JzAfP87VmlPybLl2CcVr+R9pMP34zL5Wtam4jUS4Ea6fzYWIzz5GfHBmrJ2PqAVGP+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035559; c=relaxed/simple;
	bh=12p8YmRf11b+RW3eCgjFFEhOwvz17xe1lJa0KqSowc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUDNR8JCk+33fjFO473f3vr2piALITqqvJ28YQkKzFYocuyaM2FSjy4Zj2cOtn1roW5LT4u4XC+lHyRDvsPZPEPt8HrbdHrmkmd/OgV7/EJTthqrb7QcQMTwdzPgavBcZI4WiAe7E4auRa3JOZbctaN7LMp6ZgmtIEx6b4iqfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YUWYPlwq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUWYPlwq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F8592F937;
	Fri, 30 Aug 2024 12:32:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=12p8YmRf11b+RW3eCgjFFEhOwvz17xe1lJa0Kq
	Sowc0=; b=YUWYPlwqD849T6ZcHQRHeVL/Ov7U6lc1OYxiOt1hZKGbXxA5v7N+qT
	giGz+ULchVbItVdoa+F5/uRINbgTrow3dR3EbwbH1rd833kuJHvdpJBu+5LifElt
	EydgCnhzX6MptT3GT32ZZjRdzBgoAlMIqa+ztehj9oE82y+1ULLO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04B442F936;
	Fri, 30 Aug 2024 12:32:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E18D2F935;
	Fri, 30 Aug 2024 12:32:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 00/21] environment: guard reliance on `the_repository`
In-Reply-To: <ZtFtpjaGFhORNEP4@tanuki> (Patrick Steinhardt's message of "Fri,
	30 Aug 2024 08:58:46 +0200")
References: <cover.1724923648.git.ps@pks.im> <xmqqle0fuml4.fsf@gitster.g>
	<ZtFtpjaGFhORNEP4@tanuki>
Date: Fri, 30 Aug 2024 09:32:35 -0700
Message-ID: <xmqqr0a6rmxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 772F9DB2-66ED-11EF-A08B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 29, 2024 at 12:59:35PM -0700, Junio C Hamano wrote:
>> There may be more, but I know at least of these at the moment from
>> https://github.com/git/git/actions/runs/10619536685/job/29437358521
>> 
>> Perhaps this can become [0.5/21] of the series, before globals are
>> hidden behind the macro.
>
> Thanks, I'll add these. I really need to spend some time to finally get
> Win32 builds set up in GitLab CI.

Windows builds we can get from GitHub Actions already.  It would be
nice if somebody had Cygwin, which might have avoided a need for
<d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>

Thanks.
