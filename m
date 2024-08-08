Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08706154C17
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135056; cv=none; b=PScf1KWxYgs5/vm/hOqw/8uIxaWUE2vKwP4sFi9V2RPrWVrRKhsiZU6OhqZFTmmSAWABvKoRB5IHgrT3S0aEBpwvcORfhY9zUr9QEH6xfL7S+Ml//sxCdlDFd0PgZr4SLCZt22uhTAtL/Vx8SJ9AGQX8WkXYHst57dF2vdaW2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135056; c=relaxed/simple;
	bh=vObQBayDlWiY2IWV2ovfeESdz++/eEsuyGeBgKXtAmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1tNVOCtz3ugPAg1w0BhBpjdbr6fGrrBr8bFEOzIYAy3PqotQ89STmY3YXpS/CA4LxdRnhJuH66sP4ClvdXM9A7gCNwnYCGBqOvbexvXSY2Tfxw/j9OQvVC8qHXaIEMvjyry7PvKHdQqlTmulOFWpUBr7M4O7TVqxqnYPGqpRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wmTP5vrF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmTP5vrF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACA3433C81;
	Thu,  8 Aug 2024 12:37:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vObQBayDlWiY2IWV2ovfeESdz++/eEsuyGeBgK
	XtAmI=; b=wmTP5vrFppTNA+CfzX7Ceh1eHCkapYwzH5C6lz6TYbvxqGhR2kkrD5
	otrzSagIdvx22vC2EjtnK1V3l2twOwlYYiG4UCF1h5vEQWEYXonz9Jyo1AeJfx+K
	cnoAaZSaBD82PltxWLxegMewNwYKI/YJZ9MnubtwYnBPgiKk7slik=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A5D1933C80;
	Thu,  8 Aug 2024 12:37:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C21F533C7B;
	Thu,  8 Aug 2024 12:37:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v16 0/9] ref consistency check infra setup
In-Reply-To: <ZrSyDi9tD1wtZm-F@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 13:54:54 +0200")
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
	<ZrSqMmD-quQ18a9F@ArchLinux.localdomain> <ZrSyDi9tD1wtZm-F@tanuki>
Date: Thu, 08 Aug 2024 09:37:29 -0700
Message-ID: <xmqqa5hnhsxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 818A37AE-55A4-11EF-BC73-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 08, 2024 at 07:21:22PM +0800, shejialuo wrote:
>> Hi All, this version handles some minor changes:
>> 
>> 1. Remove redundant newlines.
>> 2. Fix typo in commit message.
>> 
>> At last, I wanna thank every reviewer. As we can see, this series starts
>> from 5.27, it's a very long journey. I have learned a lot.
>> 
>> Thanks
>> Jialuo
>
> The range diff looks as expected to me, so this series is ready
> to be merged from my point of view. Thanks!
>
> Patrick

Yeah, looking good here, too.

Will replace.  Let me mark this topic for 'next'.

Thanks.
