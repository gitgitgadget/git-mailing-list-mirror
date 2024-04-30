Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED8128816
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474650; cv=none; b=sBFvOU5xrbZNot2LgulSJPfoV+GopmmrOMJ4c2s7iFx243DmuHtANGeBynGjt+m4RBHN+TijTC9s1R4jhMuGCcGVTsCymuc5Y/i1s+2/J8GhMYj7DO7zwH7sq8CE4huMlxseAS4sXvEn67+YJ4UBkZ3ge8HxG1XySSHSPcGFypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474650; c=relaxed/simple;
	bh=bwf7JZrpx6wg0k0UNQXmhEjpxbuoJfv0X/SgdwL0XNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7FZuwHD8clnWCifIpOuSeqfP8z3arwXwpf0zRn3QP6obUudSo1EYS0gGuAysHh8T/Vm2mbusl0bcMX4ttauVUTyQxMEwDaUK+Zt1FpnlDjRM4v4KVe8El74dm9gkpyaiBd82Ll9yKsmuDmS40IJnWUiFtKp2MjoUTWgYmQ/XAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3884 invoked by uid 109); 30 Apr 2024 10:57:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:57:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5888 invoked by uid 111); 30 Apr 2024 10:57:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:57:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:57:27 -0400
From: Jeff King <peff@peff.net>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
Message-ID: <20240430105727.GI1279403@coredump.intra.peff.net>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240429164849.78509-4-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429164849.78509-4-dev+git@drbeat.li>

On Mon, Apr 29, 2024 at 06:48:49PM +0200, Beat Bolli wrote:

> -test_expect_success '24-bit colors' '
> -	color "#ff00ff black" "[38;2;255;0;255;40m"
> +test_expect_success 'RGB colors' '
> +	color "#ff00ff #0f0" "[38;2;255;0;255;48;2;0;255;0m"
>  '

Heh, I would still think of it as a shorthand for 24-bit color, but I
guess you could argue it is now 12-bit color. :)

(Only observing, I think the new name is fine).

>  test_expect_success '"default" foreground' '
> @@ -146,7 +146,10 @@ test_expect_success 'non-hex character in RGB color' '
>  	invalid_color "#12x456" &&
>  	invalid_color "#123x56" &&
>  	invalid_color "#1234x6" &&
> -	invalid_color "#12345x"
> +	invalid_color "#12345x" &&
> +	invalid_color "#x23" &&
> +	invalid_color "#1x3" &&
> +	invalid_color "#12x"
>  '

This made me wonder what we'd do with "#1", "#12", "#1234", etc. Looking
at the code change, I think we'd continue to reject them. I wonder if it
is worth covering here.

-Peff
