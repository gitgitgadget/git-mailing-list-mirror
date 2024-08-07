Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112334653A
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071362; cv=none; b=G26exa5E6PJZpi4bZ51aEzFXf2uVuAdjNyJ3cb5S5fQahCFK6oYLTZpzavjLSDuWXJao7cKhFzzQOisq93RVtMjN7vcJY0LSaGTE74/YbNVrdMi7dlhPSMwtDS1DwwXf6eKQj4z2y0yWAyJY1OYBfsh7LQWKJL3IAzXDt59Wcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071362; c=relaxed/simple;
	bh=F73ukredD1pmWdD6W6k8D7YCweGoJBWBUeYR/nh2sHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NnbKW8lWIjREJrv8tKqJfsI+4o8pgk6Pipz5DJlV5vpZiNs3tTdN1R27+s47IDmhiJbFWjh5E8rkqxNUOKFuXMYBl2d3Rf+ISNoM/aAaGGnuc+Dbg1beyaxRfYVRHdnRh4sQrapTo4fjbFjR/QRYFMCn7kFmCHig5y4g77hCHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6MHzbuN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6MHzbuN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B423F1B7EA;
	Wed,  7 Aug 2024 18:55:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F73ukredD1pmWdD6W6k8D7YCweGoJBWBUeYR/n
	h2sHM=; b=Q6MHzbuNxWroo9VIk8y9i0Bcqoi9aL0nQqtpT108dBfPiGFnjFOc6y
	GRjlvXtLwqy0ynsufrrWYl1yYPNqPUsUc9BJCJ504MLzIiL22o8PGYJr4Lv+WFgB
	Kx5gNNmGN66Dna1T32SeUjesUV4ZFzbG7rOSpAJwpk+UQK65M1kgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC2301B7E8;
	Wed,  7 Aug 2024 18:55:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C7621B7E7;
	Wed,  7 Aug 2024 18:55:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH 1/6] builtin/submodule: allow cloning with different ref
 storage format
In-Reply-To: <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 7 Aug 2024 14:43:48 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723032100.git.ps@pks.im>
	<a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
Date: Wed, 07 Aug 2024 15:55:57 -0700
Message-ID: <xmqqwmkslz7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36578CE4-5510-11EF-AC47-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
> +update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
>  +
>  --
>  Update the registered submodules to match what the superproject
> @@ -185,6 +185,9 @@ submodule with the `--init` option.
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
>  
> +If `--ref-format <format>`  is specified, the ref storage format of newly
> +cloned submodules will be set accordingly.
> +
>  If `--filter <filter-spec>` is specified, the given partial clone filter will be
>  applied to the submodule. See linkgit:git-rev-list[1] for details on filter
>  specifications.

Presumably, if the named submodule has already been initialized, we
are not converting its ref backend with --ref-format=<format> option
when "git submodule update --ref-format=<format>" is run.  Would it
make sense to say it is an error to give it without "--init", I
wonder.  If so, we probably would need to see if other existing
options like "--filter" also need a similar sanity check, if not
already done.

Thanks.
