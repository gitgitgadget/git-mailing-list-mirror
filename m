Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0A3D75D9
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943731; cv=none; b=rgkYd1mtV3KHpSpDvybQZZKHfbg8IV39pc7t7uuwCZfMr/s4wy21hY5ELzt8dC1UgdspqN8KsK4U1davKalgZDymF6yqJYccboze1vhqGPyDV0lPHBENx/cHMpDEU0T/zbx0SXhdlsjq23hKMkZjW9qSMu3e3MCZcn1QB5cYqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943731; c=relaxed/simple;
	bh=DBazdVTPowd/DGBuosxb3zse30EsnN3S4JCPbibxZr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHorz24cAhPb3YiLm3jLCjLaS+ht8nhHr+zyT/08CFnONS/Z5ejZO7Y4EICssecN5bs2fs5bF+DwgrrRS0qsS1lTf7uMbq12ccSXKaUvDdZed383sgEQB/iEk96w8J3uwUgtqkzzPJmuN1ynzFEHKAA4BOEPuiP46YJgC80j0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mRZD5lH7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mRZD5lH7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774943725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Q7IcZFmX/UnUokMFKMhWlSJjSYqPpIxMsgkpdsU1E=;
	b=mRZD5lH7oj3/2Xhp+awqm87BNjTglJheOEOIiwIkWYD2EcbqWG18G4QwiRob70BWw6JzhX
	6eI915liaa12Km2pfPKPQxDPFjD3dD2pi2TMeQnP0lp6USJ5fPZd5CJrUh9JlEWozwFQps
	46d4QQmN9XoLHXCkjyj3P4BsOb1SG1M=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, Siddharth
 Asthana <siddharthasthana31@gmail.com>, Yee Cheng Chin
 <yeecheng.chin@gmail.com>
Subject: Re: [PATCH v2 0/3] Add option --ref to git-replay(1)
In-Reply-To: <xmqqjyuynv99.fsf@gitster.g>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
 <xmqqjyuynv99.fsf@gitster.g>
Date: Tue, 31 Mar 2026 09:55:20 +0200
Message-ID: <87tstwl9g7.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> As sa/replay-revert has been updated, I rebased these three patches
> on top of the updated version of that other topic and merged it to
> 'seen', which broke CI with t3650.
>
> I naturally suspected that I made some stupid mistakes while
> rebasing, so I applied these three patches directly on top of that
> old sa/replay-revert.  Unfortunately, the same test t3650 fails
> exactly the same way with merge-ort aborting.
>
> The failing test run fails like so:
>
> ok 45 - --ref with nonexistent fully-qualified ref
>
> expecting success of 3650.46 '--ref must be a valid refname':
>         test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
>         test_grep "is not a valid refname" err
>
> /home/gitster/w/git.git/t/test-lib-functions.sh: line 1180: 2840466 Aborted                    (core dumped) "$@" 2>&7
> test_must_fail: died by signal 6: git replay --onto=main --ref=refs/heads/bad..ref topic1..topic2
> not ok 46 - --ref must be a valid refname
> #
> #               test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
> #               test_grep "is not a valid refname" err
> #

No need for you to worry about those conflicts. I'm happy to do the
rebase myself.

-- 
Cheers,
Toon
