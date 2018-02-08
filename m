Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0981F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBHViJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:38:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:45932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752179AbeBHViI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:38:08 -0500
Received: (qmail 7011 invoked by uid 109); 8 Feb 2018 21:38:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 21:38:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15666 invoked by uid 111); 8 Feb 2018 21:38:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 16:38:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 16:38:06 -0500
Date:   Thu, 8 Feb 2018 16:38:06 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: [PATCH] CodingGuidelines: mention "static" and "extern"
Message-ID: <20180208213806.GA6381@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com>
 <20180208204309.GA4541@sigill.intra.peff.net>
 <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 01:04:08PM -0800, Stefan Beller wrote:

> You may sense a pattern here: I currently have the very firm understanding
> we use the extern keyword in our codebase.
> 
> And I can also attest that this was not always the case, as back in the
> day I remember writing patches without the extern keyword only to be told:
> (A) be similar to the function in the next lines
> (B) the standard is to use extern
> and I was convinced it was a bad decision to prefix declarations with
> the extern keyword, but followed along as I don't want to have style
> in the way of writing features.

It definitely was the case that people used to suggest "extern". I think
this was a Linus-ism from the early days, and I have been hating it for
almost 12 years now. ;)

>   $ cat Documentation/CodingGuidelines |grep extern
>   $ # oh no it's empty!
> 
> Care to add a section to our coding guidelines?

Here's a patch.

-- >8 --
Subject: [PATCH] CodingGuidelines: mention "static" and "extern"

It perhaps goes without saying that file-local stuff should
be marked static, but it does not hurt to remind people.

Less obvious is that we are settling on "do not include
extern in function declarations". It is already the default
unless the function was previously declared static (but if
you are following a static declaration with an unmarked one,
you should think about why you are declaring the thing
twice). And so it just becomes an extra noise-word in our
header files.

We used to give the opposite advice, so there are quite a
few "extern" markers in early Git code. But this at least
makes a concrete suggestion that we can follow going
forward.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c4cb5ff0d4..48aa4edfbd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -386,6 +386,11 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
+ - Variables and functions local to a given source file should be marked
+   with "static". Variables that are visible to other source files
+   must be declared with "extern" in header files. However, function
+   declarations should not use "extern", as that is already the default.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.16.1.365.g89f5777adf

