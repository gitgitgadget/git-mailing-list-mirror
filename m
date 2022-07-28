Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29290C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiG1Qaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiG1Qak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A1D1CB33
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q18so2884149wrx.8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XcneEM0nKdf/scpDpGVDKEW1H0hdqCzZkFEx19CgGw0=;
        b=EDThHzWSlPtjNS+25zgdalyI4/n5ENx9U8CIlDqRx9YLI4ExKjVG+qy04bSvp8wTsb
         u7YRh536yXpY3ID+bvCz4dOqX5zkpM7NLzfzvLR5nmnuTkSfNw7+9NVdCN6ARpPLzQbr
         aKTzJ09JfgvO897QfXPJ3EJhNJ7/h33RFgNScWRT7yW8aTnQup2da5CJ0NWY3/2tM+b1
         EZFHkayLW4DFF29q1KhV9pldFLQE2u4AvYXA7rfh/XSVG7lxYBpJd4+XvgIG3Bxjfwy1
         3dJJB7Fo81zOCIR55h6KYBEHZtYBM0C89meLRdcXHjAvQOp71CKYUyK7hviDqCWrPnMg
         /7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XcneEM0nKdf/scpDpGVDKEW1H0hdqCzZkFEx19CgGw0=;
        b=0VkASI+Vrcglhah6Tsl7orR1DnODcr8/mXLDMUj9OFFnCdhwEegd7XkEHOD1F+aE8e
         D+Fm0Y10WcNQfy1mnf5baGnmLbMTNmFiC3OBWNMUDEQQTYyJIcUnRc6pJ2RiSo1BwoXR
         o9B2jW8cStUlIGM2XpHdF7xtHofHZW4JNmiD4y9UwMdbZ5Z9rJBLSmD/gsAe6cQIGW90
         z5wP8H2ssayEC116qQzLsFfTfRUSHLb+QNfUvWM0zkSSkn8ujsAvHN1VrVRZ4s06R8Lw
         2oSUje3i3MKgsMsKuiEOEunAca3cx2v4s8Vimw2gfz/pwR1B89cVn7o7XLshEAEHRM/J
         vr8w==
X-Gm-Message-State: AJIora8DjabxkSUmxgAHizoKUQFaL5pABsSeezO5frOwxCwbIHmOVg7h
        72vXPC9OQMCY3fDotHhxLM6nuuvod4ljLA==
X-Google-Smtp-Source: AGRyM1vvDq/Bnm4P9sPUk5BZ/yw2smLGhjjzPbRMAlNqaig7JQYFckMcDCIrIVv0frQIKW/Nlpr0pQ==
X-Received: by 2002:a05:6000:168f:b0:21e:92d7:f4bc with SMTP id y15-20020a056000168f00b0021e92d7f4bcmr11462328wrd.101.1659025828945;
        Thu, 28 Jul 2022 09:30:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/17] submodule--helper: fix "reference" leak
Date:   Thu, 28 Jul 2022 18:30:05 +0200
Message-Id: <patch-v4-11.17-e7352bb8cfa-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
index f8a92ecf86d..debe3a4a2f5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1548,7 +1548,9 @@ static int add_possible_reference_from_superproject(
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-			string_list_append(sas->reference, xstrdup(sb.buf));
+			char *p = strbuf_detach(&sb, NULL);
+
+			string_list_append(sas->reference, p)->util = p;
 			free(sm_alternate);
 		} else {
 			switch (sas->error_mode) {
@@ -1780,6 +1782,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
+	string_list_clear(&reference, 1);
 	return 0;
 }
 
@@ -3018,6 +3021,7 @@ static int add_submodule(const struct add_data *add_data)
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3073,15 +3077,17 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3100,7 +3106,10 @@ static int add_submodule(const struct add_data *add_data)
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
2.37.1.1197.g7ed548b7807

