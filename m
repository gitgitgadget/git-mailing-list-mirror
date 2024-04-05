Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A3174EE9
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355012; cv=none; b=tHCy2yZ9ojMjBgK5g1sJ7Ut9MSfowgtcYHvAupJeRuMxllQfupEn6MSBJ+KT714jDzrEn19g9upG7FTInFF1KPDJMihi2+ozorlRE1s6sglt8ZzO5xoT5eg+2Z3cyrZCvkvfMxMEmS1CJjEdTzL8wUJ+PF2pbKKkjZijwkR7uMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355012; c=relaxed/simple;
	bh=23UMO7MjOBw2A75S/tx1gXCdKyWWtSPF0aqm5tPG7tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJTPK0wUb51BW/PxV1QKo0wykP+ys4UtBuL16+gyEwWJl11UmbkoZ0WAJ77qNtWcWxtSV/gokLrDeOr3GCOwS150kd9wNma4s+mkThuEdcMyQuvP5kYSmJVZ1KBNRw6XRrs/IWKs5OfME/JDIcmVeN6N7Jxt9KFlaTgQG7QP1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IrlPqVoR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IrlPqVoR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90CA827084;
	Fri,  5 Apr 2024 18:10:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=23UMO7MjOBw2A75S/tx1gXCdKyWWtSPF0aqm5t
	PG7tc=; b=IrlPqVoRyBmSvwDV6r+gJ6VUfbTMFVwS9VW3+35/N3Y4BE6Wk2t57f
	AoypDiTiSUxeCvGWYBi3BKUsbKsvBv6WSht0eYMFXxZHmygvzt9gH9xq3km2T++8
	hnmrgoGouZ5eHTxLH29/lDAJ/L8tGhTrLEKPTfU4nkps0mAWmIbQE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FAFA27083;
	Fri,  5 Apr 2024 18:10:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 08D902707F;
	Fri,  5 Apr 2024 18:10:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Jeff
 King <peff@peff.net>,  Linus Arver <linusa@google.com>,  Steven Jeuris
 <steven.jeuris@gmail.com>,  Steven Jeuris <steven.jeuris@3shape.com>
Subject: Re: [PATCH v5] userdiff: better method/property matching for C#
In-Reply-To: <c2154457-3f2f-496e-9b8b-c8ea7257027b@kdbg.org> (Johannes Sixt's
	message of "Sat, 6 Apr 2024 00:02:47 +0200")
References: <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
	<pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>
	<c2154457-3f2f-496e-9b8b-c8ea7257027b@kdbg.org>
Date: Fri, 05 Apr 2024 15:10:05 -0700
Message-ID: <xmqqa5m7tq9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42C07D2A-F399-11EE-9184-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.04.24 um 23:42 schrieb Steven Jeuris via GitGitGadget:
>> From: Steven Jeuris <steven.jeuris@3shape.com>
>>  ...
> The proposed patterns look reasonable and are an improvement over the
> existing patterns, so I think we can move this patch forward.

Thanks, both.  Let me mark the topic for 'next'.
