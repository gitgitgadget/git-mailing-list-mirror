Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E9819
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725690077; cv=none; b=lkWS95Ji19nrlvkaPcntw9+EdwHD+WUi2nmm7frALPMDhV1as+AjR6oHoYGZs4QsKiyUQ7w5fUuqPOG0iFxQF5ATmRkNISEHxj17pB4pDRrEwNBTXFYwMnuhcTZ98+oL6o4Z5hyzNZDhbuJWeIJ8/tDQDox1LpTWBH/6JbX90yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725690077; c=relaxed/simple;
	bh=ZhfWo6iUFGKvU7Frc0vMJRVtAdgDLVI1GbgJGVU8MZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkFMFeswI9S036kmFg/dUNkMkaF73A2JKqx23TDGEUaeX0TjFAVfTkmCX9TG7Eqg9QR+cUhiut9THKE/+qjFhjUc7W8gTKFZVDDNsBa4IVl+0R/xFRNL0qHb4GVxsYMo+y3W1NDWamaZA+g/LEkT0NMfCn6DFBSxDw0xZF/2EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27569 invoked by uid 109); 7 Sep 2024 06:21:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Sep 2024 06:21:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27004 invoked by uid 111); 7 Sep 2024 06:21:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2024 02:21:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 7 Sep 2024 02:21:12 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [RFC PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
Message-ID: <20240907062112.GA2585439@coredump.intra.peff.net>
References: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>
 <20240905104331.GD2556395@coredump.intra.peff.net>
 <c18fc95a-4dec-4e7b-8ec3-ba9747e9c464@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c18fc95a-4dec-4e7b-8ec3-ba9747e9c464@ramsayjones.plus.com>

On Sat, Sep 07, 2024 at 12:53:11AM +0100, Ramsay Jones wrote:

> > Certainly doesn't hurt to test the single-key mode of "add -p", etc,
> > though.
> 
> Yeah, I still need to check the 'other uses' out. Hmm, I have never
> used 'add -p' (never felt the need), so I guess I will have to read
> up on how to use it ...

Try:

  git init
  echo foo >file
  git add file
  echo bar >file
  git -c interactive.singleKey=true add -p

Hitting 'y' or 'n' should immediately be accepted (and exit the program
either with the hunk staged or not), whereas I suspect it would not
without HAVE_DEV_TTY.

-Peff
