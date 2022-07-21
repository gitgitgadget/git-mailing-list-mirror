Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44CCCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGUTNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGUTNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156F8965A
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so3605285wrc.8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQ/2ULJGiXlS45ldDELsoLt/a8mNNcGpe8+e1Vposms=;
        b=cz5Vkb83qicgkcKiWCmnHrkKlXsgw3n/T0FJJ0tTBCMZFhzIIAaLa1/WVMBPAKInxx
         0i+JcsgTpu3vqPOF3C6ZO1ZJ37ho0huuilD8cxNf087DSo0PpvzWfEoz0lNPQaZ9joDH
         0dR6D7LtTUyTXW/TUeJ93bRWiQQvWhCnDEIOL7HKtMVFQ8WZwCIM084VINrDNOV4Q8Di
         ArYequqwm/Wj/cDCy3Z2IJVxx3GC2MoPwdWUfouZo32CTmKrs2/mv3AbeqnshamWlXeq
         XDOQHTe9UQWzwLoWAGrgLMbrpCjQ1ke2S56Sl6nHsrqPEe36rfNnGYFaw2xUT2I1MhmI
         HAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQ/2ULJGiXlS45ldDELsoLt/a8mNNcGpe8+e1Vposms=;
        b=6eVi0rhuVxTtHWEZ3/oLzBLxXfC0RXjXv1LqSuUdYI2rGsRonn0e3W75UKuRzdVx9O
         EMN1gFD2tgXkrMoYeFvbmkKsbi6Aye3mPmZUcZkIS5kl2rEDNa15R5aSMWUFsD/siHju
         DaHbXauhs878ZQDqEJuTclCvbqOqchGqhLHOMlCQNo9k3IfTp45V6coQWVpAf/Gk3ee5
         aXukH+HA2lhBPOyL0BLxzRtAN4EitlDLZQCvhQCKmJmNelI7rUtM+txDd/mGHIGmwvgf
         2BU/S1udSz8o5MH+xRySobUCGHxFjLR0YhNA74j7hRKEv2b6THh80O7y8uMh8TQjAfd6
         4Vmw==
X-Gm-Message-State: AJIora9IWxwJ9Ix1DkeyiW+FnbeFzPPYPxHwU3DOoBro2vY3yxjVuCW5
        Bfo6FgjwrOYdtOeZT6ll50XltI7nXQ4+ww==
X-Google-Smtp-Source: AGRyM1tRhf1QNBmm51nZYE0vkuaradTfts5NTVW4edDmagE7R/516e02WGLEG56neRqEArpVCxWfag==
X-Received: by 2002:a5d:598e:0:b0:21d:86b2:f35 with SMTP id n14-20020a5d598e000000b0021d86b20f35mr37277503wri.54.1658430817735;
        Thu, 21 Jul 2022 12:13:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/26] submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
Date:   Thu, 21 Jul 2022 21:12:59 +0200
Message-Id: <patch-v3-03.26-eee6ca28c6f-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "const" to the "struct module_clone_data" that we pass to
clone_submodule(), which makes the ownership clear, and stops us from
clobbering the "clone_data->path".

We still need to add to the "reference" member, which is a "struct
string_list". We could do this by having clone_submodule() create its
own, and copy the contents over, but let's instead pass it as a
separate parameter. The main point of doing this is to make it clear
that e.g. "clone_data->path" always comes from the "argv", there's no
ambiguity about whether we can eventually free() the "struct
string_list".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 38 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 29641690c8c..7d5ee6a6261 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1650,20 +1650,22 @@ static char *clone_submodule_sm_gitdir(const char *name)
 	return sm_gitdir;
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static int clone_submodule(const struct module_clone_data *clone_data,
+			   struct string_list *reference)
 {
 	char *p;
 	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *clone_data_path;
 
 	if (!is_absolute_path(clone_data->path)) {
 		struct strbuf sb = STRBUF_INIT;
 
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
+		clone_data_path = strbuf_detach(&sb, NULL);
 	} else {
-		clone_data->path = xstrdup(clone_data->path);
+		clone_data_path = xstrdup(clone_data_path);
 	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
@@ -1674,7 +1676,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
 
-		prepare_possible_alternates(clone_data->name, &clone_data->reference);
+		prepare_possible_alternates(clone_data->name, reference);
 
 		strvec_push(&cp.args, "clone");
 		strvec_push(&cp.args, "--no-checkout");
@@ -1684,9 +1686,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_push(&cp.args, "--progress");
 		if (clone_data->depth && *(clone_data->depth))
 			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
-		if (clone_data->reference.nr) {
+		if (reference->nr) {
 			struct string_list_item *item;
-			for_each_string_list_item(item, &clone_data->reference)
+			for_each_string_list_item(item, reference)
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
 		}
@@ -1705,7 +1707,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
-		strvec_push(&cp.args, clone_data->path);
+		strvec_push(&cp.args, clone_data_path);
 
 		cp.git_cmd = 1;
 		prepare_submodule_repo_env(&cp.env);
@@ -1713,25 +1715,25 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		if(run_command(&cp))
 			die(_("clone of '%s' into submodule path '%s' failed"),
-			    clone_data->url, clone_data->path);
+			    clone_data->url, clone_data_path);
 	} else {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
-		    !is_empty_dir(clone_data->path))
-			die(_("directory not empty: '%s'"), clone_data->path);
-		if (safe_create_leading_directories_const(clone_data->path) < 0)
-			die(_("could not create directory '%s'"), clone_data->path);
+		if (clone_data->require_init && !access(clone_data_path, X_OK) &&
+		    !is_empty_dir(clone_data_path))
+			die(_("directory not empty: '%s'"), clone_data_path);
+		if (safe_create_leading_directories_const(clone_data_path) < 0)
+			die(_("could not create directory '%s'"), clone_data_path);
 		strbuf_addf(&sb, "%s/index", sm_gitdir);
 		unlink_or_warn(sb.buf);
 		strbuf_release(&sb);
 	}
 
-	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
+	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
-	p = git_pathdup_submodule(clone_data->path, "config");
+	p = git_pathdup_submodule(clone_data_path, "config");
 	if (!p)
-		die(_("could not get submodule directory for '%s'"), clone_data->path);
+		die(_("could not get submodule directory for '%s'"), clone_data_path);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
@@ -1810,7 +1812,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	clone_submodule(&clone_data);
+	clone_submodule(&clone_data, &clone_data.reference);
 	list_objects_filter_release(&filter_options);
 	return 0;
 }
@@ -3088,7 +3090,7 @@ static int add_submodule(const struct add_data *add_data)
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
-		if (clone_submodule(&clone_data))
+		if (clone_submodule(&clone_data, &clone_data.reference))
 			return -1;
 
 		prepare_submodule_repo_env(&cp.env);
-- 
2.37.1.1095.g0bd6f54ba8a

