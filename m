Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602044963A
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896700; cv=none; b=oNvXSBH/lGRDmIzJ10K3PJ14LUs4qiijKC5o+CMczFXEsjyu7WKJ0d2oyWbPo+bMezZ8PFliE565CVEK09CKRg2Bs7Nb9fRgN3TgWkBkjQmE+GS0NYdhUPEPuJBHo2Q+Xi0fznhhYPTqzoo1aXLystZDTA0LSVmMV7sCksb3eB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896700; c=relaxed/simple;
	bh=z5NC1s+n3985BxwKIwq7L1lC3ZO08yWKCg/cflxbZl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KdVnl70HXrcmgyNHMaF565cfPfPp2GOu7mrzx7wLvIe6A5X+uWJhd+n73Su9pUDTvJJrh8pWehP9NbuQqf+jh4/Oqh4Ij8c3fsVJq7FbRmbz2PRObIT1W3t4Fc7G+0wVvVhQURR3ySZ/mbQPInjNOw36Y3dWIdkCKmq6gcTkz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gYKKSZzb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gYKKSZzb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9DB273B4;
	Mon,  9 Sep 2024 11:44:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z5NC1s+n3985BxwKIwq7L1lC3ZO08yWKCg/cfl
	xbZl4=; b=gYKKSZzbkpn4PCLXP4/ZgrWgg0qs/5TErBz+Kv2iWJAKYMV1Rm91QI
	ksf8vVYTZA6VnhRTxCP0jW7IW7cxXKvqW06Ib1cV5H1O6uY5liDB+m1BJGCIXaKp
	5URAImC9kzhKQV4qwt7VuAt4nTtWfcm7GY5xVr0uMcXBzoMTPBQp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 26582273B1;
	Mon,  9 Sep 2024 11:44:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68911273B0;
	Mon,  9 Sep 2024 11:44:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin" <bupt_xingxin@163.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Xing Xin via GitGitGadget"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Brandon Williams"
 <bmwill@google.com>,  "Jonathan Tan" <jonathantanmy@google.com>,  "Xing
 Xin" <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 3/4] builtin/clone.c: recognize fetch.serverOption
 configuration
In-Reply-To: <3a7b1ced.364e.191d4b07a1a.Coremail.bupt_xingxin@163.com> (Xing
	Xin's message of "Mon, 9 Sep 2024 10:50:21 +0800 (CST)")
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
	<ZtbgafDQwbU9tBoq@pks.im>
	<366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
	<ZtmQZQHnwYLNvT0F@pks.im>
	<3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>
	<Ztm1w_61vjEkiC4C@pks.im>
	<3a7b1ced.364e.191d4b07a1a.Coremail.bupt_xingxin@163.com>
Date: Mon, 09 Sep 2024 08:44:55 -0700
Message-ID: <xmqq7cbkvnk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 769CF994-6EC2-11EF-8AA3-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Xing Xin" <bupt_xingxin@163.com> writes:

> Given the addition of a remote.*.<subkey> configuration in Git's global
> settings, such as:
>
>     git config --global remote."*".demoConfigKey demoConfigValue
>
> The current versions of Git may produce errors with certain commands.
> For example, running `git fetch --all` will result in:
>
>     $ git fetch --all
>     Fetching *
>     fatal: '*' does not appear to be a git repository
>     fatal: Could not read from remote repository.

Ah, good point.  Anything that wants to enumerate the subkeys under
remote. hierarchy MUST be aware of the new convention.

So such a code must of course need to be updated to treat "*" as a
virtual thing and exclude from enumeration (I suspect "git remote"
has the same property), and delivered to the end-users at the same
time.

An alternative is to use remote.<key> as a fallback default for
remote.<name>.<key>, which has been done successfully for other
hierarchies like http.<url>.<key> would override http.<key> for any
defined <key>s.  So if we have remote.<name>.skipFetchAll per
remote, we could use remote.skipFetchAll as its fallback default
value.
