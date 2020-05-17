Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A1C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84850207BB
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l811kq7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgEQGab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgEQGaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 02:30:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1DC05BD09
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m12so6088949wmc.0
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wm1ayrFqHjV6V01HTee0T0wxdjUsyrf6WkMnmeUyz4k=;
        b=l811kq7OCNV2hG/EgSuK/18EdSVLpfvq+gF+a1tR63WRO63pAfq+0uupivAUB/wvKx
         Lu2U7la181fnpaB6Xcks37jcQh1QHfZ8YFae+TRM5OBGNCvUbGh4bcoMyye1jnEKNDy+
         IhzsmQpJLPYTAXwYMhXsUH/10URRbNkrDlojSw2WBE7dONsTNxRw0PPD6xhigRbAOSxE
         4J0nKMfV/oez8cZk2aug/I4d17vxnO8nlnQIhEUtA3re7Y3wGgReLXJAL5ri0yQWx7bR
         OHzv71qJd12q1zSX1ggl9rxhTmmrGtf8sURFSOMcHUv671BZcLW19eh60YcZYTf4gmPT
         VykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wm1ayrFqHjV6V01HTee0T0wxdjUsyrf6WkMnmeUyz4k=;
        b=HUHmAWlJURiYx5z8f2V+ax5Q0FjIA1hCdl1VqSudatyGHdIkRxXOS33A0LfrrNzd1Y
         bFFBRIurac0vXiXA3OoosMjv+Bwur8jfoy3xL4q87KXUmxRq8OfJUSIXfeJQBJGSrvVm
         puHsL8o3TN+10ziARUgF6FpD842FxqGDKAt5eUg/ahyQk6FWOL1BijqSDuINWpXKkcFB
         ZBokhb/xB2walRRy+02v6DmocINBNwry5KbDMJ8+F4WBNiVlDk2WA2MhqK7BSf1h3VtE
         BMd25ogbaU6COHcMCSEfnw3jt8F8SiIbO//JN0hylPu7rFt6lbr2U6+glZMtChn3Z1o9
         89sQ==
X-Gm-Message-State: AOAM5332Mysh3KLamQAaO3d8QxHqsaHjePOWz5HOyDjoXHwebPmZ6Nkb
        KluMTzuKWC65xlHIyE1iLW88irdH
X-Google-Smtp-Source: ABdhPJysu7Llhan7SEWE1bS2meDgwPO9YsP+NHQOZ5ErX9WBz9MqW4Vu2tGOS8vaJ6reKTB+1UVQSA==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr12183372wmj.3.1589697028361;
        Sat, 16 May 2020 23:30:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g135sm10503722wme.22.2020.05.16.23.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 23:30:27 -0700 (PDT)
Message-Id: <65504cb780a3a596163d8c8a3b39cb208380de72.1589697023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
From:   "Guillaume Galeazzi via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 May 2020 06:30:23 +0000
Subject: [PATCH v2 3/3] submodule--helper.c: add branch to foreach
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Guillaume G." <guillaume.galeazzi@gmail.com>,
        Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>

On a repository with some submodules tracking different branch, one
may need to run a command only for submodule tracking one of specified
branch. This change, add flags `-b <branch>` and --branch <branch>` to
subcommand `foreach` of `git submodule--helper`.

Signed-off-by: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
---
 builtin/submodule--helper.c  | 21 +++++++++++++++++++--
 t/t7407-submodule-foreach.sh | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eb17e8c5293..066d1974605 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -452,11 +452,13 @@ struct foreach_cb {
 	int recursive;
 	int active_only;
 	int populated_only;
+	struct string_list remote_branch_filter;
 };
 
 #define FOREACH_BOOL_FILTER_NOT_SET -1
 
-#define FOREACH_CB_INIT { .active_only = FOREACH_BOOL_FILTER_NOT_SET, .populated_only = 1 }
+#define FOREACH_CB_INIT { .active_only = FOREACH_BOOL_FILTER_NOT_SET, \
+	.populated_only = 1, .remote_branch_filter = STRING_LIST_INIT_NODUP }
 
 static void runcommand_in_submodule(const struct cache_entry *list_item,
 				    struct foreach_cb *info)
@@ -555,12 +557,15 @@ static void runcommand_in_submodule(const struct cache_entry *list_item,
 	free(displaypath);
 }
 
+static const char *remote_submodule_branch(const char *path);
+
 static void runcommand_in_submodule_filtered_cb(const struct cache_entry *list_item,
 						void *cb_data)
 {
 	const char *path = list_item->name;
 	struct foreach_cb *info = cb_data;
 	int is_active;
+	const char *branch;
 
 	if (info->active_only != FOREACH_BOOL_FILTER_NOT_SET) {
 		is_active = is_submodule_active(the_repository, path);
@@ -571,6 +576,14 @@ static void runcommand_in_submodule_filtered_cb(const struct cache_entry *list_i
 	if (info->populated_only != is_submodule_populated_gently(path, NULL))
 		return;
 
+	if (info->remote_branch_filter.nr) {
+		branch = remote_submodule_branch(path);
+		if (!branch)
+			return;
+		if (!unsorted_string_list_has_string(&info->remote_branch_filter, branch))
+			return;
+	}
+
 	runcommand_in_submodule(list_item, info);
 }
 
@@ -588,11 +601,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 			 N_("Call command depending on submodule active state")),
 		OPT_BOOL(0, "populated", &info.populated_only,
 			 N_("Call command depending on submodule populated state")),
+		OPT_STRING_LIST('b', "branch", &info.remote_branch_filter,
+			 N_("branch"), N_("Call command only if submodule remote branch is one of <branch> given")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--[no-]populated] [--] <command>"),
+		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--[no-]populated] [-b|--branch <branch>] [--] <command>"),
 		NULL
 	};
 
@@ -608,6 +623,8 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_filtered_cb, &info);
 
+	string_list_clear(&info.remote_branch_filter, 0);
+
 	return 0;
 }
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index be6cd80d464..2da19ac54ce 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -125,6 +125,21 @@ test_expect_success 'test "submodule--helper foreach --no-active" usage' '
 	test_i18ncmp expect actual
 '
 
+cat > expect <<EOF
+Entering 'sub1'
+$pwd/clone-foo1-sub1-$sub1sha1
+EOF
+
+test_expect_success 'test "submodule--helper foreach --branch" usage' '
+	test_when_finished "git -C clone config  -f .gitmodules --unset submodule.foo1.branch" &&
+	(
+		cd clone &&
+		git config -f .gitmodules --add submodule.foo1.branch test &&
+		git submodule--helper foreach --branch test "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<EOF
 Entering '../sub1'
 $pwd/clone-foo1-sub1-../sub1-$sub1sha1
-- 
gitgitgadget
