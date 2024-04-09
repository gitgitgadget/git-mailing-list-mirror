Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A85025E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627757; cv=none; b=lZGGkilKtcxinTm8Ro5b8ErbMA/YNgzkoXtruuSqcmOoK5jcitNvGLu1y8ua6jJwziaxn4ajla/P4c4tClkhakgJQPvFNB/MfG9V+HSuVIUR42a1FLBvKQPvTeU5m2AIIabfIVxKH3TZMNo0VAnivq2WL+3lGYc0tGJYKGByTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627757; c=relaxed/simple;
	bh=15BKur46W+VeDnpr6Fgm3V3TUFpANn0EOnlJl1+bXbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VM2qyGzaHoFTVgheibP+T5ddB6msMWXPnr2g6zP3muG4dwLM1ny72Id9rfDzRMNoE3I1v3Jb7K5BhosQA7eHiSZmvqTaTfyCwYvVecJwilHpH3awtfxOAVQmCZzUchCfc8V2c7FBGcE2jpxjzI5dnWNvHLxEIawDj7S888neemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JSwKfEaB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSwKfEaB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 037501DE2A9;
	Mon,  8 Apr 2024 21:55:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=15BKur46W+VeDnpr6Fgm3V3TUFpANn0EOnlJl1
	+bXbM=; b=JSwKfEaB2JfbyFJLqDnYID58wPcIvmGVzB4ClVAOKNomCi+hq7rLEX
	vXGO2lEekr8jDNX2lAUYaHLweu9Vbf3ujNvW3OrLw1Si/0xXogG0IbJ3076bWTHR
	7Bcg8suaHHP7SMLsMA2EDW6Dygg0+GOHb8LX2GwzzyepiFvHr+XvE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFE7A1DE2A8;
	Mon,  8 Apr 2024 21:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 626CA1DE2A7;
	Mon,  8 Apr 2024 21:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in
 filename
In-Reply-To: <20240409000546.3628898-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 8 Apr 2024 17:05:46 -0700")
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
Date: Mon, 08 Apr 2024 18:55:53 -0700
Message-ID: <xmqqpluz2tau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4CD9E5A8-F614-11EE-B482-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> I originally wanted to avoid the need for an option, but git-am
> currently depends on the strict sequence number filenames.  It is
> unclear how difficult it would be to refactor git-am to work with
> names that include the extra subject data.

I am not sure if I follow.  Do you mean

	$ git am ./dir/0*.txt

in a directory where I already have these files

	$ ls dir/0*.txt
	dir/0001-Documentation-CodingGuidelines.txt
	dir/0002-quote-assigned-value.txt
	dir/0003-t-local-var.txt

that have one patch per message does not work?

