Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06BC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637CF20735
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYXHOLpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEQGab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgEQGaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 02:30:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98CC05BD0A
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m185so1876880wme.3
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3FYBejX12/M7ym/cm3FH8LmgCKNylzoM6PwXCeFpbDk=;
        b=eYXHOLpuMGBCA9GclrSxsuI3WAD3nD0YFM4txwYHW+yUqLU67e+8FeyCzJ5m9+hLSz
         hEiPRGz+ONnKx90l8OCZN3dUGWOgB0K4zlLcDUJLH/ArLTJDMTyv9dFxm2A2UG87rxER
         ZEI7wX+MC//DFkfkAOsPizbaH3APoMq/ah37XebqPw0AVGZIynHuCXQxNZpnt/SmCIfv
         dHStZDfeLLNDrecQQ3wH5fVrsj4JEBzp+543b3A7dg+uMdtXW8SpNdJ2YG/AmnRDFfYf
         FIrBROkuj5AsmfllfGoZb9h4IM5rkjOTKmo0vfHf05GgH2UYheOwno9yLPH5/W8uNApd
         69LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3FYBejX12/M7ym/cm3FH8LmgCKNylzoM6PwXCeFpbDk=;
        b=fJATcCJSiMQFySwlzLf2Io0SO4jstcQSdZeLxGteVp/gE1BXG1uv4xEHIu6jaoeue+
         UXnQbcbRKThk0oldxlKl8M9yOuK2EukdDWaSJiTUTscnfwUlvG/gxErQ5+MK0hAzlc1/
         AuybEs0ztvBZEM6P1xwcsSqWNrgG1qcc+fAKuTSvupbSRmqxPf9x0NuVwayZjNi+M1S1
         6j85sphsqWuv3uCbw6ZHxx6BRzfkjHx+YBt/sf2zOsr69IvjXzn8nCDq56+vl3x8C13I
         ZyhaYwf5p3Bp3PYF5Ubfw16NyaKliHYMQIZNkOpuQeJPIDU7TzoA/bVEgSMuOtxgd6qK
         JOgw==
X-Gm-Message-State: AOAM5306MX7vmtFkeTB9KqTVfYQxkTO7EJvosvBJtqPbfkjtCwyZZ5OI
        /TQ0m9wkOy2LNXvqJLMs3xhCf2c2
X-Google-Smtp-Source: ABdhPJwA3j3gk18jY2f123bTSOAmVOo/YH4xLOVAEuipDioy5NC1HbbsZ6AF+w+iZhCcwQPQxzk9jw==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr13037578wma.174.1589697026046;
        Sat, 16 May 2020 23:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm10889854wro.33.2020.05.16.23.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 23:30:25 -0700 (PDT)
Message-Id: <90defeb5a7594cce1a900fc5dd4fdc4ba9794005.1589697023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
From:   "Guillaume Galeazzi via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 May 2020 06:30:21 +0000
Subject: [PATCH v2 1/3] submodule--helper.c: add active to foreach
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

On a repository with some submodules not active, one may need to run a
command only for an active submodule or vice-versa. To achieve this,
one may use:
git submodule foreach 'git -C $toplevel submodule--helper is-active \
$sm_path && pwd || :'

Simplify this expression to make it more readable and easy-to-use by
adding the flat `--[no-]active` to subcommand `foreach` of `git
submodule`. Thus, simplifying the above command to:
git submodule--helper foreach --active pwd

Signed-off-by: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
---
 builtin/submodule--helper.c  | 33 +++++++++++++++++++++++++++------
 t/t7407-submodule-foreach.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c882..4b17e3b3b11 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -450,13 +450,16 @@ struct foreach_cb {
 	const char *prefix;
 	int quiet;
 	int recursive;
+	int active_only;
 };
-#define FOREACH_CB_INIT { 0 }
 
-static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
-				       void *cb_data)
+#define FOREACH_BOOL_FILTER_NOT_SET -1
+
+#define FOREACH_CB_INIT { .active_only=FOREACH_BOOL_FILTER_NOT_SET }
+
+static void runcommand_in_submodule(const struct cache_entry *list_item,
+				    struct foreach_cb *info)
 {
-	struct foreach_cb *info = cb_data;
 	const char *path = list_item->name;
 	const struct object_id *ce_oid = &list_item->oid;
 
@@ -555,6 +558,22 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	free(displaypath);
 }
 
+static void runcommand_in_submodule_filtered_cb(const struct cache_entry *list_item,
+						void *cb_data)
+{
+	const char *path = list_item->name;
+	struct foreach_cb *info = cb_data;
+	int is_active;
+
+	if (info->active_only != FOREACH_BOOL_FILTER_NOT_SET) {
+		is_active = is_submodule_active(the_repository, path);
+		if (is_active != info->active_only)
+			return;
+	}
+
+	runcommand_in_submodule(list_item, info);
+}
+
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
@@ -565,11 +584,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("Recurse into nested submodules")),
+		OPT_BOOL(0, "active", &info.active_only,
+			 N_("Call command depending on submodule active state")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--] <command>"),
 		NULL
 	};
 
@@ -583,7 +604,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	info.argv = argv;
 	info.prefix = prefix;
 
-	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
+	for_each_listed_submodule(&list, runcommand_in_submodule_filtered_cb, &info);
 
 	return 0;
 }
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e11..57c5ae70c8d 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -80,6 +80,36 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	test_i18ncmp expect actual
 '
 
+cat > expect <<EOF
+Entering 'sub3'
+$pwd/clone-foo3-sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule--helper foreach --active" usage' '
+	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
+	(
+		cd clone &&
+		git config --bool submodule.foo1.active "false" &&
+		git submodule--helper foreach --active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
+cat > expect <<EOF
+Entering 'sub1'
+$pwd/clone-foo1-sub1-$sub1sha1
+EOF
+
+test_expect_success 'test "submodule--helper foreach --no-active" usage' '
+	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
+	(
+		cd clone &&
+		git config --bool submodule.foo1.active "false" &&
+		git submodule--helper foreach --no-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<EOF
 Entering '../sub1'
 $pwd/clone-foo1-sub1-../sub1-$sub1sha1
-- 
gitgitgadget

