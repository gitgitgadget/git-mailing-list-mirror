Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CF12FB3C
	for <git@vger.kernel.org>; Wed,  1 May 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580082; cv=none; b=rp2fOZXd0cdssZFCspJ0uZH6UOSwV9RYo4L4fBpbVQV9LmxC4hbZ0qWHKOu4yXweYa+ya9Bj49BP4FrpPpUsuqR7JN7pwkKwOsy/Q8QgJPmfKuYxFSELef1k2RvyXiJdHOsFTubCOH31at19IduUPlEFugTFNhvrf+ys+Jw5A+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580082; c=relaxed/simple;
	bh=Plz5u6BxgWqP/4yLChEk98qeqT/eNxF1h804R6lwFH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sBHnFg/FC5qjaeZ7/61dml/TJ561n600HLYabEwpPUzXPMvX7fn9++RaW+DD94ja20vKL7tj3xpLMVY9pvojXUuaHOIaij+jmP5YqBL/z3EWx00MH7yPQo/697XhLjRhYWx3yydWVJPiQVCcv9jaByyrdp1e/YPXKTiyeqK1qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FCctmaj7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FCctmaj7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D4A18FB6;
	Wed,  1 May 2024 12:14:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Plz5u6BxgWqP/4yLChEk98qeqT/eNxF1h804R6
	lwFH0=; b=FCctmaj7T4JshSV6d3TQyyxz9AU27Ijr/VJb4FMePEecgnlPyrjTHn
	4sgHuwIXUkAxhpXaK8GIhZMlPE7arMUupt5itENRBtZ+ZZW3Ih2M3zNDmTPeGu34
	xnG4yJrTSNkRzeDom6r38IZNgOfjOq5dK+r01fqOY2ihBk7gATB0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AA8218FB5;
	Wed,  1 May 2024 12:14:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF8CE18FB4;
	Wed,  1 May 2024 12:14:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
In-Reply-To: <7a3fcf9c-a70f-47e8-9624-40b407f90242@gmail.com> (phillip's
	message of "Wed, 1 May 2024 16:39:53 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
	<10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
	<27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
	<ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
	<7a3fcf9c-a70f-47e8-9624-40b407f90242@gmail.com>
Date: Wed, 01 May 2024 09:14:37 -0700
Message-ID: <xmqq5xvx5x1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8FC0A7E-07D5-11EF-B7D4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

>>>> -		fprintf(stderr, _("No changes.\n"));
>>>> +		err(&s, _("No changes."));
>>>>    	else if (binary_count == s.file_diff_nr)
>>>> -		fprintf(stderr, _("Only binary files changed.\n"));
>>>> +		err(&s, _("Only binary files changed."));
>>>
>>> These two mean we'll now color these messages which we didn't do before. I
> ...
> I think so
> ...
>> -		err(&s, _("Only binary files changed."));
>> +		error(_("only binary files changed"));
>>     	add_p_state_clear(&s);
>>   	return 0;
>> Or, simply leave them untouched in this series.
>
> Either option sounds good to me

We are returning "success" to the caller, so using error() here is a
bit strong.  Judging from how other messages emitted with err() in
this program is meant to help the end user, they are all to tell the
user why their input caused no actual change, and showing these two
messages the same way as these other messages would be the best for
consistency.

So I'm inclined to say that what was posted is good.  If it paints
these two messages in the same color as others, that is even getter.
