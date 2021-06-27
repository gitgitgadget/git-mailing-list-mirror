Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918FBC49EA6
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2E61C4D
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhF0ANX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 20:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhF0ANW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 20:13:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE1C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 17:10:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so7881831pji.0
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdpOvTpfSX7HIAEqZ8IX0ujdF4hKrK77ab5GE7Vbqyo=;
        b=XqEvIHrgZdraX3tmDehh9w1DNWjhASv53jxjgRM0g43/wQSdIgpQm74LHVk6meZrTS
         zzHBYN4aZgoCg4hOdYs7/sbmDJ8c4kVpccojGRJ7VWHZExx2lbSuUDnkKeH4gtcQbfBR
         6naxBGlnJPZTXH7Z9mCQqAV5xf/QqiTAQLJdFgw/7CrE+0oJI9XrwqAJpaSqIU/T0k55
         OBqDjC/Y+fVcPlSGC8263Kj6PvFZMJ0jQjDGfCLrhteH9i1i/f24rcNmIpONCJDSKyQF
         NUVt0IHKXfHfAstXwgjO7eL57k4z0iaDaOASynDRRt8OMaDTjDghTmWxoVWP2Y6+Ft5O
         JqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdpOvTpfSX7HIAEqZ8IX0ujdF4hKrK77ab5GE7Vbqyo=;
        b=MLT/j9UqH1gi3nXh2lcqMQ9Ah6GqgtbQNh084+fznhV6Wh5efbworf8GIVT3wFtJCF
         IDcPfxNkeh8N2whedtvlz6oYNHyFfXvDXhK/YQqA92en43E3pC3RLgiLPg6Q4busL9Tq
         amy8bbnvWx9dAnwsDlqKxvvA5uQvtT8keQXpMAbFe4ig/mJLKM8O6eNvk87yyS7D3T9L
         5kn5RkcvqCzu/mw3DqQGkQjmmsU4xvdLjXg7Yi9IV6KDB26JxZUA2c7tEZHTn+V0GXhW
         ZvDWP77PmVDiEN8wiLr9rLgkhSdY71x48NJIX60IBo+VmYZK7LOYh6iQJ3it98//EEOV
         uOKQ==
X-Gm-Message-State: AOAM531ldbqVOvAEgIVgHOq+8x4HP434fMsg6EUYsznHYLNGmUfp4JAW
        LwW6QdOfOo9sZiuWssGPFYIQUUk4YawIvA==
X-Google-Smtp-Source: ABdhPJwT3p/JluIxVZXwIVjN3GkkPdFroLZtGg9tmLMXcmO4nSwVu8/PpFs29JRL2tDC6X8YJlZsyQ==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr18978348pju.205.1624752658458;
        Sat, 26 Jun 2021 17:10:58 -0700 (PDT)
Received: from xavier.local.tld (c-73-20-81-91.hsd1.ut.comcast.net. [73.20.81.91])
        by smtp.gmail.com with ESMTPSA id d3sm5924316pjo.31.2021.06.26.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 17:10:57 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, felipe.contreras@gmail.com,
        newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: abort by default if fast-forwarding is impossible
Date:   Sat, 26 Jun 2021 18:08:55 -0600
Message-Id: <20210627000855.530985-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.95.g4a22da5c5a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of warning but merging anyway is difficult to explain to
users because it sends mixed signals. End the confusion by firmly
requiring the user to specify whether they want a merge or a rebase.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-pull.txt | 14 +++++++++-----
 builtin/pull.c             | 32 +++++++++++++++-----------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..0fb185811e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -16,13 +16,17 @@ DESCRIPTION
 -----------
 
 Incorporates changes from a remote repository into the current
-branch.  In its default mode, `git pull` is shorthand for
-`git fetch` followed by `git merge FETCH_HEAD`.
+branch.  `git pull` is shorthand for `git fetch` followed by
+`git merge FETCH_HEAD` or `git rebase FETCH_HEAD`.
 
 More precisely, 'git pull' runs 'git fetch' with the given
-parameters and calls 'git merge' to merge the retrieved branch
-heads into the current branch.
-With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+parameters and then, by default, attempts to fast-forward the
+current branch to the remote branch head.  If fast-forwarding
+is not possible because the local and remote branches have
+diverged, the `--rebase` option causes 'git rebase' to be
+called to rebase the local branch upon the remote branch, and
+the `--no-rebase` option causes 'git merge' to be called to
+merge the retrieved branch heads into the current branch.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..21eaebc463 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -925,20 +925,20 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 	return ret;
 }
 
-static void show_advice_pull_non_ff(void)
+static void die_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-		 "discouraged. You can squelch this message by running one of the following\n"
-		 "commands sometime before your next pull:\n"
-		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
-		 "  git config pull.rebase true   # rebase\n"
-		 "  git config pull.ff only       # fast-forward only\n"
-		 "\n"
-		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+	die(_("Pulling without specifying how to reconcile divergent branches is not\n"
+	      "possible. You can squelch this message by running one of the following\n"
+	      "commands sometime before your next pull:\n"
+	      "\n"
+	      "  git config pull.rebase false  # merge\n"
+	      "  git config pull.rebase true   # rebase\n"
+	      "  git config pull.ff only       # fast-forward only\n"
+	      "\n"
+	      "You can replace \"git config\" with \"git config --global\" to set a default\n"
+	      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+	      "or --ff-only on the command line to override the configured default per\n"
+	      "invocation.\n"));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
@@ -1047,10 +1047,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (rebase_unspecified && !opt_ff && !can_ff) {
-		if (opt_verbosity >= 0)
-			show_advice_pull_non_ff();
-	}
+	if (rebase_unspecified && !opt_ff && !can_ff)
+		die_pull_non_ff();
 
 	if (opt_rebase) {
 		int ret = 0;
-- 
2.32.0.95.g4a22da5c5a

