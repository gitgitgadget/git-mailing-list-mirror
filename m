Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC9C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiBJJ3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbiBJJ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:18 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A11120
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:16 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f9-20020a170902684900b0014cd6059ecdso1170758pln.7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IQ/TmO04ivwY6jOcn7+5hzTvbedJJB/armLAxZ1CAiA=;
        b=lDL2XJHPZWB58mDLyrgrZprr9cQ8Ev8at+pfRuT6ANUHroJQ95shOGOcUw2luj7R3p
         T5ynFnNIgDyY4e3wASvqOx1J8ecON3f2qKDkalfIhRJN1YjguTIou33lviCCmMl2h7O0
         n9P55ynOht4emSfDXczQArcDwNGmM79EbH0SB+PzQPmOhJDCKsi6SnGSpIHRZZPUW1/T
         k7H4iRAQ6IRcxcSkW3Dfl3Rx5ioKkOusOMjAzWzpoK/zd9g/qCebuUiJTArjNmiKTUGp
         yHkZqcB6szAD2X/1PFlJ58LHHb0IC0EezOrElxN0q4I01OdQ23FgY6FUXpstIlPPvI80
         3D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IQ/TmO04ivwY6jOcn7+5hzTvbedJJB/armLAxZ1CAiA=;
        b=z3fRBPX303B8u8PggmVlfa8SQQyxkkv+AjhlHKXd+dW49NQhg4v4WwdgSbJy6BpsOV
         8ykMqjzB0wpqjgO6mFdXn3cZW/Jd5it2qwQ40mo582sYN36Owvnabmjv4vVlkSc6SFxf
         hL6Pef4FwufDTKmArEsvpjgAPfNoNJ/Dq9rP6Xn3GWyzJCBsGGaI53p4C5a/mu5YUyaC
         iQyUVD1NnJiF5UgNrlL4IypInvEJE6j8ihlic73MY6av/DlYJzknO8pw5gwUt17Xtnyf
         qvcct0r6cD19YOLKJn52dXei9u66quxnwe7wy7LzTHQIxI0LMMQJDYCU8ot4//c2u85E
         KCnQ==
X-Gm-Message-State: AOAM532OoL0j+srqFOHw/mQnZzrmivh9OSXnfedutW6LCZ3yC9zEbqKw
        2i4WGHsaBb0YOsK7EfQmXGcVlGD46/RG33G/icDC83AsbLgtnsNHxvWyX4rstvobD7A7R/sNowa
        BZX9YNhl34FRqi9EMNSmc1e4+z91ETvhqFwAPpb7hGN2PO1p5JWFSpzFN754LLQg=
X-Google-Smtp-Source: ABdhPJwK+VK7OP/KdxUsnDmSQ6ZPXqvhjoYvK3UKwzqaplyQTX1lceTHSyL9yLGVgJ/8r9JWDh5FFA8c/fsLkg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:120e:: with SMTP id
 l14mr6661107plh.124.1644485355791; Thu, 10 Feb 2022 01:29:15 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:26 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-14-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 13/20] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic of "git submodule--helper ensure-core-worktree" into
run-update-procedure. Since the ensure-core-worktree command is
obsolete, remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 13 +++----------
 git-submodule.sh            |  2 --
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 15ae986692..a05aea5cd6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2746,17 +2746,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
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
 
@@ -2776,8 +2770,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -2967,6 +2959,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	ensure_core_worktree(update_data->sm_path);
+
 	/* NEEDSWORK: fix the style issues e.g. braces */
 	if (update_data->just_cloned) {
 		oidcpy(&update_data->suboid, null_oid());
@@ -3390,7 +3384,6 @@ static struct cmd_struct commands[] = {
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 29fd69250d..aa9c898e1c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -373,8 +373,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 0
-- 
2.33.GIT

