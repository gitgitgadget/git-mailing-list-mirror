Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296613DDD2
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015610; cv=none; b=K1+ThVjlrM5MYU8tOkCpfgSk55pIDPhGKSaHD5OfKfR6s+PoEOgO+FEO39mVIrZTo7cuVMM+yJx4oPE33YFT9OIUPEsMQjQ9Hetakuc55kAcoYx5DdSekjwVsg9Vbd3DzyIrVoQ5U2qAHrhc0fKoT7TXZibaoqNyLMUoU8fUHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015610; c=relaxed/simple;
	bh=S53AkGeDURXqL/GoQrgrdR5STyf9BMRGNkeDA9xWqDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ib0Rkd5knbwcRxIVWXwXCYdqmfyzwoD1TG0Rhn2vqv1LLEgXGkfKCgUqeOTxaJOCecJNwazs8ZP2W2mTwl0AWiTzWyO1etCy8mLnz1Sa6IvOE5qEZEAu53/ms3R3XLQ9QJqoHcR1PogWeWrN69p18InkQv5OgrPyT5xjgkRmwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mGESWsxP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGESWsxP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77A5421F56;
	Mon,  6 May 2024 13:13:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S53AkGeDURXqL/GoQrgrdR5STyf9BMRGNkeDA9
	xWqDg=; b=mGESWsxPqjBIlGGtR2A6i/v/uWbt9lm/NafoI08H+RvaGiLX5OZmml
	J/C9vcq/U3SLIxJmcn+EGQmqmEElfY6RR80y/F6oAtboQiZFXs8QmRi2sMIO1cxv
	qSPJrKHQPc3y23yjms56eBmsAXbklcHbykHXdjOUi2cpJQobn0a2E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E29421F55;
	Mon,  6 May 2024 13:13:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D714D21F54;
	Mon,  6 May 2024 13:13:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com,  'Karthik Nayak' <karthik.188@gmail.com>,
  git@vger.kernel.org,  'Kristoffer Haugsbakk' <code@khaugsbakk.name>,
  'Taylor Blau' <me@ttaylorr.com>,  =?utf-8?Q?'Jean-No=C3=ABl?= AVILA'
 <jn.avila@free.fr>,
  'Eric Sunshine' <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
In-Reply-To: <ZjiL7vu5kCVwpsLd@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 09:51:10 +0200")
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
	<b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
	<CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
	<015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
	<xmqqjzkaanr1.fsf@gitster.g> <ZjiL7vu5kCVwpsLd@tanuki>
Date: Mon, 06 May 2024 10:13:25 -0700
Message-ID: <xmqqttjazwwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F3D69636-0BCB-11EF-B396-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> ... I was pondering
> whether we want to introduce a document as part of that patch series
> that starts to keep track of upcoming removals for a potential Git 3.0
> release.

Finally somebody has bit it ;-)  In the 2.44 cycle, I wrote

    The RelNotes symbolic link says we are now working towards Git 2.44.
    It may not be a bad idea to reflect on what technical debt and UI
    warts we have accumulated so far to see if we have enough of them to
    start planning for a breaking Git 3.0 release (or, of course, keep
    incrementally improve the system, which is much more preferrable---
    continuity and stability is good).  End of year being a relatively
    quiet period, it may be a good time to think about your favorite pet
    peeve, to be discussed early next year.

in a few of the "What's cooking" reports.

> There are multiple items that could be added:
>
>   - Removal of the old syntax of git-config(1).
>
>   - Removal of the dumb HTTP transport.
>
>   - Removal of `info/grafts`.
>
> There are probably other items.

A list of things I can think of that I won't be the primary advocate
for but I do not mind too terribly if we had champions for the
topics are attached at the end.

> In any case, the old actions are here to stay for the foreseeable future
> until we commit to a breaking major release.

True.

> Thanks for the thorough explanation, I have nothing to add!

You could have avoided it if you copied some from the initial cover
letter to each round (i.e. preparing the series to be read by some
folks who did not read an earlier round).


Possible additional Git 3.0 items:

 - Removing "git http-push" to push over HTTP/DAV.

 - Removing support of `$GIT_DIR/branches/` from remote.c API.

 - Removing "git update-server-info".

 - Removing "git annotate".

 - Removing "gitweb" and "git instaweb".

 - Removing "git filter-branch", now we have a better alternative
   "git filter-repo".

 - Removing discovery of hook script in "$GIT_DIR/hooks/", in favor
   of the configuration variables that point at them.

 - Switching to SHA-256 as the default hash algorithm.

 - Switching to reftable as the default ref backend.

 - Switching the hardcoded default branch name away from "master" to
   "main".

 - Declaring that "git restore" and "git switch" were failed
   experiments and deprecating them.

 - Declaring that "git submodule" was a failed experiment and
   deprecating it.
