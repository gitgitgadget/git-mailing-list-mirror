Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D732134A8
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069627; cv=none; b=OLUd3Mz1jTKTZVVKUXLpYHv1H1mBYXpeBiFud1dKJsKIjXC9a/KUTzVgClRKofGb2BMDS8VMlgCRP5XqgI92opp62l9Q1V3eHZnggPT46h1IfSPbO4zFWaXwtVJkR2cBSRD7T0lLa/rhJe3OUC/2UClYnWGE1IKJoAtchDE35vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069627; c=relaxed/simple;
	bh=HAfoC8hL3Dr1n+O33KSKnYaotaUpj/+w3by3nUjjX1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atTuvN8QjHELKXkTMhvmdW/bXHNJhiNliUWOfjyEZOdzIvSXs1TXIjPa9tVku8kCYV1F1a1DKx95T9MsQgM1CclIqr+DM9dj+YuwklVygkBpkj9zv4m1GvLBepaDh39Nj0obhtf6/Mb5i4lBBC7boel62yTUSkUHyI+DKe+QW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=KP/31s21; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="KP/31s21"
Date: Wed, 16 Oct 2024 11:07:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729069623;
	bh=HAfoC8hL3Dr1n+O33KSKnYaotaUpj/+w3by3nUjjX1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=KP/31s21+tWKetffGWr40rvHK2405g/Wp+uYZMcFgOcg8j8lZ6J0bdaKX1n5R6KEP
	 5xCHVVpwy12Z8RCxPgIJ/EvkQVTVtpBXJZUUX4byeZ7179BJ2GTrZXFVTOtd8ALV1q
	 pRLPgnLBVG/H6kHqcHF4o94LCrg+zGWTLHKLCru8+qH97+wbitGs1OcbrefVYrr13w
	 Ib5vEcIZADIYGmw1l1gVcvhh4xVlyk8duONVy4jc9hk1AHo48baFd26yvIb/wzvdyy
	 sKMHqF6/I0vaboEarJLgUBtzb9CAXJqL5cPLsJxkxNH1bH3SDP/1F5X8f72+35IHhh
	 kpsVinYE8yJeQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <yxfpbmwy5bhtjwmffzrfoagugs4rsxw7wn2cvve5ygzcnlolpu@lhjgpz4riogd>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw9_46fbvbGhjmYw@pks.im>

On 2024-10-16 10:57, Patrick Steinhardt wrote:
> Given that we do set `log.abbrev` I think we should be hitting code
> paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
> example would use `log.abbrev`, wouldn't it? It would be nice to figure
> out whether this can be made to misbehave based on which object hash we
> have in the input.

I did try this, but like I said, --format seems not supported when
git-shortlog(1) is reading from stdin. It always outputs the same
summary format, either grouped on authors or committers. This is not
explicitly documented anywhere - the manual only says that "git shortlog
will output a summary of the log read from standard input" and then goes
on to document all the options with no mention of a difference in
behaviour when reading from stdin. So I'm still not entirely convinced
that this is impossible to trigger (also given the complexity of the
argument parsing machinery), but I have not been able to find a way.

> I think it doesn't hurt to have an explicit test for this scenario, even
> if it just demonstrates that things don't crash or behave in weird ways.

Sure, that makes sense.

> You can take e.g. b2dbf97f47 (builtin/index-pack: fix segfaults when
> running outside of a repo, 2024-09-04) as inspiration for how to achieve
> this.

Thanks much for the pointer, I'll have a look!

-- 
Wolf
