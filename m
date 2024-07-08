Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37E13ACC
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429153; cv=none; b=LVAeDOZgH1UIy4Sj8pEBa9cSX5C/ul+rzmzK3u4i9RK0GO26Dtz4QOUgbjdOOsF53DBw4MyiYwZtqTkPi7pAxjYuH+UPVYjt8KIxtxuHS1jEFJVTm0Qad4GhdABllONJhwGKNv8jbCizOOq/pJkM1caoMzYUy6KBMDHuh7NsRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429153; c=relaxed/simple;
	bh=P/hAL1kdFspLfvxIwrTGm5YWRF+sUKEMpERzWtq38Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nucZkkde+wuZLqZ/NjDWmTVrJKwThavsUEXX5+JqD9avzeYPnFH9TxX4HgrPyYitBBYZVVjtFTc9jwAxjBdOa6TfdSfxDO2nAc8UEkdrgCar1LDHHBHEad5gWeZF17EVSgwTLJVB+xH7T7cKDeWzjrPfI4P6L0gekeeiLetE/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14113 invoked by uid 109); 8 Jul 2024 08:59:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 08:59:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20557 invoked by uid 111); 8 Jul 2024 08:59:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 04:59:07 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 04:59:09 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 3/3] t/chainlint: add tests for test body in heredoc
Message-ID: <20240708085909.GB819809@coredump.intra.peff.net>
References: <20240706060143.GD698153@coredump.intra.peff.net>
 <20240706060754.GC700151@coredump.intra.peff.net>
 <CAPig+cRzoyxQpNf15nGeHDdDQK64KRJXLdgKN2rkXaN+2SjTZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRzoyxQpNf15nGeHDdDQK64KRJXLdgKN2rkXaN+2SjTZQ@mail.gmail.com>

On Sun, Jul 07, 2024 at 10:43:45PM -0400, Eric Sunshine wrote:

> This one made me think of an additional pathological case, though I'm
> not sure it's worth having a test:
> 
>     test_expect_success 'pathological-here-doc-body' - <<\EOF
>         echo "missing chain before"
>         cat >file <<-\EOF &&
>         inside inner here-doc
>         these are not shell commands
>         EOF
>         echo "missing chain after"
>         echo "but this line is OK because it's the end"
>    EOF
> 
> It's exactly the same as your test except that the same tag ("EOF") is
> used for both outer and inner heredocs. It works because the outer
> heredoc is introduced with `<<` whereas the inner with `<<-`. The
> opposite case, in which outer is introduced with `<<-` and inner with
> `<<`, obviously would be bogus.

Ooh, that's devious. I'll add it.

-Peff
