Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2411CBE8C
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482183; cv=none; b=H0y84zFGnv4ycFZEUGhQbx+O+6cACYN6fJY4Hv0pwZhDuNCX5KAlaFfwYzTuEwxf0SmDKw+6sSMo8yTwJCbUYNduxpkcAriNmnxpJjKdNoml8k9GkucFG0FI1WDQocYgfEAfrpAO37GU/BDlJKFC+WM3tfzXxJCA0eBwuB2tfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482183; c=relaxed/simple;
	bh=qAZe+kNCUvBkVvRhlKIoMzZ8JPmIMjvjklRQplXISeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOAdlwBZJ6ceKh/6jJrnXk3EEgEQNIN3N5TN/jR9e91Duheu2JiyKUBSrrCB918eMNJpL2Ar4cxjX9BVM1H5NQQ/+fcyoqcDA5whik6Bt1CgeGkEdnP3Q6PH41DBz6plA9jwrrQmq9Hu/Z7DyvkzRj5X5a28GVMQmdW7C9ASP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G+Z7kwkb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G+Z7kwkb"
Received: (qmail 31292 invoked by uid 109); 1 Nov 2024 17:29:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qAZe+kNCUvBkVvRhlKIoMzZ8JPmIMjvjklRQplXISeI=; b=G+Z7kwkbYniaKs1eAfn91q5wbteitPhKvbKKnzyANUdo0w+TvK5N6dBNtfHmY/pkXNKl2MLSVTU861GgpqYgI7mDVzD3t77qJ8uo7adgMS8OFdMAvINLfn7eygReNeH9U3/MDYK1w2RzEcwWGFp0dH4Fb/Fvqpuqp375/Qjv/eMXwLT2liW68Ckn2+B0mif1ZLdrTOiCXVrx+BKAqZwAN9+7jZpvF9r30XL9/YMaCRNHGmFD6onVKdW7LWFJLCbxoj3Ecf3WVtmSihk3rIyyP21oLDQ4YBDJCtz8aA376i+CzU/vtuNhnIzmEFPP5G8l0hMJmblnAfnB7/QHgNCRKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Nov 2024 17:29:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15334 invoked by uid 111); 1 Nov 2024 17:29:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2024 13:29:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Nov 2024 13:29:39 -0400
From: Jeff King <peff@peff.net>
To: karthik nayak <karthik.188@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <20241101172939.GA2337295@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1730366765.git.karthik.188@gmail.com>
 <ZyPjJKYZzeFGLxin@nand.local>
 <ZyTnhrBLuvesK1yB@nand.local>
 <CAOLa=ZTp=QqD0P2zhGunrOfmAebwvLJ20bQq9Tog3eLaO9pwoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTp=QqD0P2zhGunrOfmAebwvLJ20bQq9Tog3eLaO9pwoA@mail.gmail.com>

On Fri, Nov 01, 2024 at 11:07:48AM -0500, karthik nayak wrote:

> Thanks for letting me know, I think the fix is simply
> 
> diff --git a/packfile.c b/packfile.c
> index f626d38071..737cd60377 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -27,8 +27,8 @@
>  #include "pack-objects.h"
> 
>  struct packfile_config {
> -	unsigned long packed_git_window_size;
> -	unsigned long packed_git_limit;
> +	unsigned long long packed_git_window_size;
> +	unsigned long long packed_git_limit;
>  };
> 
>  #define PACKFILE_CONFIG_INIT \

Wait, why did these change from "size_t" to "unsigned long" in your
series in the first place? If the goal is moving them into a struct,
they should otherwise retain the same types, no?

Two asides, one for your series and one #leftoverbits:

  1. Since these are now fields of packfile_config, do they need the
     long packed_git_ prefix anymore? Just window_size and limit would
     be nicer, I'd think.

  2. I can imagine you might have used "unsigned long" because they are
     parsed with git_config_ulong(). That is OK on Linux, where size_t
     and "unsigned long" are the same size (either 32- or 64-bits). But
     on Windows I think it means that you cannot configure a window
     larger than 4GB on a 64-bit system. Or ironically you cannot set a
     total limit larger than 4GB, even though the default is 32TB. ;)

-Peff
