Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA33C2FD
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774663410; cv=none; b=TiTupp32q8+TcMZv0OEql6R3TZoSXWx401eO53638YJGtLl1d6f30/behV0iZSDIbWrj64N8//52kIQr4uGhfGJZhFAafPApNABWz7X57PSfQeSePx/n1+A3msZpa3vDPhaKitVOHnEB/s5POmFu2FtD7rr8t6XYjgWZP27SAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774663410; c=relaxed/simple;
	bh=Y+++3E2oNPThfqQShavTP3fHflnW2AxO8dtEV2b22ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkF25rIJ0CfxOjg4t7szv+5Ka3RluKmq3dTt4TegAgESnAsDWxm2c4Qnl/TUwygFP9UI5e5QThXRZikFl6R+kJJCUUp1v9D59LUq2ufe1vsni3LDxl0ebfqH3wN+sM2M1SbBesvCIm7MdOyuUrMeMx9WyPAhR0+cmjvPliaLiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=beXIfqOv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="beXIfqOv"
Received: (qmail 173600 invoked by uid 106); 28 Mar 2026 02:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y+++3E2oNPThfqQShavTP3fHflnW2AxO8dtEV2b22ps=; b=beXIfqOvIkLWLuD11RtacKpDYkeLj9J5CiDYFkm4PkwRB5e5R7Xg8Ffz1KNNDo0f4AmlwLAd1sgRETuY2OZDEaynUdl32fhgpdIU5fS2W7fW/pfScxRndiwnFOLH50UH/cKTJvVLYx9rgkBEirD3cHsCDXJ2KmaeE1MD88lfnbRN9zT/LGQk3BRoFIVOEFBH9TV3NKWk7IxnkGwFSj3ORfEcy664WWtOeMZ2jorMrWXdFaygPNA6iHgi0OuyGsyDwF7dRfXfpNJzDqhvQp328wlfOSEUu08wcmp4qiHB1aynwUc71aBBtrNFBdT2ZkcxfzEjOmfv87wqH+dSD84i3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Mar 2026 02:03:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 243892 invoked by uid 111); 28 Mar 2026 02:03:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2026 22:03:27 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Mar 2026 22:03:27 -0400
From: Jeff King <peff@peff.net>
To: Wesley <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 3/3] connect: Add support for per-remote and
 per-namespace SSH options
Message-ID: <20260328020327.GB621762@coredump.intra.peff.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-4-wesleys@opperschaap.net>
 <20260327214559.GA599365@coredump.intra.peff.net>
 <a4a03bae-b987-4b21-a7fd-fbdb9d832430@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4a03bae-b987-4b21-a7fd-fbdb9d832430@opperschaap.net>

On Fri, Mar 27, 2026 at 08:43:07PM -0400, Wesley wrote:

> > We already have some conditional config mechanisms, and I don't think
> > it's a good idea to add one that only works for certain keys. If I
> > understand correctly, this <owner> feature can already be accomplished
> > with:
> > 
> >    [includeIf "hasconfig:remote.*.url:**/owner/**"]
> >    path = all-your-options-for-that-owner
> > 
> > It's a little more verbose (and you have to use a separate file), but it
> > also allows other conditions, like "gitdir:" for selecting based on how
> > you lay out your repos locally.
> 
> This doesn't work as you would think it does. The includeIf on hasconfig
> with the remote URL is used if it finds the remote in the config, and not on
> the actual network action. Thus if you have two remotes with two includeIfs
> on the remote URL it takes the config of the last defined include. Thus
> breaks the expectation that it is configured.

Yes, it's going to be per-local-repo. I had assumed you were in a
situation where you were defining these setups at the global level, and
each local repo will want to use them or not. I.e., something like this:

  [set up once]
  $ git config -f ~/.gitconfig-foo core.sshCommand "ssh -i whatever"
  $ git config --global includeIf.hasconfig:remote.*.url:example.com:foo/**.path .gitconfig-foo

  [and now we'd use it in this repo]
  $ git clone example.com:foo/repo.git

  [but not this one]
  $ git clone example.com:bar/repo.git

If you have remotes for both "foo/repo.git" and "bar/repo.git"
configured in one local repo, then yes, it will always apply the config.

If you really want per-connection config, I'm still not quite convinced
that you aren't better off defining host sections in your ssh config.
That covers all options that ssh knows about (not just ones we teach Git
about), and you can still apply it automatically from ~/.gitconfig using
insteadOf. Something like:

  git config --global foo.example.com:foo/.insteadOf example.com:foo/

and then defining a foo.example.com block in your ~/.ssh/config.

-Peff
