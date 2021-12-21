Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D5C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhLUTOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbhLUTON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCBC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so28827007wrg.11
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q7b5qYaiMeO17wO2Ruu/6vA9yEHdyk/xTYzDqPQlbdE=;
        b=P/OqV7DdygN+SAyJjqM1tWDmsxHjRiYHNfLlT7zgeC+nnee8VPkXOnzJPK1L2fJpjm
         CO/E4GYFv15MvsG8T4lgjWscogm9o/3KZbP+azNUvrfJbJUMYxl3Wrwm7QBn9FDVzY9M
         YL9cvZkcLpPPv0v17hUM//XrBKGDwyAbDzICWWMHmLAhuNwzdJR3GcWmDyoZzttB8Aiw
         NW/rI2AzNNLEFyYkqC4RihpnLw9uA5HAzgI8ZUgSnXRImDvkdrRs6lZNzhiAMJH/cw/o
         stGvc5W+yNBoscyjJiRw+DG9yxN7Y7P+OcAbAWR6go7n8Se2PMqn9T7NiMCPhQtuTnne
         E7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q7b5qYaiMeO17wO2Ruu/6vA9yEHdyk/xTYzDqPQlbdE=;
        b=jzgLJITzlrM1tex2UQf14zNy3sr81fhgStYTXfoOI9JvaJdNHwy7TMunTdilcXNyis
         jHfjMPGTHgmpp+n+H9fge9fC45x0+0QUsahnFVzJQaB5dFPRgxmejdh8VIeaBE9SStVd
         tqkxg9vhfJe6DGdcRzSa/ZLOpX0V8hXP1KGhB6y/R3Bv7gUy0yYHeSQjxE/jQdclJUpO
         eSc+FMG2CYBZ9/uuCOmK8NwE6wHUYI+BLyP7HQyDrTQNqOYgCAOMb/hqY/PCd4F6QN0e
         lRCh/OqQfDnDCgu240cr4gIgVgF818v7sojJK/BtqQ8zWCMUBIYsfAX8dxnUOkVSAbnI
         lotg==
X-Gm-Message-State: AOAM5324yYyf3xiQNqbmmli/OKwy2Z+ta2kifPMtVNfNQhCNX4cvV5DN
        +k5mlmSXySRUeeEXdJX02TSheieS+hU=
X-Google-Smtp-Source: ABdhPJwwcWvZEpNx8P2KBdXR0Q9fV9ND+k83TAp9AtWbM75EwoaVZVt6gwCvigHj4NYTAXMAlVe64A==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr3875114wri.8.1640114051331;
        Tue, 21 Dec 2021 11:14:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10sm3176218wri.57.2021.12.21.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:11 -0800 (PST)
Message-Id: <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:06 +0000
Subject: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some features, such as the sparse-checkout builtin, require using the
worktree config extension. It might seem simple to upgrade the
repository format and add extensions.worktreeConfig, and that is what
happens in the sparse-checkout builtin.

Transitioning from one config file to multiple has some strange
side-effects. In particular, if the base repository is bare and the
worktree is not, Git knows to treat the worktree as non-bare as a
special case when not using worktree config. Once worktree config is
enabled, Git stops that special case since the core.bare setting could
apply at the worktree config level. This opens the door for bare
worktrees.

To help resolve this transition, create upgrade_to_worktree_config() to
navigate the intricacies of this operation. In particular, we need to
look for core.bare=true within the base config file and move that
setting into the core repository's config.worktree file.

To gain access to the core repository's config and config.worktree file,
we reference a repository struct's 'commondir' member. If the repository
was a submodule instead of a worktree, then this still applies
correctly.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 worktree.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h | 12 ++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/worktree.c b/worktree.c
index 2c155b10150..e8ddbe2bfcc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "dir.h"
 #include "wt-status.h"
+#include "config.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
@@ -830,3 +831,49 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	*wtpath = path;
 	return 0;
 }
+
+int upgrade_to_worktree_config(struct repository *r)
+{
+	int res;
+	int bare = 0;
+	struct config_set cs = { 0 };
+	char *base_config_file = xstrfmt("%s/config", r->commondir);
+	char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, base_config_file);
+
+	/*
+	 * If the base repository is bare, then we need to move core.bare=true
+	 * out of the base config file and into the base repository's
+	 * config.worktree file.
+	 */
+	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
+		if ((res = git_config_set_in_file_gently(base_worktree_file,
+							"core.bare", "true"))) {
+			error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
+			goto cleanup;
+		}
+
+		if ((res = git_config_set_in_file_gently(base_config_file,
+							"core.bare", NULL))) {
+			error(_("unable to unset core.bare=true in '%s'"), base_config_file);
+			goto cleanup;
+		}
+	}
+	if (upgrade_repository_format(r, 1) < 0) {
+		res = error(_("unable to upgrade repository format to enable worktreeConfig"));
+		goto cleanup;
+	}
+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		goto cleanup;
+	}
+
+cleanup:
+	git_configset_clear(&cs);
+	free(base_config_file);
+	free(base_worktree_file);
+	trace2_printf("returning %d", res);
+	return res;
+}
diff --git a/worktree.h b/worktree.h
index 8b7c408132d..170b6b1e1f5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -182,4 +182,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname);
 
+/**
+ * Upgrade the config of the current repository and its base (if different
+ * from this repository) to use worktree-config. This might adjust config
+ * in both repositories, including:
+ *
+ * 1. Upgrading the repository format version to 1.
+ * 2. Adding extensions.worktreeConfig to the base config file.
+ * 3. Moving core.bare=true from the base config file to the base
+ *    repository's config.worktree file.
+ */
+int upgrade_to_worktree_config(struct repository *r);
+
 #endif
-- 
gitgitgadget

