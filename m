Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3348E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 00:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937046AbeFSAGW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 20:06:22 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:42023 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936996AbeFSAGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 20:06:20 -0400
Received: by mail-it0-f74.google.com with SMTP id c7-v6so9689207itd.7
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=14mk2sFXxnXcVnbYIYDIm91BMIbIhWURFmkEqfGDHQY=;
        b=ovaqst6FaT+ByNTwLli/eRrugKRVgTTSTGSC4vA8RsJIio7Kpcx/ukbtX/XoXfh9V3
         fgD0ZFMcLEimiR05AOJRxMiJN0MLNQVzEuLXVk1yggRuFnGt4AG2FzmqlQq1xVtJizzk
         KPqhw5kL4SQsL58AwFVEpoUWdgxUbDJceOYLX4JQxGERGUwBbAYoTUn+/DlWLu8fsgy1
         zGj82AfkEXEh66EjUSiQmzFU/2ocQxQmT/X5F7C+B9AI2VtCq3z5Bx8kCSJ+pQ/p4h/Z
         FDvDmOgIGVweWO2VdbLNqN8YgCc9vxsP7Q2I8RsEyzN9lyxfNApj277jhybeg+JsSW1v
         a8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=14mk2sFXxnXcVnbYIYDIm91BMIbIhWURFmkEqfGDHQY=;
        b=PeDAxkkWlHrZ9zpdY0nniVnZYfWQi84s/wsnKvh0gWVDQC/WYd18JRXUGbVsvxP48d
         xtNaymW9nzKqNST9s+1ioJ6T6vBOsKCKIduu1mdY+Stk6pvjCiESrPY1xvOu5uCoaG73
         12MjKkBo0QfFhLwR4e9+FaiAdXIaOqRPLbBCnU4ViyxwUINpplL+TVSU2beJUKIGg1Z7
         WYtdFN1NHzJcwwoeRQwUPGYIwaweyIx+YC19FO2hP9xqc00Mzfn46uoEaRvWCBQ1HkUy
         FoACyi49oxpxvr58jSkgUzDyJJZzoiPb3h9U7KzOnDvVCZQm+u6IBN2z2NT4xhKxA8ld
         Hggw==
X-Gm-Message-State: APt69E0ufA2Av3kxH8p/huIwZjLiYbM/IhQkeFGxhRmZaJu9HpDpabQJ
        jMtopDTghpOeM75+GeF0fAhiEHE4sYr3
X-Google-Smtp-Source: ADUXVKKPCmDD8VC9my+7AOn1fHA01dk5izEaNrxip6IiQkpnMaB4ZD3H9B+/XynB+nsulr9y5o27BhCNcne2
MIME-Version: 1.0
X-Received: by 2002:a24:5b02:: with SMTP id g2-v6mr5839527itb.44.1529366779399;
 Mon, 18 Jun 2018 17:06:19 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:06:06 -0700
In-Reply-To: <20180619000608.147422-1-sbeller@google.com>
Message-Id: <20180619000608.147422-2-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com> <20180619000608.147422-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 1/3] submodule: unset core.worktree if no working tree is present
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

