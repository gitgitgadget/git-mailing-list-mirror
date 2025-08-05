Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7362E36F6
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420227; cv=none; b=p0uktthq4h7SEDSadiUEt0drWhjVJcVxHY1H2QcGRnqK7nVVF9cC80V72KyyBbpY0+cnftAhC0NELEGIDsuROSb5Y6ZV+j9LOos3HaernNAW/WlWklcTVDE1VWrp2roq8A9cbpbsJlUVLktgIa54o14DSqLSP1LFUI76G7Kiedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420227; c=relaxed/simple;
	bh=5yNdp0W/QLS3KKfh46Ow4XesRTjwdnAtvg1Xaa1HrNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlGJl8BXkPTYahyCMWxnBIRGJ7u6jswQMJdsIcoKcJYbZZd12rDPQpAnZ42UoSlhZ4HiPkTS1vMt1YgZyuU3iEa41lcHFisxYPZF8T3O/Q81OeSC884B7Ed2JY0w2Ec6GRXJ1B6z3vYo+HnXi0p5b/iQHOU0xo7fyzgRDwEvvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ey/lul/6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ey/lul/6"
Received: (qmail 16034 invoked by uid 109); 5 Aug 2025 18:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5yNdp0W/QLS3KKfh46Ow4XesRTjwdnAtvg1Xaa1HrNI=; b=ey/lul/6UDQhVqgCHfolyHaT213HBl1SJQGyNAf8Du2EhKmmhKedZp9kaFUtmzHy94pvKrPG0omXYmionJh2Di1/aQkD1rBxIHe/Mz3m1WeZQxOCGdbagx6SI86oLICOvJpgqSOdieLjWxisJzyJ7hcKT9XqeJZRHZVmt0q+ZMqP0XFHPO3Xf5/W0Hra/W7MANnOZ31suDBTLFgaaB0NDezTmoLLvElJLriSOmBB1FZiHkdPMpg/FbTAR7ozziBHtDjK0rudS3Nep3rfkFZVoss9mxvq9WWQYSizvS2ZqNmfcPbjsf9Uy7p9yR03Od1KQLdPLH7zUG0Mi+Jdkw5u6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Aug 2025 18:57:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11161 invoked by uid 111); 5 Aug 2025 18:57:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Aug 2025 14:57:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Aug 2025 14:57:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
Message-ID: <20250805185703.GC1345110@coredump.intra.peff.net>
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g>
 <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
 <20250802094657.GG3711639@coredump.intra.peff.net>
 <CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>
 <20250802185238.GE1773585@coredump.intra.peff.net>
 <xmqqbjoxgd83.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjoxgd83.fsf@gitster.g>

On Sat, Aug 02, 2025 at 10:56:28PM -0700, Junio C Hamano wrote:

> > So I wonder if we have painted ourselves into a compatibility corner a
> > bit, if we have two conflicting expectations. We might be better off
> > just teaching check_filename() to parse multiple of [^/!] and the
> > trailing colon. It's horrible and not great for maintainability, but
> > this syntax is not something that changes often.
> 
> Ah, OK.
> 
> So the idea is that when given _as_ a pathspec element (e.g., after
> an explicit "--" separator), we do want to interpret ":file.txt" as
> the same as "file.txt", but when dwimming to sift revs and pathspec
> elements apart, prefer to take it as a blob object name in the
> index?

Yeah, I think that is a good way of framing / justifying it; DWIM can be
looser because it's inherently about heuristics.

I don't plan to do anything with this topic anytime soon, but maybe Ben
wants to produce a patch in that direction.

-Peff

PS I'll be offline for a week or so starting tomorrow, so apologies for
   any discussions I leave hanging.
