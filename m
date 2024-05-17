Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF22EEC5
	for <git@vger.kernel.org>; Fri, 17 May 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968952; cv=none; b=OWx4yDKZgJRISWyVC5wk7cqfr15IsiSY0bksHFR5VQGZ3SvBoYAplduZruZ3VPBGednd20DagJEuLccc8f168oigBfwN+lNTZyvg9/D3aWAFaw/Mwog+ZbqZIhcGiO8acud0kLwTyP/dTE3vh2t2sNaInG3lRFJEtcJnGxmjFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968952; c=relaxed/simple;
	bh=EaFSmliJHvv9NmwdQvDLkoIzUOQdZ7qf9LHoiSiY9+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JIl2lIEXqeBn9MTpkKTkncSWKGvx3PesK2XGy25hpECE0j2lfpss0cuY8/U/oWsdzuZmiFN6epks4jbAKo5NL7qpjsYL+1IpToDOfqDJYoU7H812i3fSP4vOXxK1etyyghDYompmo0pEVP0T2n9PFfqwUGAAR535tq17j+D7bMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IB/DlStl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IB/DlStl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E7034296E6;
	Fri, 17 May 2024 14:02:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EaFSmliJHvv9NmwdQvDLkoIzUOQdZ7qf9LHoiS
	iY9+M=; b=IB/DlStlfsdVd/n9Dwz33kOdIzP6x7j27TS+Ug4hH/yDA5ZGTIKKU9
	lSpDcexuVHFoLNEROL02ChbQPTMcjEFLYU+P3sqheYmjrRexa69liQmjU5rLkhTO
	k+MsPVRkUWexSrE9eHkTwyBxYz+O+GdJ3+N+btvpF/Ev5TsyHhCSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DEB1C296E5;
	Fri, 17 May 2024 14:02:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51EC6296E4;
	Fri, 17 May 2024 14:02:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Switch grep from non-portable BRE to portable ERE
In-Reply-To: <ZkePejx-eRNrspZ2@telcontar> (Marcel Telka's message of "Fri, 17
	May 2024 19:10:18 +0200")
References: <ZkePejx-eRNrspZ2@telcontar>
Date: Fri, 17 May 2024 11:02:28 -0700
Message-ID: <xmqq7cfsiaff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A03899DE-1477-11EF-A077-25B3960A682E-77302942!pb-smtp2.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> Subject: Re: [PATCH] Switch grep from non-portable BRE to portable ERE
>
> This makes the grep usage fully POSIX compliant.

May want to mention that using backslash to invoke ERE feature in
BRE is a GNU extension?

Thanks for this and other portability patches.  You are porting to a
new platform, I presume, where either nobody else ported to before
or those who ported did not bother reporting test breakages to us?

> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  mergetools/vimdiff           | 2 +-
>  t/t1404-update-ref-errors.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 734d15a03b..f8ad6b35d4 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -325,7 +325,7 @@ gen_cmd () {
>  		fi
>  
>  		# If this is a single window diff with all the buffers
> -		if ! echo "$tab" | grep ",\|/" >/dev/null
> +		if ! echo "$tab" | grep -E ",|/" >/dev/null
>  		then
>  			CMD="$CMD | silent execute 'bufdo diffthis'"
>  		fi
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index 98e9158bd2..67ebd81a4c 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -100,7 +100,7 @@ df_test() {
>  		printf "%s\n" "delete $delname" "create $addname $D"
>  	fi >commands &&
>  	test_must_fail git update-ref --stdin <commands 2>output.err &&
> -	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&
> +	grep -E "fatal:( cannot lock ref $SQ$addname$SQ:)? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&
>  	printf "%s\n" "$C $delref" >expected-refs &&
>  	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
>  	test_cmp expected-refs actual-refs
