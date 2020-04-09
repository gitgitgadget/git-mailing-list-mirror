Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81480C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6112020784
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgDIPv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:51:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:38124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728212AbgDIPv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 11:51:59 -0400
Received: (qmail 19654 invoked by uid 109); 9 Apr 2020 15:51:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 15:51:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19067 invoked by uid 111); 9 Apr 2020 16:02:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 12:02:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 11:51:59 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config.txt: move closing "----" to cover entire listing
Message-ID: <20200409155159.GA4129050@coredump.intra.peff.net>
References: <20200409103541.23743-1-martin.agren@gmail.com>
 <20200409141452.GC3494212@coredump.intra.peff.net>
 <CAN0heSp3=8fTGb5Ciuvr8+EevNSrAfskvrrS_PN=VPhKJyB5jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp3=8fTGb5Ciuvr8+EevNSrAfskvrrS_PN=VPhKJyB5jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 05:00:34PM +0200, Martin Ågren wrote:

> > That explains why I didn't see the issue when running doc-diff on the
> > original bug. I wonder if we could teach doc-diff to look at the HTML,
> > too. I'm not sure how, though. Certainly html2text or similar would get
> > us something diff-able, but without the visual elements (like the grey
> > box), I don't know that it's much more valuable than the manpages.
> 
> At one point I considered trying out diffoscope for this. It should
> allegedly be good at comparing "everything". But being good at
> everything, it wanted to pull in a discouragingly large number of
> dependencies, so I never actually tried it out. It doesn't explicitly
> claim to know html or manpages (but does mention xml and pdf), so I
> dunno.

I tried it just now, and it's not that clever. A regular "diff -r" of
the before and after HTML yields what you'd expect:

--- old/git-config.html	2020-04-09 11:38:19.312436125 -0400
+++ new/git-config.html	2020-04-09 11:38:40.028385850 -0400
@@ -1678,11 +1678,9 @@
 ; file (if the condition is true); their location is not
 ; affected by the condition
 [includeIf "gitdir:/path/to/group/"]
-        path = foo.inc</code></pre>
-</div></div>
-<div class="literalblock">
-<div class="content">
-<pre><code>; include only if we are in a worktree where foo-branch is
+        path = foo.inc
+
+; include only if we are in a worktree where foo-branch is
 ; currently checked out
 [includeIf "onbranch:foo-branch"]
         path = foo.inc</code></pre>

A diffoscope diff yields the same, plus it complains about differing
timestamps on all of the files. I don't think it's doing anything clever
with respect to HTML formatting.

-Peff
