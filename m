Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94262C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiGUTOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiGUTOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0148E1CB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv24so3615755wrb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOuEn2p8EmsjJccZxrWBALydAr/Z+pOthem45msEB14=;
        b=ghuWAg/OVebIrHoQz8T19K3cHR9M9DWMkLjsKO+z2a0GkNAJKKk/JYxQkN0tYq3sff
         l39P4WMCn5DiScDHQA1wwdQHYuJRZ2jDyTldKs4d2fhiTypLesHZOiBy9uwYzyax0Fvq
         eiyHAGtx7EedBDZwCBeLd/lJgRRhRKnfIkdU3EvES2Cv6ZPJ+YiqLRUrB7Z9VctHSGQK
         rHpmsK3mXnd7+bpYlk2vpEbxj5iZXHZZm2FGAe+IMSdGOUflEbVu92DMMWBLR+hCAzsu
         aEM7KZfEv9zFlpTW6KgmWQYBmt5uGGvPLcWNxuj59Apf3ZkwA9GbmhbsyAKA102dx/nt
         4kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOuEn2p8EmsjJccZxrWBALydAr/Z+pOthem45msEB14=;
        b=QRfDwq0kZ0gYIdZ3ObztxDbfxVaWf3IMA4tActily900OXLqSc59Yri2ElIihyOVTn
         Y9kVtIFYK3Wq6WFYHrc34J0tv/b4EQyOtuklTp/3Kg5XWL6or4/Q8txON8k/RtSFGVXp
         wWMCTql99KU0d1C7LPSGXsNFdE6tdoFeQnwkkhF1PhHIN+XRiUxuvsdbg5uYdw7x1JjF
         3/Vb5NEaZToqcMvkIpbPOVZKOnGnajI/MLn3sJS0g3KWbQrwjCwcs4Hv5BZrRXorj3gi
         o7G6BSKZgkZyBYNkyuRrXKHFVTgLr6GiA4IVa8HUsp4kcWVh9g6AKDOWBLP97DY1jhLS
         ygCg==
X-Gm-Message-State: AJIora/NZ9QPCfFvyuNkBbpYvkN48z2vX94972NZSItQTHol0+BCgPE8
        h3XpnL8JIPiQKv9ssRBXIx1MR9Mu7Ng06A==
X-Google-Smtp-Source: AGRyM1uRIBG07748ndyZEqwPBsV1gsSEvwL6Vhh8IMBJAlCcHHRgeGdOvBuB5UajgLBtov2J4eZrgg==
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id a8-20020a056000050800b0021d4105caf9mr37017845wrf.699.1658430848094;
        Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/26] submodule--helper: fix "reference" leak is "module_clone_data"
Date:   Thu, 21 Jul 2022 21:13:12 +0200
Message-Id: <patch-v3-16.26-b8df96a9cf0-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in the "reference" member of "struct module_clone_data" that
have been with us since 31224cbdc72 (clone: recursive and reference
option triggers submodule alternates, 2016-08-17) and
8c8195e9c3e (submodule--helper: introduce add-clone subcommand,
2021-07-10).

Those commits added an xstrdup()'d member of the
STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
those, but not the ones we get from argv, let's make use of the "util"
member, if it has a pointer it's the pointer we'll need to free,
otherwise it'll be NULL (i.e. from argv).

To fix this create a a module_clone_data_release() function to go with
the MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
refactor module_clone(), 2021-07-10). We only need to add it to
add_submodule() to fix the leak, but let's add it to module_clone() as
well for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fe490c8d44d..80c1c1d4918 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1584,6 +1584,11 @@ struct module_clone_data {
 	.single_branch = -1, \
 }
 
+static void module_clone_data_release(struct module_clone_data *cd)
+{
+	string_list_clear(&cd->reference, 1);
+}
+
 struct submodule_alternate_setup {
 	const char *submodule_name;
 	enum SUBMODULE_ALTERNATE_ERROR_MODE {
@@ -1636,7 +1641,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -1873,6 +1880,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data, &clone_data.reference);
 	list_objects_filter_release(&filter_options);
+	module_clone_data_release(&clone_data);
 	return 0;
 }
 
@@ -3117,6 +3125,7 @@ static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3171,15 +3180,17 @@ static int add_submodule(const struct add_data *add_data)
 		clone_data.url = add_data->realrepo;
 		clone_data.quiet = add_data->quiet;
 		clone_data.progress = add_data->progress;
-		if (add_data->reference_path)
-			string_list_append(&clone_data.reference,
-					   xstrdup(add_data->reference_path));
+		if (add_data->reference_path) {
+			char *p = xstrdup(add_data->reference_path);
+
+			string_list_append(&clone_data.reference, p)->util = p;
+		}
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
 		if (clone_submodule(&clone_data, &clone_data.reference))
-			return -1;
+			goto cleanup;
 
 		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
@@ -3198,7 +3209,10 @@ static int add_submodule(const struct add_data *add_data)
 		if (run_command(&cp))
 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
 	}
-	return 0;
+	ret = 0;
+cleanup:
+	module_clone_data_release(&clone_data);
+	return ret;
 }
 
 static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
-- 
2.37.1.1095.g0bd6f54ba8a

