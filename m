Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C30B20D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbdE3FPM (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:15:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:59615 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdE3FPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:15:11 -0400
Received: (qmail 12801 invoked by uid 109); 30 May 2017 05:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:15:12 +0000
Received: (qmail 20842 invoked by uid 111); 30 May 2017 05:15:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:15:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:15:09 -0400
Date:   Tue, 30 May 2017 01:15:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/8] remote-{ext,fd}: print usage message on invalid arguments
Message-ID: <20170530051509.fx35y7d67b7fev6y@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We just say "Expected two arguments" when we get a different
number of arguments, but we can be slightly friendlier.
People shouldn't generally be running remote helpers
themselves, but curious users might say "git remote-ext -h".

Signed-off-by: Jeff King <peff@peff.net>
---
According to remote-curl.c, we should actually handle the
1-argument case, too. I didn't dig into that because it's
orthogonal to this series, and it's not clear that anybody
cares.

 builtin/remote-ext.c | 5 ++++-
 builtin/remote-fd.c  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 11b48bfb4..bfb21ba7d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -3,6 +3,9 @@
 #include "run-command.h"
 #include "pkt-line.h"
 
+static const char usage_msg[] =
+	"git remote-ext <remote> <url>";
+
 /*
  * URL syntax:
  *	'command [arg1 [arg2 [...]]]'	Invoke command with given arguments.
@@ -193,7 +196,7 @@ static int command_loop(const char *child)
 int cmd_remote_ext(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 3)
-		die("Expected two arguments");
+		usage(usage_msg);
 
 	return command_loop(argv[2]);
 }
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 08d7121b6..91dfe07e0 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,6 +1,9 @@
 #include "builtin.h"
 #include "transport.h"
 
+static const char usage_msg[] =
+	"git remote-fd <remote> <url>";
+
 /*
  * URL syntax:
  *	'fd::<inoutfd>[/<anything>]'		Read/write socket pair
@@ -57,7 +60,7 @@ int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 	char *end;
 
 	if (argc != 3)
-		die("Expected two arguments");
+		usage(usage_msg);
 
 	input_fd = (int)strtoul(argv[2], &end, 10);
 
-- 
2.13.0.613.g11c956365

