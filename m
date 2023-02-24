Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A3C61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBXGjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBXGjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA761F03
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:21 -0800 (PST)
Received: (qmail 3684 invoked by uid 109); 24 Feb 2023 06:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31110 invoked by uid 111); 24 Feb 2023 06:39:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/21] mark unused parameters in signal handlers
Message-ID: <Y/hbmIwVOtOJanAc@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signal handlers receive their signal number as a parameter, but many
don't care what it is (because they only handle one signal, or because
their action is the same regardless of the signal). Mark such parameters
to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-import.c | 2 +-
 builtin/log.c         | 2 +-
 daemon.c              | 2 +-
 progress.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7134683ab9..4a8c835062 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -436,7 +436,7 @@ static void set_checkpoint_signal(void)
 
 #else
 
-static void checkpoint_signal(int signo)
+static void checkpoint_signal(int signo UNUSED)
 {
 	checkpoint_requested = 1;
 }
diff --git a/builtin/log.c b/builtin/log.c
index 04412dd9c9..813b768e24 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -436,7 +436,7 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	setitimer(ITIMER_REAL, &early_output_timer, NULL);
 }
 
-static void early_output(int signal)
+static void early_output(int signal UNUSED)
 {
 	show_early_output = log_show_early;
 }
diff --git a/daemon.c b/daemon.c
index 0ae7d12b5c..06d5bc6931 100644
--- a/daemon.c
+++ b/daemon.c
@@ -928,7 +928,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo)
+static void child_handler(int signo UNUSED)
 {
 	/*
 	 * Otherwise empty handler because systemcalls will get interrupted
diff --git a/progress.c b/progress.c
index 0cdd875d37..9b33a2df32 100644
--- a/progress.c
+++ b/progress.c
@@ -59,7 +59,7 @@ void progress_test_force_update(void)
 }
 
 
-static void progress_interval(int signum)
+static void progress_interval(int signum UNUSED)
 {
 	progress_update = 1;
 }
-- 
2.39.2.981.g6157336f25

