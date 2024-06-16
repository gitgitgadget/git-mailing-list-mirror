Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC99225D6
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718582039; cv=none; b=WG5YnKHmMJvOxVm/c89JqT5FuD0X6NqX/1HwG1AvutFeTEqnO3U7QCpIRgnfy3QRYYa7O1jOUaqTA7XPMdBSEsvdNsHfdlAr2yh3IC1ThWZaYksHjqDK0I5keuSYxNUt71S5eteMWwLkTGIKTXpjsQYSonvDdararfav+ez1I+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718582039; c=relaxed/simple;
	bh=LdjXQGS9M8Siz9Emqcj3Sczeoq9DnKngPODBQEQrHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X00uKMWfHock23CLoKaGjs7dE2cYSRdcTC1hfvf8KRm+sBT780AwT82X7Y42Zcm8YlFP+1QJ6JqmCo/eQOVen6lnz8LaLiESI/aMGPn4t4U4I/bflMgKCjcPLrYjGxgCw4VUgXWjm8XCwiLFxHw5xxKCOf4zykIFHKmIOd9XrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=5nI6LWR1; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="5nI6LWR1"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C8A1F7BE;
	Sun, 16 Jun 2024 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718581661;
	bh=LdjXQGS9M8Siz9Emqcj3Sczeoq9DnKngPODBQEQrHcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5nI6LWR17tHNYVmoecibd5L26pKwIXI9sQnUodM4gwOpal8ytYE1taueeqGiXAiy/
	 3z5aKgFY/VkvDEhNgpm5OQYLte37cN7kjDBgFxNnvY2l4t2IZVgw6wlE1CLfigrDb4
	 7varUjMT/9DIYu4gbZyTpheqNh2x41EAHec3LYO0=
Date: Sun, 16 Jun 2024 23:47:41 +0000
From: Eric Wong <e@80x24.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: RFC: indicating diff strategy in format-patch message headers
Message-ID: <20240616234741.M713118@dcvr>
References: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
 <xmqq5xuns10v.fsf@gitster.g>
 <20240605-zippy-wildcat-of-recreation-8c644e@lemur>
 <20240605222658.M32384@dcvr>
 <20240607-ultra-unicorn-of-democracy-d25a69@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607-ultra-unicorn-of-democracy-d25a69@lemur>

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Wed, Jun 05, 2024 at 10:26:58PM GMT, Eric Wong wrote:
> > > That would be redundant with the message-id. Unfortunately, this doesn't solve
> > > the problem of how to reliably map a commit to the patch from which it
> > > originated, other than using the Message-ID: or Link: trailers.
> > 
> > dfpre:, dfblob:, dfpost: search queries on lore seem to work...
> 
> I've thought about that, but this is also not very reliable, at least not when
> patch series are applied as fast-forwards, not merges. Unfortunately, some
> projects enforce a flat history (glibc, gcc), with merges being specifically
> not allowed -- which means dfblob matching is not going to match a lot of
> commits.

Yeha, my initial plan (way back around 2016 or 2017) was to use
Subject; but I also forgot why I stopped with that idea :x

Anyways, trying to add bs: (body+subject) to queries in addition to dfblob
may prove useful:

https://public-inbox.org/meta/20240616233532.574646-1-e@80x24.org/

Not sure if author + date is necessary...
