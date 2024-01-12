Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6005C8EF
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9464 invoked by uid 109); 12 Jan 2024 06:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 06:56:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14923 invoked by uid 111); 12 Jan 2024 06:56:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 01:56:56 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 01:56:54 -0500
From: Jeff King <peff@peff.net>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Storing private config files in .git directory?
Message-ID: <20240112065654.GB618729@coredump.intra.peff.net>
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
 <xmqq34v7lmb3.fsf@gitster.g>
 <20240110110842.GD16674@coredump.intra.peff.net>
 <c8ad96bc-0180-42f4-b559-20b475098eca@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8ad96bc-0180-42f4-b559-20b475098eca@haller-berlin.de>

On Thu, Jan 11, 2024 at 02:28:51PM +0100, Stefan Haller wrote:

> On 10.01.24 12:08, Jeff King wrote:
> > On Mon, Jan 08, 2024 at 10:20:00AM -0800, Junio C Hamano wrote:
> > 
> >> An obvious alternative is to have .lazygit directory next to .git directory
> >> which would give you a bigger separation, which can cut both ways.
> > 
> > Just to spell out one of those ways: unlike ".git", we will happily
> > check out ".lazygit" from an untrusted remote repository. That may be a
> > feature if you want to be able to share project-specific config, or it
> > might be a terrible security vulnerability if lazygit config files can
> > trigger arbitrary code execution.
> 
> Unless you don't version it and add it to .gitignore instead, which (I
> suppose) is what most people do with their .vscode/settings.json, for
> example.

A .gitignore will help with people accidentally adding their .lazygit
directory. What I meant, though, was somebody _intentionally_ creating a
malicious repository that would then execute arbitrary code when the
victim cloned it. We prevent that from happening with .git/config
because there's special handling that refuses to check out the name
".git" (or other filesystem-equivalent names). But ".lazygit" would not
have that same protection.

-Peff
