Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361623A5E7F
	for <git@vger.kernel.org>; Sat, 23 May 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546212; cv=none; b=hksXgO45BaKBT8mJUXV/6WV+H7CI/YO4AKyMeYUiO/PinVLcB0pOQlrdBRaTcyTlhcOIUnFH00nDgFPL9L44PaYYNFr18K5FQhM/p+Kx74L3TtuRj1f7fpuCNAXHERspPH1xkGEepXG1H2TD0ZfUAx5IUL1an+qLPt4Llh4k9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546212; c=relaxed/simple;
	bh=J2f4U0bVWtU5hzUqXWDN0DNhgH9hnTp/dJ9tUKcvNvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMWw65CXeFM4b1N1XI+43Lut5/FvFCpsnaDvvq8/+wr6T6nWfJjZfGC+r6YxILXwNxcuCcC7v+iGmIxfaiAldsqNBOvNU/xgXZaCVHFL5xILG0Rb6xe0c1yW33ISv/GLJ3KBvvPdNgHHIoq+afzs7+WhGqfqgiBNH5Z3lr6n/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gN4BR5scZzRnlK;
	Sat, 23 May 2026 16:23:27 +0200 (CEST)
Message-ID: <ae3cdc22-2f88-4222-bab7-403408373a53@kdbg.org>
Date: Sat, 23 May 2026 16:23:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] git-gui: allow specifying path '.' to the
 browser
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-10-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-10-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> Invoking "git-gui browser rev ." should show the file browser for the
> commitish rev, starting at the current directory. When the current
> directory is the working tree root, this errors out in normalize_relpath
> because the '.' is removed, yielding an empty list as argument to [file
> join ...]. The browser function demands "./" in this case, so make it
> so. (./ works on Windows as well because g4w accepts posix file
> naming).

I wonder why we need "./" instead of plain ".". The latter works just
fine in my tests (on Linux).

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index a72d8a59ec..d373457901 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3007,7 +3007,11 @@ proc normalize_relpath {path} {
>  		}
>  		lappend elements $item
>  	}
> -	return [eval file join $elements]
> +	if {$elements ne {}} {
> +		return [eval file join $elements]
> +	} else {
> +		return {./}
> +	}
>  }
>  
>  # -- Not a normal commit type invocation?  Do that instead!

-- Hannes

