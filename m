Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD1388
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573448; cv=none; b=pLw2V8ZnRfTyTTwSSa/LKbDc1pkkkwANwkgGiyGHjv0/cUVTohpVjGHrlDLep2EEMpp8efgNiXviEZMYItJsWh5Q4sWCTfNXExZfX3yxHOZUiCbtTbdS18nqypwXylChi6hPry/TOfRuTln5RUjDVNT0OtcyUHMb5/RPtPjOK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573448; c=relaxed/simple;
	bh=gj9F/vXOzTvLOraxi+dlOYSO0MdSbBbtj01mEGzhglM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Khz31SG3l4q3URiLGZYx2yML4mAo4nAFPdAEKFn45mqbLp+1tCfQTv+/SpjvRPH08P2qjOF14KWXJsmDJQPSk4e0YJF1KD1QcYsPvoz6syOhqK03nElxqnIrXK4jNoqUFNxXr8aao4bIfHi1tLIgY22VT3rrz/Cbn7o6mCg0RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rxDv05Qd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxDv05Qd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EE1ED3D8EF;
	Tue,  9 Jul 2024 21:04:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gj9F/vXOzTvLOraxi+dlOYSO0MdSbBbtj01mEG
	zhglM=; b=rxDv05QdhpMaN1/jT25Q17aD8Q83Ot1PeYOYOq3BTBcjiUNwCEzSn7
	LefnSIYN5fJyVFeaHFWPC527cEMNsOfYbjgDn9OVU7RxUcs/BTHt5Kz+Uj0jEbM9
	BXBCH8xBDg9BT+NgtDys6n7xJsQ19gRqIClYHq22vluJIHPCOE7oo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D68F93D8EE;
	Tue,  9 Jul 2024 21:04:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 489BB3D8EC;
	Tue,  9 Jul 2024 21:04:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
In-Reply-To: <20240709235507.GB1525171@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2024 19:55:07 -0400")
References: <20240708140350.622986-1-karthik.188@gmail.com>
	<20240709144931.1146528-1-karthik.188@gmail.com>
	<xmqq4j8yflrq.fsf@gitster.g>
	<20240709235507.GB1525171@coredump.intra.peff.net>
Date: Tue, 09 Jul 2024 18:04:00 -0700
Message-ID: <xmqqbk369hxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4BE53F58-3E58-11EF-B8A4-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Jul 09, 2024 at 11:44:25AM -0700, Junio C Hamano wrote:
>
>> In any case, an obvious additional fix on top of your change might
>> be to do something like this:
>> 
>>         diff --git i/remote.c w/remote.c
>>         index 5fa046c8f8..d7f9ba3571 100644
>>         --- i/remote.c
>>         +++ w/remote.c
>>         @@ -682,7 +682,7 @@ remotes_remote_get_1(
>>                 struct remote *ret;
>>                 int name_given = 0;
>> 
>>         -	if (name)
>>         +	if (name && *name)
>>                         name_given = 1;
>>                 else
>>                         name = get_default(remote_state, remote_state->current_branch,
>> 
>> which would give us the default remote name, and we would not call
>> add_url_alias() with a bogus empty string to nuke the list.
>
> FWIW, I almost suggested something like this earlier. The outcome will
> be the same (remote_get(), etc, will return NULL), but I think it
> removes the "this is surprising" comment from my earlier email and makes
> things much more explicit.
>
> (I also agree with everything else you said in your review).

Heh, thanks.  I should prepare to shoot myself then ;-)
