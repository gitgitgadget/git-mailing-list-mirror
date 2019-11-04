Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ABC81F454
	for <e@80x24.org>; Mon,  4 Nov 2019 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbfKDWSY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 17:18:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:38730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388613AbfKDWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 17:18:23 -0500
Received: (qmail 5119 invoked by uid 109); 4 Nov 2019 22:18:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 22:18:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6990 invoked by uid 111); 4 Nov 2019 22:21:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 17:21:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 17:18:22 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] doc: move author and committer information to
 git-commit(1)
Message-ID: <20191104221822.GA22367@sigill.intra.peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191102192615.10013-2-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 07:26:12PM +0000, brian m. carlson wrote:

> While at one time it made perfect sense to store information about
> configuring author and committer information in the documentation for
> git commit-tree, in modern Git that operation is seldom used.  Most
> users will use git commit and expect to find comprehensive documentation
> about its use in the manual page for that command.
> 
> Considering that there is significant confusion about how one is to use
> the user.name and user.email variables, let's put as much documentation
> as possible into an obvious place where users will be more likely to
> find it.

I think we might want to keep documentation that gets too low-level out
of git-commit(1).

So for instance, this part that got moved from commit-tree:

> +A commit encapsulates:
> +
> +- all parent object ids
> +- author name, email and date
> +- committer name and email and the commit time.
> +

I think could just stay there.

The part just below that:

> +While parent object ids are provided on the command line, author and
> +committer information is taken from the following environment variables,
> +if set:
> +
> +	GIT_AUTHOR_NAME
> +	GIT_AUTHOR_EMAIL
> +	GIT_AUTHOR_DATE
> +	GIT_COMMITTER_NAME
> +	GIT_COMMITTER_EMAIL
> +	GIT_COMMITTER_DATE
> +
> +(nb "<", ">" and "\n"s are stripped)

would be appropriate in git-commit. Though possibly they should just be
broken out into an ENVIRONMENT VARIABLES section.

I thought we already did so in git.txt, but it looks like it just refers
to commit-tree (and if we don't do anything more drastic, I think you'd
probably want to update that reference). Since these do affect multiple
commands, I wonder if it would make sense to define them there in
git.txt, giving a more user-facing description. Something like:

  GIT_COMMITTER_NAME::
	The human-readable name used in the committer identity when
	creating commit or tags objects, or when writing reflogs.
	Overrides the user.name config.

and so forth for COMMITTER_EMAIL, AUTHOR_NAME, etc.

-Peff
