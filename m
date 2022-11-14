Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA05DC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiKNKJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNKJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74261AF32
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i21so16501126edj.10
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5IxlkJA2CzIobUr4xvR0W8z2NrVqpI3mSUvv/CnalU=;
        b=qxCdRfERB+FxLjlir13JyNgp6QIWIcNg4IeNh0LXe1JVzrlG85of44DaClsj773E4L
         o1zcMt9DXoYdoGH97HupeIuuG+939JW+8O0NKEhaClUqLNt5XkXb1dh+nYQ3JcR2SgYQ
         sg5Rhl3y8uSeNA4ZMayd2eY0vlftogMUgGGKB0jhcUVI3iajQ6Dj9cNYZdq5LDZeTrY9
         T3evwqmAKTZE/Rq7PSHgoVzETJE87zo5fE78k8Iyt4yRl8XYKA6bV365C/OCWgO4lfi6
         dffSmr5M2bKtkg++yQk0mfwb1hPAnplbRiO/bby5YBfOmZa90bMoFj+m08d+E41s97/C
         9okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5IxlkJA2CzIobUr4xvR0W8z2NrVqpI3mSUvv/CnalU=;
        b=ohu17v8tvAg2ZIAH7cG5Ap4JYFEifrXrWC3qzcFlDrnjV5FJiAVX62ICttIm/CBIVL
         3VDFpmdIlf/H4dxwsxffV/sYsveJpM7dNNWaHySlZ3/BZ/J4jLJJ0hUYxQDUB+ydY6nH
         OsbknN95yWtbyrZhSrjVDvwvDHOh/S9phg+cYvti5DafNnWM0FGSuEYCabaTw4kKdsgY
         i7Wrt6KcFwd/28mRU0KcWzDa7cfF6PubSySn8pfgq3CSHea+gBby9D4xaePyUW4rbmO1
         Pz8JmG/ktOk9O6Bwxupo48NXrrTD03U9dhI1QP35APApsq1I5hpx1IiliZZ49CNSgB0q
         AB8A==
X-Gm-Message-State: ANoB5pmDa9jByX8LoG/Lg2kuQ7xdqm8DG40lPTdOM91wtU/0OffLUsqj
        mFJ7+EcgY2FDOPcNI0n+vFvtzv7LcCnovA==
X-Google-Smtp-Source: AA0mqf67pQF0NdFLk+dPUgnRNKM8StoM0z6Cjxjn2Gu3sP9BB7oF9cMNm0tzs8c1sdcP8+tGdvA52g==
X-Received: by 2002:a05:6402:949:b0:464:3f28:3707 with SMTP id h9-20020a056402094900b004643f283707mr10381814edz.411.1668420538801;
        Mon, 14 Nov 2022 02:08:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] submodule--helper: convert "foreach" to its own "--super-prefix"
Date:   Mon, 14 Nov 2022 11:08:44 +0100
Message-Id: <patch-v2-04.10-935d8070834-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding commit to convert "absorbgitdirs", we can convert
"submodule--helper foreach" to use its own "--super-prefix", instead
of relying on the global "--super-prefix" argument to "git"
itself. See that earlier commit for the rationale and background.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c4d5e029b37..989c75280af 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -285,6 +285,7 @@ struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	int quiet;
 	int recursive;
 };
@@ -300,7 +301,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *displaypath;
 
-	displaypath = get_submodule_displaypath(path, info->prefix);
+	displaypath = get_submodule_displaypath_sp(path, info->prefix,
+						   info->super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -370,10 +372,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		cpr.dir = path;
 		prepare_submodule_repo_env(&cpr.env);
 
-		strvec_pushl(&cpr.args, "--super-prefix", NULL);
-		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
 			     NULL);
+		strvec_pushl(&cpr.args, "--super-prefix", NULL);
+		strvec_pushf(&cpr.args, "%s/", displaypath);
 
 		if (info->quiet)
 			strvec_push(&cpr.args, "--quiet");
@@ -396,7 +398,9 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	const char *super_prefix = NULL;
 	struct option module_foreach_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
@@ -417,6 +421,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	info.argc = argc;
 	info.argv = argv;
 	info.prefix = prefix;
+	info.super_prefix = super_prefix;
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
@@ -3390,8 +3395,8 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	subcmd = argv[0];
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
-	    strcmp(subcmd, "sync") && get_super_prefix())
+	    strcmp(subcmd, "status") && strcmp(subcmd, "sync") &&
+	    get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
-- 
2.38.0.1471.ge4d8947e7aa

