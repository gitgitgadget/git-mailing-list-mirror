Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526B22FF22
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860481; cv=none; b=DZHl4ZZvjPCwUwagdde1keg2WdSqByzpzBtczX33QC1CAP16sWIia4ZzgfFAmljv9a3L1lScQyu4L0HdGNav6AYkABOCh7rHI/MeekD+AXX9lDbroElpXDpE7drX5AJaL74wr2Bwp53CVTlTUvJcP/Tk0i5dOy3Ub6L1FQxcpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860481; c=relaxed/simple;
	bh=sPZWtnR/gElJ4kn9bHNDUbIMdWLqpZS+UWcCM5eo8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc7hDz+DqmTsvBQQtsYx9Sw5XbmiBxnFPEwMHLWU8dGrm2Fvk+Uc7Pn4JXosGZoh7rnOjUd4PyNIMe8Yz7J1cSKBTvT1w8Vmx3zRKa6qcYAIfFHD1JZaKQGgqihdoxzd9TFzA5gbNdlWBcv8Yc5elQlcIRc6Qkgq9dvIpMwBHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gHBbJ57KKz7Qdvg
	for <git@vger.kernel.org>; Fri, 15 May 2026 17:54:36 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gHBb6071qzRnlT;
	Fri, 15 May 2026 17:54:25 +0200 (CEST)
Message-ID: <796217c3-8998-47a8-9a46-298541708d41@kdbg.org>
Date: Fri, 15 May 2026 17:54:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] git-gui: allow specifying path '.' to the
 browser
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-2-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-2-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> Invoking "git-gui browser rev ." should show the file browser for the
> commitish rev, starting at the root directory. This errors out in
> normalize_relpath because the '.' is removed, yielding an empty list as
> argument to [file join ...]. Fix this.

Good catch!

The description isn't precise, though. '.' means to list the current
directory. The mentioned problem happens only if this is also the root
of the working tree.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 23fe76e..6048f92 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2965,7 +2965,11 @@ proc normalize_relpath {path} {
>  		}
>  		lappend elements $item
>  	}
> -	return [eval file join $elements]
> +	if {$elements ne {}} {
> +		return [eval file join $elements]
> +	} else {
> +		return {}
> +	}
>  }
>  
>  # -- Not a normal commit type invocation?  Do that instead!


-- Hannes

