Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD814B09C
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158144; cv=none; b=kblIM1n2Dgj1Y0MpAPy2Z9mUSifjY8uvW6fhQCf3zgineCTcX+mubWZLfH8gXJexI0wYHc7KO++z077uLpeDGjwymWdS0JsUy/TKpcbPfEKTesWFhVtsOF3h40wYHhwoSXhvAU1KeFEw5n4T772UaNLlbmenSblZTETwSfWoyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158144; c=relaxed/simple;
	bh=lXSlGiANIfpO/lOnFlJKLbw3J1dpqsisL1slpcBW7cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmqVCo5kTcK/quXcyIjWuTo3bnspT59JRuzrTQi+EfebDT1+fz3Wk9OxzCdBMwa1x6XZDt2tkRBhmDWwoiwlzdPqw3F89eQo3p2dS1RZvAPAwZrO1G453VlzGHTm4K50MMYrcuPkV0myeyYYR8qrbgeP+hh77IDHI8SdfcEmX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l6hk3LxU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l6hk3LxU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D83033913;
	Thu, 12 Sep 2024 12:22:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lXSlGiANIfpO/lOnFlJKLbw3J1dpqsisL1slpc
	BW7cw=; b=l6hk3LxUdgbkaJ3r+RDvRThJZCC50CKkEVH+m4DWOxOYHnDwgvmlHz
	iRPsF1VW4XMqxT6NUQM163AKSwP2NwTqq+yuDaCWSTGZZRhG8J1NL+OHCsdXP6Pi
	20ohLZL8v4CzYJTSV6n18pnWXuuVR1pGi9sIv0NVJu4EU7IREBQs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 752B333912;
	Thu, 12 Sep 2024 12:22:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF5E433911;
	Thu, 12 Sep 2024 12:22:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
In-Reply-To: <ZuK8yihccDjgQGZV@pks.im> (Patrick Steinhardt's message of "Thu,
	12 Sep 2024 12:04:58 +0200")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
	<xmqqseu56hhb.fsf@gitster.g> <ZuK8yihccDjgQGZV@pks.im>
Date: Thu, 12 Sep 2024 09:22:13 -0700
Message-ID: <xmqqplp84zbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C0DFC1C-7123-11EF-AE76-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I don't think we want to return the error code from `error()`, do we?
> `set_branches()` is wired up as a subcommand, so we'd ultimately do
> `exit(-1)` instead of `exit(1)` if we returned the `error()` code here.

Hmph, I thought there was somebody doing !! to canonicalize the
return value to exit status in the call chain.

	... goes and looks again ...

After finding the subcommand in fn, cmd_remote() ends with

	if (fn) {
		return !!fn(argc, argv, prefix);
	} else {
		...
		return !!show_all();
	}


