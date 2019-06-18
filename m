Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E828B1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfFRPyP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 11:54:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729319AbfFRPyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 11:54:11 -0400
Received: (qmail 6846 invoked by uid 109); 18 Jun 2019 15:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Jun 2019 15:54:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6154 invoked by uid 111); 18 Jun 2019 15:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 11:54:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 11:54:09 -0400
Date:   Tue, 18 Jun 2019 11:54:09 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] verify-tag: drop signal.h include
Message-ID: <20190618155409.GA13431@sigill.intra.peff.net>
References: <20190618155326.GA4014@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190618155326.GA4014@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason verify-tag.c needs to include signal.h. It's already
in git-compat-util.h, which we properly include as the first header.
And there doesn't seem to be a particular reason for this include; it's
just an artifact from the file creation in 2ae68fcb78 (Make verify-tag a
builtin., 2007-07-27).

Likewise verify-commit.c has the same issue, probably because it was
created using verify-tag as a template in d07b00b7f3 (verify-commit:
scriptable commit signature verification, 2014-06-23).

These includes are probably just redundant, and not hurting anything by
circumventing the order that git-compat-util.h tries to impose, since
we'll always have loaded git-compat-util by the time we get to these. So
this is just a cleanup, and shouldn't fix or break any platforms.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/verify-commit.c | 1 -
 builtin/verify-tag.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 4b9e823f8f..40c69a0bed 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -12,7 +12,6 @@
 #include "repository.h"
 #include "commit.h"
 #include "run-command.h"
-#include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 6fa04b751a..f45136a06b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -10,7 +10,6 @@
 #include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
-#include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
 #include "ref-filter.h"
-- 
2.22.0.rc3.685.g5185838c9a

