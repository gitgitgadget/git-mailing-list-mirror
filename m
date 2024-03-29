Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190E1E862
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749373; cv=none; b=kW2fR1InqMsno8qRFbOWYWZfTpfwdJ4IcqJi4tBOh/wqchskard3OEuDq+bVMVJUXKyzOCeP4FcOmNk4/o93Ltc1/UvNnOLqJzAcBAUn2INoVZXZw9bv9wAREMB/aBJEqpe2qHFA2hLkdry7jcLcNFVZbqHQNkhJBHj/PNaNLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749373; c=relaxed/simple;
	bh=wLMjsyjQtLuiXo7OT7KRalyeZnSLIfmmeBB20/aJ9hQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qNBcj7xqdnPd93TTGJRiVEqXAOTjvRxxa8mQ5ieuGhcL7shAurWgJjUYv3Ehi5fgutBUMHehZrKi5v3J12IhRuAHpqP2xkvJGtifLfOaArNrEFBKSTHYHGDnEFNS/BAduQ1B9rWbRqMWc867X+NW5ch1aP1Fe09uNnXe8oLpFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHl4A664; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHl4A664"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15FA41F5AC9;
	Fri, 29 Mar 2024 17:56:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wLMjsyjQtLuiXo7OT7KRalyeZnSLIfmmeBB20/
	aJ9hQ=; b=gHl4A6641dM2rj1QQEHwqkdTal67MkJa2qr+cqsHRGP6oLEfJU/e0w
	+id5xctGfHi/Y+sUJGMzq+xWFBl+/fncCV163nR7CFhak+CBnaZjOOs/1wx10fTI
	NK2Ct96Pg1GkyjoIPp/oAUSyToFIwZj98GyZJKs0nXIjCqARm8rq8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CA531F5AC7;
	Fri, 29 Mar 2024 17:56:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 740E41F5AC6;
	Fri, 29 Mar 2024 17:56:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/3] reftable/stack: add env to disable autocompaction
In-Reply-To: <2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
	(Justin Tobler via GitGitGadget's message of "Fri, 29 Mar 2024
	04:16:47 +0000")
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 14:56:08 -0700
Message-ID: <xmqqttkovh1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26A2574E-EE17-11EE-B8DB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (!add->stack->disable_auto_compact)
> +	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))

Fold the line after " &&", i.e.

	if (!add->stack->disable_auto_compact &&
	    !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))

> diff --git a/reftable/system.h b/reftable/system.h
> index 5d8b6dede50..05b7c8554af 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -17,6 +17,7 @@ license that can be found in the LICENSE file or at
>  #include "tempfile.h"
>  #include "hash-ll.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> +#include "parse.h"
>  
>  int hash_size(uint32_t id);
>  
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 686781192eb..434044078ed 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -299,6 +299,21 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
>  	test_line_count = 1 repo/.git/reftable/tables.list
>  '
>  
> +test_expect_success 'ref transaction: environment variable disables auto-compaction' '
> +	test_when_finished "rm -rf repo" &&
> +
> +	git init repo &&
> +	test_commit -C repo A &&
> +	for i in $(test_seq 20)
> +	do
> +		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1

Fold the line before "git", i.e.

		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true \
		git -C repo update-ref branch-$i HEAD || return 1

> +	done &&
> +	test_line_count = 23 repo/.git/reftable/tables.list &&
> +
> +	git -C repo update-ref foo HEAD &&
> +	test_line_count = 1 repo/.git/reftable/tables.list
> +'
> +
>  check_fsync_events () {
>  	local trace="$1" &&
>  	shift &&
