Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3784C20899
	for <e@80x24.org>; Tue, 15 Aug 2017 01:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbdHOBxA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 21:53:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753286AbdHOBw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 21:52:59 -0400
Received: (qmail 6505 invoked by uid 109); 15 Aug 2017 01:52:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 01:52:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7763 invoked by uid 111); 15 Aug 2017 01:53:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 21:53:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 21:52:57 -0400
Date:   Mon, 14 Aug 2017 21:52:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
Message-ID: <20170815015256.c423wjwrq7crghu4@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-3-bmwill@google.com>
 <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
 <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net>
 <xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com>
 <xmqqvalpsoda.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvalpsoda.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 04:47:45PM -0700, Junio C Hamano wrote:

> > By the way, I do not know which vintage of /usr/bin/git-clang-format
> > I happen to have on my box, but I needed a crude workaround patch
> > (attached at the end) ...
> 
> I guess you hit the same thing while our messages crossing ;-)

Yep. Our solutions were at opposite ends of the spectrum, though. :)

> > As to what it does, the first example I tried may not have been a
> > great one.  I got this:
> >
> >         git clang-format --style file --diff --extensions c,h
> >         diff --git a/cache.h b/cache.h
> >         index 73e0085186..6462fe25bc 100644
> >         --- a/cache.h
> >         +++ b/cache.h
> >         @@ -1498,11 +1498,8 @@ struct checkout {
> >                 const char *base_dir;
> >                 int base_dir_len;
> >                 struct delayed_checkout *delayed_checkout;
> >         -	unsigned force:1,
> >         -		 quiet:1,
> >         -		 not_new:1,
> >         -		a_new_field:1,
> >         -		 refresh_cache:1;
> >         +	unsigned force : 1, quiet : 1, not_new : 1, a_new_field : 1,
> >         +		refresh_cache : 1;
> >          };
> >          #define CHECKOUT_INIT { NULL, "" }
> >  
> > which is not wrong per-se, but I have a mixed feelings.  I do not
> > want it to complain if the original tried to fit many items on a
> > single line, but if the original wanted to have one item per line,
> > I'd rather see it kept as-is.
> 
> To clarify, the above is after I added a_new_field that is one-bit
> wide without doing anything else.  I do not mind the checker
> complaining the existing force, quiet, etc. whose widths are all
> spelled without SP around ':', because they appear near-by, as a
> collateral damage.  My only gripe is that the result got squished
> into a single line.

Yes, agreed. My personal rule with a list like this is often "once you
have to start breaking across multiple lines, you should put one per
line". I don't know if there's a way to codify that in clang-format,
though.

The case I fed it (which is just nonsense I made up that does not fit
our style) also left me a bit confused at first, but I think it was
because the .clang-format parser was bailing as soon as it found an
unrecognized entry, but then formatting according to bogus rules. With
the original file from Brandon I got:

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 7e8371670b..8994450e0c 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -21,10 +21,7 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static
-int foo(void* bar,int baz) {
-	/* nothing */
-}
+static int foo(void *bar, int baz) { /* nothing */ }
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {

which is clearly not our style. And then after removing the entries I
mentioned elsewhere, I get:

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 7e8371670b..574ba6d86f 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -21,8 +21,8 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static
-int foo(void* bar,int baz) {
+static int foo(void *bar, int baz)
+{
 	/* nothing */
 }

which looks right. So you might want to double-check that it was
respecting our settings, and there were no warnings to stderr.

-Peff
