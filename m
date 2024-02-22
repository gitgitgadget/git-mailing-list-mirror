Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5163154C0D
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622287; cv=none; b=iX1CslJ5voIx/i6DbFrPDQAdQTq438c0FgBKqaUKTpuC104siwWlVV2G9HXwcM0vZPD5PwbV7WBZgsQDZGZKLU7k6BXadLCV2+Wg16Q5uto6fxOgVs8OKK48jlRtI4P8BZBWXfwkFyajztarsi+vWoywiavYc7hyxq3qwnoFNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622287; c=relaxed/simple;
	bh=Zyr/i1tH74enJehLfQ4kAH4sOSlyOL3Lg79FIJiSjm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJDsuxhUWuKlyyOSsxnSj3h6zlFGKXNtJGTfo2TVwlLWuTEVapC6WcJHd1w1RwLWMLS4F9EacM4LWXyCZTiCgvlMmqFmLgAGguZQyLMQolHKSnBSGmG5APE1Y2laIYQYBKwfyZAWI4Vi+nQXnDmfP3SWxzMWZkt4OKOjMsWEhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SHcVSpc3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SHcVSpc3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 392EE19FDA;
	Thu, 22 Feb 2024 12:18:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zyr/i1tH74enJehLfQ4kAH4sOSlyOL3Lg79FIJ
	iSjm0=; b=SHcVSpc3GIq/zb+dvhkBIthQ9zP/bWXJXVUArc9w6LmtiruqVOSnic
	f0Kwmx255MWw6o2Yy6yN9XfOnazBdKtjxiNgRTr9+WwnpW+jLbeDmKksKpA9GcCj
	JQNKwV8fRduGm9vc+wcgr1485pWwiDGvF4f84N1AH1Kl9RK+G0nQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 32F4E19FD9;
	Thu, 22 Feb 2024 12:18:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB48519FD6;
	Thu, 22 Feb 2024 12:18:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/5] merge-ort: do check `parse_tree()`'s return value
In-Reply-To: <f01f4eb011b400faeff1c33934775a521dec7a3d.1708612605.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	14:36:42 +0000")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<f01f4eb011b400faeff1c33934775a521dec7a3d.1708612605.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 09:18:00 -0800
Message-ID: <xmqqy1bcfmev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 551D8126-D1A6-11EE-8D0B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This change is not accompanied by a regression test because the code in
> question is only reached at the `checkout` stage, i.e. after the merge
> has happened (and therefore the tree objects could only be missing if
> the disk had gone bad in that short time window, or something similarly
> tricky to recreate in the test suite).

Makes sense.

A complete tangent I wonder is if unit-test-minded folks have clever
ideas to allow better test coverage, perhaps injecting a failure on
demand to any codepath (in this case, the codepath to write the
resulting tree) to simulate a situation where we fail to parse the
tree.

In any case, the patch looks good, of course, and I see no need for
further comments.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-ort.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index c37fc035f13..79d9e18f63d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4379,9 +4379,11 @@ static int checkout(struct merge_options *opt,
>  	unpack_opts.verbose_update = (opt->verbosity > 2);
>  	unpack_opts.fn = twoway_merge;
>  	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
> -	parse_tree(prev);
> +	if (parse_tree(prev) < 0)
> +		return -1;
>  	init_tree_desc(&trees[0], prev->buffer, prev->size);
> -	parse_tree(next);
> +	if (parse_tree(next) < 0)
> +		return -1;
>  	init_tree_desc(&trees[1], next->buffer, next->size);
>  
>  	ret = unpack_trees(2, trees, &unpack_opts);
