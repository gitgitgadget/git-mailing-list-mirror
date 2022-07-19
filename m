Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED13EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbiGSUsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiGSUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291752E40
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so23360309wrc.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3k0XugfJ/9UIFMhu5oW/jvAtFSE5xJ/ZI/5w4xbE0w=;
        b=SoxUqkd92kMBv5h3pehbaCDQ+gcBX3H5Hd/bvOw7giZsqjk+qIwCrsT7hIeWMwWk2g
         Cw19PGMxDbKOiSy8Xn6dUvPn4x9PRU8nUyOcBDCIfiOoQtPUdopNizaY0E6gsfYPu08f
         ZuBN9TtOnc1vsnDmluHKR73K1/GM515hOpURmtRKjlp6eZ5HWCh25731uHLgOYQ77gAH
         /si7nhoK4uOXZKfRW0kzGEO4OO0aXKuI3CAAIcy/DcLXWR0TT7vieQGBNs6Dicd7oY5L
         T1fgIB/ji6sLVvubranDeNnEcpcWYJLSIqe8hnAap4Ym+i9xjceV//RRl9125LP6aT8L
         MtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3k0XugfJ/9UIFMhu5oW/jvAtFSE5xJ/ZI/5w4xbE0w=;
        b=vZsIEFPuaL+4og/nh5KAVEhnd0ToMrvXwHeS153G+k+eQdOe7a32uoTC5+QIEnGjSN
         ermfQA8/kDG7sMoSlqi+HXuXDeAqJK+oQBInqiCcPl9yAiPvGfBtwWTAb5rJ4k8IAnRe
         dwaKRDPoJkU8zEaht6P68NML2bhLEWGnjW7PzPew2aMeo3CKYJwE14NvEDBfYUwy2HBA
         sHniVsV/JkGGSaY/9/mAU3DxgDGRNWOS2Hc1XP+C0dKL18AwviQvNcZYq26QflqAdQY4
         rwIvvFenRAKx8fejEn1UQshKPULdHZgiP1u3rtn1pSQBrro9TnqmD8OpwTfO944Cq0tB
         hEfA==
X-Gm-Message-State: AJIora+lprP+CdF5U4Hp28ptwJbPF6hPM5oLY0a4R6SrehEMnwblcUOj
        6QVeq8JuZUV914aJjd/nUS8afe9pjavC9w==
X-Google-Smtp-Source: AGRyM1uFz7h6w0DQvb/OFYdhEcXNfnjdmzDzNGlUYCOHb6t1Iv1qbZGvZa7WaU88w/2OHx8UcXEP4g==
X-Received: by 2002:a5d:6f0d:0:b0:21e:3c6f:f67c with SMTP id ay13-20020a5d6f0d000000b0021e3c6ff67cmr3430966wrb.606.1658263658737;
        Tue, 19 Jul 2022 13:47:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/24] submodule--helper: fix "reference" leak is "module_clone_data"
Date:   Tue, 19 Jul 2022 22:47:05 +0200
Message-Id: <patch-v2-14.24-c7610088968-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
member, if it has a pointer it's the pointer we'll need to free.

To fix this create a a module_clone_data_release() function to go with
the MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
refactor module_clone(), 2021-07-10). We only need to add it to
add_submodule() to fix the leak, but let's add it to module_clone() as
well for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cef8f14efb5..eb2f09d1178 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1596,6 +1596,11 @@ struct module_clone_data {
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
@@ -1648,7 +1653,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -1872,6 +1879,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data);
 	list_objects_filter_release(&filter_options);
+	module_clone_data_release(&clone_data);
 	return 0;
 }
 
@@ -3118,6 +3126,7 @@ static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	int ret;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3172,15 +3181,19 @@ static int add_submodule(const struct add_data *add_data)
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
 
-		if (clone_submodule(&clone_data))
-			return -1;
+		if (clone_submodule(&clone_data)) {
+			ret = -1;
+			goto cleanup;
+		}
 
 		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
@@ -3199,7 +3212,10 @@ static int add_submodule(const struct add_data *add_data)
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
2.37.1.1062.g385eac7fccf

