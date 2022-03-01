Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF0C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiCAAJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCAAJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:17 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCB9BADD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so39099plb.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=qx+SyICGRgfzDzk41m7kLGqVFNJQrNgNvcGqmXVVdoLKkTw0A+JVh8ngz6GxVmjQXs
         WoO4A6bXC5CvcAnBQOOz0TbGjhoQJGgBN5Jy9d7oyc9M/hVZ2jPLh5td0aJUW7Ot6FCE
         ZtJURQK+qxZZtqvM42IBNG1sQ9Qno40ydLMLS8y9eQg45K7PF0Jp2j2qaxBvhXRWvhff
         4EoHc898eVaNCD+etCdv4SaStixzs4/QikFZ9pgJXqg/U0QBdescdfErpbozpiK5uJYG
         C00YrLR/HczLOo35GZMpHPgs9rqLaWZprrMnZZIEr3gX04bnG7c2pAMiq+MPFOobCxF9
         XSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=uNNiz824+mbhECC2RSsoUEVwdHr7Wur63S9SDcm5b+Jd0amwAPAnAQ6kDo4eTkBmis
         DF41p+8+PjlkNvAJkDV5lRtf5eQOhVK23h+BmnypdLLjVQlNj0fmK/A/WsTmCRK1bce5
         RldE7P5vvb56/X43LDwlgR6wzKtjF+g2m8kFGT3+jJ+9kOUue3jZhauHFew1MupCfQGh
         oVSEXhxHdRNjms/bo49UgwASKXBExRJMUkUVSL15gdPuJcNcslFkjppjF+Qxvx2+2ump
         cc4XHSjHLDbYOJGHBIOvc9XPSLN7e72G/nzhWDRXFJozOLMz/8quxFZaeFetGqUOgMRp
         I82w==
X-Gm-Message-State: AOAM531BvFAB2qyPxWrvItBVBr4GUM3gt0nc6i4QtF7LDtrbyDeytk4o
        XX46ppwMuV5knvGdy4iAKshEsbbF0Um3/gTzAwKaZOKK+VicljgrmDrIiTYsWcqGdMsWXpPJIuJ
        s2RGLjTMOdrPb4Zr7WSrPQMK9U0CM+jdJgWqfOJrgz/Yav6ibg+a4iiijUIQq0v4=
X-Google-Smtp-Source: ABdhPJyoX5H8X3g9J4UV04SnkKQNviykE5/yMoSO1UTBZS148czZm427cOSrmCMhRNPNpq5veIq0oVuWube4IQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:1c1:b0:150:12cd:a027 with SMTP id
 e1-20020a17090301c100b0015012cda027mr23618719plh.26.1646093310717; Mon, 28
 Feb 2022 16:08:30 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:08 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 05/13] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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

