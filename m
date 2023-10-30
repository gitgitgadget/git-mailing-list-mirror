Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAADDA1
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3CB7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:36:07 -0700 (PDT)
Received: (qmail 1679 invoked by uid 109); 30 Oct 2023 09:36:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:36:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9637 invoked by uid 111); 30 Oct 2023 09:36:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:36:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:36:05 -0400
From: Jeff King <peff@peff.net>
To: Sheik <sahibzone@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
Message-ID: <20231030093605.GE84866@coredump.intra.peff.net>
References: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>

On Thu, Oct 26, 2023 at 07:36:36AM +1100, Sheik wrote:

> Repository cloned using SSH does not use the branch configured in the bare
> repository however repository cloned using filesystem does as expected.
> Shouldn't they both behave the same?

What version of Git is running on the ssh server?

Your example seems to show that the parent repository has an unborn
branch (i.e., HEAD points to "refs/heads/test", but there are no commits
yet). I think the server-side bits you need for that to work showed up
in 59e1205d16 (ls-refs: report unborn targets of symrefs, 2021-02-05),
which is in v2.31.

So even though your client seems to be v2.42 (from the output you gave),
if the server is older it may not be sending sufficient information.
There were also some other fixes on top of that, but I _think_ they were
all client-side (so your v2.42 clone command should be doing the right
thing).

-Peff
