Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475D190465
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425683; cv=none; b=dZZWlPSXZCPNjmkQH942HkHBaEu2XofBLtPx6G5G3dCF5Hxb6gKVP0ulSCu+H/jt5yk79eZzhWJlCGtdwcFCK2Ttxo3H20whg7iHfqpGGBRQBBZbO/WDMbH1rGmtHJkGDgzo+q0zFTHtBT/iNbPo3NVW4LMNkXnhH59mrsSWUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425683; c=relaxed/simple;
	bh=h60cYLSTbFu0L6u9rFcRbzUfe2AZ5mP087teFgG2DVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdFm52OaMPmsxbOGvDmQlqZoKuOvyEYDtlzDImYJyd5hRS5b6WAe0rKIGH+JiYJs4gXRNUKKYN/DWHM5bMAC/Vp0oM0MsKqVpGx7a2wuE/g2RSfoo9w30c8owSGW5ZR+5k20oVExgCuOvT+FfqhhxTSogMbgEuxy7UqlT6hopvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHSUR+MU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHSUR+MU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E70630207;
	Wed, 26 Jun 2024 14:14:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h60cYLSTbFu0L6u9rFcRbzUfe2AZ5mP087teFg
	G2DVc=; b=jHSUR+MU3rXtJv12cAoKklnRs7MN0ePHu1C8dRQNspQgKrc6LwKpkC
	zu/UHlNwZ55OEpu/m8ttPA7WbLW2sVQpOCmed1rYvmdRqu07tK+4E2bPu6axahX5
	UPf7D8Dfz3gh9OIMzyb+4Z0jc3SLx/WD6CVmiBtNBaOBufY206l5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 170E030206;
	Wed, 26 Jun 2024 14:14:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8282230205;
	Wed, 26 Jun 2024 14:14:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>,  "David C. Rankin" <drankinatty@gmail.com>,
  git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com> (Phillip Wood's
	message of "Wed, 26 Jun 2024 14:03:33 +0100")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
	<xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
	<20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
	<20240625183411.GW19642@kitsune.suse.cz>
	<834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>
Date: Wed, 26 Jun 2024 11:14:39 -0700
Message-ID: <xmqq34oz1shc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F492E77A-33E7-11EF-AD75-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... What is happening is that
> git-daemon checks that the repository path is listed as safe and then
> changes into that directory and forks
>
> 	git upload-pack --strict .
>
> "git upload-pack" then checks "." against the list of safe directories
> which fails. It fails because the safe directory check does not do any
> normalization such as cleaning up "//" elements (as seen in your
> example) or expanding relative paths on $git_dir before checking it
> against the list of safe directories.
> ...
> I think the fix is probably to make the safe directory check use the
> absolute path of $git_dir. In the mean time there is a workaround if
> you're happy to add "." to the list of safe directories.

It still is curious why unnormalized "." does not pass "*" (which is
not even a pattern matching, but is a declaration that says "don't
bother which path we are talking about"), though.  As long as the
value of that configuration is found to be '*' literally, safe
directory data is marked as "is_safe" (cf. setup.c:safe_directory_cb
and setup.c:ensure_valid_ownership; notice that data.path is not
even consulted if the value of the configuration variable is '*').

Anyway, thanks for digging.

