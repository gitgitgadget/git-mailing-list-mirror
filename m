Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA176026
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749105; cv=none; b=LDWc+F7bxMK8bwl82K0v6JQCu8b8ZWeVFtpp48WPHK0XcNrx6tjfGo6TLbAFkFcV2/yi70sShG2VWuRCYsxzFa+m/eRhah4hp14LtcXgNqit96XAV5eoTltal/kha9lS1mhu2JZQVFg9TpV/zheNRtDWk0gebWCO8zQiP3MwL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749105; c=relaxed/simple;
	bh=j/ubCQ++y/4aqrcb4Xc6IjHj+m0Qkz9seL/QqQMwxxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEbbSlneVHFWKzi1tUGjTu49Rz2LX5iwVxYw7LoOMMHOrRhkIUeFMmTDy0UYELkUslwHh6reAvbnqNDF68EF7xEfzfIvje4f0109j/Od0YZPvzGc8qvzVK5ESFmoHmsQvJ4/gokOv/Ak2Rk/+bjbO0S85TSP3CtteGjusokDmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j/V5/PrN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j/V5/PrN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AA2E2478E;
	Thu, 15 Aug 2024 15:11:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j/ubCQ++y/4aqrcb4Xc6IjHj+m0Qkz9seL/QqQ
	MwxxE=; b=j/V5/PrNCOAfKcMTPUGi2WEU5NrPFkK3J8bLqDgeXLRZ63CB0F3b3q
	jjPLHqsd/ZYE+XJS59HjGkZvxhTLvJefoPYTekH+LsGpBmUxgOU7B3wKMiiBHyxp
	dwqThBU7ZFYS5Q+MMq2sVhd+rwljQxDB7J+3pmDFW1B5OES0c6ZGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9170B2478D;
	Thu, 15 Aug 2024 15:11:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD2E42478C;
	Thu, 15 Aug 2024 15:11:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  phillip.wood@dunelm.org.uk,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 5/7] builtin/gc: add a `--detach` flag
In-Reply-To: <ca78d3dc7c0270b434ee4ca4ef618212c7dc1d5b.1723712608.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 15 Aug 2024 11:12:43 +0200")
References: <cover.1723533091.git.ps@pks.im> <cover.1723712608.git.ps@pks.im>
	<ca78d3dc7c0270b434ee4ca4ef618212c7dc1d5b.1723712608.git.ps@pks.im>
Date: Thu, 15 Aug 2024 12:11:40 -0700
Message-ID: <xmqq34n5txcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3468583E-5B3A-11EF-A07B-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success '--detach overrides gc.autoDetach=false' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		# Prepare the repository such that git-gc(1) ends up repacking.
> +		test_commit "$(test_oid blob17_1)" &&
> +		test_commit "$(test_oid blob17_2)" &&
> +		git config gc.autodetach false &&
> +		git config gc.auto 2 &&
> +
> +		cat >expect <<-EOF &&
> +		Auto packing the repository in background for optimum performance.
> +		See "git help gc" for manual housekeeping.
> +		EOF
> +		GIT_PROGRESS_DELAY=0 git gc --auto --detach 2>actual &&
> +		test_cmp expect actual
> +	)
> +'

If the gc/maintenance is going to background itself, it is possible
that it still is running, possibly with files under repo/.git/ open
and the process running in repo directory, when the test_when_finished
clean-up trap goes in effect?

I am wondering where this comes from:

  https://github.com/git/git/actions/runs/10408467351/job/28825980833#step:6:2000

where "rm -rf repo" dies with an unusual

  rm: can't remove 'repo/.git': Directory not empty

and my theory is that after "rm -rf" _thinks_ it removed everything
underneath, before it attempts to rmdir("repo/.git"), the repack
process in the background has created a new pack, and "rm -rf" does
not go back and try to create such a new cruft.

The most robust way to work around such a "race" is to wait for the
backgrounded process before cleaning up, or after seeing that the
message we use as a signal that the "gc" has backgrounded itself,
kill that backgrounded process before exiting the test and causing
the clean-up to trigger.

