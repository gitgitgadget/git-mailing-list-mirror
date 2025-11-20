Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE683128CF
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632860; cv=none; b=BXS62TvpZW+TDXgDUnseTw3OzOpvEpokrTAajaWcxiqyvpQes+IpRfBGAP8jwvfptuFmkGWu2AWaLkW7mXFqFiGHFi5RFYV1mQFshQZw4QCftA+MYGaRwIl2SWkawm2VDwcwf8xkVrXYYsRztw0NFZE19V8eemhF7wznBo4ZEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632860; c=relaxed/simple;
	bh=yYiMSM0enL9YBnrep/F71mbMIMAEKMDZH9BiZa2R7Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HDl6oV/g94L0g9lMvFPGg6HGnrG7ciFuHzxRIyI9cAWMln5d26bsF87xYxeMXD0qUK5wJoE9qPRjJ/seTWv64YAbAiiJVcEZ4ef0scnS6jEthA8cWbomwwJBwYnZ5MSlY1186+cq1mCPuemHssqA7GL0osbxmVz0ia5apXrP/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Rjpvo0fu; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Rjpvo0fu"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 83853DF9BC2
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 11:00:47 +0100 (CET)
Received: from [192.168.3.154] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 3E14260136;
	Thu, 20 Nov 2025 11:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763632840;
	bh=yYiMSM0enL9YBnrep/F71mbMIMAEKMDZH9BiZa2R7Xg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Rjpvo0fue6rkz6ZS4OtsPuAFoybaC4cj5pwfAMm7SuRfNQCIDDATBI5lNxyXzKFsw
	 eRpw4c6jJxDscUhh2mNZW26wFx/zkFZ+NDi86dPLSTU7PhP9xQ56/C4c3ZsZcSIQCa
	 g3PwHThvvkCAoUHJkm8KWUEy8H8ENkvAjKvDWqG9zv0/RQ8sjk8J2tmKmOEXy/rjyF
	 pDM7kgrSZVq4nD8JdQidhQ+SUlPtXJB4SArgTgxRBRdhPGYsqkdjjAgRL8/8STuihh
	 eKTZNx6ZR6a6bWEkpvSPvBk2KtECnT7t+MYRZYiIwCpBs1ACle34hVC/+yZIwZKdqy
	 rOLEvELQpWPng==
Message-ID: <46f9d35e-60f2-488c-a0b4-89855f27cc66@free.fr>
Date: Thu, 20 Nov 2025 11:00:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2025 at 22:48, Karthik Nayak wrote:
> ---
>  Documentation/git.adoc |   8 ++++
>  environment.h          |   1 +
>  refs.c                 |  53 +++++++++++++++++++++++-
>  t/meson.build          |   1 +
>  t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..a1d1078f42 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	repositories will be set to this value. The default is "files".
>  	See `--ref-format` in linkgit:git-init[1].
>  
> +`GIT_REF_URI`::
> +    Specify which reference backend and path to be used, if not specified the
> +    backend is inferred from the configuration and $GIT_DIR is used as the
> +    path.

Please use backquotes for environment variables: `$GIT_DIR`

> ++
> +Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
> +reference backend and the 'path' specifies the directory used by the backend.

Constant strings and keywords are back-quoted too but placeholders are
underscored:

Expects the format `<ref_backend>://<path>`, where the _<ref_backend>_
specifies the reference backend and the _<path>_ specifies the directory
used by the backend.

I'm only focusing on documentation.

Thanks
