Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EBC1
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 13:50:53 -0800 (PST)
Received: (qmail 25995 invoked by uid 109); 27 Nov 2023 21:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Nov 2023 21:50:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4134 invoked by uid 111); 27 Nov 2023 21:50:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Nov 2023 16:50:54 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Nov 2023 16:50:52 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] trace2: redact passwords from https:// URLs by
 default
Message-ID: <20231127215052.GD87495@coredump.intra.peff.net>
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
 <a1686ab52f1bec4bddeaab973c9b77e55e8b539b.1700680717.git.gitgitgadget@gmail.com>
 <CABPp-BELjVqVEB3oVx3fMzmvNfE1f7muLR_2k912_C+SaQtZtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BELjVqVEB3oVx3fMzmvNfE1f7muLR_2k912_C+SaQtZtg@mail.gmail.com>

On Thu, Nov 23, 2023 at 10:59:20AM -0800, Elijah Newren wrote:

> > Let's at least avoid logging such secrets via Trace2, much like we avoid
> > logging secrets in `http.c`. Much like the code in `http.c` is guarded
> > via `GIT_TRACE_REDACT` (defaulting to `true`), we guard the new code via
> > `GIT_TRACE2_REDACT` (also defaulting to `true`).
> 
> Training users is hard.  I appreciate the changes here to make trace2
> not be a leak vector, but is it time to perhaps consider bigger safety
> measures: At the clone/fetch level, automatically warn loudly whenever
> such a URL is provided, accompanied with a note that in the future it
> will be turned into a hard error?

Yes, the password in such a case ends up in the plaintext .git/config
file, which is not great.

There's some discussion and patches here:

  https://lore.kernel.org/git/nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet/

I meant to follow up on them, but never did.

-Peff
