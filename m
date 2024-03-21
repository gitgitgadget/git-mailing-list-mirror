Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63C757F7
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026827; cv=none; b=us7ENMKX9acL8c2B9aDrSpdNrBRW+NOwxlen/aapOH4LSFfkCixGJiwNpvnyeNDAqiOOU6U15/MP/TX54RWwvWw11NxCSquw6qQOo/5Le9cymAyWsPCe88vmkYIijTHQ4zQepPhu0WgNv4n9vS0c0kMJ5BGMR++EdnUQGpgo1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026827; c=relaxed/simple;
	bh=lq9nBW+dTzU7kZhpJmWnXTaYlPNXHAXig7cPpzMEEWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNEPWouCbknkhUYR+ipJ9itOTOcFfViQlpKHsbNvahSl2qD8OQy0wqSrsjmOnBDC61wj2ZP6XUe1DNQDWZT4N0ZRYsLvKtVuuwSXuxPYzEBQALeJgpxgb9STtN1vmuc+L+vZI2V49jh6xx2stuzAwH3+jEe0V6Pz8cnIj5u42TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=oekcKsMW; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="oekcKsMW"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 352C660334;
	Thu, 21 Mar 2024 14:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711026822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i26d0bExCCbWymr1YuJyOs8eEKgjmN084/ftiqLcCjc=;
	b=oekcKsMWq+zMD5/Mb0m2mS6gfDoFX2Oz8pdVvT5O1GGV+wBxHGB80ZBhp84rsmLd82v4pN
	CuoV+AGwgjKsHa4331GaWJxZaB85JPNmdXb0Fbw1MNK1u/nmUsCr4uT7731U0ccoKzwFL5
	RbvvwLaAf4gzA0TVBYdQtJ7WKTj1d5HAQBvwt/Y1XLTzicwYkEbtfMOnjMfMrSwky3Slqt
	aaZR+jNXy4DtDf+RiNak3NLhpAMhEIbygOugH0B7XFaVNj/EDXp7RHZDHE4udgO317vDy6
	CvIXkEAzfYpnJWtyd61J5Kz1Cpgb5ePvqSNZdCm18d39WvRHwc1lElEzvaYaTg==
Date: Thu, 21 Mar 2024 14:13:41 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 2/5] maintenance: add fixed random delay to systemd
 timers
Message-ID: <ZfwyhSgvhDASusFf@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-3-mg@max.gautier.name>
 <ZfwqD7z6S8Olc5xa@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwqD7z6S8Olc5xa@tanuki>

On Thu, Mar 21, 2024 at 01:37:35PM +0100, Patrick Steinhardt wrote:
> On Mon, Mar 18, 2024 at 04:31:16PM +0100, Max Gautier wrote:
> > Ensures that:
> > - git maintenance timers have a fixed time interval between execution.
> > - the three timers are not executed at the same time.
> 
> Commit messages are typically structured so that you first explain what
> the problem is that you're trying to solve, and then you explain how you
> solve it. Your commit message is missing the first part.
> 
> > This is intended to implement an alternative to the two followings
> > commits:
> > c97ec0378b (maintenance: fix systemd schedule overlaps, 2023-08-10)
> > daa787010c (maintenance: use random minute in systemd scheduler, 2023-08-10)
> > 
> > Instead of manually adding a specific minute (which is reset on each
> > invocation of `git maintenance start`), we use systemd timers
> > RandomizedDelaySec and FixedRandomDelay functionalities.
> 
> I think it would help to not list commits, but put the commit references
> in a paragraph. Something in the spirit of "In commit c97ec0378b we
> already tried to address this issue in such and such a way, but that is
> quite limiting due to that and that. Similarly, in commit daa787010c..".
> 

Ok I see how that would work.
Stating the limitations of the implemenation added by those commits
would be the problem we're trying to solve, then the proposed solution.

> > From man systemd.timer:
> > >FixedRandomDelay=
> > >  Takes a boolean argument. When enabled, the randomized offset
> > >  specified by RandomizedDelaySec= is reused for all firings of the
> > >  same timer. For a given timer unit, **the offset depends on the
> > >  machine ID, user identifier and timer name**, which means that it is
> > >  stable between restarts of the manager. This effectively creates a
> > >  fixed offset for an individual timer, reducing the jitter in
> > >  firings of this timer, while still avoiding firing at the same time
> > >  as other similarly configured timers.
> > 
> > -> which is exactly the use case for git-maintenance timers.
> > 
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > ---
> >  systemd/user/git-maintenance@.service | 1 +
> >  systemd/user/git-maintenance@.timer   | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-maintenance@.service
> > index 87ac0c86e6..f949e1a217 100644
> > --- a/systemd/user/git-maintenance@.service
> > +++ b/systemd/user/git-maintenance@.service
> > @@ -1,5 +1,6 @@
> >  [Unit]
> >  Description=Optimize Git repositories data
> > +Documentation=man:git-maintenance(1)
> 
> This change feels unrelated and should likely go into the first commit.
> 
> >  
> >  [Service]
> >  Type=oneshot
> > diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maintenance@.timer
> > index 40fbc77a62..667c5998ba 100644
> > --- a/systemd/user/git-maintenance@.timer
> > +++ b/systemd/user/git-maintenance@.timer
> > @@ -1,9 +1,12 @@
> >  [Unit]
> >  Description=Optimize Git repositories data
> > +Documentation=man:git-maintenance(1)
> 
> Same.
> 
> Patrick

Ack, will do.

> 
> >  [Timer]
> >  OnCalendar=%i
> >  Persistent=true
> > +RandomizedDelaySec=1800
> > +FixedRandomDelay=true
> >  
> >  [Install]
> >  WantedBy=timers.target
> > -- 
> > 2.44.0
> > 
> > 



-- 
Max Gautier
