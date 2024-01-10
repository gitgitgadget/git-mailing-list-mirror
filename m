Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7D360AD
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17735 invoked by uid 109); 10 Jan 2024 11:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 11:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25837 invoked by uid 111); 10 Jan 2024 11:08:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 06:08:45 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 06:08:42 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Storing private config files in .git directory?
Message-ID: <20240110110842.GD16674@coredump.intra.peff.net>
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
 <xmqq34v7lmb3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34v7lmb3.fsf@gitster.g>

On Mon, Jan 08, 2024 at 10:20:00AM -0800, Junio C Hamano wrote:

> Stefan Haller <lists@haller-berlin.de> writes:
> 
> > Our git client (lazygit) has a need to store per-repo config files that
> > override the global one, much like git itself. The easiest way to do
> > that is to store those in a .git/lazygit.cfg file, and I'm wondering if
> > there's any reason why this is a bad idea?
> 
> An obvious alternative is to have .lazygit directory next to .git directory
> which would give you a bigger separation, which can cut both ways.

Just to spell out one of those ways: unlike ".git", we will happily
check out ".lazygit" from an untrusted remote repository. That may be a
feature if you want to be able to share project-specific config, or it
might be a terrible security vulnerability if lazygit config files can
trigger arbitrary code execution.

-Peff
