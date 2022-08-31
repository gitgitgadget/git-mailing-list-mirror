Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCCECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiHaXPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiHaXO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A70BA3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w5so3947064wrn.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4eJmDU3g6LqrwEvZWabChjP+noxCms3uGQbVJGBv4ww=;
        b=BUevs4cYur1FN3XhZ0AtNCt6GReOXVaHvneGGjWrhDRq6Jr97rC9IWri108DI60Tt3
         kniklj9C4fucdO4PsnANK921TdaXNBVzF47e8jc0KQlqK8Ez1oMu6csjM82PZ7hT/tNA
         PP8Vy6i6+++BHdPHe/Fsu7wAVNUHbucM1y8cxzmrXfXlxDO7PZIB8RonoUgD3qpK6z/P
         JevvpyRCOMV1OmX9yQCK3DA4wVV7N8riFQDZQPz+CwPU1RXcdG8qk6IS75ZdMpmLjoeY
         dekWJrclz4RJ75p39m5YicgNEdedXan+2bPJ2uHx0btlS0NFKtb9sQy99EVC7AcQqpQj
         oCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4eJmDU3g6LqrwEvZWabChjP+noxCms3uGQbVJGBv4ww=;
        b=QO8v/MUTDflVku9/9XGo6EKUC8RKPBnMTyBfpurel15yEmTp3CFUOeDg2wZeHyPZYb
         w1t8T35ST0blgw5nXtZezJD8392S4+vMzdq36En6rY+CSD5VCuoghG2Jv0wJ17ThuYln
         aKgwScj5eZRR0iz0IyNXjeHIwpZZ6YMMW2VtQh1lxBX+GFuINUXGcgPg6N0JuINOd9Ot
         8uiu122YTphjFGxwRGuasf6ZaLQM+cP+7t5oT1XqTphFnM7VtZOj75o3yZ2Pknbp2NKm
         LvoawUdU3zXTcqX6dp7vFNxgEgeN15UYNFcEwGTWnQfLqZrsHgc0+Hsj+D9sLt+Ksyy/
         BCow==
X-Gm-Message-State: ACgBeo3ukQzZ3Tff7t5Dxk0z5aS0vcP5PH2l5+Jv1IDW10BOEdLOAGUX
        +7BRncMzv463XGqiXieEIP5p51QPQs+ZAA==
X-Google-Smtp-Source: AA6agR7m4qnErFDxWmnVEIZXTCzNRGXLjuur3DVBvp+/z1I9Fcn/JtkfSwWKnNcFYKtsfP0MP4ZPwQ==
X-Received: by 2002:a5d:6daa:0:b0:225:5eeb:f76f with SMTP id u10-20020a5d6daa000000b002255eebf76fmr12463618wrs.479.1661987695026;
        Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 11/17] submodule--helper: fix "reference" leak
Date:   Thu,  1 Sep 2022 01:14:18 +0200
Message-Id: <patch-v7-11.17-6a4c22d07b9-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in the "reference" variable declared in add_submodule() and
module_clone().

In preceding commits this variable was refactored out of the "struct
module_clone_data", but the leak has been with us since
31224cbdc72 (clone: recursive and reference option triggers submodule
alternates, 2016-08-17) and 8c8195e9c3e (submodule--helper: introduce
add-clone subcommand, 2021-07-10).

Those commits added an xstrdup()'d member of the
STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
those, but not the ones we get from argv, let's make use of the "util"
member, if it has a pointer it's the pointer we'll need to free,
otherwise it'll be NULL (i.e. from argv).

Note that the free() of the "util" member is needed in both
module_clone() and add_submodule(). The module_clone() function itself
doesn't populate the "util" pointer as add_submodule() does, but
module_clone() is upstream of the
add_possible_reference_from_superproject() caller we're modifying
here, which does do that.

This does preclude the use of the "util" pointer for any other reasons
for now, but that's OK. If we ever need to use it for something else
we could turn it into a small "struct" with an optional "to_free"
member, and switch to using string_list_clear_func().

Alternatively we could have another "struct string_list to_free" which
would keep a copy of the strings we've dup'd to free(). But for now
this is perfectly adequate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f9e5f05094..170eaf010ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1566,7 +1566,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -1798,6 +1800,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
+	string_list_clear(&reference, 1);
 	return 0;
 }
 
@@ -3045,6 +3048,7 @@ static int add_submodule(const struct add_data *add_data)
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3100,15 +3104,17 @@ static int add_submodule(const struct add_data *add_data)
 		clone_data.url = add_data->realrepo;
 		clone_data.quiet = add_data->quiet;
 		clone_data.progress = add_data->progress;
-		if (add_data->reference_path)
-			string_list_append(&reference,
-					   xstrdup(add_data->reference_path));
+		if (add_data->reference_path) {
+			char *p = xstrdup(add_data->reference_path);
+
+			string_list_append(&reference, p)->util = p;
+		}
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
 		if (clone_submodule(&clone_data, &reference))
-			return -1;
+			goto cleanup;
 
 		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
@@ -3127,7 +3133,10 @@ static int add_submodule(const struct add_data *add_data)
 		if (run_command(&cp))
 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
 	}
-	return 0;
+	ret = 0;
+cleanup:
+	string_list_clear(&reference, 1);
+	return ret;
 }
 
 static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
-- 
2.37.3.1420.g76f8a3d556c

