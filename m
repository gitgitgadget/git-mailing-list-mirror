Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E230CD9E
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474765; cv=none; b=uwmmB/RaR7Se0zvkGljeQdmX6BWSOtb/3L9rW/6VeNDVsGqhw24fw0dujToA2JrIUVnLe+OY05IiNKeDzea9iULNP9kvOnai6t6gVFbQmy4srkEsG7/DV1JdS9L2ia8fY8ZUdrX/Lmynk820lwKrHqY6giFhXX+DT5Vq637Wi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474765; c=relaxed/simple;
	bh=kXYMVrnvtTkdHEU/83W9OnFVqlKQsd0oowfVl+4tvQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSbO4lTZjHHv7UIOwlk15qS/PPJDmPA+Qn2E4pAjGcNPoGAnUCH08w32mOxjsJ4ouY45W52/Js0rodB8wAcLLNjlln2oozJyhLOJlcBDpQbMOB062ioTQVMB27CIgC7mc8gqsI4JywXBCgVzk47B8XFFRqfzz68M5wQaSdYTUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xd7z/DdK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xd7z/DdK"
Received: (qmail 29168 invoked by uid 106); 2 Mar 2026 18:06:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kXYMVrnvtTkdHEU/83W9OnFVqlKQsd0oowfVl+4tvQY=; b=Xd7z/DdKpQ+sYBV6ngcMaTArtTY/UC/QEYjRJ2y2tTaRvl/NDzx2KVuurZCyorRiIVpbHs8KU6Bp79BmONzJNv2I4wtGS5uq/BRyULcUuMYLJXNC/aTd8QPNjqr1YyC9J8J+pnpBXrDhW2E9LJMZFpCup3XtPmgGRNo9jlf1HsNpKgDkM7GVwrOOq/Zhb1E5Vt5x6ccLIQR4GiyLn0NHK3eftlXTdqX0cEh8Cl2e14nLfBkqpU9htynXXny+H3bM3Okp8//rMTobHzuhaRtPcUXMu7JPKmWuA2JgDNEqM9p62ElTvQpO3ndl3Zfr4RDfmFsl+dk13+leKuZRH+UyGw==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:06:02 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333918 invoked by uid 111); 2 Mar 2026 18:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:06:03 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:06:01 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/4] for-each-repo: work correctly in a worktree
Message-ID: <20260302180601.GD28275@coredump.intra.peff.net>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <2a6091095f120426fed554a08871f2b4dcd15282.1772465805.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a6091095f120426fed554a08871f2b4dcd15282.1772465805.git.gitgitgadget@gmail.com>

On Mon, Mar 02, 2026 at 03:36:44PM +0000, Derrick Stolee via GitGitGadget wrote:

> @@ -15,10 +16,11 @@ static const char * const for_each_repo_usage[] = {
>  
>  static int run_command_on_repo(const char *path, int argc, const char ** argv)
>  {
> -	int i;
>  	struct child_process child = CHILD_PROCESS_INIT;
>  	char *abspath = interpolate_path(path, 0);
>  
> +	clear_local_repo_env(&child.env);
> +
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "-C", abspath, NULL);

The second part of the hunk here is as expected, but the first one looks
wrong. We didn't remove any references to "i", so either it was
redundant to start with (and the compiler should have complained), or
now we've broken compilation.

Looks like the latter, but we recover when we switch to using pushv in
patch 4. So I think the declaration of "i" should move to that patch.

-Peff
