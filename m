Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A880134AC
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339343; cv=none; b=ta8mO+XyH/jR8RQi9rQnaAK3bzeO7qlDUKFLVzGmR6z4v4E6C2Om8qW2CNcK1/zYkrz6qcItNHP2pjZh1LYqnylapWAJbpWuCs81OtCfLfyhelrEY0jrxKISW6ACJPo5M/dmjPGzjt5r8CRwpTzuCXKiOraPSjxWo1A4MRaaYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339343; c=relaxed/simple;
	bh=Q48QSQOMFKirtdqOtF7KQxf0ICU8rgwAdepflXlrsd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciqo++TX3hXbXsDl9kPs65C+caDaVLCiQurydcEeUoVjDLJYBwTujwRbf/Al3dgPC4GXkF51PxkrYLhOkwKCQWDY1G2xMEMnpxGQitkMrfKZEGfqInvYGfoZuDp2stWnAV084fvWGTnpSFjv8QBLqvK5dq7KIr3vG9lZwdd8fio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18269 invoked by uid 109); 5 Apr 2024 17:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 17:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30934 invoked by uid 111); 5 Apr 2024 17:49:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 13:49:01 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 13:48:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
Message-ID: <20240405174859.GE2529133@coredump.intra.peff.net>
References: <cover.1712235356.git.ps@pks.im>
 <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
 <xmqqmsq7yezc.fsf@gitster.g>
 <xmqqbk6nyej1.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbk6nyej1.fsf_-_@gitster.g>

On Fri, Apr 05, 2024 at 09:12:34AM -0700, Junio C Hamano wrote:

> Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
> lets the shell erroneously perform field splitting on the expansion
> of a command substitution during declaration of a local or an extern
> variable.
> 
> The explanation was stolen from ebee5580 (parallel-checkout: avoid
> dash local bug in tests, 2021-06-06).

Thanks for digging up that commit. I read the earlier part of the thread
and went off on a wild goose chase in the archive. :)

> + - Some versions of dash has broken variable assignment when prefixed
> +   with "local", "export", and "readonly", in that the value to be
> +   assigned goes through field splitting at $IFS unless quoted.  
> +
> +   DO NOT write:
> +
> +     local variable=$value           ;# wrong
> +     export variable=$(command args) ;# wrong
> +
> +   and instead write:
> +
> +     local variable="$value"
> +     export variable="$(command args)"

I think that is a good rule for "local", but I thought we did not allow
"export foo=bar" at all, and required:

  foo=bar
  export foo

If that was only because of this bug, it would be nice to loosen the
rules a bit.

-Peff
