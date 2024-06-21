Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460F128812
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991105; cv=none; b=b7/pyrsWvsxQ9QD3FtthPz/pxwQqIOlMY3YoYHVK6LLJGhiBHCYhrXlH9pqIRrencWYyg0b1Zz1UzyKl9ogbtI8LDITIbUF2I43ZgBuNBtyiCujWytUNbSr01TowgT2hiRrJ+4B/He3rmN9jOSVcQIdQAYulepj3E3Znl/gWNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991105; c=relaxed/simple;
	bh=UySh+QMGIQWBLYtcWIJ94MUWqstmnAh7LDFV0BzO8xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQOV2WDf0iuna4O/8YMtiX2EIsBxrZFjpbMDLZpTyeNSVQvDl0S2UFmHhRP3zpOExxstvPdK1DUSu6RlvkuydhqtnQU9Rs6RnVo2DTd08gHo4y/rSBK5uCT8x95caMAMfidMMFinW43UKwO7wL33+7Oy8oo3DemxxZWnIjSGUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HRMXI1KO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HRMXI1KO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E648F3746C;
	Fri, 21 Jun 2024 13:31:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UySh+QMGIQWB
	LYtcWIJ94MUWqstmnAh7LDFV0BzO8xc=; b=HRMXI1KOHg+OEfeCNik3WN7E/R/A
	ZPUp6Qmx4S14KrTGY66rV/DuAK2KjQ0XQ+BAH92K3AS9gxZx4VsKVKWR0mj3jrK9
	wd1sdvY9caQBp/G31metwKXu9neRnPBZwQ9mRDrsTnCRm2/3wSg4W9NR5jqMSLVx
	0/xk5o6jqkHASHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DF3C437469;
	Fri, 21 Jun 2024 13:31:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 820F837468;
	Fri, 21 Jun 2024 13:31:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Millar <paul.millar@desy.de>
Cc: git@vger.kernel.org
Subject: Re: bug with git describe --dirty --broken
In-Reply-To: <c4f5ae01-97fe-4e3a-94e2-72da75b9df83@desy.de> (Paul Millar's
	message of "Fri, 21 Jun 2024 14:07:26 +0200")
References: <0fd230f6-a5c5-463d-8584-651ceff3cf99@desy.de>
	<xmqqwmmjwnzs.fsf@gitster.g>
	<c4f5ae01-97fe-4e3a-94e2-72da75b9df83@desy.de>
Date: Fri, 21 Jun 2024 10:31:38 -0700
Message-ID: <xmqqmsnemccl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1EB4B8B4-2FF4-11EF-B9EE-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Paul Millar <paul.millar@desy.de> writes:

> Hi Junio,
>
> Thanks for your quick reply.
>
>> 	if (broken) {
>> 		run 'git diff-index' in a subprocess
>> 		use the result from 'diff-index' unless the command
>> 		aborted
>> 	} else if (dirty) {
>> 		refresh the index
>> 		run the equivalent of 'diff-index' in-core
>> 		use the result; if the in-core diff-index aborts,
>> 		you are dead already.
>> 	}
>
> Great.
>
> This matches my intuition from investigating this problem: the
> --broken flag triggers a different code-path.=C2=A0 However, it's good =
to
> have this confirmed.
>
>> I _think_ the "broken" codepath should be taught to also run "git
>> update-index --refresh" before it runs "git diff-index" (both in
>> their own subprocesses, or run in the same subprocess sequencially,
>> as if "git update-index --refresh && git diff-index" were run), and
>> your problem may disappear.
>
> For what it's worth, I agree.
>
> Also, just to mention it, fixing this problem isn't a priority (at
> least, not for me).=C2=A0 Simply removing the --broken flag resolves th=
e
> problem and I can live without this functionality.

Thanks.  Let's mark it with #leftoverbits so that people who are
bored and looking for small and isolated things to do can work on it
on their ample spare time ;-)
