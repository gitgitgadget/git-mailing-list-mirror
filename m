Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FF14D43A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893711; cv=none; b=oEM+l44w1gbhLOhmUdrRWxdxRSxXjpKF2nDVW0xYe5u7oDb5hZi7D+IkxQiMTJd/fxGWePXDPrFW9xsp7cvhz7lq2k+sb6HjaI3HWSJcnniaLqP5rJXvw/+Rv4yunV/Vu94JwDiTvegBYdjRFYO495B55jcWwfjhztJGk0B54rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893711; c=relaxed/simple;
	bh=rrhdJH5I04X76FcMVEMmbEsg3d63YppmSKRnX/7KugM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddtnDHic60sBfUsKLljVJRbRQIhqSnrkAgOAPbXH8CTG3nbtxg2HIeWiTFdDhCZH1dWEFhfE6EHNVJ/gcHpcVAkZ1ABxs+fVzCtYovGQI+eL4RWzA6AGdo48m7NPG3Vt5fvHCXmJpFxEP2UVfSGCIxQQjChQUqQEuNQBEOL0I5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ba2vym3Y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ba2vym3Y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 278741C2499;
	Fri,  2 Feb 2024 12:08:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rrhdJH5I04X76FcMVEMmbEsg3d63YppmSKRnX/
	7KugM=; b=Ba2vym3Y2EG67holip3ymz3sSAR3myqplrJ8N7V/cUcz2jf4JXUSjS
	YBuNCqrgZSGsqBiZtOBWMCgEnCPKqlDYBQwnK27htF4Nvj+bM2e8Q41J1H8gaIS0
	bvOdVLIMU5sR4a4zddp/73E1G8YdBRH9Ue4TzV3P3Kov8DYLErBcA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FA1D1C2498;
	Fri,  2 Feb 2024 12:08:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 849541C2497;
	Fri,  2 Feb 2024 12:08:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/2] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <20240202150434.11256-3-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 2 Feb 2024 20:33:50 +0530")
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
	<20240202150434.11256-1-shyamthakkar001@gmail.com>
	<20240202150434.11256-3-shyamthakkar001@gmail.com>
Date: Fri, 02 Feb 2024 09:08:17 -0800
Message-ID: <xmqqh6iqu73y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9395C44-C1ED-11EE-804F-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Currently, (checkout, reset, restore) commands correctly take '@' as a
> synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@' and
> 'HEAD', different prompts/messages are given by the commands mentioned
> above. This is due to the literal and only string comparison with the word
> 'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
> desired, especially since '@' already resolves to 'HEAD'.
>
> Therefore, make a new function user_meant_head() which takes the
> revision string and compares it to 'HEAD' as well as '@'. However, in
> builtin/checkout.c, there is some logic to convert all revs besides
> 'HEAD' to hex revs due to 'diff-index', which is used in patch mode
> machinery, not being able to handle '<a>...<b>' revs. Therefore, in
> addition to 'HEAD', do not convert '@' as well, so it can be later
> used in assigning patch_mode_(...)_head.

In this context <a>...<b> names a single rev (not two revs) that is
the merge base of <a> and <b>.  Perhaps

    ... there is a logic to convert all command line input rev to
    the raw object name for underlying machinery (e.g., diff-index)
    that does not recognize the <a>...<b> notation, but we'd need to
    leave "HEAD" intact.  Now we need to teach that "@" is a synonym
    to "HEAD" to that code, too.

which may be a bit shorter.

You decided to use is_rev_head() instead of user_meant_head(), so
you'd need to update the above description to match, I think.

> -		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
> +		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
> +		    strcmp(rev, "@"))

Shouldn't this be

		if (rev && new_branch_info->commit && !is_rev_head(rev))

instead of "HEAD" and "@" spelled out?

Other than the above, nicely done.
