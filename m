Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA818EB0
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963183; cv=none; b=AbmG/L0D4aHi69ZAWrKpWMJIlwqgc3Ot7c7a1WFD+evIf3GhsRaZxbzJLe+dBiL+9AoHk5tmxahluQnJGdowAbw/+2VzTKETuU+lOz+B9LHZWYCKRq5WP0R3wzukM15Nvthiy4xts6EHcHj6mImGOH/WXVDaq2u/ipJInoGan/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963183; c=relaxed/simple;
	bh=PMnnO9lMl7xpjIzeWWRQy+bKiKoBST87iLEQaV9wnRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADtGBiKiAnF04eUl61NYmM5XpY8bSjKlIL7UYsf9tNPc/39Lh5gzjhP6Cc+GC7CgN7e6xRlBSe/yGjldZlscu9nBDRUUIRznJL66DO0lHINuqF33eZPsS76YPSyyIZGpRhiKCXaZrELnfOGxnUsnmEq7CQ1iEy2P+CqYnI00qQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c8Cc/FOt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c8Cc/FOt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DEA013636D;
	Tue,  6 Aug 2024 12:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PMnnO9lMl7xp
	jIzeWWRQy+bKiKoBST87iLEQaV9wnRs=; b=c8Cc/FOtNUjF3N+Uc0KmvaqFwQoT
	OaOlxDwGtZxZbTJbW0evtrgzEdgxXesszhH8pfKBtQelgtiDWL02hUDMO2jK/4X7
	aLxgdeJdUT+gNGfLBWm/ZlL1EzO/YPkwM6TVHjF2VW3NsAecqe2XgLc7GU4eAGsx
	qY4t8D8vIuKOLIc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D842F3636C;
	Tue,  6 Aug 2024 12:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C33263636A;
	Tue,  6 Aug 2024 12:52:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t3206: test_when_finished before dirtying operations,
 not after
In-Reply-To: <CAPig+cRO=BqR1WFcni6CSxqyqvt1Ksmsyr0odmqTDKX4JdbDaA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 5 Aug 2024 22:21:59 -0400")
References: <xmqqttfyzd01.fsf@gitster.g>
	<CAPig+cRO=BqR1WFcni6CSxqyqvt1Ksmsyr0odmqTDKX4JdbDaA@mail.gmail.com>
Date: Tue, 06 Aug 2024 09:52:56 -0700
Message-ID: <xmqq4j7xvbiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 554082E8-5414-11EF-91E6-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 5, 2024 at 8:55=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> Many existing tests in this script perform operation(s) and then use
>> test_when_finished to define how to undo the effect of the
>> operation(s).
>>
>> This is backwards.  When your operation(s) fail before you manage to
>> successfully call test_when_finished (remember, that these commands
>> must be all &&-chained, so a failure of an earlier operation mean
>> your test_when_finished may not be executed at all).  You must
>> establish how to clean up your mess with test_when_finished before
>> you create the mess to be cleaned up.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/t3206-range-diff.sh | 52 +++++++++++++++++++++---------------------=
-
>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> @@ -533,9 +533,9 @@ test_expect_success 'dual-coloring' '
>>  for prev in topic main..topic
>>  do
>>         test_expect_success "format-patch --range-diff=3D$prev" '
>> +               test_when_finished "rm 000?-*" &&
>>                 git format-patch --cover-letter --range-diff=3D$prev \
>>                         main..unmodified >actual &&
>> -               test_when_finished "rm 000?-*" &&
>
> Do we care whether the action invoked by `test_when_finished` itself
> succeeds or fails? In particular, should this be using `rm -f` rather
> than `rm`?

Thanks for good eyes.  The original avoids that issue by making sure
it only installs the clean-up after the operation to create crufts
successfully completes ;-)  Of course, if it fails in the middle,
then the crufts are left behind X-<.

>> @@ -606,9 +606,9 @@ test_expect_success 'basic with modified format.pr=
etty without "commit "' '
>>  test_expect_success 'range-diff compares notes by default' '
>> +       test_when_finished git notes remove topic unmodified &&
>>         git notes add -m "topic note" topic &&
>>         git notes add -m "unmodified note" unmodified &&
>> -       test_when_finished git notes remove topic unmodified &&
>
> Similarly, should this be using `|| :`?

Ah, I forgot that "notes remove" would barf when there is no note to
remove, instead of being idempotent no-op.  Yes, you'd need ||: there.

>     test_when_finished "git notes remove topic unmodified || :" &&
