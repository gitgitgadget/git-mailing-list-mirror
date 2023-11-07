Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698346138
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C911A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 19:52:53 -0800 (PST)
Received: (qmail 27486 invoked by uid 109); 7 Nov 2023 03:52:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 03:52:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10913 invoked by uid 111); 7 Nov 2023 03:52:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 22:52:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 22:52:52 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-bitmap: drop --unpacked non-commit objects from
 results
Message-ID: <20231107035252.GB873619@coredump.intra.peff.net>
References: <cover.1699311386.git.me@ttaylorr.com>
 <7492dc699052a392d2fb394e1dcfabebac82ded0.1699311386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7492dc699052a392d2fb394e1dcfabebac82ded0.1699311386.git.me@ttaylorr.com>

On Mon, Nov 06, 2023 at 05:56:33PM -0500, Taylor Blau wrote:

> Before returning a bitmap containing the result of the traversal back to
> the caller, drop any bits from the extended index which appear in one or
> more packs. This implements the correct behavior for rev-list operations
> which use the bitmap index to compute their result.

Nice. I was very happy to see the extra test for "rev-list --disk-usage"
to demonstrate this. The same should apply for "pack-objects --unpacked
--use-bitmap-index" (though in practice I don't think we'd do that, as
"--unpacked" implies on-disk repacking, which we do not generally use
with bitmaps).

-Peff
