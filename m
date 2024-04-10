Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB678179218
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765286; cv=none; b=kWpw3UlgZnLyMt5YtVx6lH8B1gAZW5yNK7Tui27iHBP759HkCgmbDJlvhRfz24ln8fUZuOt2j9xrkpmW+bQuVAjTAnslxNKFrCnWQ5P7FGnCnMnuT49ZZVFgKv1Egd7/qq91fsJl8yle1RC/TPhucxtQvklnF+5kvrD3b2shsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765286; c=relaxed/simple;
	bh=8ZSuP2fl5M4iqHChwCcA0p11E0tbpqtxNzQM+ri38NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bGQPB6kl6b4pC/Q91I+9I227xttdCiRuI+6m5lx7d4qYY0a7UYFV2frJFx87tAgvh9/sWHYEsYE4QPbeTey382WpGlUyG2Hy0ht1zNt2JzAtn5QlT97u60HkzExycNisv36MhEEuuo9RDxaj4YHpF5xqyi9PZ/MJ7w5uxJEBGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QvfS5GI+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QvfS5GI+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BD051DF539;
	Wed, 10 Apr 2024 12:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8ZSuP2fl5M4iqHChwCcA0p11E0tbpqtxNzQM+r
	i38NE=; b=QvfS5GI+Ljirn+fRT5VaKJBr4PgByY13iujIDeVu8tmjkdnmuHRwRY
	GXGhHI97KiQsQEgHDZYgrVHbvjtSoyAPag/5LbvEPAcRz6ZdhT6LUaTT0bQCcUJ2
	9J+W9qR07uJ4h0HovQd3GPQrIBh6UrRHzE7wfMH/if/DCIIL7xBlg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7137B1DF537;
	Wed, 10 Apr 2024 12:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C81CB1DF534;
	Wed, 10 Apr 2024 12:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2024, #04; Tue, 9)
In-Reply-To: <ZhYy-rwepBwiziK_@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Apr 2024 08:34:34 +0200")
References: <xmqqttkayuy5.fsf@gitster.g> <ZhYy-rwepBwiziK_@tanuki>
Date: Wed, 10 Apr 2024 09:08:01 -0700
Message-ID: <xmqqv84pw68u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 822CF4FC-F754-11EE-8B4D-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Apr 09, 2024 at 04:31:30PM -0700, Junio C Hamano wrote:
>> * jt/reftable-geometric-compaction (2024-04-08) 4 commits
>>  - reftable/stack: use geometric table compaction
>>  - reftable/stack: add env to disable autocompaction
>>  - reftable/stack: expose option to disable auto-compaction
>>  - Merge branch 'ps/pack-refs-auto' into jt/reftable-geometric-compaction
>> 
>>  The strategy to compact multiple tables of reftables after many
>>  operations accumulate many entries has been improved to avoid
>>  accumulating too many tables uncollected.
>> 
>>  Comments?
>>  source: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
>
> You mentioned in [1] that you'll mark this for next after taking a look,
> so I assume that you asking for comments here is simply stale. In any
> case, the patch series is ready to be merged down in my opinion.

Thanks.  I haven't had time to read it over, during which time
others are welcome to further comment.  Hopefully I can find some
time to do so today.

Thanks.
