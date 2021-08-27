Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE2C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC19601FF
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhH0Sc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:32:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60830 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhH0Sc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:32:56 -0400
Received: (qmail 9096 invoked by uid 109); 27 Aug 2021 18:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 18:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15495 invoked by uid 111); 27 Aug 2021 18:32:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 14:32:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 14:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
Message-ID: <YSkvpqiW09DugNoz@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSkvNyR4uT52de13@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 02:30:16PM -0400, Jeff King wrote:

> Here it is polished into a real commit.
> 
> Subject: [PATCH] logmsg_reencode(): warn when iconv() fails

And here's a minimal documentation I'd suggest on top. We can discuss
going further in discussing subtleties of iconv() if we want, but IMHO
it would work to stop here.

-- >8 --
Subject: [PATCH] docs: use "character encoding" to refer to commit-object
 encoding

The word "encoding" can mean a lot of things (e.g., base64 or
quoted-printable encoding in emails, HTML entities, URL encoding, and so
on). The documentation for i18n.commitEncoding and i18n.logOutputEncoding
uses the phrase "character encoding" to make this more clear.

Let's use that phrase in other places to make it clear what kind of
encoding we are talking about. This patch covers the gui.encoding
option, as well as the --encoding option for git-log, etc (in this
latter case, I word-smithed the sentence a little at the same time).
That, coupled with the mention of iconv in the --encoding description,
should make this more clear.

The other spot I looked at is the working-tree-encoding section of
gitattributes(5). But it gives specific examples of encodings that I
think make the meaning pretty clear already.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/gui.txt     | 2 +-
 Documentation/pretty-options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gui.txt b/Documentation/config/gui.txt
index d30831a130..0c087fd8c9 100644
--- a/Documentation/config/gui.txt
+++ b/Documentation/config/gui.txt
@@ -11,7 +11,7 @@ gui.displayUntracked::
 	in the file list. The default is "true".
 
 gui.encoding::
-	Specifies the default encoding to use for displaying of
+	Specifies the default character encoding to use for displaying of
 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
 	It can be overridden by setting the 'encoding' attribute
 	for relevant files (see linkgit:gitattributes[5]).
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 42b227bc40..b3af850608 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -33,7 +33,7 @@ people using 80-column terminals.
 	used together.
 
 --encoding=<encoding>::
-	The commit objects record the encoding used for the log message
+	Commit objects record the character encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
 	preferred by the user.  For non plumbing commands this
-- 
2.33.0.396.g72f622fe47

