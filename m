Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED41E4841
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611622; cv=none; b=ft/n3qZEiUpRNn1ISRQ+t7YEfvx3ykWv0OC3XH8G5PMKHanwefA/2KEH0SXdxaHfiTpFeFvVk+ixSzMIB4Trmu8sOAxugFkCToI+a+Hkuu09+2LWxi6fZuc+2iIEeYiBWuAs8Ckg0Q9OrfuUdXHCjI0GBL+PFq9/g8Rs7SYFPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611622; c=relaxed/simple;
	bh=7xwy/GanYSpWQApjmx74XATvkUHipFUenojp2/yhFrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihHz8oCOu4N6nGD1OIjqS9hbDmkQnBGg/rP0a0x64CcPx0+s5GCxdbK6t2nSMExx0ka3NVy3UPljndbVH7/ZAkoT3bAP+Vd/aOJ3mx5pTyMW0T9mpNuChdegs6YQdsJWtWu193DNdLL1S5pCtmsU1fwsiPty3yTni76/uKmh8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZQ2/+SyI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQ2/+SyI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BACE26576;
	Fri,  2 Aug 2024 11:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7xwy/GanYSpWQApjmx74XATvkUHipFUenojp2/
	yhFrg=; b=ZQ2/+SyIF7wRpc2paTzAqOouwNUsFrmn/HXfTYDLiQLdpkld/fd4tU
	iKHj9hbdxFf9t74cu/iE71a8ZY1txuEj2nYJYHCKpCWwhzte/irq0NfePlYtvi6t
	Kvihmt1eMN946vPKLp1M82kyB+0IuVAzHxY5DPEOXNUy0PAav2gXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 848B426575;
	Fri,  2 Aug 2024 11:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8B9226574;
	Fri,  2 Aug 2024 11:13:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 3/3] t6421: fix test to work when repo dir contains d0
In-Reply-To: <6c08b8ceb2b87671a3e57c09e4e45170eaac37fc.1722571853.git.gitgitgadget@gmail.com>
	(Kyle Lippincott via GitGitGadget's message of "Fri, 02 Aug 2024
	04:10:53 +0000")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<6c08b8ceb2b87671a3e57c09e4e45170eaac37fc.1722571853.git.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 08:13:37 -0700
Message-ID: <xmqqplqrez4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBD9CB02-50E1-11EF-A453-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> The `grep` statement in this test looks for `d0.*<string>`, attempting
> to filter to only show lines that had tabular output where the 2nd
> column had `d0` and the final column had a substring of
> [`git -c `]`fetch.negotiationAlgorithm`. These lines also have
> `child_start` in the 4th column, but this isn't part of the condition.
>
> A subsequent line will have `d1` in the 2nd column, `start` in the 4th
> column, and `/path/to/git/git -c fetch.negotiationAlgorihm` in the final
> column. If `/path/to/git/git` contains the substring `d0`, then this
> line is included by `grep` as well as the desired line, leading to an
> effective doubling of the number of lines, and test failures.
>
> Tighten the grep expression to require `d0` to be surrounded by spaces,
> and to have the `child_start` label.

Makes sense.

Updating the comment with expected shape of the output might make it
even less likely that we'd break these fixes again by mistake.

Thanks.

> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>  t/t6421-merge-partial-clone.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
> index 711b709e755..0f312ac93dc 100755
> --- a/t/t6421-merge-partial-clone.sh
> +++ b/t/t6421-merge-partial-clone.sh
> @@ -231,7 +231,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded for single relev
>  		test_cmp expect actual &&
>  
>  		# Check the number of fetch commands exec-ed
> -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
> +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
>  		test_line_count = 2 fetches &&
>  
>  		git rev-list --objects --all --missing=print |
> @@ -319,7 +319,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
>  		test_cmp expect actual &&
>  
>  		# Check the number of fetch commands exec-ed
> -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
> +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
>  		test_line_count = 1 fetches &&
>  
>  		git rev-list --objects --all --missing=print |
> @@ -423,7 +423,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded with lots of ren
>  		test_cmp expect actual &&
>  
>  		# Check the number of fetch commands exec-ed
> -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
> +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
>  		test_line_count = 4 fetches &&
>  
>  		git rev-list --objects --all --missing=print |
