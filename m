Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A36C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiA1M4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiA1M4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120CC06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so9793445edn.0
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LIdu6Ug8au7Eckfba72IS9/sOnAAQhXI82RYg2ZxYI=;
        b=q1vxT4lVAPu8zqjA35cn6I3rOA8gcJsJOec07qjPboSF+3FPnkqi09b7dZXU5lsCIE
         qw7xqcx33g/j5vS8Q2gHlpi+eTbc33V/cPcGV+WYsPxHU65pdL+ylV40zTUFxgyehZ+4
         OiyBZgC4aKxI+OMcHhLp/xhjGOAfEFourEZSaZ0UZDzGF8yne3QXgZkZwrreld4/tzMR
         xQxhzLoNAzxwher01RdDsuWQotAUgpp2a3i6dwU/t61av6QmsvYOHLvngjkEjWOCBhze
         PcnBnwC3L0eLdKgpyiixDlVoW+G+a0zHSC247HH3Z3rlkjTDh8EV+ROud6mBdTAQwnhj
         amEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LIdu6Ug8au7Eckfba72IS9/sOnAAQhXI82RYg2ZxYI=;
        b=ta8RrMVxfsasfsKQtN/vAB8znPMH1skFl2Lz8WJmAaz9AU828xjHSdhPXOoF9bF7et
         1kymY01wR1VyMgqWIgOkLSPJWqXIkYmYgDG3PptI5ccNxUsIKHb9duwfU/mgP91gTDXy
         mQV09Tir+Ht5FkF2eeg030XLrodYuWPF3i/Z6N/IUMy3JLM8u+tJ4D81S/oybBWmzmwH
         pzUFV7DSI/oAw58iKJSYbch9OubF3C/35fy6sJiqYSZMXPE1DFIzpsQsepNRlrnuiBUp
         ZhIvEgc7apFZXSFPsmnQbS5sAoc2ql8219jBeL+LAAG+/nvAwdEUJBph1DVG0OpYKCoN
         5reg==
X-Gm-Message-State: AOAM531ez7Yk47DLwgTiYFGaWYjmAyHrrUdvV4ROmmY/8AaFi7kOUOSV
        KTEfJgIsS+Z8C0T8/pnmRwrHHqqW9WIj/Q==
X-Google-Smtp-Source: ABdhPJx2ZG+28tftfoxX42dlDotZey/sqpYp7q+th7LRgy3IRkl9odv+mCASAzpQDjXVfCfMKzCXLg==
X-Received: by 2002:a05:6402:1543:: with SMTP id p3mr7974214edx.273.1643374607566;
        Fri, 28 Jan 2022 04:56:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:47 -0800 (PST)
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
Subject: [PATCH v5 1/9] submodule--helper: get remote names from any repository
Date:   Fri, 28 Jan 2022 13:56:32 +0100
Message-Id: <patch-v5-1.9-088c7236a16-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
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
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..4c7c1e1432d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,14 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo)
 {
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	struct ref_store *store = get_main_ref_store(repo);
+	int ignore_errno;
+	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+						      NULL, &ignore_errno);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +49,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
 		ret = dest;
@@ -55,6 +58,19 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static char *get_default_remote_submodule(const char *module_path)
+{
+	struct repository subrepo;
+
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo);
+}
+
+static char *get_default_remote(void)
+{
+	return repo_get_default_remote(the_repository);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *prefix)
 {
 	char *remote;
@@ -1341,9 +1357,8 @@ static void sync_submodule(const char *path, const char *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key = NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
 
 	if (!is_submodule_active(the_repository, path))
@@ -1382,21 +1397,15 @@ static void sync_submodule(const char *path, const char *prefix,
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
2.35.0.914.ge5c8aab0d5b

