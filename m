Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B112E1E0
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130764; cv=none; b=sUfTOB2yUsWnjYW6r3H/HnmqQgVuH4smKb2CtQuXnLpicMH2aHrgcqXsld8GjPA2mr8oMjedXVSkomL6Jsrr2Is1wJA1ddSgCCA7M7B3xzQOrIoWweAAOH0pbhF6jMVOYD4Sm42lfzBaWh79CiF02ogRXLV62VkXsc46UzEt/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130764; c=relaxed/simple;
	bh=yTPgbX4O0lQ/ROYGzUBKiTwIHdSh6CKGplw7593ipD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIjNTpT1Zag0smoUg/13F4Apf0Q71J172ooA6XDuPkAl9e9nOGIMJZjqYXrl0qkDCnLuavkUprE0ATYXbz+NSqcbuSSPVXT9b7zy18/DGKG9FlHQDvv8qHfwgSA7WhhIrQ2x32ypDDS9hRo4z1hermU2JEwCiRnG6pRsMCdU+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TOMKmt3t; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOMKmt3t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 526482C127;
	Mon, 23 Sep 2024 18:32:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yTPgbX4O0lQ/
	ROYGzUBKiTwIHdSh6CKGplw7593ipD4=; b=TOMKmt3tJGi2m3gUEfN3Ttl8BCd8
	cpKAkcJD7Zke1095LkYGCcKjnQyYkT1L0sLKqBTUUkrRSf3A1nxZTMPvYPY8RmBr
	5adjCHbBOkoFsRbtxG5rzyowkYzHwlL3iZTtrwWIQjfI//toQn/K2uPx8I9QDi7X
	8/UYy3B3s2MRGSw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A9AC2C126;
	Mon, 23 Sep 2024 18:32:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF46F2C125;
	Mon, 23 Sep 2024 18:32:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Ian Turner <vectro@vectro.org>,  git@vger.kernel.org
Subject: Re: Bug report: Undocumented interaction of --exit-code and
 --ignore-space-change for file move
In-Reply-To: <2c3472d4-ad40-4636-9840-51fa97bca02b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 23 Sep 2024 20:08:58 +0200")
References: <d8512f2b-400f-4daa-a59f-5d10d4fc3840@vectro.org>
	<2c3472d4-ad40-4636-9840-51fa97bca02b@web.de>
Date: Mon, 23 Sep 2024 15:32:39 -0700
Message-ID: <xmqqzfnyvw54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BE3F2332-79FB-11EF-878D-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 87cf96094a (diff: report copies and renames as changes in
> run_diff_cmd(), 2024-09-08) fixes it, but it's not in any release, yet.

Thanks.

It should first appear in Git 2.46.2 and would be in Git 2.47.
