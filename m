Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B44C19F29
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiHBPzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiHBPy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15D222BD
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso473354wma.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UDu5sYlvnotwRhSN/0pCfT6pfXh/D4xLT26fGbbOdiA=;
        b=SlgtKUpg/358HLlA+H3ik4t3FjuLuv9MX1KETCKgnyBoFTYJH0tc5ND3lDBESTpzC+
         TIy7/7N12oDVmHMkFi1A4scDlqb6RZBKFlgV51jIuipwFnrV52Dvl728Ex2MOOxB1OIf
         er80tMW0sfL4QfSCNJc5KR1s+4j/9O1fRaTesCBa6F2ycJx1ZU3/pb6e4jB9eu0AtP8G
         CbZ7z57J7toxhj6przPoPCJ7L5/exzQdYnyFiEyHqQcOpponm6ImMJBRfbV5m/k4LCTt
         coilVca/OcpU5c055mUirp4SBe80EW5cbXD1P6+9aWA2AMNkJS1I3jTcwb34JOW6Zs67
         xGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UDu5sYlvnotwRhSN/0pCfT6pfXh/D4xLT26fGbbOdiA=;
        b=KzizX5Hn5XSRa3Q2QiDoLKK2peSttmLFtUfEa/6X/rR9MdGztcHR0puWRE3MjhsbGs
         AnP/QUG28ZrN1bqJWDym3HZ5IvoD+yn1bTGcknyRuBPnD2ZHnbBUm5cxjgM5VWgVZuAQ
         3cSMDwRA7WGbPHN+623PMKx8N35EQ/ginNlXnRYfp2aX5Iw8TEgxoev91GrBnWY9+4WK
         F/psfLtRHdZJySFLpWeQoL354w5H5PU3OJ2P3Es2ewF5cxDTFPcAy7w2kKxGa8/+IQxc
         PNEuvnjd9UDACjVXDzvP3dfyPdBDxEsMEh7uYmU/PjOFPYd7IKWg9SISv8wZd8sUF3d4
         +5cA==
X-Gm-Message-State: ACgBeo3XI1Cn0n4PrbW6urpD8U3y9WFFW4a+DtMBopsXd4dRl9EZFTfb
        hiLvXHYVnZI/LUrMwUbC15eQyabD2RDTmw==
X-Google-Smtp-Source: AA6agR5PXwlqXF9N7HQvecRv77vvkdW7tws5Yk63/WUh3KbvmKKo8nhqg9uX/1aG81krRjB/8kS/hw==
X-Received: by 2002:a1c:720a:0:b0:3a3:327:da23 with SMTP id n10-20020a1c720a000000b003a30327da23mr83941wmc.196.1659455695920;
        Tue, 02 Aug 2022 08:54:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/17] submodule--helper: fix "reference" leak
Date:   Tue,  2 Aug 2022 17:54:35 +0200
Message-Id: <patch-v5-11.17-4b1e5ced969-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index 902349976da..a5b0b3859c5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1568,7 +1568,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -1800,6 +1802,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
+	string_list_clear(&reference, 1);
 	return 0;
 }
 
@@ -3033,6 +3036,7 @@ static int add_submodule(const struct add_data *add_data)
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3088,15 +3092,17 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3115,7 +3121,10 @@ static int add_submodule(const struct add_data *add_data)
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
2.37.1.1233.ge8b09efaedc

