Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229520B81C
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950453; cv=none; b=Y8km/9BRRxk1/t992H7QXWwK11+VdLTeSAh7IvFzSE5YE/lIGUk8dndDJoCJ802s/KYdmWWLZPwChiTzYn5m0Dao6MSqJT6upQVIJQpuOkzm8PC+hyc1k6KDZVGZKnY+gOSUGfp0O6sIcVkAspO1jdGd0ky9qEIQHH/fdzFaaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950453; c=relaxed/simple;
	bh=WSDLAknzCshpq++TXEbubxmo6SxlCJiepXxiQGP8XEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZlsuvQrp5X/zOideYkN0WWJINElNvsNoPCneRKsrJvLwhlzDLlHYDRxc41lC3DtBe7tF+UCXYOd7WVhafIs38HkHi+4cQGo5vVLBEmmpo3y5U5SvfymLmRsvcSCWsowBQ+VQMMhCDd7LR+LNdqPZSen2T+tgeMZjgHEzqFA6gQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4NtcQJVO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4NtcQJVO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1733950447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBs7yExoGESxMG9gGc2AAQsMCciYkvJX2C8JId1DtzE=;
	b=4NtcQJVOtZbCrfblO5esw9A1ExsiqB8sVUUiMmz0I9C+zqq21p4zqTDts4lvuz/LcGv3lG
	bAfhUhmtIMntwzCTz5lMAsj++zxJYFwDJ082oVhxmgXXBn46+cDSkugbD/EofEjQnRxZuB
	TaasjR6B22N3KNtmkKpKT/cCzbFPccg=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] bundle: remove unneeded code
In-Reply-To: <xmqqcyhyi7g7.fsf@gitster.g>
References: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
 <xmqqcyhyi7g7.fsf@gitster.g>
Date: Wed, 11 Dec 2024 21:53:57 +0100
Message-ID: <87y10mhrfe.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> expecting success of 6020.17 'clone from full bundle upto annotated tag':
>         git clone --mirror v2.bdl tag-clone.git &&
>         git -C tag-clone.git show-ref |
>                 make_user_friendly_and_stable_output >actual &&
>         cat >expect <<-\EOF &&
>         <TAG-2> refs/tags/v2
>         EOF
>         false &&
>         test_cmp expect actual
>
> Cloning into bare repository 'tag-clone.git'...
> Receiving objects: 100% (35/35), done.
> Resolving deltas: 100% (6/6), done.
> not ok 17 - clone from full bundle upto annotated tag
> #
> #               git clone --mirror v2.bdl tag-clone.git &&
> #               git -C tag-clone.git show-ref |
> #                       make_user_friendly_and_stable_output >actual &&
> #               cat >expect <<-\EOF &&
> #               <TAG-2> refs/tags/v2
> #               EOF
> #               false &&
> #               test_cmp expect actual
> #
> 1..17
>
> What's the "false" doing here?

I'm terribly sorry, how sloppy of me. I added that during debugging to
be able to inspect the t/trash* directory. This shouldn't have made it
to the final patch. My apologies, I've submitted v3 which doesn't
include that line.

--
Toon
