Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734D386551
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676935; cv=none; b=Gs3jaBn5j10zmaUKj48t+UYsV/YLSc3PmnnQ81oPE2FngEW1fiIt/2Ov7QrTDdMPw/JIVrwa7kUV08ZqmCzAqua3YJHapLMfICrjlMrzXqGeUsdxaJ/rBDA1Nz8Qmym8aBydIQdxJyeiBQCXBHzwqHEK6rBJDj0UjdUcG1D1vvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676935; c=relaxed/simple;
	bh=VuZTH/9n50OAQdUlaURPnbRwviCVpdILHL8glPv3Y78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6SMQGZXmsHDVYQl/c41nA/eZwdUJWF7hKwGyvV8y8JVDNQmXBWjN9PCj4+7pqsRCsNDCj2F6+9BDB32/V6qSZfD7A4G/Z0orQZFjMPlEgkXF3i9l04LGnbbnVd5Bi1TUEzh57g35sld3g3HCuTQzNH7z33eXMm19gX+ua3pLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=R7MBpHqX; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="R7MBpHqX"
Date: Mon, 20 Apr 2026 11:22:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776676930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLd5m6TMVjNrsJlLT5pJdK75cuwNndFcoTteJTUr0BY=;
	b=R7MBpHqXHCo4kkA34dv+5aYY/LlLmrP2dYFRSRI5RrNZOc0DKPBy7OGj7cFwY6/7+bg7eY
	Ja106IZsh7KPpipP5vOzS3Mb1VhEl4T3nfSkCY761j8QjZPHBy2pp4JRat3mJ9CNLbFYf3
	oCaTpoXWme+2QmjfK3PRXG9W6Gn660xAy6vFYRS4oT4JYxscJshTrtjHKvG8djLK129GRI
	pJ+n6cqBf5yw2wp7Jcp4Tdqj5m+/iPgu11OegAd58hn3y5dWGF8sPFy6ChSkkaGQ/poE6Q
	vyr8dsw3QSIfcNhfmFwsDt2I/rjF2Js+BUs2xO88poMoRXdxD/+uQvZcpqqthQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aeXvuuhjTmHyumGq@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=mroik@delayed.space;
 h=from:subject:message-id; bh=VuZTH/9n50OAQdUlaURPnbRwviCVpdILHL8glPv3Y78=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp5fAzl9ppVqC/u53UviClSJx4KkD7cuiabHaRr
 z8KaN00vICJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeXwMwAKCRBIeX6hnBm+
 0XqvD/9a7KyOm7VayxiOGBXBjXg7IhMGqhcIEyTivJQ53IC4nLTrRFjSLjYnfHUNuPxasd+b1i5
 DHcpALsBKYmPDgTDOxfJLgFJhl1qxgWWNvcE/TxyPTSyZbWu2Wk/8HBBy2MtJVPuwmJBAg+ttrO
 Exgj00GpzipnYVNjUmrPnKn88EESvKhIEZ+D43e6t3m1P2peydS7CZVLfa+D7Ijw4Iiw8u4zYSI
 lVqgdOxogbJYGcwMsUQ49sYMhe3Mrzv10OUcBlAtHgKKz7G3MdCN9JTrGAqQY5wKZGPlkceiDbS
 Uw0ptDSzArGI4uaAvfgt71+Isq/61eGGfNU4ARrYaSN3oYBDzsFx+I5DXVX/0iuud5+XcbXlBH2
 G9KT+8m3VY8pJkueUtkYbdsSV/8R1QNxL48CzcsH3rfeGLwxqY3bJazAiih/rnD8ffofV+J9aF7
 YsZmaAyiD68x2dj6QSXdBX7n+qYtmbKu5l2ztzLkY5ctLfUDez2cusxHSKpRrxiSinZqy3WHUSD
 mOw/ZaOMaOke+J+yjJFNvH+Tnl4vIE5pVmTySOE46JunVJdOIaGebCRdLeZ8UnR56KI1/igbKBL
 pVbNTcGuZPinjAcgpJCMf3Ks8HD8VHQ5//hzsUtpfqCDSNWNPi3UayUwTSZ5hKKkmmPeFWcOpEM
 q0sZCsij15hlc6w==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <20260420000440.GA1238475@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420000440.GA1238475@coredump.intra.peff.net>
X-Spamd-Bar: --

On Sun, Apr 19, 2026 at 08:04:40PM -0400, Jeff King wrote:
> On Sat, Apr 18, 2026 at 06:47:35PM +0200, Mirko Faina wrote:
> 
> > @@ -2685,8 +2685,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >  		else
> >  			git_log_output_encoding = xstrdup("");
> >  		return argcount;
> > -	} else if (!strcmp(arg, "--reverse")) {
> > -		revs->reverse ^= 1;
> > +	} else if (starts_with(arg, "--reverse")) {
> > +		if (!skip_prefix(arg, "--reverse=", &optarg)) {
> > +			if (argc < 2) {
> > +				revs->reverse = 1;
> > +				return 1;
> > +			} else {
> > +				optarg = argv[1];
> > +			}
> > +		}
> 
> It looks like you're trying to support "--reverse after" here, but don't
> do that. Flags with optional arguments must use the "stuck" form,
> "--reverse=after", which is covered in the "gitcli" manpage.

Oh I see, I thought I had to parse both ways. If I just have to allow
for the stuck form then it becomes way easier to deal with.

> That's to prevent "--reverse --foo" from being ambiguous. It looks like
> you try to limit that with the final "else" here:
> 
> > +
> > +		if (!strcmp(optarg, "after")) {
> > +			revs->reverse = 1;
> > +		} else if (!strcmp(optarg, "before")) {
> > +			revs->reverse = 2;
> > +		} else {
> > +			revs->reverse = 1;
> > +			return 1;
> > +		}
> 
> but that just makes things more complicated:
> 
>   - doing "git log --reverse=bogus" is silently accepted
> 
>   - trying to show a branch named "after" with "git log --reverse after"
>     has changed meanings
> 
> So I think you really just want to handle "--reverse=" separately from
> "--reverse", and the latter should behave as it always has.
> 
> -Peff

Thanks you
