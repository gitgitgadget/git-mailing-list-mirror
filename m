Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A2C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2561F20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="uGxXKOTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgAPClI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:08 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34476 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPClI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:08 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so8424316qvf.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wW6c8ZQC5dL41VvBXgGUNhFPmey3a9gRO+wb6Da2/A=;
        b=uGxXKOTaNPwJbdBPgWcSyztJgbUSjyXwVRvSjhDz98KoD36gD8bKo7oTytC2v+ZwA9
         DydfVxRmiWjVu/acDfjUXA1veR+R3oEL/K+1+4pl0f2nxGdogCjKAEyQhSh8Xh9U1cU0
         U1yfKOpZi8zkLpseDGMGrpfY1g4GAL4dzeUHWzfXjQ4m3WKL41UbHqgsBg94KWKnYSsO
         6h4i7LPV9CsNsMUpHelLkjIM6nO0qavN1rVVXw+lF97LIpUejFSykJwWx+/w4hUFiRv3
         tD3OL/qp/anLOnt6E361SPIG9/SAu4J+yUaz12d1uIfOxu9DSEUpbvP/6J4+sl4Kw8mM
         yRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wW6c8ZQC5dL41VvBXgGUNhFPmey3a9gRO+wb6Da2/A=;
        b=UlekfkJ3EEYT5b4aP36qmXQK2TqKU93OIdQyWetVj/8nh/wcQLy3BI9ahi2Gkb0i/e
         I9jo6h8/GOK98PoON9fCo9DInF39eyICY5aHsyzraWWf07msRfw7RvUZUiEqsU0lOLMk
         BC0k/OR/jAv2fl5OEa06ewZXVJ8OaekHzfASPBGLcWaCdJee7nynGZrzuvTZ3LPXMzwV
         BZF4pz9s9xVUuO5aKaW23GSLmv6As1FGhE5s96hE5xywRl8YjW7hmlto+GsXkknQU3Y7
         U4g+n80UWSBBTmZNx2rtPChLpsplh4nWaIARZb9nwCLJRktRGqZOiHwBSJPnc9ZKqBm/
         z/Lg==
X-Gm-Message-State: APjAAAWU7HiXvIUHy4+rnnKxqAMqjTPHavI0YsKXd+rVVbXn8e5olTxJ
        7+KUCayBjr5YTG5shJrhDIc3rHB3FUA=
X-Google-Smtp-Source: APXvYqxsV3O6cFYvRvoiGtWHR1toCIj9wYr6JwE+bhv0v/UvOss0CjDHe7cKxDZCKhC4WPJirgXH3Q==
X-Received: by 2002:a0c:ca06:: with SMTP id c6mr499822qvk.74.1579142466361;
        Wed, 15 Jan 2020 18:41:06 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:05 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 08/12] grep: allow submodule functions to run in parallel
Date:   Wed, 15 Jan 2020 23:39:56 -0300
Message-Id: <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that object reading operations are internally protected, the
submodule initialization functions at builtin/grep.c:grep_submodule()
are very close to being thread-safe. Let's take a look at each call and
remove from the critical section what we can, for better performance:

- submodule_from_path() and is_submodule_active() cannot be called in
  parallel yet only because they call repo_read_gitmodules() which
  contains, in its call stack, operations that would otherwise be in
  race condition with object reading (for example parse_object() and
  is_promisor_remote()). However, they only call repo_read_gitmodules()
  if it wasn't read before. So let's pre-read it before firing the
  threads and allow these two functions to safely be called in
  parallel.

- repo_submodule_init() is already thread-safe, so remove it from the
  critical section without other necessary changes.

- The repo_read_gitmodules(&subrepo) call at grep_submodule() is safe as
  no other thread is performing object reading operations in the subrepo
  yet. However, threads might be working in the superproject, and this
  function calls add_to_alternates_memory() internally, which is racy
  with object readings in the superproject. So it must be kept
  protected for now. Let's add a "NEEDSWORK" to it, informing why it
  cannot be removed from the critical section yet.

- Finally, add_to_alternates_memory() must be kept protected for the
  same reason as the item above.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d3ed05c1da..ac3d86c2e5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -401,25 +401,23 @@ static int grep_submodule(struct grep_opt *opt,
 	struct grep_opt subopt;
 	int hit;
 
-	/*
-	 * NEEDSWORK: submodules functions need to be protected because they
-	 * call config_from_gitmodules(): the latter contains in its call stack
-	 * many thread-unsafe operations that are racy with object reading, such
-	 * as parse_object() and is_promisor_object().
-	 */
-	obj_read_lock();
 	sub = submodule_from_path(superproject, &null_oid, path);
 
-	if (!is_submodule_active(superproject, path)) {
-		obj_read_unlock();
+	if (!is_submodule_active(superproject, path))
 		return 0;
-	}
 
-	if (repo_submodule_init(&subrepo, superproject, sub)) {
-		obj_read_unlock();
+	if (repo_submodule_init(&subrepo, superproject, sub))
 		return 0;
-	}
 
+	/*
+	 * NEEDSWORK: repo_read_gitmodules() might call
+	 * add_to_alternates_memory() via config_from_gitmodules(). This
+	 * operation causes a race condition with concurrent object readings
+	 * performed by the worker threads. That's why we need obj_read_lock()
+	 * here. It should be removed once it's no longer necessary to add the
+	 * subrepo's odbs to the in-memory alternates list.
+	 */
+	obj_read_lock();
 	repo_read_gitmodules(&subrepo, 0);
 
 	/*
@@ -1052,6 +1050,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
+	if (recurse_submodules && (!use_index || untracked))
+		die(_("option not supported with --recurse-submodules"));
+
 	if (list.nr || cached || show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
@@ -1071,6 +1072,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		    && (opt.pre_context || opt.post_context ||
 			opt.file_break || opt.funcbody))
 			skip_first_line = 1;
+
+		/*
+		 * Pre-read gitmodules (if not read already) to prevent racy
+		 * lazy reading in worker threads.
+		 */
+		if (recurse_submodules)
+			repo_read_gitmodules(the_repository, 1);
+
 		start_threads(&opt);
 	} else {
 		/*
@@ -1105,9 +1114,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (recurse_submodules && (!use_index || untracked))
-		die(_("option not supported with --recurse-submodules"));
-
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
-- 
2.24.1

