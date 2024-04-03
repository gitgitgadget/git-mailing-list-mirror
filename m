Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18353A7
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171557; cv=none; b=rzU1CyQ7J+4eZtzH7NmjhEJ/UOaZ55eGljeoj+480HvEa0hd3FUHhXLuQsMK8EJEitP2FJyhZv5unJpE5DgJMEuZs3P1ZBkZMIEn//MR8CT8cWA3Nw3uyQPFaf+sbzC3aBQci7KG+QO2vZ9SeqADcey4knUK8hcRqCWGrb1zjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171557; c=relaxed/simple;
	bh=E3dSVQqFl5gFN5q4rM40Va7GMpw0sEfPIGoy4lI9yiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keLNBQSnSti0a+UMdTNzZlzB6DGRfEP/qnBMSPvX+aFb/WkCcOtqoYiUQr3zIcqj4eeQRujv0HZGnW3UbdxvGPd6wJEhyaM6iJHAYyzxURTYrRUWT9GI6g9y30a/aCgtKtdjhzP2LBGGVV1CSzSS+8nqDQJrN244kGu1rJOy7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dDAcgI+X; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDAcgI+X"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E3F11DC695;
	Wed,  3 Apr 2024 15:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E3dSVQqFl5gFN5q4rM40Va7GMpw0sEfPIGoy4l
	I9yiA=; b=dDAcgI+XStTvmFQe7hFDOh+LXdXBvigedZeSfOSeLJpmp9rhapgSmN
	ViSn48Dfm0/vrruwkmL4d1RO/S4UzABm/NvDRXXSWs7o+rinC1OxX5JYBai8Teel
	E94qmxl3xxJGXczzWCQ3Kn2DzA73IyXq3kHAAM++g1Ipg7XnLpcss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 162F31DC694;
	Wed,  3 Apr 2024 15:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AB221DC693;
	Wed,  3 Apr 2024 15:12:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com> (Justin
	Tobler via GitGitGadget's message of "Thu, 21 Mar 2024 22:40:16
	+0000")
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
	<pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
Date: Wed, 03 Apr 2024 12:12:32 -0700
Message-ID: <xmqq5xwy6z1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FED2728-F1EE-11EE-947A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the second version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compared
> to v1:
>
>  * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to disable
>    reftable compaction when testing.
>  * Refactored worktree tests in t0610-reftable-basics.sh to properly assert
>    git-pack-refs(1) works as expected.
>  * Added test to validate that alternating table sizes are compacted.
>  * Added benchmark to compare compaction strategies.
>  * Moved change that made compaction segment end inclusive to its own
>    commit.
>  * Added additional explanation in commits and comments and fixed typos.

Has anybody took a look at recent failures with this series present
in 'seen' [*1*] and without [*2*] in osx-reftable jobs for t0610?



*1* https://github.com/git/git/actions/runs/8543205866/job/23406512990
*2* https://github.com/git/git/actions/runs/8543840764/job/23408543876
