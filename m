Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F616AA1
	for <git@vger.kernel.org>; Thu, 30 May 2024 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039415; cv=none; b=sZPHct57c8sbJfbY7ukVJl0LqtXtYO1WB+QPUpp9daB/O4C1tmLOY19ROHUheQT/v3YnrrDctIAS3xkDVT7C7u4PNNd1gB/O5SSc3lPqIVijHAw4Bgia/mrjzNxLMrIyzpN1MntZBR+pZfaJWFH+6nIggu4nUv+i3Qo/hojFIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039415; c=relaxed/simple;
	bh=Scyw0LGOAWt8jSK3VMDOB49HT6PuXMazOutRcUUJt9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:References:Date:
	 Message-ID:MIME-Version:Content-Type; b=jrGzc5Um6zrV0orLrbZ/k1PFFjxAaQfVVB08LCvbwMkujhzMcR1gmt0Ow8IyU2sd/ZbyYYMJH0aQO5WOJQ/YDMmVX/NCacQoPqaXEt4AsSV9sFiVujblPZp0AcN6yXkgYqhUKoJpY6MxGuBmVtpIw3jddbGgz8uWM4u7KLOva30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eWhxVSsp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eWhxVSsp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3227335CD6;
	Wed, 29 May 2024 23:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:references:date:message-id
	:mime-version:content-type; s=sasl; bh=Scyw0LGOAWt8jSK3VMDOB49HT
	6PuXMazOutRcUUJt9c=; b=eWhxVSspRWlqNGKtYshXDWAs8C8Jm1u5d6S8ATOvI
	siXllQ7pAJyqxXDXV9CfvVDWBuvkxTNbYmmI7J/3WYxWjpeLvY6e6GGqMle2SQzG
	rYUTZLuneLJmBK0VihqSwum+fiyMdbuHJxi/afHjvVXeDRkouqlsx6fOWlRLZIt6
	Rw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B3A235CD5;
	Wed, 29 May 2024 23:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43DD335CD3;
	Wed, 29 May 2024 23:23:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kevin Day <toasty@dragondata.com>
Cc: git@vger.kernel.org
Subject: Re: Commands using -h as an option don't work consistently
In-Reply-To: <0F971F6E-6462-4E0D-880B-8FD67F42A782@dragondata.com> (Kevin
	Day's message of "Wed, 29 May 2024 17:40:31 -0500")
References: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com>
	<xmqqfru0tg1a.fsf@gitster.g>
	<0F971F6E-6462-4E0D-880B-8FD67F42A782@dragondata.com>
References: <84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
Date: Wed, 29 May 2024 20:23:27 -0700
Message-ID: <xmqq34q0rnio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC1129B8-1E33-11EF-95B4-8F8B087618E4-77302942!pb-smtp21.pobox.com

Kevin Day <toasty@dragondata.com> writes:

>>> 1) Fix -h handling and add ignores and fixes where possible to the
>>> failing tests and try to not use -h as an option for anything new.
>> 
>> I do not quite understand the former half, but "try not to use -h
>> for new things" is a very good idea and it is pretty much what we
>> have been doing.
>
> Sorry, let me rephrase that.  1) Apply the fix I was proposing to make
> it so that the command's -h usage has precedence over showing the
> usage. Any tests that break because of that which don't have a
> plausible fix mark as "# TODO known breakage" like several other
> commands have because they aren't generating usage output correctly
> for one reason or another.

Ah, then no.

I am afraid that it is a non starter.  "git ls-remote -h" would then
stop breaking existing users' long established expectation, i.e.,
"for any git subcommand 'cmd', you can say 'git cmd -h' to get the
short help".  We need to design a good transition plan to wean
existing users off of that expectation.

For example, we _could_ introduce "-?" to parse-options _now_, and
mark the use of "-h" as deprecated.  When the special casing of "-h"
parse-options has triggers, the user will be reminded that the "-h"
support will have a limited shelf life, and they are urged to
retrain their fingers and update their scripts to use "-?", possibly
with "advice.shorthelpdeprecationnotice" configuration knob that
helps ease the transition.  We would update the t/ scripts to use
"-?" at the same time, but would probably need to keep tests that
use "-h" to ensure that the warning triggers.

We will keep things that way for a while, and once we get the users'
expectation updated so that they think 'git cmd -?' (not 'git cmd
-h') is _the_ way to get the short help for any git subcommand.

At a major version boundary, e.g., Git 3.0, we could remove the
special casing of '-h' from parse-options, and "git ls-remote -h"
will start working the same way as "git ls-remote -h origin" all of
a sudden, but nobody remembers "git ls-remote -h" used to be the way
to get short help for the command any more by that time, so nobody
will get hurt by such a flipping of the behaviour.

