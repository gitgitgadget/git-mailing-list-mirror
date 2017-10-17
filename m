Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258D4202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756189AbdJQENf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:13:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:55012 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755668AbdJQENf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:13:35 -0400
Received: (qmail 32038 invoked by uid 109); 17 Oct 2017 04:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 04:13:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20207 invoked by uid 111); 17 Oct 2017 04:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 00:13:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 00:13:33 -0400
Date:   Tue, 17 Oct 2017 00:13:33 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] deprecate git stash save?  (was: Re: [PATCH 2/3]
 http-push: fix construction of hex value from path)
Message-ID: <20171017041332.ooybecmonvssko2k@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005200049.GF30301@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 09:00:49PM +0100, Thomas Gummerer wrote:

> Since you were asking :)  With the introduction of 'git stash push',
> my hope was always that we could eventually get rid of 'git stash
> save' and only keep one interface around.
> 
> As there still many references to it around on the internet, it
> probably requires a bit of a longer deprecation plan.  What do you
> think about the following:
> 
> - Change docs/man pages to use 'git stash push' everywhere instead of
>   'git stash save'.
> - Mention the deprecation in the release notes and in the man page.
> - Print a warning when 'git stash save' is used.
> - Eventually get rid of it (maybe something for 3.0?)
> 
> The steps above would all occur sequentially with a few releases
> between each of them.

That sounds like a pretty good plan.

> A patch for the first step below.  I think that even makes sense if we
> don't want to follow through with the deprecation.

Agreed. The patch mostly looks good, except:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index b4d88af133..1c4e44892d 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1556,7 +1556,7 @@ so on a different branch and then coming back), unstash the
>  work-in-progress changes.
>  
>  ------------------------------------------------
> -$ git stash save "work in progress for foo feature"
> +$ git stash push "work in progress for foo feature"
>  ------------------------------------------------

This needs "-m", doesn't it?

>  
>  This command will save your changes away to the `stash`, and
> diff --git a/git-stash.sh b/git-stash.sh
> index 8b2ce9afda..8ce6929d7f 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -267,11 +267,11 @@ push_stash () {
>  			# translation of "error: " takes in your language. E.g. in
>  			# English this is:
>  			#
> -			#    $ git stash save --blah-blah 2>&1 | head -n 2
> -			#    error: unknown option for 'stash save': --blah-blah
> -			#           To provide a message, use git stash save -- '--blah-blah'
> -			eval_gettextln "error: unknown option for 'stash save': \$option
> -       To provide a message, use git stash save -- '\$option'"
> +			#    $ git stash push --blah-blah 2>&1 | head -n 2
> +			#    error: unknown option for 'stash push': --blah-blah
> +			#           To provide a message, use git stash push -- '--blah-blah'
> +			eval_gettextln "error: unknown option for 'stash push': \$option
> +       To provide a message, use git stash push -- '\$option'"

And here, too?

-Peff
