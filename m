Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36EC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiCAEmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiCAEmh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805416E8FF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:46 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w3-20020a17090ac98300b001b8b914e91aso846240pjt.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=LAddV+PxuYAc3lfKd72LHn29p7CMviLrsujYfKmd9CmvC50WqsRNeukaPh3cYJQolC
         WslRq/hNFfFvJ23z+FatYEj7YbqA5Tbk0D/vGdZM026RizJn8HN0p/kFqaVpuS4J6XNZ
         xq57JCHvyLaBlRTijpzFc923ZtLIPpRc1AXQzq8Lw3Uv2/Sc01i4JeSrsczyC0FE02Mc
         LL/x+uWNjfaJDJ9L3CXygGWs1sRi8KjGwkDIO0o92lFujgWISXN8GtbOxecouV6E0qHK
         zrdHQ/A0yuc3WUSRgDB+Jw9QRsTL6loXEnIV1k36vtRjDxWv/MbQzAD9GdWzswhwxWqQ
         sF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=cchRltmWjBqoDv4BCymoyuV6zZpo24KqGMExl1+nHdtTPK+PLHylC1SfGGg0+xGVmu
         8SxUXso5eDmaVnJ3FEOmv71v8SRqmeMwVrd2f60fAG2nwgTNczWA9U4tUjTexN40/w44
         kO1wd8NiUUrWnmZo8rJJOPhXzU1SfPC0zhvmGnvHf6JQqtwc61iNi82Tk4i4FUFmWQhb
         uOCK6tfMrdn8VEICt+s+/d8+Ctcpt1NUt68j3+mor9gEZYhVO/Osq6aAb1qAQB88m3fE
         rWfvhWHP+Qi06EmL3/5KjZI4mdzilmnEAXNPY9h/3VYInDTeKg7P8mKjZAIayDAipcDg
         lPbw==
X-Gm-Message-State: AOAM533i4RIdksNSdhA3OWalu1BcyvwG9sJGgBCgEQJLcMH+tLfu/MqD
        jV0YTPyu0zx+do++ytmN53hfCvL3PBeYZQdjiOYCBV8WJ/sT9F8nie8RJ87v2kNT6/SRtZ2QCqr
        AHtHQbDDEmxIB5kHpSvUMgWbLfrgRoYsq89QBv1gW9AGu314n24Nw749OwtrLW7A=
X-Google-Smtp-Source: ABdhPJzyRI+JTiBhsJPPXT2+bPh/IqBQalk8XEb3w7v/cJ2KSc1qobF+88Zz/DeAVYamlMG07Jb8KVFIZh52EA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ce91:b0:150:3f7:5096 with SMTP id
 f17-20020a170902ce9100b0015003f75096mr23264004plg.128.1646109705905; Mon, 28
 Feb 2022 20:41:45 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:24 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 05/13] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic of "git submodule--helper ensure-core-worktree" into
run-update-procedure. Since the ensure-core-worktree command is
obsolete, remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 12 ++----------
 git-submodule.sh            |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 77ca4270f4..6b473fc0d2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2771,17 +2771,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void ensure_core_worktree(const char *path)
 {
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
@@ -2801,8 +2795,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -3029,6 +3021,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	ensure_core_worktree(update_data->sm_path);
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
@@ -3428,7 +3421,6 @@ static struct cmd_struct commands[] = {
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 32a09302ab..458ce73ac6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -402,8 +402,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 0
-- 
2.33.GIT

