Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C411F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeKLWH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:07:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:35296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728401AbeKLWH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:07:26 -0500
Received: (qmail 23219 invoked by uid 109); 12 Nov 2018 12:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:14:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10096 invoked by uid 111); 12 Nov 2018 12:13:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:13:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:14:23 -0500
Date:   Mon, 12 Nov 2018 07:14:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     nbelakovski@gmail.com, rafa.almas@gmail.com, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if
 it is checked out in a linked worktree
Message-ID: <20181112121423.GA3956@sigill.intra.peff.net>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-3-nbelakovski@gmail.com>
 <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 07:20:28PM +0900, Junio C Hamano wrote:

> nbelakovski@gmail.com writes:
> 
> > diff --git a/color.h b/color.h
> > index 98894d6a17..857653df73 100644
> > --- a/color.h
> > +++ b/color.h
> > @@ -42,6 +42,24 @@ struct strbuf;
> >  #define GIT_COLOR_FAINT_BLUE	"\033[2;34m"
> >  #define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
> >  #define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
> > +#define GIT_COLOR_LIGHT_RED	"\033[91m"
> > +#define GIT_COLOR_LIGHT_GREEN	"\033[92m"
> > +#define GIT_COLOR_LIGHT_YELLOW	"\033[93m"
> > +#define GIT_COLOR_LIGHT_BLUE	"\033[94m"
> > +#define GIT_COLOR_LIGHT_MAGENTA	"\033[95m"
> > +#define GIT_COLOR_LIGHT_CYAN	"\033[96m"
> > +#define GIT_COLOR_BOLD_LIGHT_RED	"\033[1;91m"
> > +#define GIT_COLOR_BOLD_LIGHT_GREEN	"\033[1;92m"
> > +#define GIT_COLOR_BOLD_LIGHT_YELLOW	"\033[1;93m"
> > +#define GIT_COLOR_BOLD_LIGHT_BLUE	"\033[1;94m"
> > +#define GIT_COLOR_BOLD_LIGHT_MAGENTA	"\033[1;95m"
> > +#define GIT_COLOR_BOLD_LIGHT_CYAN	"\033[1;96m"
> > +#define GIT_COLOR_FAINT_LIGHT_RED	"\033[2;91m"
> > +#define GIT_COLOR_FAINT_LIGHT_GREEN	"\033[2;92m"
> > +#define GIT_COLOR_FAINT_LIGHT_YELLOW	"\033[2;93m"
> > +#define GIT_COLOR_FAINT_LIGHT_BLUE	"\033[2;94m"
> > +#define GIT_COLOR_FAINT_LIGHT_MAGENTA	"\033[2;95m"
> > +#define GIT_COLOR_FAINT_LIGHT_CYAN	"\033[2;96m"
> 
> Hopefully you made sure that there is no other topic in-flight that
> touch this area before doing this change?  Otherwise you'd be
> creating pointless merge conflict by futzing with spaces.

This hunk confused me for a minute, too. It's not changing spaces, but
just adding a bunch of color variants. It would be nice if we could just
do this with a run-time parse_color("bold red") or whatever, but we use
these as static initializers.

We don't strictly need anything more than FAINT_LIGHT_GREEN here. I
don't have a strong opinion on adding just what we need versus
being more complete.

> Ditto for an earlier hunk of this patch.

Yeah, I think this does apply to the earlier hunk that defines
branch_colors[].

-Peff
