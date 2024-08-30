Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9D199FB7
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034481; cv=none; b=HGZP/rlPBE48PMCFOcN/DZmv30KT4WM2w00nHMcjWLLqQIRMzUzW+nZ++8HRfphmrSewK7dnmXk64gKw7748Al0KZlespuE17vWkJ53wKCnPmrPZkT9nUdyJ048hmBDO1lkDoQEkp/gQc8X5OPUFJQA141lHceTyV4n6WINgLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034481; c=relaxed/simple;
	bh=7nCSUqHxNl5s2QG5j4HyrZ3JIIcVTT+hx6RkO+Dh4Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpZR4xvucw1umEHfQNCXpFBUDB8gyjTR7VaM5CpT+g9+NQQ1I8gPQ5VNFycgWt4BDRz8DlXUOdjH8cg6gcpzK9SdFN7LN2feBG7xsbGz+yuQ8ba2LU3jbUWgQd8+S3BYdRnqcpkDjx8OZsltXybpLoQJJ+NBx7oBziG6zJqA83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TY0h+R5f; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TY0h+R5f"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81F882F709;
	Fri, 30 Aug 2024 12:14:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7nCSUqHxNl5s2QG5j4HyrZ3JIIcVTT+hx6RkO+
	Dh4Cg=; b=TY0h+R5fG330Y9AAvF2FzHwFJJVgxbcLsY2P+xf4zgdAKN4qLhAvL0
	r/FDu4z/m3xix4OH8KwLcTmJWL14IoUUI5DHISGX1xX6g6sFghZdpicpxvmJOVVZ
	Ck0UmVQxFcEkCuV1RU4HHoEryph+x62+3v5MzFjEF0Ni8JK+zVJHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79DE72F708;
	Fri, 30 Aug 2024 12:14:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC60B2F707;
	Fri, 30 Aug 2024 12:14:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pavel Rappo <pavel.rappo@gmail.com>,  Elijah Newren <newren@gmail.com>,
  Git mailing list <git@vger.kernel.org>
Subject: Re: How to turn off rename detection for cherry-pick?
In-Reply-To: <20240830003147.GA450797@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2024 20:31:47 -0400")
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
	<CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
	<20240829214336.GA440013@coredump.intra.peff.net>
	<CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
	<20240830003147.GA450797@coredump.intra.peff.net>
Date: Fri, 30 Aug 2024 09:14:31 -0700
Message-ID: <xmqq8qwet2c8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F15783E6-66EA-11EF-8F84-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> though I'm not sure how DIFF_DETECT_COPIES should be handled
> ("recursive" silently downgrades it to DIFF_DETECT_RENAME).

I somehow suspect that we would want to go there to avoid
overloading ourselves (and end-users) with conceptual complexity.

If we detect that the file the side branch modified was copied to
create multiple files on our side (with or without modification on
our end), where would we want to reapply their changes to?  To the
original file only?  To all copies?  The same story goes for the
opposite direction.  How should possibly different changes they made
to their copies be merged back to the sole original file we have
(which we may or may not have modified)?  What if the both sides
made copies of the same file, and now we need to shuffle NxM
combination of changes?  I would expect it would be a whole can of
worms, which we _may_ be able to define concrete rules how we would
handle each of these cases but we may have a hard time to explain in
simple terms to end-users.


