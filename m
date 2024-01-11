Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B24D271
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29249 invoked by uid 109); 11 Jan 2024 07:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 07:30:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3559 invoked by uid 111); 11 Jan 2024 07:30:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 02:30:10 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 02:30:07 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
Message-ID: <20240111073007.GE48154@coredump.intra.peff.net>
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
 <20240110120531.GA25541@coredump.intra.peff.net>
 <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>
 <20240111070114.GB48154@coredump.intra.peff.net>
 <ZZ-V-vwnm2hOkrMC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ-V-vwnm2hOkrMC@tanuki>

On Thu, Jan 11, 2024 at 08:17:14AM +0100, Patrick Steinhardt wrote:

> > Right, it's not config itself that's unsafe; it's that many options are.
> > We could try to annotate them to say "it is OK to parse core.eol but not
> > core.pager", presumably with an allow-known-good approach (since so many
> > ard bad!). But that feels like an ongoing maintenance headache, and an
> > easy way to make a mistake (your mention of terminal sequences makes me
> > assume you're thinking of "color.diff.*", etc). A rule like "we do not
> > read repo-level config at all" seems easier to explain (to me, anyway).
> 
> With the exemption of the repository format, I assume? We have to parse
> things like `core.repositoryFormatVersion` and extensions in order to
> figure out how a repository has to be accessed. So I agree that we
> should not partition config based on safeness, which is going to be a
> headache as you rightly point out. But we can partition based on whether
> or not config is required in order to access the repository, where the
> set of relevant config keys is a whole lot smaller.

Right. See the pseudo-patch I posted earlier. I think we just want to
touch do_git_config_sequence(), which leaves repo discovery and stuff
like "git config --local" working.

-Peff
