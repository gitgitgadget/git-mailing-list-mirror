Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E48F48
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710572261; cv=none; b=Lq9SFCjfSX/1BmKPvuKVLU/Wtp2ug1uAXiVA1XK4ztrKIQmZ7GoYf3mUXvGf8m7BokubOvo8YcQ0KGB/qxIR6kM8ladHi2XhtTKXCHoK/Q1+Zb0X9iwr+EVh27yKW6HIyyy62Nvoef/izs00FC8EqSGBOmKNtFT+DtGBPpwVIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710572261; c=relaxed/simple;
	bh=/sC9LsVC4Zu8fTrKQlg01PNepAokyYOEIVnRLoEA9E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADuzvjsbOT/8faOqpbAP/i/8xqOT6XxkqlWHPDGTDpA2yyUmJlAH3aLV/TGlktbeYq1CMMKIdrqRw9CTtrZ4PkckdtTrYuAQEJOmwc1Ou3eY4TTEVyAaCAYrnQYYYu4cv8J7RaS9knozhRyQM9p7SBn8wt7GnnBJLDbtKzfYB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6111 invoked by uid 109); 16 Mar 2024 06:57:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Mar 2024 06:57:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7638 invoked by uid 111); 16 Mar 2024 06:57:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Mar 2024 02:57:42 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 16 Mar 2024 02:57:37 -0400
From: Jeff King <peff@peff.net>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Message-ID: <20240316065737.GA544929@coredump.intra.peff.net>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240309181828.45496-2-ignacio@iencinas.com>

On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e3a74dd1c19d..9a22fd260935 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
>  a naming scheme that supports more variable-based include conditions,
>  but currently Git only supports the exact keyword described above.
>  
> +`hostname`::
> +	The data that follows the keyword `hostname:` is taken to be a
> +	pattern with standard globbing wildcards. If the current
> +	hostname matches the pattern, the include condition is met.

Do we need to define "hostname" in more detail here? Specifically, I'm
wondering whether the result will be a FQDN or not (i.e., the output of
"hostname" vs "hostname -f"). Looking at the code I think it will just
be the short name returned. That's probably OK, but it may be worth
documenting.

-Peff
