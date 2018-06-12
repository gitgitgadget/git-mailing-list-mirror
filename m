Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25191F403
	for <e@80x24.org>; Tue, 12 Jun 2018 23:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934832AbeFLX6i (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 19:58:38 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44927 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbeFLX6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 19:58:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id h12-v6so361943pfk.11
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14mk2sFXxnXcVnbYIYDIm91BMIbIhWURFmkEqfGDHQY=;
        b=rOIOfk0MC3GavCshorCsCqequIv5VQC+RMEy0RDsN3WkOJGYDi3TuxgNTrvew2ElJ4
         rG3lrVuMBboGSmhWNz4VzbAOLSAP8NLJ8IClya3n//qJwlri+mATv6bGyf8o3GQUdfxN
         Z8BPQOglYAC2gG3hcq4K8BY/ULl0DrCM5cdSV/vMbTdCariRKN4Kw+i24tqfroNhSTAr
         7ZVp7qv/u3p2bXebgRXZE1GsbM5PTYmSONETylsCz5Epmc6srtEgpY3v951WbKJOyFa+
         mySZkMUuuNwgihpwxrgd8nKJj71CoDZD7ly2Cz1hwYmPi+fNbrZBImW2yV28WAGN7A+/
         1ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14mk2sFXxnXcVnbYIYDIm91BMIbIhWURFmkEqfGDHQY=;
        b=V39dz8+MRSOIOw/7xTS3KdSshqqC3Mgk84qUcM8iP54kpctLv5m8oVq97OfBHUNhxs
         DZ/OzOlMjKyOBjIIi3fPUxTmWFEPnLkHs3PfGOxp5g/TYmm03LNFa2xOV0EhU/1MWr26
         2JUrp9LNPYXSlXD4X5hqmliBKpUTp4buGZXT4eZUB+KnsV31IBDlVmQpLRIhDKn0I7Jd
         KRjsGjhzkYAR2gqQlkMyPzEGHW04buc6tGTZYLYrRVQjnvhm3Z6tl31sZbqj/QRn3LoI
         p5woqtSMhqalwgi80PfXsAUkMTD7StVnnGJFrnKpE4KkG9DHbfYQ4cCXopVR7O9heCKY
         AroA==
X-Gm-Message-State: APt69E17JddFPWZDdomP2pULrCENmdB/mx+hAG6WnEjdxR52nBsLiYjs
        LYLMkRhZ2OOxykRV2GitS4PXP+c6gnw=
X-Google-Smtp-Source: ADUXVKK0rAROWvrh/aPDA2kDP+iWwPDbrGY3GegaA1olzlc0BP/fo7HR9jvwh+CkYHd7cUYY6V1KCA==
X-Received: by 2002:a63:91c8:: with SMTP id l191-v6mr2084457pge.53.1528847916130;
        Tue, 12 Jun 2018 16:58:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i71-v6sm1178224pgd.22.2018.06.12.16.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:58:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule: unset core.worktree if no working tree is present
Date:   Tue, 12 Jun 2018 16:58:23 -0700
Message-Id: <20180612235825.12271-2-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180612235825.12271-1-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodules work tree is removed, we should unset its core.worktree
setting as the worktree is no longer present. This is not just in line
with the conceptual view of submodules, but it fixes an inconvenience
for looking at submodules that are not checked out:

    git clone --recurse-submodules git://github.com/git/git && cd git &&
    git checkout --recurse-submodules v2.13.0
    git -C .git/modules/sha1collisiondetection log
    fatal: cannot chdir to '../../../sha1collisiondetection': \
        No such file or directory

With this patch applied, the final call to git log works instead of dying
in its setup, as the checkout will unset the core.worktree setting such
that following log will be run in a bare repository.

This patch covers all commands that are in the unpack machinery, i.e.
checkout, read-tree, reset. A follow up patch will address
"git submodule deinit", which will also make use of the new function
submodule_unset_core_worktree(), which is why we expose it in this patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 14 ++++++++++++++
 submodule.h               |  2 ++
 t/lib-submodule-update.sh |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 939d6870ecd..e127c074b04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1532,6 +1532,18 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+void submodule_unset_core_worktree(const struct submodule *sub)
+{
+	char *config_path = xstrfmt("%s/modules/%s/config",
+				    get_git_common_dir(), sub->name);
+
+	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
+		warning(_("Could not unset core.worktree setting in submodule '%s'"),
+			  sub->path);
+
+	free(config_path);
+}
+
 static const char *get_super_prefix_or_empty(void)
 {
 	const char *s = get_super_prefix();
@@ -1697,6 +1709,8 @@ int submodule_move_head(const char *path,
 
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
+
+			submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/submodule.h b/submodule.h
index 7856b8a0b3d..4644683e6cb 100644
--- a/submodule.h
+++ b/submodule.h
@@ -121,6 +121,8 @@ extern int submodule_move_head(const char *path,
 			       const char *new_head,
 			       unsigned flags);
 
+void submodule_unset_core_worktree(const struct submodule *sub);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1f38a85371a..12cd4e9233e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -709,7 +709,8 @@ test_submodule_recursing_with_args_common() {
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
-			! test -e sub1
+			! test -e sub1 &&
+			test_must_fail git config -f .git/modules/sub1/config core.worktree
 		)
 	'
 	# ... absorbing a .git directory along the way.
-- 
2.18.0.rc1.244.gcf134e6275-goog

