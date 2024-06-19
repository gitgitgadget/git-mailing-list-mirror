Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7ED55884
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819796; cv=none; b=hpFm8XzrBfxTUe26unX24re8ma/afBqE2C1TL0RFTq64HgN1sdi+E0XPGELNHOyalTAvh+4E04wlVckjFkABp9inPWZ8MX3MuhHYUCSSNAPlFpWYXHYBfQjSIDAmlp8HE8aMVxZSk0+KHkgvaVfRnDCKewuWZry+J/EsG6tLkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819796; c=relaxed/simple;
	bh=geiD0TwIQqIx3kKDPQq1hj9r5npXnudIk3XN9DkJMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz6ISuA/ppLsmlbgBz5qEPMwURU/5ErFTWFIKfBuNrf2I5cMKDuDEs0y+30rnN9sSTIexaDPXOvEtijwgeDX2CPTqaitWOg/6nysZS9JzsLy/E3vAg5UCUfI9QhlAcbcpyA28Hfn3MjzuvZ/ood/C6Cg2J6LH2nBw1bQyk7lUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=nNWlczy+; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="nNWlczy+"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF1DD48B4;
	Wed, 19 Jun 2024 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718819794;
	bh=geiD0TwIQqIx3kKDPQq1hj9r5npXnudIk3XN9DkJMjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNWlczy+F0NX4crJKZZSI0FYLHeVCrn29pAo/07ZKkNWyGjL1znFrfdL2qQmlguUj
	 k9AaRMZBNJddUY00qiLhWxgzkYgsFnigAK4ZwpbPGsWXZZ5EPe6WkLJa5fI27AZ+Bi
	 IpIAlgliB6ZG7A5SfZ+qIzMVXSHIdNWk8ieK2yUc=
Date: Wed, 19 Jun 2024 17:56:33 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
Message-ID: <20240619175633.M826655@dcvr>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <xmqq1q4v5m5a.fsf@gitster.g>
 <20240618213041.M462972@dcvr>
 <xmqqzfrhyg8j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfrhyg8j.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> >> Yes, using Perl is a good substitute for writing it in C in this
> >> case.  I however question the choice to use t9700/test.pl here,
> >> which is clearly stated that its purpose is to "test perl interface
> >> which is Git.pm", and added tests are not testing anything in Git.pm
> >> at all.
> >> 
> >> Using t9700/test.pl only because it happens to use "perl -MTest::More"
> >> sounds a bit eh, suboptimal.
> >
> > *shrug*  I figure Test::More is common enough since it's part of
> > the Perl standard library; but I consider Perl a better scripting
> > language than sh by far and wish our whole test suite were Perl :>
> 
> Oh, I think we (actually the author of t9700) considers it common
> enough that we have PERL_TEST_MORE prerequisite to allow us to write
> tests, assuming that it is available, and let us easily skip where
> it is not available.  So I do not think I mind the dependency on
> Test::More at all.  Moving the tests to t1006 and rewriting the
> tests not to use Test::More are two separate and unrelated things,
> and if you are more comfortable with Test::More (and more
> importantly if it is natural to write Perl based tests using
> Test::More), it is not necessary to switch away from it.

OK, fair enough.  Given t1006 is mostly sh, I prefer keeping v2
as-is because the Test::More->builder munging of test numbers in
t9700/test.pl is nasty too and I wouldn't enjoy duplicating
those bits in a hypothetical t1006/test.pl, either.

It would be nice to have first class support for Test::More in
our suite so we could just have t/t0006-cat-file.t and
t/t9700-perl-git.t implemented in Perl without sh at all, but
that's a separate discussion.
