Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91974400
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436770; cv=none; b=B+6AenQuKkkUOTXsYpU8BHrufKPfVwAybsLgRLcIv7UBS2+Fs2JZ9l/3qanpYvrM78u0oYvApvVYZ3fQXwBwfmtSHps9rp92d11mLeL1SYkYIP+by/vSuuqt1nrT4JKBPDL0IDBVFWENn1BAF2qe5MLQBBti8Ng+KVFiRTln5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436770; c=relaxed/simple;
	bh=IQMQqBwtDvcUv0kQAQ1y3jKa+pIZ2Tf26Rwc0Agt/rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvTteA5pJkioa3SVu0ntKxg5LhmrW44bzKYxxDut6T1pOLxIid8APWsRXIrMJSH4NVI2CIigDlso91wSnFfU0dcHBP4Olv+4vqtcQxNTYWSWACe5ND8cXMosOoAyuKSLeSwyhnVSBPXWhJbPpx75GHbKXKvr1fRTdJHTFB6dz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pkKTzdo0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pkKTzdo0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C8852335D;
	Thu, 14 Mar 2024 13:19:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IQMQqBwtDvcUv0kQAQ1y3jKa+pIZ2Tf26Rwc0A
	gt/rQ=; b=pkKTzdo0UbY6xwiZY2mzS1OFii1JwgS9ghajGqQsEu7tMlVFqd8FAk
	rxQQ07vXqKr9C2HdlNivTXWhZbO4F/8/1taKIlfRxPV1BCl7q00Da2dxvg/s8uaz
	au70c6y3yCjdQdedKzQfcDpJ9fPXnAnAJt7M4EblF9MQNI9/B/XSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 14FCA2335C;
	Thu, 14 Mar 2024 13:19:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF5922335A;
	Thu, 14 Mar 2024 13:19:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] xdiff-interface: refactor parsing of
 merge.conflictstyle
In-Reply-To: <629e577879c550aafffeb0f75a64c9a2a95df512.1710435907.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Thu, 14 Mar 2024 17:05:03
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
	<629e577879c550aafffeb0f75a64c9a2a95df512.1710435907.git.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 10:19:23 -0700
Message-ID: <xmqqwmq4vihw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 013B77AC-E227-11EE-AA00-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Factor out the code that parses of conflict style name so it can be
> reused in a later commit that wants to parse the name given on the
> command line.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff-interface.c | 29 ++++++++++++++++++-----------
>  xdiff-interface.h |  1 +
>  2 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 3162f517434..16ed8ac4928 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -305,6 +305,22 @@ int xdiff_compare_lines(const char *l1, long s1,
>  	return xdl_recmatch(l1, s1, l2, s2, flags);
>  }
>  
> +int parse_conflict_style_name(const char *value)
> +{
> +	if (!strcmp(value, "diff3"))
> +		return XDL_MERGE_DIFF3;
> +	else if (!strcmp(value, "zdiff3"))
> +		return XDL_MERGE_ZEALOUS_DIFF3;
> +	else if (!strcmp(value, "merge"))
> +		return 0;
> +	/*
> +	 * Please update _git_checkout() in git-completion.bash when
> +	 * you add new merge config
> +	 */
> +	else
> +		return -1;
> +}

As these symbols are now more public, it is tempting to leave a
#leftoverbits mark to remind us to clean them up by adding
XDL_MERGE_MERGE (instead of 0) and XDL_MERGE_UNKNOWN (instead of -1)
after the dust settles.  That would have made reading later patches
in the series a little less puzzling.

But within the scope of this series, the above is perfect, faithful
refactoring of the original.
