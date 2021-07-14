Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8DC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF997613AB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhGNVlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:41:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:50068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhGNVlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 17:41:09 -0400
Received: (qmail 410 invoked by uid 109); 14 Jul 2021 21:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 21:38:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28493 invoked by uid 111); 14 Jul 2021 21:38:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 17:38:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 17:38:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/3] doc/git-config: clarify GIT_CONFIG environment variable
Message-ID: <YO9ZSBVHRweQNHIf@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scope and utility of the GIT_CONFIG variable was drastically reduced
by dc87183189 (Only use GIT_CONFIG in "git config", not other programs,
2008-06-30). But the documentation in git-config(1) predates that, which
makes it rather misleading.

These days it is really just another way to say "--file". So let's say
that, and explicitly make it clear that it does not impact other Git
commands (like GIT_CONFIG_SYSTEM, etc, would).

I also bumped it to the bottom of the list of variables, and warned
people off of using it. We don't have any plans for deprecation at this
point, but there's little point in encouraging people to use it by
putting it at the top of the list.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm taking a more opinionated stance on "nobody should actually use this
thing", but I think it's merited. It really is useless, and if not for
the history, I'd argue against somebody trying to introduce such a thing
now. :)

 Documentation/git-config.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 193fef2867..30186812a8 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -341,11 +341,6 @@ can specify any filename you want.
 ENVIRONMENT
 -----------
 
-GIT_CONFIG::
-	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig. Using the
-	"--system" option forces this to $(prefix)/etc/gitconfig.
-
 GIT_CONFIG_GLOBAL::
 GIT_CONFIG_SYSTEM::
 	Take the configuration from the given files instead from global or
@@ -373,6 +368,12 @@ This is useful for cases where you want to spawn multiple git commands
 with a common configuration but cannot depend on a configuration file,
 for example when writing scripts.
 
+GIT_CONFIG::
+	If no `--file` option is provided to `git config`, use the file
+	given by `GIT_CONFIG` as if it were provided via `--file`. This
+	variable has no effect on other Git commands, and is mostly for
+	historical compatibility; there is generally no reason to use it
+	instead of the `--file` option.
 
 [[EXAMPLES]]
 EXAMPLES
-- 
2.32.0.689.gbb74d99cdd

