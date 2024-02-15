Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB971386BE
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022575; cv=none; b=TAjr20RCQps+g8n/IQE2zJLm+ku97Nh0mNLKDY2BNjWnxQ1HE2LfdtBOGyc77zmJ56PLc4fxWd9CvsdkqZhDHTaKjxX7+XOAHqTd//nVN8jT5BMm7oPD2jY3BPLp1UCmurELBBWn6muCKhk8ShBiDR0GHjcHIcCr8QaS8n89YpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022575; c=relaxed/simple;
	bh=XikKeYX/80rUWsFSxdyrRd9XF32F49N7pGLAfpRUTNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvC+7jQTHoXtvRdxjkWmGu6imdQVJV2+LEJsxv3QVzkL48GDoHyeOODNdiXK9uZVM7zRMvr6c/44ysCaJ/j/BlRWykhQeKBGfDfiFhRXOzQu/1LHhtPXQZwTR7FLdQyu2X6tx1NnfRSe/eOfyJU5o9eRXSFGf31+E9q2WtT10/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qBd5yFm2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qBd5yFm2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D923E1DEA0E;
	Thu, 15 Feb 2024 13:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XikKeYX/80rUWsFSxdyrRd9XF32F49N7pGLAfp
	RUTNI=; b=qBd5yFm2pCfeovMqfi90Q1oXMSIicjkedwoGus7o2IIOEedOKroull
	wQOLgqI1+2y3Dy5wPQgiAsdzGJc487yhFF0glKl83VSY9jjgZN/JfS6cU/bbx6IX
	JpJ7Kihscm1X/5cOcNGVXnaez3LP9vtnjjF/a/Y+KPhvHfQtxBjZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D13611DEA0D;
	Thu, 15 Feb 2024 13:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4041A1DEA0C;
	Thu, 15 Feb 2024 13:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kipras Melnikovas <kipras@kipras.org>
Cc: git@vger.kernel.org,  greenfoo@u92.eu
Subject: Re: [PATCH v2] mergetools: vimdiff: use correct tool's name when
 reading mergetool config
In-Reply-To: <20240215142002.36870-1-kipras@kipras.org> (Kipras Melnikovas's
	message of "Thu, 15 Feb 2024 16:20:02 +0200")
References: <20240215083917.98218-2-kipras@kipras.org>
	<20240215142002.36870-1-kipras@kipras.org>
Date: Thu, 15 Feb 2024 10:42:49 -0800
Message-ID: <xmqq8r3lr2l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05CCF1DE-CC32-11EE-9126-25B3960A682E-77302942!pb-smtp2.pobox.com

Kipras Melnikovas <kipras@kipras.org> writes:

> Though, for backwards-compatibility, I've kept the mergetool.vimdiff
> fallback, so that people who unknowingly relied on it, won't have their
> setup broken now.

It is a good consideration, and should be documented ...

> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 294f61efd1..8e3d321a57 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -45,10 +45,11 @@ mergetool.meld.useAutoMerge::
>  	value of `false` avoids using `--auto-merge` altogether, and is the
>  	default value.
>  
> -mergetool.vimdiff.layout::
> -	The vimdiff backend uses this variable to control how its split
> -	windows appear. Applies even if you are using Neovim (`nvim`) or
> -	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
> +mergetool.{g,n,}vimdiff.layout::
> +	The vimdiff backend uses this variable to control how its split windows
> +	appear. Use `mergetool.vimdiff` for regular Vim, `mergetool.nvimdiff` for
> +	Neovim and `mergetool.gvimdiff` for gVim to configure the merge tool. See
> +	BACKEND SPECIFIC HINTS section

... perhaps before "See BACKEND SPECIFIC HINTS section."  E.g.

	When a variant of vimdiff (vim, Neovim, or gVim) is used as
	a mergetool backend, they use this variable to control how
	the split windows appear.
	The variable `mergetool.<variant>.layout` (where <variant>
	is one of `vimdiff`, `nvimdiff`, or `gvimdiff`, depending on
	what you are using) is consulted first, and if it is missing,
	`mergetool.vimdiff.layout` is used as a fallback.  See
	BACKEND SPECIFIC HINTS section.

or something?	


> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 06937acbf5..0e3058868a 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -371,9 +371,17 @@ diff_cmd_help () {
>  
>  
>  merge_cmd () {
> -	layout=$(git config mergetool.vimdiff.layout)
> +	TOOL=$1
>  
> -	case "$1" in
> +	layout=$(git config mergetool.$TOOL.layout)

The callers of merge_cmd are careful to do

	merge_cmd "$1"

so it would be a good hygiene to also quote $TOOL here, i.e.

	layout=$(git config "mergetool.$TOOL.layout")

It might not matter if the caller of run_merge_cmd (which calls
merge_cmd) eventually chooses from a known set of strings hardcoded
in mergetools--lib.sh, but it is much easier to show that you are
doing the right thing without relying on such a detail of what
happens far in the code to quote what you get from the caller
appropriately.

> +
> +	# backwards-compatibility:
> +	if test -z "$layout"
> +	then
> +		layout=$(git config mergetool.vimdiff.layout)
> +	fi
> +
> +	case "$TOOL" in

This one is quoted properly (and TOOL=$1 at the beginning does not
require quoting).  The "git config" call above is the only one that
needs to be fixed.

Thanks.

>  	*vimdiff)
>  		if test -z "$layout"
>  		then
>
> base-commit: 4fc51f00ef18d2c0174ab2fd39d0ee473fd144bd
