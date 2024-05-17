Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98414F61
	for <git@vger.kernel.org>; Fri, 17 May 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978963; cv=none; b=VdEC609Parg45PvGh5zTHc3Hf35yo4TU1msGBTzb8PvTpeJj39vmd/aTaktZ9x5Z603i/r0PK8LoDalCa1x1r0jUXKFC5s1uBIO2QV9aKsVKJNNyb/YFl2AvVlZ5MiOeKpXk3PPoOh1nOWKB+WBJgtXXNxcPMOLzOKj7dGuE41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978963; c=relaxed/simple;
	bh=P/em+EzuQ9Vb7r+08ZA+Bcu9M0xAKhGWG9Uh24HFe0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HKW1vSJmqhtg5LOD1y4CMoXq7bHfXziNi0Awdk9jMXj5i9dRAvotCWr78jMnnVi7XLsTEVjbSyUIRmujAadZTWxqgtJ65vjY41nbvT43Om80JXY4xYrpmxEcIWdCgoZo/RxLtBFiRu1fPLnKF6UMG8EIt1+BdOSclyt4CJv3QGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZFnp6UZH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZFnp6UZH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 41C2130A69;
	Fri, 17 May 2024 16:49:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P/em+EzuQ9Vb7r+08ZA+Bcu9M0xAKhGWG9Uh24
	HFe0M=; b=ZFnp6UZHiBfF4a0BBGA2hXU0zRxr4tQr9SR91bb7R4eB8lelEINV5B
	w5a8FLLWfXgLEr21dggZk1HNBER6Z7qDwt0SuYtO0M6E9nYvfo7PQDkaOerQRozu
	WtpKevTN6ww4sZeEzygvkwIky2n8Q0zdbpx7PHvsZVBmi0wwDpyoE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A41930A68;
	Fri, 17 May 2024 16:49:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07C0B30A67;
	Fri, 17 May 2024 16:49:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Victoria Dye <vdye@github.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] scalar: make enlistment delete to work on all POSIX
 platforms
In-Reply-To: <Zkds81OB7C5bTCl_@telcontar> (Marcel Telka's message of "Fri, 17
	May 2024 16:42:59 +0200")
References: <Zkds81OB7C5bTCl_@telcontar>
Date: Fri, 17 May 2024 13:49:14 -0700
Message-ID: <xmqqbk54go51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECADB134-148E-11EF-950B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> The ability to remove the current working directory is not guaranteed by
> POSIX so it is better to go out of the directory we want to delete on
> all platforms unconditionally.
>
> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  scalar.c | 4 ----
>  1 file changed, 4 deletions(-)

Let's CC a few folks that had their hands in the delete_enlistment()
function over the years for their opinions on this change.

> diff --git a/scalar.c b/scalar.c
> index 7234049a1b..331b91dbdb 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -361,16 +361,13 @@ static char *remote_default_branch(const char *url)
>  
>  static int delete_enlistment(struct strbuf *enlistment)
>  {
> -#ifdef WIN32
>  	struct strbuf parent = STRBUF_INIT;
>  	size_t offset;
>  	char *path_sep;
> -#endif
>  
>  	if (unregister_dir())
>  		return error(_("failed to unregister repository"));
>  
> -#ifdef WIN32
>  	/*
>  	 * Change the current directory to one outside of the enlistment so
>  	 * that we may delete everything underneath it.
> @@ -385,7 +382,6 @@ static int delete_enlistment(struct strbuf *enlistment)
>  		return res;
>  	}
>  	strbuf_release(&parent);
> -#endif
>  
>  	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
>  		return error(_("failed to stop the FSMonitor daemon"));
