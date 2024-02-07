Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA698F55
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267970; cv=none; b=paD3SBmFuY+VcT4hm327ZV+i1uFwmXyBAD49a72xLb6wOWUvux0gW9kFAGG8IDUbWcIydFlsIvCoRTzvkagpPjChZw7pYl+A5kZjGgII3IaSdSmDVTLO7GlQx2XG2Tu5mnicSrAxrv5VGbC1rQ5NrEhKBLOKvwxjTpoOXlY39Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267970; c=relaxed/simple;
	bh=c1Yx3SKxTt/bK/bpUt8Uo2XM4FWuaL4G/587sL1td0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NqGS5etNTqoEJderslC7VKS8QDJijHRbWxHWxK8eYK4tHQK+XL7lWTECfFUJkal+cJZsXSKzPvg048d4AVDTAjtIy9fEw2bcP/6HCYn3MzfFSjnKCeKG0mNt+SKkDiGOgttFFvIzYeEw06Mhir7E/yjRXv58GlJMPTjINvtRzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FcgzN40u; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FcgzN40u"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BFAE11D0511;
	Tue,  6 Feb 2024 20:05:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c1Yx3SKxTt/bK/bpUt8Uo2XM4FWuaL4G/587sL
	1td0o=; b=FcgzN40uXz5aHw2qtIdVj5Yc4zBrYxqqqjVUNqO0QgMGrP2DbrdBW5
	rvuWAx9zu+L7gn5dX6Mp13yeNwO1P69RZLCnE3JsmfrIrouq+c4sf7rhFqzLgeci
	fDn3u73Sud/IDn60AmxVrCEM8ALa8yCP4SE3CTCUpDa8EDbuYzkg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B68FD1D050E;
	Tue,  6 Feb 2024 20:05:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04C561D050B;
	Tue,  6 Feb 2024 20:05:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [PATCH v4 2/3] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <20240206225122.1095766-6-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 7 Feb 2024 04:20:38 +0530")
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
	<20240206225122.1095766-6-shyamthakkar001@gmail.com>
Date: Tue, 06 Feb 2024 17:05:57 -0800
Message-ID: <xmqqil31dqx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0DDB11DC-C555-11EE-9924-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Currently, (checkout, reset, restore) commands correctly take '@' as a
> synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@'
> and 'HEAD', different prompts/messages are given by the commands
> mentioned above (because of applying reverse mode(-R) in case of '@').
> This is due to the literal and only string comparison with the word
> 'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
> desired, especially since '@' already resolves to 'HEAD'.
>
> Therefore, replace '@' to 'HEAD' at the beginning of
> add-patch.c:run_add_p().

Of course there is only one possible downside for this approach, in
that if we are using "revision" in an error message, users who asked
for "@" may complain when an error message says "HEAD" in it.  I think
the simplicity of the implementation far outweighs this downside.

> There is also logic in builtin/checkout.c to
> convert all command line input rev to the raw object name for underlying
> machinery (e.g., diff-index) that does not recognize the <a>...<b>
> notation, but we'd need to leave 'HEAD' intact. Now we need to teach
> that '@' is a synonym to 'HEAD' to that code and leave '@' intact, too.

Makes me wonder why we cannot use the same "normalize @ to HEAD
upfront" approach here, though?

It would involve translating "@" given to new_branch_info->name to
"HEAD" early, possibly in setup_new_branch_info_and_source_tree(),
and that probably will fix the other strcmp() with "HEAD" that
appears in builtin/checkout.c:update_refs_for_switch() as well, no?

> +	/* helpful in deciding the patch mode ahead */
> +	if(revision && !strcmp(revision, "@"))
> +		revision = "HEAD";

Style.  "if (revision ...)"
