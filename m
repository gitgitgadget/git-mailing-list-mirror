Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132A63407
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204797; cv=none; b=KGzEK9va+YKvVoGnj4JR2jOX6BLkOGTW9+uWxhSIgjecu4mRKAvlu2tRmDy3i1FA6+wKq+z97KoTtRIwSrdevVDDnFxGkcCuXxjtDvyN6qG2/myFKlfL42KInUY9IeVVwmNEA9an1ADlwZscdvoVfXNLvJeZ3yEhmLIvlLsbUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204797; c=relaxed/simple;
	bh=yNC7lbm87HrIfJLjtJ6IRPMKQUP91l5fRCvR+G2LrzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVz4FRxjYQoov5+lsKJtv8jeKGxBced2Hrr6cxaFGgOok9NO5XhKohdjU1tVx9A4uVnKU37Lv2BxGXcCXUsSgx5oyNwIZa07tyt0SeZuxRPG6SKcSl5H3nIssUEJjSpIfXqOcnkIQ/KPQE+8ReIrkqwpiQWmZUlwd+Mld16pCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XTZVrOMg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XTZVrOMg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 517361BE909;
	Thu, 25 Jan 2024 12:46:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yNC7lbm87HrIfJLjtJ6IRPMKQUP91l5fRCvR+G
	2LrzI=; b=XTZVrOMgONeTRTaFnIc0tgDxUZn74r2acXhsp3Gh2AehwAzQQo4xKs
	ixXAQhoEkxnbVHdHsVcdqJMc5K3NB5SyLrY74SpJIPyukyg79ZaG45ZGrFh/OJxv
	I2hVE4fkNzN7gPRu8h9w5XaJYJGHJ0lAEzGsyCaACP9P3NR2LmxSw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48EFC1BE908;
	Thu, 25 Jan 2024 12:46:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B14B81BE907;
	Thu, 25 Jan 2024 12:46:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <87il3h72ym.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	25 Jan 2024 20:11:29 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru>
Date: Thu, 25 Jan 2024 09:46:32 -0800
Message-ID: <xmqq1qa5xq4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ADF4CA9C-BBA9-11EE-A43D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> Now we are going to introduce "dry run" option "-n". Most simple and
> obvious way to do it is to set internal flag "dry_run" and then at every
> invocation of "remove(file_name)" put an if(dry_run) that will just
> print(file_name) instead or removing it. Let's suppose we did just that.
> We get this behavior:
>
>   $ git clean -n
>   fatal: clean.requireForce defaults to true and neither -i nor -f given; refusing to clean
>   $ git clean -f -n
>   would remove "a"
>   would remove "b"
>   $ git clean -f -f -n
>   would remove "a"
>   would remove "b"
>   would remove "sub/a"
>   $
>
> I see this as logical, clean, and straightforward behavior, meeting user
> expectations for "dry run" option, so I suggest to do just that.

I think we are saying the same thing.  If the original semantics
were "you must force with -f to do anything useful", instead of "you
must choose either forcing with -f or not doing with -n", then it
would have led to the above behaviour.

The thing is, it is way too late to change it that way without
breaking too many folks, and that is the problem.

