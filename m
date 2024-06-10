Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4E5588B
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055456; cv=none; b=TcdgUYJsRFRV/msgu7noOZM3TKd1n/Cz15FVclL73h5VjWWz4a3gQiu15rQ0YUrM3bj+n2ArKwqloWj468AO2291VbkrfMNc9eTwxXAfkc4KL5uJ/kvly3S23Ga+UQq19hAGyogfWjqW7+XQmR0ewcaUzvDy1/PBvSj+tq9DAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055456; c=relaxed/simple;
	bh=TX89nT7G+4KelcqoBO1VbH0KH/iYDrYvz0FWUDDasx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtB9oK+tKpnsmnNU/sH18odO73Rzh6+bsayI1GRdlzRlWE1S1dGmmoka/9wAUIDp9QUdo1hpL7NKPzpehRFq6mMWGqnIptqlJHUgvGce2u/QXl8OHdOtbcZ2AQIR0U3cXbNLwicL6TA32szMxgnidij49OpgqTvmvtBpyVcaJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hNBjB66M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNBjB66M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4109A21C18;
	Mon, 10 Jun 2024 17:37:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TX89nT7G+4KelcqoBO1VbH0KH/iYDrYvz0FWUD
	Dasx4=; b=hNBjB66MqVKLGiOck3LEulO6PsSLS6NVbHiQeFh1TtyYD0xzfoq4XA
	qXMIhaQgWq9uF/jAiwjlurnmAQf7ioA+C6mLv3+PrEsyL1B67lTphA5n5sVTkrFJ
	BjiEbyCr0y3GG5Tn/ZvVPGMxst6OYPo0+HndyGhq+w3WlSH4tGOkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 386A021C17;
	Mon, 10 Jun 2024 17:37:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 982D921C16;
	Mon, 10 Jun 2024 17:37:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Yuri <yuri@rawbw.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
In-Reply-To: <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
	(yuri@rawbw.com's message of "Mon, 10 Jun 2024 13:08:38 -0700")
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
	<xmqqwmmw1sev.fsf@gitster.g>
	<4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
Date: Mon, 10 Jun 2024 14:37:31 -0700
Message-ID: <xmqqikygzdgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5180AB8-2771-11EF-BFA5-6488940A682E-77302942!pb-smtp2.pobox.com

Yuri <yuri@rawbw.com> writes:

> On 6/10/24 12:58, Junio C Hamano wrote:
>> So "was supposed to remove" above is not quite correct. Where did
>> such a piece of misinformation come from?
>
>
> "git clean -df ." removes all files that
>
> (1) aren't added to the repo
>
> (2) aren't added as exceptions
>
> (3) aren't repo files themselves.

But .nfs* files are not something you as an application are not
supposed to touch, so a directory that still contains one cannot be
removed, either.

It's a limitation (I wouldn't call it a "bug") of NFS.  You can kill
the process (or wait until they exit) holding the file open and then
run "clean -df" again, perhaps.

A few Google searches tell us more, e.g.

 - https://nfs.sourceforge.net/#faq_d2
 - https://kb.netapp.com/on-prem/ontap/da/NAS/NAS-KBs/What_are_nfsXXXX_files_and_how_do_I_delete_them

They tell us what these files, which are the result of "silly
rename", are, why they exist, and that they will appear again even
if we remove them.  So we don't remove them, which means the
directory that contains them will not become empty, which in turn
means we do not remove them.

