Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710C1B6
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 13:56:40 -0800 (PST)
Received: (qmail 26032 invoked by uid 109); 27 Nov 2023 21:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Nov 2023 21:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4188 invoked by uid 111); 27 Nov 2023 21:56:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Nov 2023 16:56:41 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Nov 2023 16:56:38 -0500
From: Jeff King <peff@peff.net>
To: guillaume.yziquel@mailfence.com
Cc: git@vger.kernel.org
Subject: Re: [BUG?] Semantics of HEAD when bare cloning non-bare repositories
Message-ID: <20231127215638.GE87495@coredump.intra.peff.net>
References: <179a3f7b2605b295.375e54053ab898bd.31bd44aeb0344c08@hilbert>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179a3f7b2605b295.375e54053ab898bd.31bd44aeb0344c08@hilbert>

On Thu, Nov 23, 2023 at 12:13:27PM +0000, guillaume.yziquel@mailfence.com wrote:

> Observation: When git clone --bare is used on a non-bare repo, the
> HEAD is put in ./refs/HEAD, and conflicts with ./HEAD in the sense
> that they may end up decorelated over time.

That sounds like a bug, but I can't reproduce it here:

  $ git init not-bare
  $ git -C not-bare commit --allow-empty -m foo
  $ git clone --bare not-bare bare.git
  $ find bare.git/refs
  bare.git/refs
  bare.git/refs/tags
  bare.git/refs/heads
  $ cat bare.git/packed-refs
  # pack-refs with: peeled fully-peeled sorted
  db58e786007ca405e34df314479e27ddd337957a refs/heads/main

Are you sure that your non-bare repository does not accidentally have a
"refs/HEAD" that should not be there?

> Suggestion: When bare cloning on a non-bare repo, do not put the HEAD
> of the non-bare repo in refs/HEAD like every branch, but treat it
> separately: put it in ./HEAD, not ./refs/HEAD.

That should be what happens already.

-Peff
