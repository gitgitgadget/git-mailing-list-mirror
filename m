Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE10C1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfI3Bvm (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35476 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so15034765qtq.2
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqBGrCUWa9QM3lyZChHVyrO7vjAONfPnBWLMDPdXlmE=;
        b=cw8F0ogWxLE1mNHB8crnvmdLKkdpBhA3x8PW9zVbwODp1bsyk1jzZMtEA+yt8X7zSA
         Vl2w21joa2gL+G8N1uAUNd5z2JC6aebLAsrbxFl0KQEdMTLWWM1MwJ4ala9bgbN8xpS2
         dlUzrnSUpKeAx5r5BAQXcXK/MDTDoZjlshwBCsjYkhsV+o7F4CR/rtTKmlXYZkmY1lyY
         HYTDEZZYCNIYtL92UN64fmgrWkEljAH1TfVSurzikwT58bj4Ux7nPjyLoy8exqugOQ6t
         pVXtJEtLQVkIbuhGOArG28m9cZnFUtnMDyHKpwjkTck387aH5U8/0/sFAguupqEYx7ud
         mm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqBGrCUWa9QM3lyZChHVyrO7vjAONfPnBWLMDPdXlmE=;
        b=n4P7p+M9/Ygy25fIHMr2qqJnv6UkcNlw0q5QG0wYrIHIhCJulo7L8ZCutTwVxxArfT
         f8W9i8g+FDbnn1jTRFpDQNZrNmavqN6VW1ymmIt7KRo/RqwHXEj9uaKE1HWv4I/IToki
         MlmNWZlDW0i+RwSU+J4gKk5/kKmT9bUhCLJfAaS42DmjRjLn0JiJUx/IaGIYfQ1nrf9j
         nZQjyeqt8Ii/pxzo2SJ60+hPITvsRYyb0ICp/Gt3C2uUX8EOMENlqnfzxot6han+vgPc
         AtxK9foOwKk+26+t608kCFMa4k/o2WGTSmCbHRD8lUQ5RJ5zIBSnwZ8BODgokq2UGWx4
         QqsQ==
X-Gm-Message-State: APjAAAWqi0jMHleCjLSq76/kRVEIUq6keGx9UW4rt5gnYlEtvb36nVEn
        hqQQfE+WbozxNwyrKG6Xd5Q5GajbfIg=
X-Google-Smtp-Source: APXvYqwec1ngAUgkpw1ZWzhn06D8TlqFehUu8sNjJD+cxgspfH4a6dipaG0x9IdF7ErU9wpwkqh9Lw==
X-Received: by 2002:a0c:9369:: with SMTP id e38mr18566952qve.25.1569808299593;
        Sun, 29 Sep 2019 18:51:39 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 08/11] grep: allow submodule functions to run in parallel
Date:   Sun, 29 Sep 2019 22:50:54 -0300
Message-Id: <8070e154070e6eaef6f31077d15349e74147ff84.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
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
  threads and allow these two functions to safelly be called in
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

- Finally, add_to_alternates_memory() must be kept protected by the same
  reason of the above item.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1c4ff4a75f..c973ac46a7 100644
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
2.23.0

