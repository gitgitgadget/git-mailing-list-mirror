Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3733CC4
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589608; cv=none; b=Ap9WoxFAV0Nu+5/feqM7zVpk21CncRUlJZ9XP0Gven4nt45rPm5JQqu/pZGSYHUwm/O24jM4dWXkBi2MC7+dVPSh/+cfXrV80ko9dsRyic2c2bDbhj9KtvyW/ec+EU/dWSoGBs9Cl8QSPHSLygxV+hFHNFwW/bytfzZZVxeCSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589608; c=relaxed/simple;
	bh=ipA+48nqndO55uqQgt8b5Sn6gtUILCSGrKXT7ZIML2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGnfFNYy0SBhgBpL8Ffk6qA6DycdGs15A+we/ilMHReII5CqlCptM3+H9kH6P3Jt9+54d+43syLCX6VEMY0FByFrGssGq69nGRib4BPiG5GgbvNCEhuyp50GDRPLuOZZkghss40Kan8Ez4jyvkGdk1OngkUIJptui0ZmpLCcwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fjhlDRsj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjhlDRsj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A29A1DBD88;
	Mon, 29 Jan 2024 23:40:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ipA+48nqndO55uqQgt8b5Sn6gtUILCSGrKXT7Z
	IML2Y=; b=fjhlDRsj46Hloo59DNc6zQtLNNEhm6UlKibDN+bh0GkSf3DKi1ZUCB
	aeGOUcG/mf1snzpwFlZKSW7XoMX0S+iJDMhzujRXU5RxDIddFeryDQospmKIWFle
	58PLvwULImZT7VCp7D/IQDoOFKDUVpeZuXQGJ+73Kn/lS624lPx6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 159BC1DBD86;
	Mon, 29 Jan 2024 23:40:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FD481DBD84;
	Mon, 29 Jan 2024 23:40:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>,  Mohit
 Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH v5 1/2] git-compat-util: add strtoi_with_tail()
In-Reply-To: <f09b0838f049de3e4b8cc6adc6cd4492bac7e967.1706416952.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Sun, 28 Jan 2024
	04:42:31 +0000")
References: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
	<pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
	<f09b0838f049de3e4b8cc6adc6cd4492bac7e967.1706416952.git.gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 20:40:02 -0800
Message-ID: <xmqqle87e8nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2D71646-BF29-11EE-AD80-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mohit Marathe <mohitmarathe23@gmail.com>
>
> This function is an updated version of strtol_i() function. It will
> give more control to handle parsing of the characters after the
> numbers and better error handling while parsing numbers.
>
> Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
> ---
>  git-compat-util.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 7c2a6538e5a..c576b1b104f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1309,6 +1309,29 @@ static inline int strtol_i(char const *s, int base, int *result)
>  	return 0;
>  }

Are we leaving the original one above?  Shouldn't this step instead
remove it, as strtol_i() is now a C preprocessor macro as seen below?

> +#define strtol_i(s,b,r) strtoi_with_tail((s), (b), (r), NULL)
> +static inline int strtoi_with_tail(char const *s, int base, int *result, char **endp)
> +{
> +	long ul;
> +	char *dummy = NULL;
> +
> +	if (!endp)
> +		endp = &dummy;
> +	errno = 0;
> +	ul = strtol(s, endp, base);
> +	if (errno ||
> +	    /*
> +	     * if we are told to parse to the end of the string by
> +	     * passing NULL to endp, it is an error to have any
> +	     * remaining character after the digits.
> +	     */
> +	   (dummy && *dummy) ||
> +	    *endp == s || (int) ul != ul)
> +		return -1;
> +	*result = ul;
> +	return 0;
> +}
> +
>  void git_stable_qsort(void *base, size_t nmemb, size_t size,
>  		      int(*compar)(const void *, const void *));
>  #ifdef INTERNAL_QSORT
