Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D81C28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiHUOCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiHUOBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CB24977
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r16so10294412wrm.6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vCc4PKZxPqwkrhlbtf54CptZqNk4hAwqT8g9afScT3E=;
        b=Nql7DwFP9lKFFJGtZRMkoGPWsYigNW5hqFB7/YNOjUae6rZcC4vGxwnTEA0g0MRrRI
         KOelXT12PrnqU7LcBrviZvqk6y79vvnAbQUjJBUarY7FNz7kIsUBS9xgFmlBId6PBiTa
         Dky6t/81LMmpKZbTlNMUyU5WYdB51jRZbOEAn7VTwaFHwcA6CXem60s19+KMLoFC7nwL
         z7frS2SiZbfuo4Dskh62xfN9pThEstr224kBs6LWId0OyVbgPw+nanJUiOPvdueKwpES
         k7pIYWq0oVnNUfQ3FLS/mZg3jMakEZMm8jOr2Ff9+N+l9sSl39eI59V5f0YIeGYfYbPe
         UmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vCc4PKZxPqwkrhlbtf54CptZqNk4hAwqT8g9afScT3E=;
        b=blk1WUq7qDWdwAT/KL9jKeNOSBG+L/Qbmb0XFjTn4abOzI0ZTlSnQWJFNgpPvKeafe
         F3r9ZhKigVefxYZmE5lx2IWBXOcewH1rYKNymtIQwaMUhYZNPpqsRqOnjheEaA3VlNUn
         BLgRMpP5dTsftPom/2emOLr4SAYqMPP0nft7ZkQ2VIYW7RF/haEcUdxYv7aKVMji7gho
         i3b8iJlgBiUqiwV63ZjhwjB2gu/APmVR031dd1NG7kYPMRUIvLLys1wGY5/2uEw/prxj
         ITol3zDcl/2J5B9KFkZltn1rmf2Ch0aeoQW6tXbCGB/ssJQvM9BODQYN3N6vvwQu4B+s
         6mXw==
X-Gm-Message-State: ACgBeo1rTQlFPF+5MdgBdynoG4vrhpHN+b5p55h1fZKwMNHAc/8aD9LX
        nsq7N+YCPxrGbV+vwk3bPQdsd6lbx3gTVnOD
X-Google-Smtp-Source: AA6agR6+EcQim9s1Sw+bw2JxvT9z+EC1KwBn+w2b0ubqOW3f9iHKshGeQP7EHXQRiw7+3CuREKvMxA==
X-Received: by 2002:adf:e9c7:0:b0:225:4536:4437 with SMTP id l7-20020adfe9c7000000b0022545364437mr3606492wrn.428.1661090474221;
        Sun, 21 Aug 2022 07:01:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/17] submodule--helper: fix "reference" leak
Date:   Sun, 21 Aug 2022 15:59:35 +0200
Message-Id: <patch-v6-11.17-dc5e8504354-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index 3f123f014f9..d469c571d52 100644
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
 
@@ -3043,6 +3046,7 @@ static int add_submodule(const struct add_data *add_data)
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3098,15 +3102,17 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3125,7 +3131,10 @@ static int add_submodule(const struct add_data *add_data)
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
2.37.2.1279.g64dec4e13cf

