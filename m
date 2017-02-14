Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1368C1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbdBNSE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:04:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:55159 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754419AbdBNSE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:04:56 -0500
Received: (qmail 8922 invoked by uid 109); 14 Feb 2017 18:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 18:04:55 +0000
Received: (qmail 4779 invoked by uid 111); 14 Feb 2017 18:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 13:04:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 13:04:53 -0500
Date:   Tue, 14 Feb 2017 13:04:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 6/7] grep: avoid resolving revision names in --no-index
 case
Message-ID: <20170214180453.tpze2hdv3eytxfju@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
 <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 08:53:04AM -0800, Jonathan Tan wrote:

> On 02/13/2017 10:07 PM, Jeff King wrote:
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index e83b33bda..c4c632594 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -1176,6 +1176,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  			break;
> >  		}
> > 
> > +		if (!use_index) {
> > +			if (seen_dashdash)
> > +				die(_("--no-index cannot be used with revs"));
> 
> There is a subsequent check that prints "--no-index or --untracked cannot be
> used with revs." - maybe we should just expand this part to incorporate that
> case. (That is, write `if (!use_index || untracked)` instead of `if
> (!use_index)`.) This also allows us to preserve the error message, which
> might be useful for someone using a translated version of Git.

I wasn't sure if we wanted to treat "untracked" in the same way.
Certainly we can catch the error here for the seen_dashdash case, but is
it also the case that:

  echo content >master
  git grep --untracked pattern master

should treat "master" as a path?

-Peff
