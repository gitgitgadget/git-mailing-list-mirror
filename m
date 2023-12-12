Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C29CB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:04:10 -0800 (PST)
Received: (qmail 9219 invoked by uid 109); 12 Dec 2023 07:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 07:04:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11922 invoked by uid 111); 12 Dec 2023 07:04:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 02:04:07 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 02:04:06 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <20231212070406.GA1117953@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>

On Tue, Nov 28, 2023 at 02:07:59PM -0500, Taylor Blau wrote:

> +static void clear_bb_commit(struct bb_commit *commit)
> +{
> +	free(commit->reverse_edges);
> +	bitmap_free(commit->commit_mask);
> +	bitmap_free(commit->bitmap);
> +}

I think these bitmaps may sometimes be NULL. But double-checking
bitmap_free(), it sensibly is noop when passed NULL. So this look good
to me.

-Peff
