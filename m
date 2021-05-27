Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ABCC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FF06128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhE0ALf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbhE0ALK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910AC061347
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i8-20020a25b2080000b0290523c9c81ba5so3630663ybj.20
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pIxbakJrlVOPkzM2S4hipsY2erGboEvpJ+ELV0xPoXQ=;
        b=p+I8JeRC/LUjExo1PvG7U53kcGex6CgfKpsHxee2W8JD7qu6oIwWuymBamc9WtRYM4
         LSA0dhugDSW20jiXcwaGolFoLHRI0Hu+kfJ6esWYDl20xkv1fc1UTduwOqbY8cLBB6Zx
         T8Dt6sNIRY2DvWgYr9oOgJc+1lZtQ+IGMhXInNZXqa1gwGSzcZChjB9xeg7IPPqnNrng
         PJDG67m5JAK6zIcIJHhKMJyYyOGpbkHqv+4vYhxdOjXUK4V6o6NIfZZstBfPsuxoa51w
         BJ3cJARXg+BY7k5B2WpD2RqXfDNcIqch9tGLoUPaOXu+QZZQIrTh6pDL4I+XBMLi99d0
         dghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pIxbakJrlVOPkzM2S4hipsY2erGboEvpJ+ELV0xPoXQ=;
        b=O6c3fNVN6lEXNvQ4HCZXXC9sLrhsXm9Y8Nb+7Loz9XVM2uZtFv5cUUsSVP0RPvhrSp
         46uJW8wlJ+8BsO5iLekzr1gjda57M8VuTbpDjXRvOzFrS6ulJUW2f0AwcwGkeCxTn7AH
         OvZhfXHKRpT1VV14dxyfHWRyXX/nL8hXIPbuqko2xdqy0NUK6+g1pEx72GbNSByoQloA
         gZe4RfzPZUGIi9NghmR/GCF61+tjdRQFNKuQX85PVBzPpQireMWLPk54kBU1QTfyZp6T
         x7G889SiBHpp+qguoETKufMAh2xdET2sC/EOTTBeV5LWaOmc08jHTZrePPzGmIoEhhGc
         4WVg==
X-Gm-Message-State: AOAM532rHn9XM+Ax29K20c8sBKwdwYWVaohc/t4A52PfFxUK6sQ+gAgK
        Q62lWrWWUCtQxkIZA4NAfA0IKy6NFGyGySWFw8cqMh+I/HPVY40GOR8hjYaXANmBTg5J2JLCqj7
        CgPj5bv34iSTDxB6z3v2py/ypMxabp5IA+GwOLN9v4LK+po0Hwa/CXW2uo2BxqdMHl3UtXTvl0Q
        ==
X-Google-Smtp-Source: ABdhPJwmN8V7t0EXlsM16KZMZgOmEGFv84ot9ii4laGvlYz/3JtsFiod1BhnuAhiHR7I84ehPLfwkRptQ6yK14rItjs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3103:: with SMTP id
 x3mr930807ybx.8.1622074176012; Wed, 26 May 2021 17:09:36 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:37 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-19-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 18/37] am: convert applypatch hooks to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library. This enables use of
hooks specified in the config, in addition to those in the hookdir.
These three hooks are called only by builtin/am.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  9 +++++++++
 builtin/am.c               | 21 ++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4af202b366..ec5020bfb6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -58,6 +58,9 @@ the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
+Hooks run during 'applypatch-msg' will not be parallelized, because hooks are
+expected to edit the file holding the commit log message.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
 
@@ -73,6 +76,9 @@ make a commit if it does not pass certain test.
 The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
 
+Hooks run during 'pre-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 post-applypatch
 ~~~~~~~~~~~~~~~
 
@@ -82,6 +88,9 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+Hooks run during 'post-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..d84791859c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -33,6 +33,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "hook.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -444,9 +445,14 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt;
+
+	run_hooks_opt_init_sync(&opt);
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks("applypatch-msg", &opt);
+	run_hooks_opt_clear(&opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1606,9 +1612,16 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct run_hooks_opt hook_opt;
+
+	run_hooks_opt_init_async(&hook_opt);
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		exit(1);
+	}
+
+	run_hooks_opt_clear(&hook_opt);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
@@ -1659,8 +1672,10 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks_opt_init_async(&hook_opt);
+	run_hooks("post-applypatch", &hook_opt);
 
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&sb);
 }
 
-- 
2.31.1.818.g46aad6cb9e-goog

