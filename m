Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2312DDAB
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968623; cv=none; b=nW3EIJSNqoIJEVTgtHtUI1/og5bfIIOnrgE33foQFvG8Y+UG0wOnGZZ3thaxAib/GpzjA3gC5mOBleSosxmg+3RyMtMw98j8hK7wVmp2yaIIl5aF80YkPjk/+h7f3BF1lfSDs7AJ0lJMglfyquQDN74m70+x1JvicVMvyF2Cn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968623; c=relaxed/simple;
	bh=raVtvE9EGoW1a5CmYIlhdsDh0GmJyO91PfMsmNVT/ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mBr6zGeS3vHfJGwVQ3ICjpgbTnDZv44u5ShKPGeoBLHSBGdBXgI/VNqkM1AL+JMb/EAK/13OA2U9uQfK5pYfYhFYwhhJU81ryZF9F0/k0b+hZlN6jBGox3IL8y1a8zZPe0nL2xyNEDu4PrxZ4L/JILlM9YeJjgRKpMvekmReCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xNc9vgBS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xNc9vgBS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6F531D2819;
	Mon, 26 Feb 2024 12:30:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=raVtvE9EGoW1a5CmYIlhdsDh0GmJyO91PfMsmN
	VT/ro=; b=xNc9vgBSk66UEm5gnpx9kX/FZjBunysMKDw97nBfRlYBaFsIvap6+G
	O4Q7GuxNcaGZESZu0urY5jT4WwusUVTAExjDh13ng1wk+TLnZn4Imds1xWu6YpAR
	KbFQ09A1BRJjAJTNoNWcXsntDJv19jb4ASZJn8iwyvzcAElfqkG7E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D4621D2816;
	Mon, 26 Feb 2024 12:30:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DAF91D2815;
	Mon, 26 Feb 2024 12:30:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v3] build: support z/OS (OS/390).
In-Reply-To: <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Sun, 25 Feb 2024 06:10:39
	+0000")
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
	<pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 09:30:19 -0800
Message-ID: <xmqq7circevo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B6D2D726-D4CC-11EE-9993-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Haritha D <harithamma.d@ibm.com>
>
> Since the z/OS linker does not support searching dynamic libraries,
> and the current setting of CC_LD_DYNPATH results in a directory
> to be supplied to the link step with no option as the suffix,
> it causes a linker error because the z/OS LD linker
> does not accept directories as input.
> Therefore, -L option is added.

Shouldn't all of the above removed by now, with 07bbe4ca (Merge
branch 'jc/make-libpath-template', 2024-02-06) that merged the
support for platforms whose linker does not have a way to specify
the path used at runtime to locate dynamic libraries and is already
in the Git 2.44 release?  The autoconf-generated config.mak.autogen
would leave CC_LD_DYNPATH to empty on such a platform, which then
adds only one "-L $where" (instead of the usual "-L $where -R
$where") on the linker command line, making your earlier workaround
to use "-L $where -L $where" unnecessary?

> Also introduced z/OS (OS/390) as a platform in config.mak.uname

"Introduce z/OS ..." (cf. Documentation/SubmittingPatches)

Or perhaps

	Add platform specific settings in config.mak.uname for zOS
	(OS/390).

> diff --git a/config.mak.uname b/config.mak.uname
> index dacc95172dc..03ee2b74525 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
> +ifeq ($(uname_S),OS/390)
> +        NO_SYS_POLL_H = YesPlease
> +        NO_STRCASESTR = YesPlease
> +        NO_REGEX = YesPlease
> +        NO_MMAP = YesPlease
> +        NO_NSEC = YesPlease
> +        NO_STRLCPY = YesPlease
> +        NO_MEMMEM = YesPlease
> +        NO_GECOS_IN_PWENT = YesPlease
> +        HAVE_STRINGS_H = YesPlease
> +       NEEDS_MODE_TRANSLATION = YesPlease

All of the above should be indented with TAB to imitate the support
for other platforms, I think.

Thanks.

> +endif
>  ifeq ($(uname_S),MINGW)
>  	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
>  		$(error "Building with MSys is no longer supported")
>
> base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
