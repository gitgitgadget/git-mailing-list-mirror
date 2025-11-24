Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF82690E7
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025058; cv=none; b=t2CfJYlTTh+Osfm38vepWJwyt2+CUP+4GkykYJVTiR7XiR8KfIO88VTkfNIr+69w4o06KD2mjpVooE7s1hjQc+xebBv4SOElQif73Ir/QDEQMYV8st0OSnaCu+NTJNMCHO98wzh2R8zOCd7Fz2BXNrmBBlzOv/bsgUcEcRZKsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025058; c=relaxed/simple;
	bh=yuzNIhieLTPzG4UUapDqdpNJNZT5gQEscVC95m7BA/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckqpSndY3vfr/oDAPKMiRg9tlDLMdaGr1P/9D+xU0GNdfnJX4hh2LxPQsLUbpQNdFhSNfTH9rkJKr7bZ12yT5UoOc/kGM5n+0bfu5u8u+RtEWl/lYl0WrRqXzvh3kVkmNPLgk21iPsFL1WuDa5uekUNtiXZyRlMkmXkH5KvEqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hvVL24BW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hvVL24BW"
Received: (qmail 92011 invoked by uid 109); 24 Nov 2025 22:57:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yuzNIhieLTPzG4UUapDqdpNJNZT5gQEscVC95m7BA/U=; b=hvVL24BW7XfZXLEwd2EfGFNstvadJlFxOqBNtYTYrq2q8GIRuec8ASHjMourxLbz6g7urbvrRoe4vwRnCFw9U4kSOPwn7WHhoUWW+gxg8lwwlcPsUC1uxqhWTFtXiUpH52B+KhHkg+gDsamI2U+Y0x44f1MxVwASw2kpoPvApFhnqbVP9rlKwkFtRBDVg9mC6EOscay5ALq3GvqmtQz8cTm7yNW83TE9JuOUuGddPOEnDHYI10+fQY/M5uvxgQSapoI+/+bMZeCKjpzm1JtztYG2Oo2OMAJlXwxuiI6a+hEBlZvTtK1lIoU1tqZoiDAIx7KJ4q9a3ZajxaBfRyrbGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Nov 2025 22:57:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 156234 invoked by uid 111); 24 Nov 2025 22:57:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Nov 2025 17:57:37 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Nov 2025 17:57:34 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org,
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
Message-ID: <20251124225734.GB2051672@coredump.intra.peff.net>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
 <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>

On Mon, Nov 24, 2025 at 11:20:05AM -0500, D. Ben Knoble wrote:

> Thanks! As far as backward compatibility, I think this behavior has
> been around since 2010's 8b1fa77867 (Allow passing of configuration
> parameters in the command line, 2010-03-26) which morphed via
> 572e4f6a0c (Use strbufs instead of open-coded string manipulation,
> 2010-03-26) into the strbuf_trim(pair[0]) that you pointed to as
> disappearing.
> 
> Interestingly, I note that we dropped the trim around pair[1] in
> 06eb708f33 (config: always parse GIT_CONFIG_PARAMETERS during
> git_config, 2011-05-24), but I don't see that discussed in the commit
> message either. I tried a handful of mailing list searches around
> 20110524224955.GC24527@sigill.intra.peff.net, but didn't find any
> relevant discussion (though my lore-search skills are mediocre).

Yeah, there's really not much (any) discussion in that thread. I don't
recall why I would have removed the trim on the value side, but I don't
think it was an intentional choice. I don't think either trim (key or
value) really makes much sense. I'm kind of puzzled why we had them.

I thought it first it was to be lenient in the environment list.  This
code was originally for "git -c foo.bar=baz", and we are not even
parsing it directly there. It gets shoved into GIT_CONFIG_PARAMETERS and
then re-parsed from there. So I think it was an attempt to be lenient
about writing:

  GIT_CONFIG_PARAMETERS="foo.bar=baz     other.key=whatever"

But it predates that! The environment passing came in 2b64fc894d (pass
"git -c foo=bar" params through environment, 2010-08-23). And it always
shell-quotes the names, like:

  GIT_CONFIG_PARAMETERS="'foo.bar=baz' 'other.key=whatever'"

so the extra whitespace would need to be inside the shell quotes to
matter. So it seems like it really was about allowing:

  git -c ' foo.bar=baz ' ...

to work. Which seems odd. And as an added bonus, that was already
broken! In 1ff21c05ba (config: store "git -c" variables using more
robust format, 2021-01-12) we switched to a different format which does
not call git_config_parse_parameter() at all, and does not do the extra
trim. (The old code is still there to read the non-robust format, but
new Git will never write it).

So this recent refactoring of the function is left affecting only "git
clone -c", which does not pass through the environment (we write the
variables out directly into the newly-cloned repo's config).

While it is a change of behavior, I'm tempted to say that it was not
something that was ever intended to work, and not worth going back now
to restore.

-Peff
