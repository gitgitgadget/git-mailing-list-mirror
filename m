Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396EE1D131A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265489; cv=none; b=oRcjeaB09lNs/F1j55R1bmsnM4dCouEGVgQip9uppcZ7mmghQVvy727I/9KpXyVzW/6iqhdjWy9rU6ruGS3oOVOVW8brWWwQ09PNV1VJzzhOjWvs1H3iW/yRJJbihbQ+7cbfFHG51YxDPWVgrLvxbiwQvsKYX8C2Dox1P37pekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265489; c=relaxed/simple;
	bh=JCEJgCKvaCqTzCV9q9fKS5PyhC+2ZGcEvVZlAqZXuSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cDb7vklRcCfdb+cmyXPVhnaE5u8McuCT4hu0LQBFOT+qKBZ3CA4Q4KrA9lrOcUprdQb41OwCVlAoa2g6HaU2hWNvjVaW6F3mV0NLkjqdJNn4Ni8Yxr3Zckh5AFWNLYiG+a6VzTJJJ+NNPmr9NgqDIi2viYLh4txFGjS0OzVg3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRYfM2t7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRYfM2t7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A859236BE9;
	Wed, 21 Aug 2024 14:38:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JCEJgCKvaCqTzCV9q9fKS5PyhC+2ZGcEvVZlAq
	ZXuSQ=; b=CRYfM2t7Pd7TVz6nSB+NATDFoJZhc9cTc0tgsKUnMbGPEznJK7eFVU
	ZpDWXFTReSMV6xSsfVg4bL6DqYIJ+pMaGXsKTh2n3cH5Vnw2qqCN1jrLx4fNeR1c
	yCmPcCN8w6YusHIV1JKGKONiLf7aHRxjyfm9euivwdDocr+Th7rCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A10A836BE8;
	Wed, 21 Aug 2024 14:38:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30D4F36BE5;
	Wed, 21 Aug 2024 14:38:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,  James Liu
 <james@jamesliu.io>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] t7900: exercise detaching via trace2 regions
In-Reply-To: <ZsMIxmX2Ash9YtEU@tanuki> (Patrick Steinhardt's message of "Mon,
	19 Aug 2024 10:56:38 +0200")
References: <ZsLjcjhgI8Wk2tIV@tanuki> <cover.1724053639.git.ps@pks.im>
	<9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
	<20240819085105.GC2955268@coredump.intra.peff.net>
	<ZsMIxmX2Ash9YtEU@tanuki>
Date: Wed, 21 Aug 2024 11:38:02 -0700
Message-ID: <xmqqfrqxyb5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 805B461E-5FEC-11EF-A6AA-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> ...I think this "we have no better way..." comment is now out of date
>> (and can probably just be dropped).
>
> Oops, yes, that one is definitely stale. I'll drop it in the next
> version of this patch series.

I am not sure if there is a need for "the next version"; in the
meantime, let me do this.  I'd prefer to merge the main topic down
to 'master' soonish.

Thanks.

1:  759b453f9f = 1:  759b453f9f t7900: fix flaky test due to leaking background job
2:  b64db3e437 ! 2:  51a0b8a2a7 t7900: exercise detaching via trace2 regions
    @@ Commit message
         do not have the ability to daemonize.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +    [jc: dropped a stale in-code comment from a test]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/gc.c ##
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
     
      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success '--no-detach causes maintenance to not run in background' '
    - 		# We have no better way to check whether or not the task ran in
    - 		# the background than to verify whether it output anything. The
    - 		# next testcase checks the reverse, making this somewhat safer.
    + 		git config set maintenance.loose-objects.auto 1 &&
    + 		git config set maintenance.incremental-repack.enabled true &&
    + 
    +-		# We have no better way to check whether or not the task ran in
    +-		# the background than to verify whether it output anything. The
    +-		# next testcase checks the reverse, making this somewhat safer.
     -		git maintenance run --no-detach >out 2>&1 &&
     -		test_line_count = 1 out
     +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
3:  eac44feff3 = 3:  8311e3b551 builtin/maintenance: fix loose objects task emitting pack hash
