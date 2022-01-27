Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0020C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiA0QXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiA0QXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCEC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so5694323wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H64A1Rjra5E/HKvj+CXIxp79HUm56OeYZTg0LJZecTI=;
        b=TYXJxfv/BqZwit2NTaTndiQvSmwc7AQAo+0WFzvwfcd299ttT1ZHfAqwIR5Hq8PLWX
         hEwF8roJAE5j6t+Q3LYenKkZ+6T2YDiQ6IXEfd3N8RtoFyeKFoT9zOZtKnUHJmoqYYEV
         RrThY2Wna27ftD58Bs/NwMWs1ctLIUQ8QgnZL0EIv8EnBXWnOlVE7RuuU0EbLOmZ6TSb
         j+ghlsH/0bNjADa84QqcViRtXLuX+0Ntdfc8FS7uSsnZatYMwkJrqlwTO8T9PKck4pLu
         V2Gq9ePWAUON+zse4KMsJRCH8Uw4SjH5oWH13xxGLWjj9zOVhKtVRz6JMZ6jPf/SL5CT
         fqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H64A1Rjra5E/HKvj+CXIxp79HUm56OeYZTg0LJZecTI=;
        b=lF0N4RzKJLS2eVD58eXVS2T+Ld1Mo/y5nQuV1XP4EqrQYLeli/TsikczSmz41uTlpq
         rSs5pALGyw8Txu3a8IinYJHcJdMtbH2SsiA9202Ko71UM7RzBY7oVb2O0UP3FHnwMIvS
         RcZLpj3ou6kSvXZbi6Vq9sgk1JfxNyNdZpZQMYCRrpO2rV0ub7wFa8MUTj7pFM3073t2
         Yn8Vg3T27aUj2HyVUk4QUT0f344ohbsR2sZ0x1Na3XGg9QBl+4cIEtp8mx7jtRm2WPqy
         fvkL4D9nnL9pcit3/VNVj0mQzobqEx1I2r5/EXL6X/e3FFa3/TS+free5YqbvJBnexsI
         YIVw==
X-Gm-Message-State: AOAM533YgQCt6Xa7rg7Y1KP9HxfkUeTyvAnDvOgrkvsH08OW85LvmXX9
        viElGfhLN45Ys6O2N9hR+4ivUVJ8Yicrqw==
X-Google-Smtp-Source: ABdhPJxCSWDOusg/1BODtI2n8fwS8rH6Nc3VvX+Q9BgnMCwXUxk5tW0UXc4D1iHzfZZ0ZfwRHidKDg==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr3516148wry.423.1643300582791;
        Thu, 27 Jan 2022 08:23:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/7] submodule--helper: get remote names from any repository
Date:   Thu, 27 Jan 2022 17:22:50 +0100
Message-Id: <patch-v4-1.7-1a0b1323cd7-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 41 +++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..965260edb22 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,10 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo, const char *refname)
 {
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +45,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
 		ret = dest;
@@ -55,6 +54,25 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static char *get_default_remote_submodule(const char *module_path)
+{
+	const char *refname;
+	struct repository subrepo;
+	int ignore_errno;
+
+	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
+					  "HEAD", 0, NULL, NULL,
+					  &ignore_errno);
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo, refname);
+}
+
+static char *get_default_remote(void)
+{
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	return repo_get_default_remote(the_repository, refname);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *prefix)
 {
 	char *remote;
@@ -1341,9 +1359,8 @@ static void sync_submodule(const char *path, const char *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key = NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
 
 	if (!is_submodule_active(the_repository, path))
@@ -1382,21 +1399,15 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
 
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd = 1;
-	cp.dir = path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	default_remote = get_default_remote_submodule(path);
+	if (!default_remote)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
 
-	strbuf_strip_suffix(&sb, "\n");
-	remote_key = xstrfmt("remote.%s.url", sb.buf);
+	remote_key = xstrfmt("remote.%s.url", default_remote);
+	free(default_remote);
 
-	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
 
-- 
2.35.0.894.g563b84683b9

