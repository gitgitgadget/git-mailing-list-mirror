Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D909D1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757874AbdAGBgG (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:36:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:36321 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755425AbdAGBgF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:36:05 -0500
Received: (qmail 30619 invoked by uid 109); 7 Jan 2017 01:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 01:36:04 +0000
Received: (qmail 22096 invoked by uid 111); 7 Jan 2017 01:36:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:36:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 20:36:02 -0500
Date:   Fri, 6 Jan 2017 20:36:02 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, l.s.r@web.de, git@vger.kernel.org
Subject: Re: [PATCH 4/5] unpack-trees: factor file removal out of
 check_updates
Message-ID: <20170107013602.act7aouuzgzpwb54@sigill.intra.peff.net>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com>
 <20170106210330.31761-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106210330.31761-5-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 01:03:29PM -0800, Stefan Beller wrote:

> +static int remove_workingtree_files(struct unpack_trees_options *o,
> +				    struct progress *progress)
> +{
> +	int i;
> +	unsigned cnt = 0;
> +	struct index_state *index = &o->result;
> +
> +	for (i = 0; i < index->cache_nr; i++) {
> +		const struct cache_entry *ce = index->cache[i];
> +
> +		if (ce->ce_flags & CE_WT_REMOVE) {
> +			display_progress(progress, ++cnt);
> +			if (o->update && !o->dry_run)
> +				unlink_entry(ce);
> +		}
> +	}
> +
> +	return cnt;
> +}

"cnt" is unsigned here, as it is in the caller. Should the return value
match?

-Peff
