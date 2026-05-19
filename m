Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489643C0619
	for <git@vger.kernel.org>; Tue, 19 May 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225758; cv=none; b=DWB8vefZybVypGnm9ULurPFA0qHwHKWmiyWr3efup+NTyFsURsRScr6MPHNzm2Novk2qa4ikUyCyzsRgI/kuBeFfcJj4HmQeOr4EUGrYMorOvb1Y7AVAkVNryPJ6wD4zV7s89XEA4FgysX9QQ92ID1lPvR8jEH7V/eKxjRYUTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225758; c=relaxed/simple;
	bh=LtzEDXgb2NzssOZ9qy9fDn1ckd0wdNyyCXm7GrNVFi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG/pu0H7N4LyWp/ZBB7m3F/JCOmQSSMpkIZlEYfsx/Bt8Cd03RILibY1YlpOV8gHUXtrET/1+dlmRZJ+Zz1rf5k2MzgujniUDRPsuzYoJO+nAZxgcDy8kRKXT4SHyX4gD3Xv6twbO+7lBGL45RJp6XWyh9PHltScPbP65xconq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UxmmhoFP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UxmmhoFP"
Received: (qmail 24085 invoked by uid 106); 19 May 2026 21:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LtzEDXgb2NzssOZ9qy9fDn1ckd0wdNyyCXm7GrNVFi0=; b=UxmmhoFPCaWhOLno2TRwaAb8FrvQ4a4nUSfrbkoaBNgRfTJ9xSYyZFR0Ms+ZI0S7SJ6fngF6XrUGaEMagSMBlf+yIjRG5yNQX6QJJ1ke8lUpOumcbMA4bTzKDtSDm/PdjYSsbEr2FItrx5Ya0BY+BdbVnFpKrUp65gJV+nhcR8twErixrjA5WpusJHPb9t+XBO3fZpzE3ynnkKhCHlfTH/LTQJQ+sN5rdd1xFC6IUYnHkpe77yZ1BVMqPCNUUtF+70ZeDio60P97tDf/CDSLPrfgLuThP+aVQk1sRlLh4vzpLky2r5iM742bEwFmDABxHfkvpNYi6SvWcJT1PNHjcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 21:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 56919 invoked by uid 111); 19 May 2026 21:22:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 17:22:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 17:22:34 -0400
From: Jeff King <peff@peff.net>
To: Greg Hurrell <greg@hurrell.net>
Cc: Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without
 arguments
Message-ID: <20260519212234.GA2278669@coredump.intra.peff.net>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
 <20260508141314.GB709299@coredump.intra.peff.net>
 <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>
 <20260508175240.GA737125@coredump.intra.peff.net>
 <agXb1SXKnA69L9ak@mbp>
 <8f4b75d8-f875-434a-8fc5-06a708cbc53f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f4b75d8-f875-434a-8fc5-06a708cbc53f@app.fastmail.com>

On Tue, May 19, 2026 at 11:03:44AM +0200, Greg Hurrell wrote:

> On Thu, May 14, 2026, at 5:40 PM, Erik Cervin Edin wrote:
> > On 26/05/08 09:07AM, Greg Hurrell via GitGitGadget wrote:
> > > -usage: git jump [--stdout] <mode> [<args>]
> > > +usage: git jump [--stdout] [<mode>] [<args>]
> > 
> > The usage message makes <mode> optional but doesn't explain what
> > happens when you omit it. Seems worth documenting the auto-detect behavior
> > there too.
> > 
> > If we're going to teach git-jump how to be more clever about where to jump,
> > does it also make sense to bake `git jump ws` into this?
> > 
> > Also, if this is going to grow into a proper auto-detect heuristic, it
> > might be cleaner as a first-class mode rather than logic spliced into the
> > argument parser. Something like:
> > 
> >     mode_auto() {
> >         if test -n "$(git ls-files -u)"; then
> >             mode_merge "$@"
> >         elif ! git diff --quiet; then
> >             mode_diff "$@"
> >         elif ! git diff --cached --check >/dev/null 2>&1; then
> >             mode_ws --cached "$@"
> >         else
> >             return 0
> >         fi
> >     }
> > 
> > That way `git jump auto` works explicitly, bare `git jump` defaults
> > to it (just `set -- auto` when $# -lt 1), and the usage text can
> > document the heuristic. It also keeps the detection and dispatch in
> > one place in case someone wants to tweak the priority later.
> 
> All of those suggestions sound reasonable to me. Jeff, do you agree?
> If so, I can update the patch.

Yeah, I agree that having an explicit "auto" mode (and then just
defaulting to it) makes perfect sense.

I don't really have an opinion on adding "ws" in here. Despite being the
person who added the whitespace mode in the first place, I can't
remember ever using it in the last 10 years. ;) But the cost is fairly
low to support it, so we might as well.

-Peff
