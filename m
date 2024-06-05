Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FB27701
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626836; cv=none; b=IWp/VlZqW3mT+s1L0IaJOJffzlaQIz2xDqcDSTc0wMMW+r8KGBudeokJw4dy5BZq3RSPd60u3m1VoBpElGlNYRIx+OB0r1ku/5FJ1zdoms1PXgZOdPCilebf4ze/V/qagUvyTsQ4Xv69P8dAGnjfVHEQM2D62TDU/SGVrPxXqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626836; c=relaxed/simple;
	bh=txQHCX/Y/hXV2FstF+tqw4Ti1RqeFOGZdeGkDpbxulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdZRVdXXpudMX3/egELpa75eqq2QoaVSk73+h7+83SRE9VyMT3vP7BFpWONQhP03POtK0P36l2kP+9otK7qqlLvJzt8wwFIZhWHRsQMAgksbBvtebeUuw2Pi+a8F8jbqreRZWSswL3k68ZPpShs4VfwMaTDxWe9euomJgv9chrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=bFcRlRZp; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="bFcRlRZp"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBC91F518;
	Wed,  5 Jun 2024 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1717626418;
	bh=txQHCX/Y/hXV2FstF+tqw4Ti1RqeFOGZdeGkDpbxulU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFcRlRZpm+iBGr0c80Om7BnNXFmzIH8Jr2my6BPmkvDDY2hrPvASzhu6AkIMlddyv
	 jYkad5GZ7w7guryOGNiE+IKNVaZvIBXVjHuouWWXTLbT14Mz13Iu4mbC6e/IAK3hHk
	 YvDoy/yi2wd3sqTJTfKC+OGQFADAHlBxrdgm6jRs=
Date: Wed, 5 Jun 2024 22:26:58 +0000
From: Eric Wong <e@80x24.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: RFC: indicating diff strategy in format-patch message headers
Message-ID: <20240605222658.M32384@dcvr>
References: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
 <xmqq5xuns10v.fsf@gitster.g>
 <20240605-zippy-wildcat-of-recreation-8c644e@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605-zippy-wildcat-of-recreation-8c644e@lemur>

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Wed, Jun 05, 2024 at 11:22:08AM GMT, Junio C Hamano wrote:
> > > Would it make sense to have git-format-patch (and friends) include an
> > > additional header hinting at the options used to generate the patch? E.g.:
> > >
> > >     X-git-diff-options: algo=myers; context=3;

Fwiw, I use format-patch command-line + options in the
--signature= switch when generating patches in WIP git repo viewer:

https://yhbt.net/lore/pub/scm/git/git.git/6549c41e/s/0001.patch

> > If you were to add a new e-mail header, wouldn't it make more sense
> > to add a patch-id header and agree on the set of options to be used
> > to generate that patch-id (which might be different from the setting
> > used to format the real patch for human and "git am" consumption)?
> 
> That would be redundant with the message-id. Unfortunately, this doesn't solve
> the problem of how to reliably map a commit to the patch from which it
> originated, other than using the Message-ID: or Link: trailers.

dfpre:, dfblob:, dfpost: search queries on lore seem to work...

On my lore + gko mirror, the #related search off a commit mostly
works for a single extindex, but mapping hundreds of forks to
hundreds of inboxes with a presentable UI for w3m||lynx users is
a different matter I haven't been able to solve:

https://yhbt.net/lore/pub/scm/git/git.git/6549c41e/s/#related

> I'm not sure if there's a reliable way to solve this.

I started working on a scoring mechanism a while back but got
distracted with personal matters.  UI is hard, and dealing with
my gko mirror has been a source of pain due to various
memory+performance problems.
