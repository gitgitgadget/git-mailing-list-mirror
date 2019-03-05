Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363C720248
	for <e@80x24.org>; Tue,  5 Mar 2019 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfCEFD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 00:03:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:38908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725782AbfCEFD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 00:03:29 -0500
Received: (qmail 895 invoked by uid 109); 5 Mar 2019 05:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 05:03:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28809 invoked by uid 111); 5 Mar 2019 05:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 00:03:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 00:03:27 -0500
Date:   Tue, 5 Mar 2019 00:03:27 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is it "git gc --prune=now" or "git gc --prune=all"?
Message-ID: <20190305050326.GK19800@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 03:26:37AM -0500, Robert P. J. Day wrote:

>   more pedantry, but digging through "git gc", the man page reads:
> 
>        --prune=<date>
>            Prune loose objects older than date (default is 2 weeks
>            ago, overridable by the config variable gc.pruneExpire).
>            --prune=all prunes loose objects regardless of their age
>            ^^^^^^^^^^^
> 
> but the code for gc.c contains a check for "now" (which actually makes
> more sense semantically):
> 
>   static void add_repack_all_option(struct string_list *keep_pack)
>   {
>         if (prune_expire && !strcmp(prune_expire, "now"))
>                 argv_array_push(&repack, "-a");
>         else {
>         ... snip ...
> 
> while the man page does not seem to mention the possible value of
> "now".
> 
>   am i misreading something? should the man page mention the possible
> value of "now" as opposed to "all"?

Using "all" would also work. It wouldn't shortcut to using "-a" (which
lets pack-objects save a little work), but it is handled in
parse_expiry_date() the same as "now". I do think the documentation
should recommend "now". Possibly builtin/gc.c should be smarter about
recognizing "all" in the conditional you quoted, too, though I don't
know that it's all that important (especially if we tweak the
documentation).

-Peff
