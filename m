Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72544C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLOJd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLOJdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6472EF39
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:03 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so50894183ejb.6
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJskAIxH9NEG2Wvc5PBdWTC1TF0l9Jk4ceguWbwKZaM=;
        b=ht0PzduAq/qvhuyY3MwWfXhUVXUkKKQFkM/vfnvjK4U8EhUPaLqKw96cBlxl0PYv0Q
         OSKg/KNLaGzPYgUmJm/H3J7W0EK4eFERT3nHFos8uSGWK0BjmYCK8XSNxYAvsGTgNny8
         fLXgxUKen04MdlYm0gR31w0oou35HnpbdyeuoYBb6z0fXmzmEts9Fo1VgsTdDn7ZpNa0
         dsc9afeVjJQJVW+nM4WqJXAwofQVV5KOaDkoOjheG8DMyDfp/LPsfrvUmBrrQXzY3AWN
         tGygxUKMdVuF1d4OSoYyJg+kzq3zf0FJHfyWweE4EUuQm5gaHXU21G2hIszWtNPjS65F
         zQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJskAIxH9NEG2Wvc5PBdWTC1TF0l9Jk4ceguWbwKZaM=;
        b=1i18eNNwuTWni2p8QF1WLSq9QqzZ1nPAm0mPR3k6lss+o4KiIC3Af+ZjuzkRavSXxe
         f42L+eEkl2cEfl1RBdyA70f79/rbxJk0jUeObgRa4ct4Apyjdnd5llQkYsKdQtkOVM1V
         OKJmi0M3jo9aY/pES8ac5ssZ6UQdAU7tZM2p6RJiN98dwaJp87qwCL1pboPYfqQNTr58
         8QXKjRuILPY0gOvFWNqltFD5NjrCPyH4AWzB17B5XJNImQvZFurU8LKw6Ap90zIyPKqu
         VliqUH0IIGqogjbLUtAWJX8pOS8zSD9N+P+zl7NlHQxjDtAm7k6Digd9mEEZVKJwda3e
         lG/Q==
X-Gm-Message-State: ANoB5plbC0WcIPajgeZ1oKGNL6fURrENVH4CwP4QvVXJlclFAyBrwAHJ
        Bt7LNzTHM7g2LVAc51wlfFE2VwPCo/HciQ==
X-Google-Smtp-Source: AA0mqf5rH8Bwah4AIrCGqZOabk6juGiYWLoInbpOV6w2ZftUMSiZlksDJm6tS6m3u8AUbWrYQq9hyw==
X-Received: by 2002:a17:907:d38c:b0:7c1:9020:72a9 with SMTP id vh12-20020a170907d38c00b007c1902072a9mr9689645ejc.43.1671096781619;
        Thu, 15 Dec 2022 01:33:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:33:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/9] submodule--helper: convert "foreach" to its own "--super-prefix"
Date:   Thu, 15 Dec 2022 10:32:46 +0100
Message-Id: <patch-v4-5.9-4da58e7ea50-20221215T083502Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b8b2bc776d1..2a6ced13f6d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -278,6 +278,7 @@ struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	int quiet;
 	int recursive;
 };
@@ -294,7 +295,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	char *displaypath;
 
 	displaypath = get_submodule_displaypath(path, info->prefix,
-						get_super_prefix());
+						info->super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -364,10 +365,10 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
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
@@ -391,6 +392,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option module_foreach_options[] = {
+		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
@@ -3390,8 +3392,8 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
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
2.39.0.rc2.1048.g0e5493b8d5b

