Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5619CC0C
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550571; cv=none; b=Nko5mHghPgWCBxVe1egecKxq6szZmQJo+LgZPVtnsuI6I65aCNHOd2lZWEe4SGT15DxnH4vGRTgZDtNxMJb5G8HtPPk1n7VSs4+BKOb0BIQiMXMo3JP6+xj3HyAsvlx1NZpl1YfkLaJvuStHtWFPqwkZbC6vID3ircmjSSq0M2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550571; c=relaxed/simple;
	bh=VSZKCVT2JGhummMp1CAb0Io17m9hF6k/ypo6weOho7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaDdvv6JDo/PYg7gDfmlAqL7hbfrank98OJ8b4UbWLPSlUy0jYs/G7skRsQ9LPzaWaaFY5SwR95M9XU3Z+M5pf1wzG2ULSoM5lu5jVPusqmjM2q2fkIXtA9d7vpErH83AvBiV8n85y5CnQArXBEsYo4qKyuRgRDXhSB3IInk+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DbcJ2972; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DbcJ2972"
Received: (qmail 23232 invoked by uid 109); 18 Aug 2025 20:56:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VSZKCVT2JGhummMp1CAb0Io17m9hF6k/ypo6weOho7E=; b=DbcJ2972dFTRwtvvWe5ruYxeRkvYO4AXn5XgBFTupjQVQDcrbExBubhsTZx+Ald2NQhpNJKxi+3Gg2i28eKAbf4fhVazHU9l0Oe2pHeYHMdMAn8VjysO0ofKxc2HbrEA4IqVJmdjTef3E738eCW9Y7SEH7YDBBOMOBoJZB6UpBbAoZ/UIPSQPmsRwHWNHvRVDCMUPf0HLn1DmGxIa/WcFC3s1qiPt0QRWQRCgUTLMaWP0KPXb7RVGVhisNMT7d0D07KDizYUNkhQyUKkGe/JgArZHrZ42zTdaoZeXHkiHWVrjwCqaUuBJpxIuiCuBd8+z6iXyIZAxKPZF+ricX9Z6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 20:56:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30200 invoked by uid 111); 18 Aug 2025 20:56:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 16:56:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 16:56:08 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
Message-ID: <20250818205608.GA1018532@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
 <20250818044807.GA51803@coredump.intra.peff.net>
 <20250818050545.GA62231@coredump.intra.peff.net>
 <194415e5-2adc-4b3f-98d3-0fde4a288b5c@web.de>
 <20250818202140.GA1014353@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818202140.GA1014353@coredump.intra.peff.net>

On Mon, Aug 18, 2025 at 04:21:40PM -0400, Jeff King wrote:

> >   5. When process_object() has a commit, but it is indescribable, it
> >      shows an error:
> > 
> >      $ git describe 5afbe6da1d6ab0b8939343166636b828e561bf35
> >      fatal: No tags can describe '3b681e255cd8577a77983958ef7f566b05806cd0'.
> >      Try --always, or create some tags.
> > 
> >      It's not immediately clear that the reported hash belongs to the
> >      found commit.  And that suggestion to try --always is misleading,
> >      as "git describe <blob>" takes no options according to the
> >      documentation.  I'm not sure I like it in general -- can't tell
> >      if the command is being snarky with me.
> 
> Yeah, describe_commit()'s messages are not really set up to handle
> describing an arbitrary commit that the user did not specify.

Oh, there's one other related case I _thought_ was bug, but maybe isn't.
If you don't have any tags at all, then we'll bail immediately:

  $ git init
  $ echo foo >file && git add file && git commit -m foo
  $ git describe $(git rev-parse HEAD:file)
  fatal: No names found, cannot describe anything.

But we're traversing from HEAD, not the tags, so my initial thought was
that this should work. But of course it doesn't because we try to
describe the containing commit, which _does_ require tags.

And that leads back to: "well, you could pass --always". Which disagrees
with the documentation, but I think does actually do something useful
here.

-Peff
