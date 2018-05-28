Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190E91F42D
	for <e@80x24.org>; Mon, 28 May 2018 17:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeE1R56 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 13:57:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:54760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932242AbeE1R55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 13:57:57 -0400
Received: (qmail 7444 invoked by uid 109); 28 May 2018 17:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 May 2018 17:57:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22491 invoked by uid 111); 28 May 2018 17:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 May 2018 13:58:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2018 13:57:55 -0400
Date:   Mon, 28 May 2018 13:57:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] make show-index a builtin
Message-ID: <20180528175754.GA20636@sigill.intra.peff.net>
References: <20180528093740.GA6902@sigill.intra.peff.net>
 <20180528093853.GA20229@sigill.intra.peff.net>
 <xmqqlgc3iyom.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgc3iyom.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 12:31:53AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/show-index.c b/builtin/show-index.c
> > similarity index 96%
> > rename from show-index.c
> > rename to builtin/show-index.c
> > index 1ead41e211..65fa86dd08 100644
> > --- a/show-index.c
> > +++ b/builtin/show-index.c
> > @@ -4,7 +4,7 @@
> 
> I squashed
> 
> #include "builtin.h"
> 
> near the beginning of this file to squelch -DDEVELOPER extra
> warnings.  Otherwise looks obviously good.

Thanks. I'm still using my custom build options, and obviously I need to
add -Wmissing-prototypes.

> > diff --git a/git.c b/git.c
> > index 5771d62a32..c91e144d9a 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -470,6 +470,7 @@ static struct cmd_struct commands[] = {
> >  	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
> >  	{ "show", cmd_show, RUN_SETUP },
> >  	{ "show-branch", cmd_show_branch, RUN_SETUP },
> > +	{ "show-index", cmd_show_index },
> 
> Hmph, this does not need SETUP?  Ah, of course, because its
> subcommand body used to do everything itself, and this patch just
> turns cmd_main() to cmd_show_index().

It is not even that it does the setup itself. It does not need the setup
at all, because it is purely a mechanical parsing of the stdin stream
to text output. No repo required, and it does not know or care if the
matching packfile even exists.

-Peff
