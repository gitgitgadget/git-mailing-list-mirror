Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFB12D1E3
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677757; cv=none; b=IMi7ngY7ots+1be7qECdIpq+9EGoss+NAWVmmv4MUcPWYxuxXCsm99gbeurrsJS9GX5ccngN2lK6NWbKYMmks+tTe/n6P8/3RxWQRTELslLZi4jYQa20ArVyxmEn98wGGwxZvWZ8ow7y4rBhwiYWKPPQRIIc12ECcwpR1izvduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677757; c=relaxed/simple;
	bh=GXJu/p3S5ODvh69lxLTqiA8kFtpQ+z8v6ydoWtYmPVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccMnPL30YKXmQ5XArIj5RAyxQK73p7qLw78bEqr94oROUKYP48sgV2NxYSLBLr7yjyQHZb1njIqpxhUVFmOmUpunHx3VKpLOK+R08GAvA0Eqz4KHDCp0y/fyK239umwcsUaiW5l42vuaXa1ubipGJTWfFjnLnx61jrmLLI2vrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bGIboWHw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bGIboWHw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 306061D04C1;
	Tue,  5 Mar 2024 17:29:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GXJu/p3S5ODvh69lxLTqiA8kFtpQ+z8v6ydoWt
	YmPVc=; b=bGIboWHwfa32dIHNHThSvSn3haarJCPUyyDw2gHNHAl3Dxo7DsyuxS
	j14vJ23HvOTh0h6Vt3XHcrpqxYeFEEu3iGP/EzBuu++T4I8Mfy3ifSr6yMhnW0mH
	JY2bWtKwFo8/q8gOqAyadfSwiAUl9j73y9u9pCkGPGPQ24vjX1uy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2753D1D04C0;
	Tue,  5 Mar 2024 17:29:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74CAE1D04BF;
	Tue,  5 Mar 2024 17:29:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 05/22] t/perf: avoid redundant use of cat
In-Reply-To: <20240305212533.12947-6-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:04 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-6-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 14:29:06 -0800
Message-ID: <xmqqle6wxqh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7B474E0-DB3F-11EE-9907-25B3960A682E-77302942!pb-smtp2.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Take care to redirect stdin, otherwise the output of wc would also contain
> the file name.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/perf/repos/inflate-repo.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/perf/repos/inflate-repo.sh b/t/perf/repos/inflate-repo.sh
> index fcfc992b5b02..412e4b450b16 100755
> --- a/t/perf/repos/inflate-repo.sh
> +++ b/t/perf/repos/inflate-repo.sh
> @@ -33,7 +33,7 @@ do
>  done
>  
>  git ls-tree -r HEAD >GEN_src_list
> -nr_src_files=$(cat GEN_src_list | wc -l)
> +nr_src_files=$(wc -l <GEN_src_list)

Good thinking to explicitly redirect into the command.

>  
>  src_branch=$(git symbolic-ref --short HEAD)
