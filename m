Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F66DC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B9206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG2UMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:12:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:41528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgG2UMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:21 -0400
Received: (qmail 8869 invoked by uid 109); 29 Jul 2020 20:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:12:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7899 invoked by uid 111); 29 Jul 2020 20:12:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:12:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:12:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 7/7] doc/git-log: clarify handling of merge commit diffs
Message-ID: <20200729201220.GG2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be surprising that git-log doesn't show any diff for merge
commits by default. Arguably "--cc" would be a reasonable default, but
it's very expensive (which is why we turn it on for "git show" but not
for "git log"). Let's at least document the current behavior, including
the recent "--first-parent implies -m" case

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-log.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0a4c99e5f8..9ccba65469 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -117,6 +117,13 @@ DIFF FORMATTING
 By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
+Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
+will never show a diff, even if a diff format like `--patch` is
+selected, nor will they match search options like `-S`. The exception is
+when `--first-parent` is in use, in which merges are treated like normal
+single-parent commits (this can be overridden by providing a
+combined-diff option or with `--no-diff-merges`).
+
 -c::
 	With this option, diff output for a merge commit
 	shows the differences from each of the parents to the merge result
-- 
2.28.0.465.gd2839157e3
