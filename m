Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED431DDDA
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292808; cv=none; b=jlp4UvTQPBiXGgCUKF2X8aiT9ByesEpHH79uUQgor1kjAD9sjPDGPunX+WjOt0RCZbFNkgDkc9WG08tldzcCr+87GO4ywkExyttJfjTFn9nz16zeYfLhNE5aT7OJ55slKvH7DkimlFJ2AHMDcAebEpK8+QWSgnlJB6AXChSdnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292808; c=relaxed/simple;
	bh=lpp+M8DKx9WRR0+vS1EfxpKuY1SS1tAQJHBrrG8+yHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S+N9oQ7ug0Syi0CdjGzAfA3ByBQ+lAxT8U5E+MVb0JKGw6fFlaLtAF5U4rnWrlXsldIZj9n9NaV5vwV+QbuR5gBvv8WPZE8w4OjG1J+qoioTpOoL60Frfe88j9bOTrDIhy3T8HMEn59AXsXSENrFo8Jvlj3OgbuD9uSKGvR1HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jkF6Ywe/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jkF6Ywe/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EA5F1C91D7;
	Fri, 26 Jan 2024 13:13:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lpp+M8DKx9WRR0+vS1EfxpKuY1SS1tAQJHBrrG
	8+yHY=; b=jkF6Ywe/+OY/u/TR7b96KuGm7eAg2/Gm2Orgecj2p2B5cFHcEXTwUv
	w8h4Gjcox9yuRZ8s/BJQUxbt1eTsvH7JjTC+1XWd2mvsQydJY8EWC5vZpDfNS7fK
	UQfs689BDBipTRFG+wPCyNUuu50CpQQbpznIyHreZe5ztam3cOwy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 964351C91D6;
	Fri, 26 Jan 2024 13:13:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 071631C91D5;
	Fri, 26 Jan 2024 13:13:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
In-Reply-To: <cce63c6465fb1e29252d7e0918e03ff0f08d37f4.1706289180.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Fri, 26 Jan 2024 17:13:00
	+0000")
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<cce63c6465fb1e29252d7e0918e03ff0f08d37f4.1706289180.git.gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 10:13:22 -0800
Message-ID: <xmqqwmrwm08t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 982F06F0-BC76-11EE-B933-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--fsck-objects[=<msg-ids>=<severity>...]::
> +	Instructs index-pack to check for broken objects, but unlike `--strict`,
> +	does not choke on broken links. If `<msg-ids>` is passed, it should be
> +	a comma-separated list of `<msg-id>=<severity>` where `<msg-id>` and
> +	`<severity>` are used to change the severity of `fsck` errors e.g.,
> +	`--strict="missingEmail=ignore,badTagName=ignore"`. See the entry for

In addition to the comment I made in my reply to 1/2, this should
be `--fsck-objects="missingEmail=ignore,badTagName=ignore"`, I
think.  Will treak locally.

Thanks.
