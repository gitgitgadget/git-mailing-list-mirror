Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BC61FD6
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423942; cv=none; b=jUVO+cVqWcpzuo3keX8MJLb/SOtY55snGh501TN73sQMOg39uJZop0TFPbgzThbZbAITMy20dfrkX4w9ZJ/4blIDeOUekF62CyfhLvY+5zeAE4Ok5CRL/y7/3p47ujoCUSYwvWqedn7UN6luF5CItaseAaZYOxtJqRWJUI9Sdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423942; c=relaxed/simple;
	bh=rE6DKWKZNQhXpDYUgF5QwKBRjowgnaAo5LWvv4l1BAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWvU1ADHEIvigX/1DZa5TjYkkzQWVW3YFn2nRZahQJkDsdW2yivDJnl+u4tdjWSF74pxXvDLUQquhewzN084i8PvWrNboDMtCstTRncPX7BY15rKycn6k2yBYdd4ogbgpWhDDAR3449hXeV8CxIUL63Wps5wEQgvg1iduHXgEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uoYswFqK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uoYswFqK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63A24234D6;
	Wed, 26 Jun 2024 13:45:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rE6DKWKZNQhXpDYUgF5QwKBRjowgnaAo5LWvv4
	l1BAQ=; b=uoYswFqKHFCdLWcvQAeg/csqKDXNcN4S8eiduegseM8RfiLereS77X
	THey41ZSbEGN3TMfTMdpWRCakR4iyTG4mgnZpP7LabuEY28gz3NwTpc4zOL6jIVc
	y/1znpL65ZubR4c2L5QCfxePNHPDXSiwRGCF2d9bd2sdt5zsfs3Ck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AD71234D5;
	Wed, 26 Jun 2024 13:45:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B48ED234D4;
	Wed, 26 Jun 2024 13:45:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag
 is used
In-Reply-To: <xmqqsewz1ua5.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Jun 2024 10:35:46 -0700")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	<2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
	<xmqqikxv4t1v.fsf_-_@gitster.g> <xmqqcyo33cgu.fsf@gitster.g>
	<bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
	<xmqqsewz1ua5.fsf@gitster.g>
Date: Wed, 26 Jun 2024 10:45:31 -0700
Message-ID: <xmqqmsn71ttw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E2CEC936-33E3-11EF-9E77-965B910A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>
>> To me, this looks much better.  child_process_clear's name already
>> suggests that is sort of like a destructor, so it makes sense to
>> re-initialize everything here.  I even wonder why it was not that way to
>> begin with.  I suppose no callers are assuming that it only clears args
>> and env though?
>
> I guess that validating that supposition is a prerequisite to
> declare the change as "much better" and "makes sense".

Having said that, a lot more plausible reason is that most callers
are expected to use a single struct just once without reusing it, so
the cost of re-initialization is wasted cycles for them if it were
part of child_process_clear() which is primarily about releasing
resources (instead of leaking them).

It can be argued that it is a sensible design decision to make those
minority callers that do reuse the same struct to pay the cost of
reinitialization themselves, instead of the majority callers that
use it once and then release resources held in there.
