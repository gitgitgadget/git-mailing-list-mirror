Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B9136989
	for <git@vger.kernel.org>; Mon, 20 May 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229096; cv=none; b=Y0IE/Lr7UFtwD1zUXeN83jaVGzWU/YqWpuIQBOti4jSkXD4/lIgyeQjCoZMFjdG8SWQYTC3Tq+4ZLEGej4ap60aPD6msRbU869toZonKLxOIg3HkEeUzDqZAkQDuXPf7MH2tV4hqak9754AtdMHGoNHooresiAl3Mpr5A3MpPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229096; c=relaxed/simple;
	bh=6Ilu/K7kSttT9yDswv5jHikk1Kvnm1fEiguct0jqEXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOyMUZqiGSabyaqoJcOgyJuLtz9nNU8gAUMHwqnoxShTg5DaFsEHuw8PfRjibEyZ0kmuEqR3ndenSyEeWB9uvCMOL76bdfYfkoB+NXKzrwjl0L1pw78gR0sKzUd+zxX089Es40Zn1h5ERD4BqfrywjuFb12IBL6+yg0bhqyd0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AO7ogY22; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AO7ogY22"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC06A27DE8;
	Mon, 20 May 2024 14:18:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Ilu/K7kSttT9yDswv5jHikk1Kvnm1fEiguct0
	jqEXw=; b=AO7ogY22KyjpHpWcNGhLWr5MggWV7iTJQ9UbezqgjuRS7Gh7mSPw0c
	qwYVzQrUZ8NqCr9X9KGWXQsm5WshyGoUnlwFdMaQKMpdYghzCWpNrFHaNKZm0Z9Y
	LDhJwNNna8NvCcRNh5zs6Ua5htuJ39HEmu7StTGfR8f+UeQ/Zx4No=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E365527DE7;
	Mon, 20 May 2024 14:18:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52C7027DE6;
	Mon, 20 May 2024 14:18:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de> (Johannes
	Schindelin's message of "Mon, 20 May 2024 18:05:30 +0200 (CEST)")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
	<20240518181432.GA1570600@coredump.intra.peff.net>
	<c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
	<20240518194724.GB1573807@coredump.intra.peff.net>
	<86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>
	<20240518211224.GA1574761@coredump.intra.peff.net>
	<xmqqed9yob4v.fsf@gitster.g>
	<5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de>
Date: Mon, 20 May 2024 11:18:12 -0700
Message-ID: <xmqqzfskfiu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5221F96A-16D5-11EF-9510-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To put this into perspective: If this protection had been put in place
> before v2.39.4, the CVSS score of CVS-2024-32002 would not have been
> 9.1 (Critical), but instead 2.2 (Low).

But we wouldn't have a working git-lfs then, so that comparison is
not quite fair.  As brian already said, you can reduce the score by
making Git do nothing, which is _also_ an absurd position to take
"security" (in air quotes) over everything else like usability and
functionality.  And this time, the layered security went a bit too
aggressive.

Also as Peff said and I agreed to, we are not talking about refusing
to do anything on top.  It was just that the "never run any approved
hook during clone" turned out to be not-quite-fully thought out and
it should be reworked in the open, and reverting that wholesale
would hopefully give us a cleaner ground to design it.

The end-result of such a reworking in the open may turn out to be
the same (or similar) "register the blob object name of the contents
to appear in approved hook scripts", or it may look completely
different.  But the road to get there, and the state of the system
while we get there, would be different.

I would probably see if I can take brian's revert directly; if it
applies to the oldest maint-2.39 track, it would be the ideal, but
we'd still need to prepare a similar 7-track cascade like we did for
the js/fix-clone-w-hooks-2.XX topics.  If it is only for the master,
it needs to be munged to apply to maint-2.39 first.

Thanks.
