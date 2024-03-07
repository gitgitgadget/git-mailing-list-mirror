Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF924B33
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845575; cv=none; b=j3vqH+a9h/+Fjl0KjviNQpjTYbCab6h1fYeyJZJu0eoVKueG2FHP0yW+eG4WiJjSo03iMeGuUhJAU0hpeXeX/+lucYlt4QFyQEq8BixZfa09jb2vaxadYwgL1z8qyu5Ul12cRkttbsj4wtcnFT+LGWMCpsjrZCEcBJdE42vPoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845575; c=relaxed/simple;
	bh=vyOjyQwxKuJpHcoMZxY31+Opxq1wtnuYz0XZyiYbPCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4hsEYL8Yb+p43QSRq+fMrGJlUf4yDPNlN2KsQO+xRMiq/6SlUESh/Rj4NFDBL4SgAwY7uFbzo9xrgKFFV/rTyqj+8c/BOK98zaJ/L9gXYbIHluWQuBBB0dlRdVppDfO3BU0Lp9rJsiXBXY6CAzmMH94CWDLVeWqTCEcB9IZcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVIggp3s; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVIggp3s"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 924C21EF833;
	Thu,  7 Mar 2024 16:06:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vyOjyQwxKuJpHcoMZxY31+Opxq1wtnuYz0XZyi
	YbPCs=; b=AVIggp3stNndTl72J7dF89NFysQF8pRpp14+vNeerjSGYziOjn5s3z
	qvNlhy5zH3Nymk7kiI434rZ+b5XgMQrtGSCTXGmQgA0ygJFQrhZKIUkbyIX6Mmjl
	728VG80KiOD8sEYPfEW1nU3k6/tWl7FP37pCb5n0GIpUaf7eQFsvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89B1C1EF832;
	Thu,  7 Mar 2024 16:06:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E93DD1EF831;
	Thu,  7 Mar 2024 16:06:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
In-Reply-To: <Zeopa57o1fMxPoZg@framework> (Patrick Steinhardt's message of
	"Thu, 7 Mar 2024 21:54:03 +0100")
References: <cover.1709549619.git.ps@pks.im>
	<02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
	<6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
	<Zehav4V_8GGZG94Q@tanuki> <xmqqedcntj06.fsf@gitster.g>
	<Zelb8ldHh4Lnlh7Z@tanuki> <xmqqo7bpncrt.fsf@gitster.g>
	<Zeopa57o1fMxPoZg@framework>
Date: Thu, 07 Mar 2024 13:06:10 -0800
Message-ID: <xmqqwmqdkb0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86E2B55C-DCC6-11EE-AB6E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 07, 2024 at 09:59:50AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
> [snip]
>> I sense there might be some clean-up opportunities around here.
>> After all, lockfile is (or at least pretends to be) built on top of
>> tempfile, and it is for more permanent (as opposed to temporary)
>> files, but it somehow wasn't a good fit to wrap new tables in this
>> series?
> ...
> As lockfiles to me are rather about mutually exclusive locking I think
> that using tempfiles directly is preferable. As far as I can see there
> is also no real benefit with lockfiles in our context, except for the
> mode handling. But given that we have "default_permissions" I'd say it
> is preferable to consistently use these for now via chmod(3P).

I wasn't talking about the use of temp or lock API in _this_ series,
but was talking about the different permission bit handling between
the two API.  The loose object codepath that uses the tempfile API
is closer to what you are doing, which suffers from the same "at
creation tempfile API does not bother with permission bits because
it may be removed at the end".  The index codepath that uses the
hold_lock_file_for_update() does not have to care, as it gets the
permission right from the start.

Because of these differences, the loose object codepath has to do
the adjust_perm_bits() itself, and similarly, you have to fix the
permission the same.

These callers may become simpler if we give an option to the
git_mkstemps_mode() to return a file whose permission bits are
already correct from the start.

