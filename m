Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724DC4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiLTMni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiLTMnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:07 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254E1AD98
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja17so8594666wmb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As/Hj+6fC5VCfoJBYg3HjS+IBdM9HhWr/D7Ex8iL6+Y=;
        b=KT4snsiHgVVoxHtupbXkaYqI0GBNJs2DgJTnqFr2n+Ge1LvDedlk6godZZ+s8cNHDj
         kxls8+hSa3L8dXjwZqz5z2g809hgc6yhnFG1eqKT/EY6Lc97omVnjwMigN6IgNDfN1JP
         hcyJCWtaeq5hQcde481wrgLlRfMQTbm/gHxrPRlGmkmp9F1o1pdoQl09MeLjBcufSzXq
         7aOWTDG5lqoheHSOtaucSgyKSSUPNPTI60GLQ3UKIUOhFzkXIENJu63alYoolZTBEfp9
         pAyxKF9BlG59N53IZ3UHCT/hyfZmMqU5fvdHJA6HuOH7Q1DHYgrkWn7wK4vp7xZ10816
         JP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As/Hj+6fC5VCfoJBYg3HjS+IBdM9HhWr/D7Ex8iL6+Y=;
        b=4sYtXyQ9nCmojcYYrRtZGp5LR7vVeBxzVuyNJaTO8ldN81pofdR+bR1DLJExWHyM1w
         1QRcMdzCWSFQx2bmXGm5Qqf07b5Nuk9tLqgZztfKHnTfEu1c+iw2uI+HznCuP+P2MmG5
         CBYLP2Yx4qAatzM4x8XD3ku/wTSKmoW4uUc/3UwpCe5PFu3Oj9WSl9ttB6Q92B9H+E3i
         5c2cx6r3Oyvb3QO5BHk575ldxHhUZ6ScgsZrAmZ42ZIspQj6aGEBq7u2tlRPDNlu8KzZ
         yo5kpwtjAnx7bVWjQpaNlRS3bGinUmDAD7udagFeqtaRXceLIcKZDGvGKNIHdItKntsx
         7PmQ==
X-Gm-Message-State: AFqh2kpc4JheJIijdbmdiOMLKoSpG+/cjOU2lKhdMFwRlzlEXe6BaWeV
        TIcm5hSWao0xV8vvRgVOGzTU+3eUfLtXrw==
X-Google-Smtp-Source: AMrXdXvZm4qhZ6V9PpGt8YkHMziWVZ2LFDto29nUG2/f14eB9kPKFiEuNjgYoTLo+FvaC8d6F/bJRA==
X-Received: by 2002:a05:600c:502c:b0:3d3:49db:9b25 with SMTP id n44-20020a05600c502c00b003d349db9b25mr1462389wmr.26.1671540005993;
        Tue, 20 Dec 2022 04:40:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/9] submodule--helper: convert "foreach" to its own "--super-prefix"
Date:   Tue, 20 Dec 2022 13:39:52 +0100
Message-Id: <patch-v5-5.9-13f1f0db07a-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
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
2.39.0.1071.g97ce8966538

