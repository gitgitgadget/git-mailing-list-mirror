Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA86C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B1861279
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhGNQwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGNQwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:52:30 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC7C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:49:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u15so3005267oiw.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQpbdXdmqjW5htUiM3euUuvoRst2VyUAfyx26KU2g/4=;
        b=BLP8eL33ZY5dFySkxYrdgUbuhTXtGhm/YvTFZSNRziaWNpZu/5pmp8ywZAIEbkOYpe
         k/B/BONC5UKZoC6fuowM4FfaV5BC57qn4CxoQH5TzRd+huQ0lRsObBZ/nyiENt6kdArL
         524UDZVlbT4pUY2/4E+7ZjUle/K+Tx7dS3EATE98w4Fu3BelYVBCu5B4ppYRLq2RZA/F
         uPNtjZK7mex1AYEK3O7oC66GAauFk70vTtOWqVp5C4pkFG72uFKBpR/GC7vEX4bPaJQ2
         k1dk/LhJzOWTieqTTPr0eIHTXp6R5biL3zuFdv1giiuFCcW5T0Av/4Ea2kugds0tYCcE
         JW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQpbdXdmqjW5htUiM3euUuvoRst2VyUAfyx26KU2g/4=;
        b=t4XDzpthJDFFrqWyDdbWIM/FEjXKAcUbe0NxE4Hj2rgE2YmJTUZ1hrKAzjvjbJr4kl
         kyM5Whls5AtFaW05TwH4oWAqjFKQ8NR5beaRZdU7l7IhWvPp39BJ1xz43MGiy/PVPEi/
         nZJKOCCqEc5bCgrDZKNJGHjrK7Q3jND9voK3zbev6ElBdGgxcdWRvNwTveQQfrIHNUa0
         /VjkuDNftsn/k4qVzQlw1YEzdfibvdyOhiO7bGweqvQqEs+6P/QPBPqLEyzXVUIDa1n1
         MBbvROvSpq84gWDkGU4l+1tVdJdWa2QRvTqrDDnqBTdPebX6DmAY7LuYJesLeDKhNqZh
         aXnw==
X-Gm-Message-State: AOAM533T28dn1llaJNM4nBqUk251aJxFywPSqFl5aVFUcvsP8d91VIO1
        eRLDTc3sy6gkkfUieiCBdH3CbgMVTp6X+w==
X-Google-Smtp-Source: ABdhPJxo6Kr9k7tDeh2hcXaQQR6pQB4Bh0CjJ5DBK5589szRTypnvMYGSbpAXWLVyvLijh+qexGunw==
X-Received: by 2002:a05:6808:1488:: with SMTP id e8mr8179231oiw.179.1626281377116;
        Wed, 14 Jul 2021 09:49:37 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v3sm516698ood.16.2021.07.14.09.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:49:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] push: make default consistent
Date:   Wed, 14 Jul 2021 11:49:00 -0500
Message-Id: <20210714164900.606330-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.38.g1d70fa854e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default action "simple" doesn't make sense. It's supposed to be the
same as "current", except with an extra safety in case the name of the
upstream branch doesn't match the name of the current branch (and we are
pushing to the same remote). But if there's no upstream configured
there's no need for any check.

If this works:

  git clone $central .
  ...
  git push

Then this should too:

  git clone $central .
  git checkout -b fix-1
  ...
  git push

Cloning automatically sets up an upstream branch for "master", and
therefore it passes the safety check, but that is much more dangerous
than pushing any other branch.

Why do we barf with "fix-1", but not "master"?

Instead of behaving like "current" if the current branch doesn't have an
upstream configured, `git push` fails like "upstream", so it's a
Frankensteinian action.

If the upstream branch isn't configured, "simple" should not abort, just
like "current".

Reported-by: Mathias Kunter <mathiaskunter@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Now that my push reorganization patches have landed on master, it's
clear why the current behavior doesn't really match the behavior of
"current".

As was discussed previously:
https://lore.kernel.org/git/60b15cd2c4136_2183bc20893@natae.notmuch/

 Documentation/config/push.txt |  5 +++--
 Documentation/git-push.txt    |  6 +++---
 builtin/push.c                | 17 ++++++++++++-----
 t/t5528-push-default.sh       |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 632033638c..d267d05e7a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -27,8 +27,9 @@ push.default::
 * `simple` - pushes the current branch with the same name on the remote.
 +
 If you are working on a centralized workflow (pushing to the same repository you
-pull from, which is typically `origin`), then you need to configure an upstream
-branch with the same name.
+pull from, which is typically `origin`), and you have configured an upstream
+branch, then the name must be the same as the current branch, otherwise this
+action will fail as a precaution.
 +
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c387..58352bbf88 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -39,9 +39,9 @@ what to push (See linkgit:git-config[1] for the meaning of `push.default`).
 
 When neither the command-line nor the configuration specify what to
 push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
+value for `push.default`: the current branch is pushed to a remote
+branch with the same name, but as a safety measure the push is aborted
+if there's a configured upstream branch with a different name than the
 local one.
 
 
diff --git a/builtin/push.c b/builtin/push.c
index e8b10a9b7e..6062edb6f6 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,9 +185,11 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
+static const char *get_upstream_ref(struct branch *branch, const char *remote_name, int fatal)
 {
-	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+	if (!branch->merge_nr || !branch->merge || !branch->remote_name) {
+		if (!fatal)
+			return NULL;
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
@@ -195,6 +197,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 		    branch->name,
 		    remote_name,
 		    branch->name);
+	}
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
@@ -231,12 +234,16 @@ static void setup_default_push_refspecs(struct remote *remote)
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
-	case PUSH_DEFAULT_SIMPLE:
+	case PUSH_DEFAULT_SIMPLE: {
+		const char *upstream;
+
 		if (!same_remote)
 			break;
-		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+		upstream = get_upstream_ref(branch, remote->name, 0);
+		if (upstream && strcmp(branch->refname, upstream))
 			die_push_simple(branch, remote);
 		break;
+	}
 
 	case PUSH_DEFAULT_UPSTREAM:
 		if (!same_remote)
@@ -244,7 +251,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 			      "your current branch '%s', without telling me what to push\n"
 			      "to update which remote branch."),
 			    remote->name, branch->name);
-		dst = get_upstream_ref(branch, remote->name);
+		dst = get_upstream_ref(branch, remote->name, 1);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index f280e00eb7..ba38256ef4 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -126,7 +126,7 @@ test_expect_success 'push from/to new branch with current creates remote branch'
 test_expect_success 'push to existing branch, with no upstream configured' '
 	test_config branch.main.remote repo1 &&
 	git checkout main &&
-	test_push_failure simple &&
+	test_push_success simple main &&
 	test_push_failure upstream
 '
 
-- 
2.32.0.38.g1d70fa854e

