Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35160205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 09:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757099AbdAJJEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 04:04:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:37433 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752770AbdAJJEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 04:04:22 -0500
Received: (qmail 29139 invoked by uid 109); 10 Jan 2017 09:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 09:04:21 +0000
Received: (qmail 12231 invoked by uid 111); 10 Jan 2017 09:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 04:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2017 04:04:18 -0500
Date:   Tue, 10 Jan 2017 04:04:18 -0500
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 01:43:15PM +0100, Michael J Gruber wrote:

> > I can't say I'm excited about having matching "_" variants for each
> > function. Are we sure that they are necessary? I.e., would it be
> > acceptable to just translate them always?
> 
> We would still need to mark the strings, e.g.
> 
> die(N_("oopsie"));
> 
> and would not be able to opt out of translating in the code (only in the
> po file, by not providing a translation).

I meant more along the lines of: would it be OK to just always translate
the prefix, even if the message itself is not translated? I.e.,

diff --git a/usage.c b/usage.c
index 82ff13163..8e5400f57 100644
--- a/usage.c
+++ b/usage.c
@@ -32,7 +32,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf(_("fatal: "), err, params);
 	exit(128);
 }

> In any case, the question is whether we want to tell the user
> 
> A: B
> 
> where A is in English and B is localised, or rather localise both A and
> B (for A in "error", "fatal", "warning"...).
> 
> For localising A and B, we'd need this series or something similar. For
> keeping the mix, we don't need to do anything ;)

What I wrote above would keep the mix, but switch it in the other
direction.

And then presumably that mix would gradually move to 100% consistency as
more messages are translated. But the implicit question is: are there
die() messages that should never be translated? I'm not sure.

-Peff
